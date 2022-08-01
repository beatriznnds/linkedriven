CREATE TABLE "public.users" (
	"id" serial NOT NULL PRIMARY KEY,
	"name" TEXT NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL,
	CONSTRAINT "users_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.addresses" (
	"id" serial NOT NULL PRIMARY KEY,
	"idUser" integer NOT NULL UNIQUE,
	"street" TEXT NOT NULL,
	"number" integer NOT NULL,
	"complement" TEXT,
	"postalCode" TEXT NOT NULL,
	"cityId" integer NOT NULL UNIQUE,
	CONSTRAINT "addresses_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.cities" (
	"id" serial NOT NULL PRIMARY KEY,
	"name" serial NOT NULL,
	CONSTRAINT "cities_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.products" (
	"id" serial NOT NULL PRIMARY KEY,
	"name" TEXT NOT NULL,
	"price" DECIMAL NOT NULL,
	"pictureId" integer NOT NULL UNIQUE,
	"categoryId" integer NOT NULL UNIQUE,
	"sizeId" integer NOT NULL UNIQUE,
	"morePicturesId" integer,
	CONSTRAINT "products_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.pictures" (
	"id" serial NOT NULL PRIMARY KEY,
	"url" serial NOT NULL,
	"productId" serial NOT NULL UNIQUE,
	CONSTRAINT "pictures_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.morePictures" (
	"id" serial NOT NULL PRIMARY KEY,
	"url" serial NOT NULL,
	"mainPictureId" integer NOT NULL UNIQUE,
	CONSTRAINT "morePictures_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TYPE type AS ENUM ('P', 'M', 'G');
CREATE TABLE "public.categories" (
	"id" serial NOT NULL PRIMARY KEY,
	"name" type,
	CONSTRAINT "categories_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.sizes" (
	"id" serial NOT NULL PRIMARY KEY,
	"name" TEXT NOT NULL,
	CONSTRAINT "sizes_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.orders" (
	"id" serial NOT NULL PRIMARY KEY,
	"productId" integer NOT NULL UNIQUE,
	"amount" integer NOT NULL,
	"userOrderId" integer NOT NULL UNIQUE,
	CONSTRAINT "orders_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TYPE status AS ENUM ('created', 'paid', 'delivered', 'cancelled')
CREATE TABLE "public.userOrder" (
	"id" serial NOT NULL PRIMARY KEY,
	"userId" BINARY NOT NULL UNIQUE,
	"addressId" BINARY NOT NULL UNIQUE,
	"date" DATE NOT NULL DEFAULT NOW(),
	"status" status,
	"total" DECIMAL NOT NULL,
	CONSTRAINT "userOrder_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);




ALTER TABLE "addresses" ADD CONSTRAINT "addresses_fk0" FOREIGN KEY ("idUser") REFERENCES "users"("id");
ALTER TABLE "addresses" ADD CONSTRAINT "addresses_fk1" FOREIGN KEY ("cityId") REFERENCES "cities"("id");


ALTER TABLE "products" ADD CONSTRAINT "products_fk0" FOREIGN KEY ("pictureId") REFERENCES "pictures"("id");
ALTER TABLE "products" ADD CONSTRAINT "products_fk1" FOREIGN KEY ("categoryId") REFERENCES "categories"("id");
ALTER TABLE "products" ADD CONSTRAINT "products_fk2" FOREIGN KEY ("sizeId") REFERENCES "sizes"("id");
ALTER TABLE "products" ADD CONSTRAINT "products_fk3" FOREIGN KEY ("morePicturesId") REFERENCES "morePictures"("id");

ALTER TABLE "pictures" ADD CONSTRAINT "pictures_fk0" FOREIGN KEY ("productId") REFERENCES "products"("id");

ALTER TABLE "morePictures" ADD CONSTRAINT "morePictures_fk0" FOREIGN KEY ("mainPictureId") REFERENCES "pictures"("id");



ALTER TABLE "orders" ADD CONSTRAINT "orders_fk0" FOREIGN KEY ("productId") REFERENCES "products"("id");
ALTER TABLE "orders" ADD CONSTRAINT "orders_fk1" FOREIGN KEY ("userOrderId") REFERENCES "userOrder"("id");

ALTER TABLE "userOrder" ADD CONSTRAINT "userOrder_fk0" FOREIGN KEY ("userId") REFERENCES "users"("id");
ALTER TABLE "userOrder" ADD CONSTRAINT "userOrder_fk1" FOREIGN KEY ("addressId") REFERENCES "addresses"("id");











