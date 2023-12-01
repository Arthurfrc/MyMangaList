-- CreateTable
CREATE TABLE "Manga" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "link" TEXT,
    "last" INTEGER DEFAULT 1,
    "lastRead" INTEGER DEFAULT 1
);
