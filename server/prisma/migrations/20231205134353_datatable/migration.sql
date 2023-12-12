-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User_Manga" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "mangaId" INTEGER NOT NULL,
    "lastRead" REAL DEFAULT 1,
    CONSTRAINT "User_Manga_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "User_Manga_mangaId_fkey" FOREIGN KEY ("mangaId") REFERENCES "Manga" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_User_Manga" ("id", "lastRead", "mangaId", "userId") SELECT "id", "lastRead", "mangaId", "userId" FROM "User_Manga";
DROP TABLE "User_Manga";
ALTER TABLE "new_User_Manga" RENAME TO "User_Manga";
CREATE UNIQUE INDEX "User_Manga_userId_mangaId_key" ON "User_Manga"("userId", "mangaId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
