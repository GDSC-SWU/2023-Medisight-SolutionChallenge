const scheduler = require("node-schedule");

const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const { grainDB, permissionDB, householdDB } = require('../util/OpenAPI');

// 매일 새벽 3시마다 실행
const schedule = scheduler.scheduleJob("0 00 3 * * *", async function () {
    try {
        // 저장된 데이터 전체 삭제
        await prisma.$queryRaw`TRUNCATE TABLE Grain;`
        await prisma.$queryRaw`TRUNCATE TABLE Permission;`
        await prisma.$queryRaw`TRUNCATE TABLE Household;`

        grainDB();
        permissionDB();
        householdDB();
    } catch (err) {
        console.log(err);
    }
});