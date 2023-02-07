-- CreateTable
CREATE TABLE `Grain` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `itemSeq` VARCHAR(300) NOT NULL,
    `itemName` VARCHAR(300) NULL,
    `entpSeq` VARCHAR(300) NULL,
    `entpName` VARCHAR(300) NULL,
    `chart` VARCHAR(300) NULL,
    `itemImage` VARCHAR(300) NULL,
    `printFront` VARCHAR(300) NULL,
    `printBack` VARCHAR(300) NULL,
    `drugShape` VARCHAR(300) NULL,
    `colorClass1` VARCHAR(300) NULL,
    `colorClass2` VARCHAR(300) NULL,
    `lineFront` VARCHAR(300) NULL,
    `lineBack` VARCHAR(300) NULL,
    `lengLong` VARCHAR(300) NULL,
    `lengShort` VARCHAR(300) NULL,
    `thick` VARCHAR(300) NULL,
    `imgRegistTS` VARCHAR(300) NULL,
    `classNo` VARCHAR(300) NULL,
    `className` VARCHAR(300) NULL,
    `etcOtcName` VARCHAR(300) NULL,
    `itemPermitDate` VARCHAR(300) NULL,
    `formCodeName` VARCHAR(300) NULL,
    `markCodeFrontAnal` VARCHAR(300) NULL,
    `markCodeBackAnal` VARCHAR(300) NULL,
    `markCodeFrontImg` VARCHAR(300) NULL,
    `markCodeBackImg` VARCHAR(300) NULL,
    `itemEngName` VARCHAR(300) NULL,
    `changeDate` VARCHAR(300) NULL,
    `markCodeFront` VARCHAR(300) NULL,
    `markCodeBack` VARCHAR(300) NULL,
    `ediCode` VARCHAR(300) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Permission` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `itemSeq` VARCHAR(300) NOT NULL,
    `itemName` TEXT NULL,
    `entpName` TEXT NULL,
    `itemPermitDate` TEXT NULL,
    `cnsgnManuf` TEXT NULL,
    `etcOtcCode` TEXT NULL,
    `chart` TEXT NULL,
    `barCode` TEXT NULL,
    `materialName` TEXT NULL,
    `eeDocId` TEXT NULL,
    `udDocId` TEXT NULL,
    `nbDocId` TEXT NULL,
    `insertFile` TEXT NULL,
    `storageMethod` TEXT NULL,
    `validTerm` TEXT NULL,
    `reexamTarget` TEXT NULL,
    `reexamDate` TEXT NULL,
    `packUnit` TEXT NULL,
    `ediCode` TEXT NULL,
    `docText` TEXT NULL,
    `permitKindName` TEXT NULL,
    `entpNo` TEXT NULL,
    `makeMaterialFlag` TEXT NULL,
    `newdrugClassName` TEXT NULL,
    `indutyType` TEXT NULL,
    `cancelDate` TEXT NULL,
    `cancelName` TEXT NULL,
    `changeDate` TEXT NULL,
    `narcoticKindCode` TEXT NULL,
    `gbnName` TEXT NULL,
    `totalContent` TEXT NULL,
    `eeDocData` LONGTEXT NULL,
    `udDocData` LONGTEXT NULL,
    `nbDocData` LONGTEXT NULL,
    `pnDocData` LONGTEXT NULL,
    `mainItemIngr` TEXT NULL,
    `ingrName` TEXT NULL,
    `atcCode` TEXT NULL,
    `itemEngName` TEXT NULL,
    `entpEngName` TEXT NULL,
    `mainIngrEng` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `household` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `prdlstNm` VARCHAR(300) NULL,
    `bsshNm` VARCHAR(300) NULL,
    `vldPrdYmd` VARCHAR(300) NULL,
    `strgMthCont` VARCHAR(300) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
