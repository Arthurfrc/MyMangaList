-- CreateTable
CREATE TABLE "Person" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT,
    "email" TEXT
);

-- CreateTable
CREATE TABLE "Manga" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "numbersId" TEXT NOT NULL,
    CONSTRAINT "Manga_numbersId_fkey" FOREIGN KEY ("numbersId") REFERENCES "Numbers" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Numbers" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "number" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Chapters" (
    "numbersId" TEXT NOT NULL,
    "mangaId" TEXT NOT NULL,
    "check" BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT "Chapters_numbersId_fkey" FOREIGN KEY ("numbersId") REFERENCES "Numbers" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Chapters_mangaId_fkey" FOREIGN KEY ("mangaId") REFERENCES "Manga" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Chapters_numbersId_mangaId_key" ON "Chapters"("numbersId", "mangaId");
