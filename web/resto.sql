drop view commandeactuel;
drop view addition;
drop view detailsaddition;
drop view nombre;
drop view detailscomposition;
drop view prixdevente;
drop view prixderevient;
drop view platdisponible;
drop view listepourboire;
drop view ingredientinsuffisant;

drop table stock;
drop table composition;
drop table ingredients;
drop table condition;
drop table detailscommande;
drop table commande;
drop table plat;
drop table categorie;
drop table tabla;
drop table serveur;

drop sequence id;
drop sequence idingredient;
drop sequence idstock;

--		CREATION TABLE 		----------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE categorie(
	id serial PRIMARY KEY,
	nom varchar(50) not null
);

CREATE TABLE plat(
	id serial PRIMARY KEY,
	idcategorie int REFERENCES categorie(id),
	nom varchar(50) not null, 
	prix real not null
);


CREATE TABLE ingredients(
	idingredient serial PRIMARY KEY,
	nom varchar(50) not null 	
);

CREATE TABLE composition(
	idcomposition serial PRIMARY KEY,
	idplat int REFERENCES plat(id),
	idingredient int  REFERENCES ingredients(idingredient),
	quantite int 	
);

CREATE TABLE stock(
	idstock serial PRIMARY KEY,
	idingredient int REFERENCES ingredients(idingredient),
	quantite int,
	prixunitaire real
);

CREATE TABLE condition(
	idconfig serial PRIMARY KEY,
	min real,
	max real,
	pourcentage double precision
);


CREATE TABLE serveur(
	id serial PRIMARY KEY,
	nom VARCHAR(100)
);


CREATE TABLE tabla(
	id serial PRIMARY KEY,
	nom VARCHAR(100)
);

CREATE TABLE commande(
	id serial PRIMARY KEY,
	idserveur int REFERENCES serveur(id),
	idtabla int REFERENCES tabla(id),
	datecommande timestamp
);

CREATE TABLE detailscommande(
	id serial PRIMARY KEY,
	idcommande int REFERENCES commande(id),
	idserveur int REFERENCES serveur(id),
	idplat int,
	prixunitaire real
);



--		CREATION  		----------------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE id increment by 1;
CREATE SEQUENCE idingredient increment by 1;
CREATE SEQUENCE idstock increment by 1;

--		CREATION VIEW 		----------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW ingredientinsuffisant as SELECT plat.id,plat.nom from plat 
join composition on plat.id = composition.idplat
join ingredients on composition.idingredient = ingredients.idingredient
join stock on stock.idingredient = ingredients.idingredient
WHERE stock.quantite < composition.quantite;

CREATE VIEW platdisponible as SELECT * from plat where id NOT IN( select id from ingredientinsuffisant);

CREATE VIEW prixderevient as SELECT plat.id,plat.nom,sum(composition.quantite*stock.prixunitaire) as prixderevient from public.plat 
join public.composition on plat.id = composition.idplat
join public.ingredients on composition.idingredient = ingredients.idingredient
join public.stock on stock.idingredient = ingredients.idingredient GROUP BY plat.id;

CREATE VIEW detailscomposition as 
select plat.id ,plat.nom as plat_nom,ingredients.nom as ingredient_nom,composition.quantite,stock.prixunitaire,(composition.quantite*stock.prixunitaire) as prixfinale from 
plat join composition on plat.id=composition.idplat
join ingredients on composition.idingredient=ingredients.idingredient
join stock on ingredients.idingredient= stock.idingredient;

CREATE VIEW prixdevente as
select prixderevient.*,
(select pourcentage from condition where prixderevient>=condition.min and prixderevient<=condition.max)*prixderevient/100+prixderevient  as prixdevente,
(select pourcentage from condition where prixderevient>=condition.min and prixderevient<=condition.max) as marge
from prixderevient;

CREATE VIEW listepourboire as
select detailscommande.idserveur,(select nom from serveur where id=detailscommande.idserveur),
((sum(detailscommande.prixunitaire)*2)/100) as pourboire,commande.datecommande from commande 
join serveur on commande.idserveur=serveur.id
join detailscommande on commande.id=detailscommande.idcommande
group by commande.id,detailscommande.idserveur;

CREATE VIEW addition as 
SELECT commande.idtabla,(select nom from tabla where tabla.id=commande.idtabla),sum(detailscommande.prixunitaire) from
commande join tabla on commande.idtabla= tabla.id
join detailscommande on commande.id=detailscommande.idcommande
group by commande.id;

CREATE VIEW  nombre as
select idcommande,idplat,count(*) as nombre
from commande 
join detailscommande on commande.id = detailscommande.idcommande
join plat on detailscommande.idplat= plat.id
group by idcommande,idplat;

CREATE VIEW detailsaddition as
select (select idtabla from commande as c where c.id = idcommande), 
(select nom from plat as p where p.id=idplat),
count(*) as nombre, 
prixunitaire,
(prixunitaire*
(SELECT nombre from nombre where nombre.idcommande=detailscommande.idcommande AND nombre.idplat=detailscommande.idplat ))
from commande 
join detailscommande on commande.id = detailscommande.idcommande
group by detailscommande.idcommande,detailscommande.idplat,detailscommande.prixunitaire;

CREATE VIEW commandeactuel as
select id as idtabla,
(select id from commande c where c.idtabla=tabla.id order by datecommande desc limit 1) as idcommande
from tabla ;

--		INSERTION  		----------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO public.tabla(id, nom)VALUES (nextval('tabla_id_seq'::regclass), 'Table rose');
INSERT INTO public.tabla(id, nom)VALUES (nextval('tabla_id_seq'::regclass), 'Table bleu');
INSERT INTO public.tabla(id, nom)VALUES (nextval('tabla_id_seq'::regclass), 'Table verte');
INSERT INTO public.tabla(id, nom)VALUES (nextval('tabla_id_seq'::regclass), 'Table blanche');

INSERT INTO public.categorie(id, nom) VALUES (nextval('categorie_id_seq'::regclass), 'entre');	--1
INSERT INTO public.categorie(id, nom) VALUES (nextval('categorie_id_seq'::regclass), 'resistance');	--2
INSERT INTO public.categorie(id, nom) VALUES (nextval('categorie_id_seq'::regclass), 'dessert');--3

INSERT INTO public.plat(id, idcategorie,nom, prix) VALUES (nextval('plat_id_seq'::regclass), 2,'Compose', 2000 );	--1
INSERT INTO public.plat(id, idcategorie,nom, prix) VALUES (nextval('plat_id_seq'::regclass), 2,'Minsao simple', 3500 );	--2
INSERT INTO public.plat(id, idcategorie,nom, prix) VALUES (nextval('plat_id_seq'::regclass), 2,'Minsao special', 3800 );	--3
INSERT INTO public.plat(id, idcategorie,nom, prix) VALUES (nextval('plat_id_seq'::regclass), 2,'Vary',1500 );	--4
INSERT INTO public.plat(id, idcategorie,nom, prix) VALUES (nextval('plat_id_seq'::regclass), 1,'Milkshake', 2000 );	--5
INSERT INTO public.plat(id, idcategorie,nom, prix) VALUES (nextval('plat_id_seq'::regclass), 2,'Gratin', 3000 ); --6
INSERT INTO public.plat(id, idcategorie,nom, prix) VALUES (nextval('plat_id_seq'::regclass), 2,'Soupe chinoise', 1500 ); --7
INSERT INTO public.plat(id, idcategorie,nom, prix) VALUES (nextval('plat_id_seq'::regclass), 2,'Soupe vantan', 2500 );	--8
INSERT INTO public.plat(id, idcategorie,nom, prix) VALUES (nextval('plat_id_seq'::regclass), 2,'Soupe special', 3500 );	--9
INSERT INTO public.plat(id, idcategorie,nom, prix) VALUES (nextval('plat_id_seq'::regclass), 2,'Soupe atody', 2000 );	--10
INSERT INTO public.plat(id, idcategorie,nom, prix) VALUES (nextval('plat_id_seq'::regclass), 3,'salade de fruit ', 1500 );	--11

INSERT INTO public.ingredients(idingredient, nom)VALUES (nextval('ingredients_idingredient_seq'::regclass), 'patte');	--1
INSERT INTO public.ingredients(idingredient, nom)VALUES (nextval('ingredients_idingredient_seq'::regclass), 'oeuf');	--2
INSERT INTO public.ingredients(idingredient, nom)VALUES (nextval('ingredients_idingredient_seq'::regclass), 'riz');	--3
INSERT INTO public.ingredients(idingredient, nom)VALUES (nextval('ingredients_idingredient_seq'::regclass), 'carotte');	--4
INSERT INTO public.ingredients(idingredient, nom)VALUES (nextval('ingredients_idingredient_seq'::regclass), 'pomme de terre');	--5
INSERT INTO public.ingredients(idingredient, nom)VALUES (nextval('ingredients_idingredient_seq'::regclass), 'sauce soja');	--6
INSERT INTO public.ingredients(idingredient, nom)VALUES (nextval('ingredients_idingredient_seq'::regclass), 'sel');	--7
INSERT INTO public.ingredients(idingredient, nom)VALUES (nextval('ingredients_idingredient_seq'::regclass), 'lait');	--8
INSERT INTO public.ingredients(idingredient, nom)VALUES (nextval('ingredients_idingredient_seq'::regclass), 'vantan');	--9
INSERT INTO public.ingredients(idingredient, nom)VALUES (nextval('ingredients_idingredient_seq'::regclass), 'viande de porc');	--10
INSERT INTO public.ingredients(idingredient, nom)VALUES (nextval('ingredients_idingredient_seq'::regclass), 'banane');	--11
INSERT INTO public.ingredients(idingredient, nom)VALUES (nextval('ingredients_idingredient_seq'::regclass), 'letchi');	--12



INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 1, 1, 2);--1800

INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 2, 1, 2);--2700
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 2, 4, 1);
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 2, 6, 1);

INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 3, 1, 2);--3200
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 3, 4, 1);
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 3, 6, 1);
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 3, 10, 1);

INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 4, 3, 1);--1000

INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 5, 8, 2);--1300
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 5, 11, 1);


INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 6, 3, 1);--2500
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 6, 8, 1);
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 6, 5, 1);

INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 7, 1, 1);--900

INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 8, 1, 1);--2000
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 8, 10, 1);
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 8, 6, 1);

INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 9, 1, 1);--2800
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 9, 10, 1);
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 9, 6, 1);
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 9, 2, 1);

INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 10, 1, 1);--1700
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 10, 2, 1);

INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 11, 11, 1);--800
INSERT INTO public.composition(idcomposition, idplat, idingredient, quantite)VALUES (nextval('composition_idcomposition_seq'::regclass), 11, 12, 1);


INSERT INTO public.stock(idstock, idingredient, quantite, prixunitaire)VALUES (nextval('stock_idstock_seq'::regclass), 1, 6, 900);
INSERT INTO public.stock(idstock, idingredient, quantite, prixunitaire)VALUES (nextval('stock_idstock_seq'::regclass), 2, 6, 800);
INSERT INTO public.stock(idstock, idingredient, quantite, prixunitaire)VALUES (nextval('stock_idstock_seq'::regclass), 3, 6, 1000);
INSERT INTO public.stock(idstock, idingredient, quantite, prixunitaire)VALUES (nextval('stock_idstock_seq'::regclass), 4, 6, 500);
INSERT INTO public.stock(idstock, idingredient, quantite, prixunitaire)VALUES (nextval('stock_idstock_seq'::regclass), 5, 6, 1000);
INSERT INTO public.stock(idstock, idingredient, quantite, prixunitaire)VALUES (nextval('stock_idstock_seq'::regclass), 6, 6, 600);
INSERT INTO public.stock(idstock, idingredient, quantite, prixunitaire)VALUES (nextval('stock_idstock_seq'::regclass), 7, 6, 100);
INSERT INTO public.stock(idstock, idingredient, quantite, prixunitaire)VALUES (nextval('stock_idstock_seq'::regclass), 8, 6, 500);
INSERT INTO public.stock(idstock, idingredient, quantite, prixunitaire)VALUES (nextval('stock_idstock_seq'::regclass), 9, 6, 400);
INSERT INTO public.stock(idstock, idingredient, quantite, prixunitaire)VALUES (nextval('stock_idstock_seq'::regclass), 10, 6, 500);
INSERT INTO public.stock(idstock, idingredient, quantite, prixunitaire)VALUES (nextval('stock_idstock_seq'::regclass), 11, 6, 300);
INSERT INTO public.stock(idstock, idingredient, quantite, prixunitaire)VALUES (nextval('stock_idstock_seq'::regclass), 12, 6, 500);

INSERT INTO public.condition(idconfig, min, max, pourcentage)VALUES (nextval('condition_idconfig_seq'::regclass), 0, 1000, 200);
INSERT INTO public.condition(idconfig, min, max, pourcentage)VALUES (nextval('condition_idconfig_seq'::regclass), 1001, 1500, 200);
INSERT INTO public.condition(idconfig, min, max, pourcentage)VALUES (nextval('condition_idconfig_seq'::regclass), 1501, 2000, 150);
INSERT INTO public.condition(idconfig, min, max, pourcentage)VALUES (nextval('condition_idconfig_seq'::regclass), 2001, 50000, 100);


INSERT INTO public.serveur(id, nom)VALUES (nextval('serveur_id_seq'::regclass), 'serv1');
INSERT INTO public.serveur(id, nom)VALUES (nextval('serveur_id_seq'::regclass), 'serv2');
INSERT INTO public.serveur(id, nom)VALUES (nextval('serveur_id_seq'::regclass), 'serv3');
INSERT INTO public.serveur(id, nom)VALUES (nextval('serveur_id_seq'::regclass), 'serv4');
INSERT INTO public.serveur(id, nom)VALUES (nextval('serveur_id_seq'::regclass), 'serv5');

INSERT INTO public.commande(id, idserveur, idtabla, datecommande)VALUES (nextval('commande_id_seq'::regclass), 1, 1, '2022-02-20 12:30:01.876007');
INSERT INTO public.commande(id, idserveur, idtabla, datecommande)VALUES (nextval('commande_id_seq'::regclass), 1, 2, '2022-02-21 12:00:20.876007');
INSERT INTO public.commande(id, idserveur, idtabla, datecommande)VALUES (nextval('commande_id_seq'::regclass), 2, 3, '2022-02-21 15:30:05.876007');
INSERT INTO public.commande(id, idserveur, idtabla, datecommande)VALUES (nextval('commande_id_seq'::regclass), 2, 4, '2022-03-04 09:15:17.876007');


INSERT INTO public.detailscommande(id, idcommande, idserveur, idplat, prixunitaire)VALUES (nextval('detailscommande_id_seq'::regclass), 1, 1, 1, 4500);
INSERT INTO public.detailscommande(id, idcommande, idserveur, idplat, prixunitaire)VALUES (nextval('detailscommande_id_seq'::regclass), 1, 4, 1, 4500);
INSERT INTO public.detailscommande(id, idcommande, idserveur, idplat, prixunitaire)VALUES (nextval('detailscommande_id_seq'::regclass), 1, 4, 1, 4500);


INSERT INTO public.detailscommande(id, idcommande, idserveur, idplat, prixunitaire)VALUES (nextval('detailscommande_id_seq'::regclass), 2, 2, 7, 2700);
INSERT INTO public.detailscommande(id, idcommande, idserveur, idplat, prixunitaire)VALUES (nextval('detailscommande_id_seq'::regclass), 3, 2, 11, 2400);
INSERT INTO public.detailscommande(id, idcommande, idserveur, idplat, prixunitaire)VALUES (nextval('detailscommande_id_seq'::regclass), 4, 2, 2, 5800);
INSERT INTO public.detailscommande(id, idcommande, idserveur, idplat, prixunitaire)VALUES (nextval('detailscommande_id_seq'::regclass), 4, 5, 2, 5800);