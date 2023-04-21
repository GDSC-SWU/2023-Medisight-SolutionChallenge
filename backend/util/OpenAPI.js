var convert = require("xml-js");
const request = require("request");

// prisma
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

// totalCount 값 조회
function getTotalCount(option) {
    return new Promise(function (resolve, reject) {
        request(option, function (error, response, body) {
            if (!error && response.statusCode == 200) {
                var result = convert.xml2json(body, { compact: true, spaces: 4 });
                var totalCount = Number(JSON.parse(result).response.body.totalCount._text);
                resolve(totalCount);
            } else {
                reject(error);
            }
        });
    });
}

function insertGrain(url, queryParams) {
    return new Promise(function (resolve, reject) {
        request(
            {
                url: url + queryParams,
                method: "GET",
            },
            async function (error, response, body) {
                var data;
                // 에러는 xml 또는 json으로 오고 statusCode로는 잡을 수 없음
                if (body == undefined) {
                    console.log(body);
                    return reject();
                }
                else if (body[0] == '<') {
                    console.log(body);
                    return reject();
                }
                else {
                    data = JSON.parse(body).body.items;
                    if (data == undefined) {
                        console.log(body);
                        return reject();
                    }
                }

                // 정상 response
                for (var i = 0; i < data.length; ++i) {
                    await prisma.grain.create({
                        data: {
                            itemSeq: data[i].ITEM_SEQ,
                            itemImage: data[i].ITEM_IMAGE,
                            printFront: data[i].PRINT_FRONT,
                            printBack: data[i].PRINT_BACK,
                            drugShape: data[i].DRUG_SHAPE,
                            colorClass1: data[i].COLOR_CLASS1,
                            colorClass2: data[i].COLOR_CLASS2,
                            lineFront: data[i].LINE_FRONT,
                            lineBack: data[i].LINE_BACK,
                            lengLong: data[i].LENG_LONG,
                            lengShort: data[i].LENG_SHORT,
                            thick: data[i].THICK,
                            imgRegistTS: data[i].IMG_REGIST_TS,
                            className: data[i].CLASS_NAME,
                            formCodeName: data[i].FORM_CODE_NAME,
                            markCodeFrontAnal: data[i].MARK_CODE_FRONT_ANAL,
                            markCodeBackAnal: data[i].MARK_CODE_BACK_ANAL,
                            markCodeFrontImg: data[i].MARK_CODE_FRONT_IMG,
                            markCodeBackImg: data[i].MARK_CODE_BACK_IMG,
                            markCodeFront: data[i].MARK_CODE_FRONT,
                            markCodeBack: data[i].MARK_CODE_BACK
                        }
                    });
                }
                resolve();
            }
        ); // end request
    });
}

function insertPermission(url, queryParams) {
    return new Promise(function (resolve, reject) {
        request(
            {
                url: url + queryParams,
                method: "GET",
            },
            function (error, response, body) {
                var data;
                // 에러는 xml 또는 json으로 오고 statusCode로는 잡을 수 없음
                if (body == undefined) {
                    console.log(body);
                    return reject();
                }
                else if (body[0] == '<') {
                    console.log(body);
                    return reject();
                }
                else {
                    data = JSON.parse(body).body.items;
                    if (data == undefined) {
                        console.log(body);
                        return reject();
                    }
                }

                // 정상 response
                for (var i = 0; i < data.length; ++i) {
                    (async () => {
                        await prisma.permission.create({
                            data: {
                                itemSeq: data[i].ITEM_SEQ,
                                itemName: data[i].ITEM_NAME,
                                entpName: data[i].ENTP_NAME,
                                itemPermitDate: data[i].ITEM_PERMIT_DATE,
                                etcOtcCode: data[i].ETC_OTC_CODE,
                                chart: data[i].CHART,
                                barCode: data[i].BAR_CODE,
                                materialName: data[i].MATERIAL_NAME,
                                storageMethod: data[i].STORAGE_METHOD,
                                validTerm: data[i].VALID_TERM,
                                reexamTarget: data[i].REEXAM_TARGET,
                                reexamDate: data[i].REEXAM_DATE,
                                ediCode: data[i].EDI_CODE,
                                permitKindName: data[i].PERMIT_KIND_NAME,
                                entpNo: data[i].ENTP_NO,
                                makeMaterialFlag: data[i].MAKE_MATERIAL_FLAG,
                                indutyType: data[i].INDUTY_TYPE,
                                cancelDate: data[i].CANCEL_DATE,
                                cancelName: data[i].CANCEL_NAME,
                                changeDate: data[i].CHANGE_DATE,
                                gbnName: data[i].GBN_NAME,
                                totalContent: data[i].TOTAL_CONTENT,
                                eeDocData: data[i].EE_DOC_DATA,
                                udDocData: data[i].UD_DOC_DATA,
                                nbDocData: data[i].NB_DOC_DATA,
                                pnDocData: data[i].PN_DOC_DATA,
                                mainItemIngr: data[i].MAIN_ITEM_INGR,
                                ingrName: data[i].INGR_NAME,
                                itemEngName: data[i].ITEM_ENG_NAME,
                                entpEngName: data[i].ENTP_ENG_NAME,
                                mainIngrEng: data[i].MAIN_INGR_ENG,
                            }
                        });
                    })();
                }
                resolve();
            } // end of request callback
        ); // end of request
    });
}

function insertHousehold(url, queryParams) {
    return new Promise(function (resolve, reject) {
        request(
            {
                url: url + queryParams,
                method: "GET",
            },
            async function (error, response, body) {
                var data;
                // 에러는 xml 또는 json으로 오고 statusCode로는 잡을 수 없음
                if (body == undefined) {
                    console.log(body);
                    return reject();
                }
                else if (body[0] == '<') {
                    console.log(body);
                    return reject();
                }
                else {
                    data = JSON.parse(body).body.items;
                    if (data == undefined) {
                        console.log(body);
                        return reject();
                    }
                }

                // 정상 response
                for (var i = 0; i < data.length; ++i) {
                    await prisma.household.create({
                        data: {
                            prdlstNm: data[i].PRDLST_NM,
                            bsshNm: data[i].BSSH_NM,
                            vldPrdYmd: data[i].VLD_PRD_YMD,
                            strgMthCont: data[i].STRG_MTH_CONT,
                        }
                    });
                }
                resolve();
            } // end of request callback
        ); // end of request
    });
}

function grainDB() {
    return new Promise(async function (resolve, reject) {
        var url = "http://apis.data.go.kr/1471000/MdcinGrnIdntfcInfoService01/getMdcinGrnIdntfcInfoList01";
        var queryParams = "?" + encodeURIComponent("serviceKey") + "=" + process.env.SERVICE_KEY;
        queryParams += "&" + encodeURIComponent("numOfRows") + "=" + encodeURIComponent(1);
        queryParams += "&" + encodeURIComponent("pageNo") + "=" + encodeURIComponent(1);
        let option = {
            'method': 'GET',
            'url': url + queryParams
        };
        let totalCount = await getTotalCount(option);

        // 공공데이터 조회
        var numOfRows = 300;
        var loopCount = Math.ceil(totalCount / numOfRows, 0);
        var endRows = totalCount % numOfRows;

        for (var pageNo = 1; pageNo <= loopCount; ++pageNo) {
            var queryParams = "?" + encodeURIComponent("serviceKey") + "=" + process.env.SERVICE_KEY;
            queryParams += "&" + encodeURIComponent("numOfRows") + "=" + encodeURIComponent(pageNo == loopCount ? endRows : numOfRows);
            queryParams += "&" + encodeURIComponent("pageNo") + "=" + encodeURIComponent(pageNo);
            queryParams += "&" + encodeURIComponent("type") + "=" + encodeURIComponent("json");

            await insertGrain(url, queryParams).then(() => {
                process.stdout.clearLine();
                process.stdout.cursorTo(0);
                process.stdout.write(`* * * Grain: ${pageNo}/${loopCount} 적재 성공`);  // write text
            }).catch(async () => {
                console.log(`\n* * * Grain: 적재에 실패하여 재시도합니다. (pageNo: ${pageNo})\n`);
                await insertGrain(url, queryParams).catch(() => {
                    console.log(`\n* * * Grain: 재시도에 실패하여 스킵합니다. (pageNo: ${pageNo})\n`);
                });
            });
        }
        console.log("\n* * * Grain: 낱알데이터 저장 완료 " + Date());
        resolve();
    });
}

function permissionDB() {
    return new Promise(async function (resolve, reject) {
        var url = "http://apis.data.go.kr/1471000/DrugPrdtPrmsnInfoService04/getDrugPrdtPrmsnDtlInq03";
        var queryParams = "?" + encodeURIComponent("serviceKey") + "=" + process.env.SERVICE_KEY;
        queryParams += "&" + encodeURIComponent("numOfRows") + "=" + encodeURIComponent(1);
        queryParams += "&" + encodeURIComponent("pageNo") + "=" + encodeURIComponent(1);
        let option = {
            'method': 'GET',
            'url': url + queryParams
        };
        let totalCount = await getTotalCount(option);

        // 공공데이터 조회
        var numOfRows = 100;
        var loopCount = Math.ceil(totalCount / numOfRows); // numOfRows에 미치지 못하는 마지막 페이지까지 포함한 개수
        var endRows = totalCount % numOfRows;

        for (var pageNo = 1; pageNo <= loopCount; ++pageNo) {
            var queryParams = "?" + encodeURIComponent("serviceKey") + "=" + process.env.SERVICE_KEY;
            queryParams += "&" + encodeURIComponent("numOfRows") + "=" + encodeURIComponent(pageNo == loopCount ? endRows : numOfRows);
            queryParams += "&" + encodeURIComponent("pageNo") + "=" + encodeURIComponent(pageNo);
            queryParams += "&" + encodeURIComponent("type") + "=" + encodeURIComponent("json");

            await insertPermission(url, queryParams).then(() => {
                process.stdout.clearLine();
                process.stdout.cursorTo(0);
                process.stdout.write(`* * * Permission: ${pageNo}/${loopCount} 적재 성공`);  // write text
            }).catch(async () => {
                console.log(`\n* * * Permission: 적재에 실패하여 재시도합니다. (pageNo: ${pageNo})\n`);
                await insertPermission(url, queryParams).catch(() => {
                    console.log(`\n* * * Permission: 재시도에 실패하여 스킵합니다. (pageNo: ${pageNo})\n`);
                });
            });
        }
        console.log("\n* * * Permission: 허가데이터 저장 완료 " + Date());
        resolve();
    });
}

function householdDB() {
    return new Promise(async function (resolve, reject) {
        var url = "http://apis.data.go.kr/1471000/SafeStadDrugService/getSafeStadDrugInq";
        var queryParams = "?" + encodeURIComponent("serviceKey") + "=" + process.env.SERVICE_KEY;
        queryParams += "&" + encodeURIComponent("numOfRows") + "=" + encodeURIComponent(1);
        queryParams += "&" + encodeURIComponent("pageNo") + "=" + encodeURIComponent(1);
        let option = {
            'method': 'GET',
            'url': url + queryParams
        };
        let totalCount = await getTotalCount(option);

        // 공공데이터 조회
        var numOfRows = 7;
        var loopCount = Math.ceil(totalCount / numOfRows, 0);
        var endRows = totalCount % numOfRows;

        for (var pageNo = 1; pageNo <= loopCount; ++pageNo) {
            var queryParams = "?" + encodeURIComponent("serviceKey") + "=" + process.env.SERVICE_KEY;
            queryParams += "&" + encodeURIComponent("numOfRows") + "=" + encodeURIComponent(pageNo == loopCount ? endRows : numOfRows);
            queryParams += "&" + encodeURIComponent("pageNo") + "=" + encodeURIComponent(pageNo);
            queryParams += "&" + encodeURIComponent("type") + "=" + encodeURIComponent("json");

            await insertHousehold(url, queryParams).then(() => {
                process.stdout.clearLine();
                process.stdout.cursorTo(0);
                process.stdout.write(`* * * Household: ${pageNo}/${loopCount} 적재 성공`);  // write text
            }).catch(async () => {
                console.log(`\n* * * Household: 적재에 실패하여 재시도합니다. (pageNo: ${pageNo})\n`);
                await insertHousehold(url, queryParams).catch(() => {
                    console.log(`\n* * * Household: 재시도에 실패하여 스킵합니다. (pageNo: ${pageNo})\n`);
                });
            });
        }
        console.log("\n* * * Household: 안전상비약데이터 저장 완료 " + Date());
        resolve();
    });
}

module.exports = { grainDB, permissionDB, householdDB }