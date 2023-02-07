const scheduler = require("node-schedule");

const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const { grainDB, permissionDB, householdDB } = require('../util/OpenAPI');

// 매일 새벽 3시마다 실행
const schedule = scheduler.scheduleJob("0 00 3 * * *", async function () {
    // 저장된 데이터 전체 삭제
    await prisma.$queryRaw`TRUNCATE TABLE grain;`
    await prisma.$queryRaw`TRUNCATE TABLE permission;`
    await prisma.$queryRaw`TRUNCATE TABLE household;`

    grainDB();
    permissionDB();
    householdDB();
});