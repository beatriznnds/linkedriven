CREATE TABLE states (
    id serial NOT NULL PRIMARY KEY,
    name text NOT NULL
);

CREATE TABLE cities (
    id serial NOT NULL PRIMARY KEY,
    name text NOT NULL,
    "stateId" integer NOT NULL REFERENCES states(id)
);

CREATE TABLE customers (
    id serial NOT NULL PRIMARY KEY,
    "fullName" text NOT NULL,
    cpf varchar(11) NOT NULL UNIQUE,
    email text NOT NULL UNIQUE,
    password text NOT NULL
);

CREATE TABLE "customerAddresses" (
    id serial NOT NULL PRIMARY KEY,
    "customerId" integer REFERENCES customers(id) UNIQUE,
    street text NOT NULL,
    number integer NOT NULL,
    complement varchar(50),
    "postalCode" varchar(8) NOT NULL,
    "cityId" integer REFERENCES cities(id)
);

CREATE TYPE phone AS ENUM ('landline', 'mobile');
CREATE TABLE "customersPhone" (
    id serial NOT NULL PRIMARY KEY,
    "customerId" integer REFERENCES customers(id),
    number varchar(12) NOT NULL,
    type phone
);

CREATE TABLE "bankAccount" (
    id serial NOT NULL PRIMARY KEY,
    "customerId" integer REFERENCES customers(id),
    "accountNumber" integer NOT NULL,
    agency varchar(4) NOT NULL,
    "openDate" timestamp NOT NULL DEFAULT NOW(),
    "closeDate" timestamp
);

CREATE TYPE transaction AS ENUM ('deposit', 'withdraw');
CREATE TABLE transactions (
    id SERIAL NOT NULL PRIMARY KEY,
    "bankAccountId" integer NOT NULL REFERENCES "bankAccount"(id),
    amount number NOT NULL,
    type transaction,
    description text,
    cancelled boolean NOT NULL DEFAULT false
);


CREATE TABLE "creditCards" (
    id SERIAL NOT NULL PRIMARY KEY,
    "bankAccountId" integer NOT NULL REFERENCES "bankAccount"(id),
    name text UNIQUE NOT NULL,
    number varchar(16) NOT NULL,
    "securityCode" varchar(3) NOT NULL,
    "expirationMonth" varchar(2) NOT NULL,
    "expirationYear" varchar (4) NOT NULL,
    password varchar(4) NOT NULL,
    limit number NOT NULL
);