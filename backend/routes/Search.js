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
                const json = JSON.parse(body);
                if (json.body.items == undefined) {
                    resolve();
                }
                else {
                    var eArray = json.body.items[0];
                    // 태그 및 개행문자 제거
                    eArray.efcyQesitm = (eArray.efcyQesitm != null ? eArray.efcyQesitm.replace(/<[^>]*>?/g, '').replace(/\n|\r*/g, "") : null);
                    eArray.useMethodQesitm = (eArray.useMethodQesitm != null ? eArray.useMethodQesitm.replace(/<[^>]*>?/g, '').replace(/\n|\r*/g, "") : null);
                    eArray.atpnWarnQesitm = (eArray.atpnWarnQesitm != null ? eArray.atpnWarnQesitm.replace(/<[^>]*>?/g, '').replace(/\n|\r*/g, "") : null);
                    eArray.atpnQesitm = (eArray.atpnQesitm != null ? eArray.atpnQesitm.replace(/<[^>]*>?/g, '').replace(/\n|\r*/g, "") : null);
                    eArray.intrcQesitm = (eArray.intrcQesitm != null ? eArray.intrcQesitm.replace(/<[^>]*>?/g, '').replace(/\n|\r*/g, "") : null);
                    eArray.seQesitm = (eArray.seQesitm != null ? eArray.seQesitm.replace(/<[^>]*>?/g, '').replace(/\n|\r*/g, "") : null);
                    eArray.depositMethodQesitm = (eArray.depositMethodQesitm != null ? eArray.depositMethodQesitm.replace(/<[^>]*>?/g, '').replace(/\n|\r*/g, "") : null);

                    resolve(eArray);
                }
            } else {
                reject(error);
            }
        });
    });
}

// 기본 정보 가져오기
router.get('/basicInfo/:itemSeq', async (req, res) => {
    var itemSeq = req.params.itemSeq;
    try {
        const getItem = await prisma.permission.findMany({
            select: {
                itemSeq: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });

        const permArray = await prisma.permission.findMany({
            select: {
                itemSeq: true,
                itemName: true,
                entpName: true,
                itemPermitDate: true,
                etcOtcCode: true,
                barCode: true,
                reexamTarget: true,
                reexamDate: true,
                ediCode: true,
                permitKindName: true,
                entpNo: true,
                makeMaterialFlag: true,
                indutyType: true,
                cancelDate: true,
                cancelName: true,
                changeDate: true,
                gbnName: true,
                itemEngName: true,
                entpEngName: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });
        const grainArray = await prisma.grain.findMany({
            select: {
                className: true
            },
            where: {
                itemSeq: getItem[0].itemSeq
            },
            take: 1
        });

        var array = Object.assign(permArray[0], grainArray[0]);
        res.send(array);
    } catch (err) {
        res.status(500).send('Internal Server Error');
        console.log(err);
    }
});

// 제품모양 가져오기
router.get('/shape/:itemSeq', async (req, res) => {
    var itemSeq = req.params.itemSeq;
    try {
        const getItem = await prisma.permission.findMany({
            select: {
                itemSeq: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });

        const permArray = await prisma.permission.findMany({
            select: {
                itemSeq: true,
                chart: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });

        const grainArray = await prisma.grain.findMany({
            select: {
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
                formCodeName: true,
                markCodeFrontAnal: true,
                markCodeBackAnal: true,
                markCodeFrontImg: true,
                markCodeBackImg: true,
                markCodeFront: true,
                markCodeBack: true
            },
            where: {
                itemSeq: getItem[0].itemSeq
            },
            take: 1
        });
        var array = Object.assign(permArray[0], grainArray[0]);
        res.send(array);
    } catch (err) {
        res.status(500).send('Internal Server Error');
        console.log(err);
    }
});

// 효능 효과 가져오기
router.get('/efficacy/:itemSeq', async (req, res) => {
    var itemSeq = req.params.itemSeq;

    try {
        const getItem = await prisma.permission.findMany({
            select: {
                itemSeq: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });

        var url = 'http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList';
        var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + process.env.SERVICE_KEY;
        queryParams += '&' + encodeURIComponent('itemSeq') + '=' + encodeURIComponent(getItem[0].itemSeq);
        queryParams += '&' + encodeURIComponent('type') + '=' + encodeURIComponent('json');
        let option = {
            'method': 'GET',
            'url': url + queryParams
        };

        const Earray = await getEarray(option);
        if (Earray == undefined) {
            var efcyQesitm = [];
        }
        else {
            const string = Earray.efcyQesitm != null ? Earray.efcyQesitm.toString() : null;
            var efcyQesitm = [{ 'efcyQesitm': string }];
        }

        const permArray = await prisma.permission.findMany({
            select: {
                itemSeq: true,
                eeDocData: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });
        var array = Object.assign(permArray[0], efcyQesitm[0]);
        res.send(array);
    } catch (err) {
        res.status(500).send('Internal Server Error');
        console.log(err);
    }
});

// 용법 용량 가져오기
router.get('/usage/:itemSeq', async (req, res) => {
    var itemSeq = req.params.itemSeq;

    try {
        const getItem = await prisma.permission.findMany({
            select: {
                itemSeq: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });

        var url = 'http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList';
        var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + process.env.SERVICE_KEY;
        queryParams += '&' + encodeURIComponent('itemSeq') + '=' + encodeURIComponent(getItem[0].itemSeq);
        queryParams += '&' + encodeURIComponent('type') + '=' + encodeURIComponent('json');
        let option = {
            'method': 'GET',
            'url': url + queryParams
        };

        const Earray = await getEarray(option);
        if (Earray == undefined) {
            var useMethodQesitm = [];
        }
        else {
            const string = Earray.useMethodQesitm != null ? Earray.useMethodQesitm.toString() : null;
            var useMethodQesitm = [{ 'useMethodQesitm': string }];
        }

        const permArray = await prisma.permission.findMany({
            select: {
                itemSeq: true,
                totalContent: true,
                udDocData: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });

        var array = Object.assign(permArray[0], useMethodQesitm[0]);
        res.send(array);
    } catch (err) {
        res.status(500).send('Internal Server Error');
        console.log(err);
    }
});

// 주의사항 가져오기
router.get('/precautions/:itemSeq', async (req, res) => {
    var itemSeq = req.params.itemSeq;

    try {
        const getItem = await prisma.permission.findMany({
            select: {
                itemSeq: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });

        var url = 'http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList';
        var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + process.env.SERVICE_KEY;
        queryParams += '&' + encodeURIComponent('itemSeq') + '=' + encodeURIComponent(getItem[0].itemSeq);
        queryParams += '&' + encodeURIComponent('type') + '=' + encodeURIComponent('json');
        let option = {
            'method': 'GET',
            'url': url + queryParams
        };

        const Earray = await getEarray(option);
        if (Earray == undefined) {
            var eArray = [];
        }
        else {
            const atpnQesitm = Earray.atpnQesitm != null ? Earray.atpnQesitm.toString() : null;
            const atpnWarnQesitm = Earray.atpnWarnQesitm != null ? Earray.atpnWarnQesitm.toString() : null;
            const seQesitm = Earray.seQesitm != null ? Earray.seQesitm.toString() : null;
            const intrcQesitm = Earray.intrcQesitm != null ? Earray.intrcQesitm.toString() : null;
            var eArray = [{ 'atpnQesitm': atpnQesitm, 'atpnWarnQesitm': atpnWarnQesitm, 'seQesitm': seQesitm, 'intrcQesitm': intrcQesitm }];
        }

        const permArray = await prisma.permission.findMany({
            select: {
                itemSeq: true,
                nbDocData: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });

        var array = Object.assign(permArray[0], eArray[0]);
        res.send(array);
    } catch (err) {
        res.status(500).send('Internal Server Error');
        console.log(err);
    }
});

// 저장방법 가져오기
router.get('/storage/:itemSeq', async (req, res) => {
    var itemSeq = req.params.itemSeq;

    try {
        const getItem = await prisma.permission.findMany({
            select: {
                itemSeq: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });

        var url = 'http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList';
        var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + process.env.SERVICE_KEY;
        queryParams += '&' + encodeURIComponent('itemSeq') + '=' + encodeURIComponent(getItem[0].itemSeq);
        queryParams += '&' + encodeURIComponent('type') + '=' + encodeURIComponent('json');
        let option = {
            'method': 'GET',
            'url': url + queryParams
        };

        const Earray = await getEarray(option);
        if (Earray == undefined) {
            var eArray = [];
        }
        else {
            const string = Earray.depositMethodQesitm != null ? Earray.depositMethodQesitm.toString() : null;
            var depositMethodQesitm = [{ 'depositMethodQesitm': string }];
        }

        const permArray = await prisma.permission.findMany({
            select: {
                itemSeq: true,
                storageMethod: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });
        var array = Object.assign(permArray[0], depositMethodQesitm[0]);
        res.send(array);
    } catch (err) {
        res.status(500).send('Internal Server Error');
        console.log(err);
    }
});

// 유효기간 가져오기
router.get('/validity/:itemSeq', async (req, res) => {
    var itemSeq = req.params.itemSeq;
    try {
        const result = await prisma.permission.findMany({
            select: {
                itemSeq: true,
                validTerm: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });
        res.send(result);
    } catch (err) {
        res.status(500).send('Internal Server Error');
        console.log(err);
    }
});

// 원료 및 성분 가져오기
router.get('/materials/:itemSeq', async (req, res) => {
    var itemSeq = req.params.itemSeq;
    try {
        const result = await prisma.permission.findMany({
            select: {
                itemSeq: true,
                materialName: true,
                ingrName: true,
                mainItemIngr: true,
                mainIngrEng: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });
        res.send(result);
    } catch (err) {
        res.status(500).send('Internal Server Error');
        console.log(err);
    }
});

// 모든 칼럼 가져오기, 정규표현식 사용
router.get('/:itemSeq', async (req, res) => {
    var itemSeq = req.params.itemSeq;

    try {
        const getItem = await prisma.permission.findMany({
            select: {
                itemSeq: true
            },
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });

        var url = 'http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList';
        var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + process.env.SERVICE_KEY;
        queryParams += '&' + encodeURIComponent('itemSeq') + '=' + encodeURIComponent(getItem[0].itemSeq);
        queryParams += '&' + encodeURIComponent('type') + '=' + encodeURIComponent('json');
        let option = {
            'method': 'GET',
            'url': url + queryParams
        };

        const Earray = await getEarray(option);

        const permArray = await prisma.permission.findMany({
            select: {},
            where: {
                OR: [
                    { itemSeq: itemSeq },
                    {
                        barCode: {
                            contains: itemSeq
                        }
                    }
                ]
            },
            take: 1
        });
        permArray[0].eeDocData = permArray[0].eeDocData != null ? permArray[0].eeDocData.match(/(?<=title=")(.*?)(?=")|(?<=\[CDATA\[)(.*?)(?=\]])|(?<=<p>)(.*?)(?=<\/p>)/g) : null;
        permArray[0].udDocData = permArray[0].udDocData != null ? permArray[0].udDocData.match(/(?<=title=")(.*?)(?=")|(?<=\[CDATA\[)(.*?)(?=\]])|(?<=<p>)(.*?)(?=<\/p>)/g) : null;
        permArray[0].nbDocData = permArray[0].nbDocData != null ? permArray[0].nbDocData.match(/(?<=title=")(.*?)(?=")|(?<=\[CDATA\[)(.*?)(?=\]])|(?<=<p>)(.*?)(?=<\/p>)/g) : null;
        permArray[0].pnDocData = permArray[0].pnDocData != null ? permArray[0].pnDocData.match(/(?<=title=")(.*?)(?=")|(?<=\[CDATA\[)(.*?)(?=\]])|(?<=<p>)(.*?)(?=<\/p>)/g) : null;

        const grainArray = await prisma.grain.findMany({
            select: {},
            where: {
                itemSeq: getItem[0].itemSeq
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