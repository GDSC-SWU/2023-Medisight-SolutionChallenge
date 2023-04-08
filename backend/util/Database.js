const scheduler = require("node-schedule");
const request = require("request");

const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const { grainDB, permissionDB, householdDB } = require('../util/OpenAPI');

// 매일 새벽 3시마다 실행
const schedule = scheduler.scheduleJob("0 00 3 * * *", async function () {
    try {
        await prisma.$queryRaw`TRUNCATE TABLE Permission;`
        await permissionDB();

        await prisma.$queryRaw`TRUNCATE TABLE Grain;`
        await grainDB();

        await prisma.$queryRaw`TRUNCATE TABLE Household;`
        await householdDB();

    } catch (err) {
        console.log(err);
    }
});

const health_check = scheduler.scheduleJob("0 */20 * * * *", function () {
    const options = {
        uri: "https://hc-ping.com/8a296db2-45af-4f48-96d5-ee17e8a7ae9d"
    };
    request.get(options, function (error, response, body) {
        if (error) {
            console.log("* * * Health Check: 실패 (" + Date() + ")");
            console.log(response);
        }
        else {
            console.log("* * * Health Check: OK (" + Date() + ")");
        }
    });
});