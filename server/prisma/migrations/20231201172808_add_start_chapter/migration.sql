/*
  Warnings:

  - You are about to drop the column `last` on the `Manga` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Manga" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "link" TEXT,
    "startC" INTEGER DEFAULT 1,
    "lastC" INTEGER DEFAULT 1,
    "lastRead" INTEGER DEFAULT 1
);
INSERT INTO "new_Manga" ("id", "lastRead", "link", "name") SELECT "id", "lastRead", "link", "name" FROM "Manga";
DROP TABLE "Manga";
ALTER TABLE "new_Manga" RENAME TO "Manga";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
