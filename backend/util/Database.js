const scheduler = require("node-schedule");

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