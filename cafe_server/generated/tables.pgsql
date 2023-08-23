--
-- Class Cafe as table cafe
--

CREATE TABLE "cafe" (
  "id" serial,
  "url" text NOT NULL,
  "name" text NOT NULL,
  "sub" text NOT NULL,
  "harga" text NOT NULL,
  "jenis" text NOT NULL
);

ALTER TABLE ONLY "cafe"
  ADD CONSTRAINT cafe_pkey PRIMARY KEY (id);


