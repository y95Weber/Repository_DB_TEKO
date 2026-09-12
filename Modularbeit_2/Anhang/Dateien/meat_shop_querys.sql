-- public.kunde definition
-- Drop table
-- DROP TABLE public.kunde;

create table public.kunde (
	kundeid serial4 not null,
	vorname varchar(50) not null,
	nachname varchar(100) not null,
	email varchar(100) not null,
	telefon varchar(30) null,
	strasse varchar(150) not null,
	plz varchar(100) not null,
	ort varchar(100) not null,
	constraint kunde_email_key unique (email),
	constraint kunde_pkey primary key (kundeid)
);
-- public.tierart definition
-- Drop table
-- DROP TABLE public.tierart;

create table public.tierart (
	tierartid serial4 not null,
	bezeichnung varchar(50) not null,
	constraint tierart_pkey primary key (tierartid)
);
-- public.zuschnitt definition
-- Drop table
-- DROP TABLE public.zuschnitt;

create table public.zuschnitt (
	zuschnittid serial4 not null,
	bezeichnung varchar(50) not null,
	constraint zuschnitt_pkey primary key (zuschnittid)
);
-- public.bestellung definition
-- Drop table
-- DROP TABLE public.bestellung;

create table public.bestellung (
	bestellungid serial4 not null,
	kundeid int4 not null,
	bestelldatum timestamp default now() not null,
	status varchar(30) default 'offen'::character varying not null,
	lieferart varchar(30) not null,
	constraint bestellung_pkey primary key (bestellungid),
	constraint bestellung_kundeid_fkey foreign key (kundeid) references public.kunde(kundeid)
);
-- public.produkt definition
-- Drop table
-- DROP TABLE public.produkt;

create table public.produkt (
	produktid serial4 not null,
	"name" varchar(100) not null,
	preisprokg numeric(10, 2) not null,
	verpackungsgewicht numeric(10, 2) not null,
	beschreibung varchar(255) null,
	tierartid int4 not null,
	zuschnittid int4 not null,
	constraint produkt_pkey primary key (produktid),
	constraint produkt_tierartid_fkey foreign key (tierartid) references public.tierart(tierartid),
	constraint produkt_zuschnittid_fkey foreign key (zuschnittid) references public.zuschnitt(zuschnittid)
);
-- public.bestellposition definition
-- Drop table
-- DROP TABLE public.bestellposition;

create table public.bestellposition (
	bestellungid int4 not null,
	produktid int4 not null,
	menge int4 not null,
	einzelpreis numeric(10, 2) not null,
	constraint bestellposition_menge_check check ((menge > 0)),
	constraint bestellposition_pkey primary key (bestellungid,
produktid),
	constraint bestellposition_bestellungid_fkey foreign key (bestellungid) references public.bestellung(bestellungid),
	constraint bestellposition_produktid_fkey foreign key (produktid) references public.produkt(produktid)
);
