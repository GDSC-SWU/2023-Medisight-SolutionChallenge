const express = require('express');
const request = require("request");
const router = express.Router();

const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

// e약은요 공공데이터 조회
function getEarray(option) {
    return new Promise(function (resolve, reject) {
        request(option, function (error, response, body) {
            if (!error && response.statusCode == 200) {
                if (body.items == undefined) {
                    resolve();
                }
                else {
                    const json = JSON.parse(body);
                    var eArray = json.body.items[0];

                    // 태그 및 개행문자 제거
                    eArray.efcyQesitm = eArray.efcyQesitm.replace(/<[^>]*>?/g, '').replace(/\n|\r*/g, "");
                    eArray.useMethodQesitm = eArray.useMethodQesitm.replace(/<[^>]*>?/g, '').replace(/\n|\r*/g, "");
                    eArray.atpnQesitm = eArray.atpnQesitm.replace(/<[^>]*>?/g, '').replace(/\n|\r*/g, "");
                    eArray.intrcQesitm = eArray.intrcQesitm.replace(/<[^>]*>?/g, '').replace(/\n|\r*/g, "");
                    eArray.seQesitm = eArray.seQesitm.replace(/<[^>]*>?/g, '').replace(/\n|\r*/g, "");
                    eArray.depositMethodQesitm = eArray.depositMethodQesitm.replace(/<[^>]*>?/g, '').replace(/\n|\r*/g, "");

                    resolve(eArray);
                }
            } else {
                reject(error);
            }
        });
    });
}

router.get('/:itemSeq', async (req, res) => {
    var itemSeq = req.params.itemSeq;
    var url = 'http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList';
    var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + process.env.SERVICE_KEY;
    queryParams += '&' + encodeURIComponent('itemSeq') + '=' + encodeURIComponent(itemSeq);
    queryParams += '&' + encodeURIComponent('type') + '=' + encodeURIComponent('json');
    let option = {
        'method': 'GET',
        'url': url + queryParams
    };

    try {
        const Earray = await getEarray(option);

        const permArray = await prisma.permission.findMany({
            select: {
                itemSeq: true,
                itemName: true,
                entpName: true,
                itemPermitDate: true,
                cnsgnManuf: true,
                etcOtcCode: true,
                chart: true,
                barCode: true,
                materialName: true,
                eeDocId: true,
                udDocId: true,
                nbDocId: true,
                insertFile: true,
                storageMethod: true,
                validTerm: true,
                reexamTarget: true,
                reexamDate: true,
                packUnit: true,
                ediCode: true,
                docText: true,
                permitKindName: true,
                entpNo: true,
                makeMaterialFlag: true,
                newdrugClassName: true,
                indutyType: true,
                cancelDate: true,
                cancelName: true,
                changeDate: true,
                narcoticKindCode: true,
                gbnName: true,
                totalContent: true,
                eeDocData: true,
                udDocData: true,
                nbDocData: true,
                pnDocData: true,
                mainItemIngr: true,
                ingrName: true,
                atcCode: true,
                itemEngName: true,
                entpEngName: true,
                mainIngrEng: true
            },
            where: {
                itemSeq: itemSeq
            },
            take: 1
        });
        permArray[0].eeDocData = permArray[0].eeDocData != null ? permArray[0].eeDocData.match(/(?<=title=")(.*?)(?=")|(?<=\[CDATA\[)(.*?)(?=\]])|(?<=<p>)(.*?)(?=<\/p>)/g) : null;
        permArray[0].udDocData = permArray[0].udDocData != null ? permArray[0].udDocData.match(/(?<=title=")(.*?)(?=")|(?<=\[CDATA\[)(.*?)(?=\]])|(?<=<p>)(.*?)(?=<\/p>)/g) : null;
        permArray[0].nbDocData = permArray[0].nbDocData != null ? permArray[0].nbDocData.match(/(?<=title=")(.*?)(?=")|(?<=\[CDATA\[)(.*?)(?=\]])|(?<=<p>)(.*?)(?=<\/p>)/g) : null;
        permArray[0].pnDocData = permArray[0].pnDocData != null ? permArray[0].pnDocData.match(/(?<=title=")(.*?)(?=")|(?<=\[CDATA\[)(.*?)(?=\]])|(?<=<p>)(.*?)(?=<\/p>)/g) : null;

        const grainArray = await prisma.grain.findMany({
            select: {
                entpSeq: true,
                itemImage: true,
                printFront: true,
                printBack: true,
                drugShape: true,
                colorClass1: true,
                colorClass2: true,
                lineFront: true,
                lineBack: true,
                lengLong: true,
                lengShort: true,
                thick: true,
                imgRegistTS: true,
                classNo: true,
                className: true,
                etcOtcName: true,
                formCodeName: true,
                markCodeFrontAnal: true,
                markCodeBackAnal: true,
                markCodeFrontImg: true,
                markCodeBackImg: true,
                markCodeFront: true,
                markCodeBack: true
            },
            where: {
                itemSeq: itemSeq
            },
            take: 1
        });

        var array = Object.assign(permArray[0], grainArray[0], Earray);
        const itemName = array.itemName;

        const householdArray = await prisma.household.findMany({
            select: {
                bsshNm: true,
                vldPrdYmd: true,
                strgMthCont: true,
            },
            where: {
                prdlstNm: itemName
            },
            take: 1
        });

        var array = Object.assign(permArray[0], grainArray[0], Earray, householdArray[0]);
        res.send(array);
    } catch (err) {
        res.status(500).send('Internal Server Error');
        console.log(err);
    }
});

module.exports = router;