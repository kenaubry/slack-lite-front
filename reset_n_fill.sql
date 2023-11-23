DROP TABLE IF EXISTS "public"."message";
DROP TABLE IF EXISTS "public"."thread";
DROP TABLE IF EXISTS "public"."user";

CREATE TABLE "public"."user" (
	"id" uuid NOT NULL,
	"name" varchar(50) NOT NULL,
	"avatar" varchar(50) NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE "public"."thread" (
    "id" uuid NOT NULL,
    "label" varchar(255) NOT NULL,
	"locked" boolean NOT NULL DEFAULT false,
    PRIMARY KEY ("id")
);

CREATE TABLE "public"."message" (
    "id" uuid NOT NULL,
    "author_id" uuid NOT NULL,
	"thread_id" uuid NOT NULL REFERENCES "public"."thread" ON DELETE CASCADE,
    "content" text NOT NULL,
    "date" timestamp NOT NULL DEFAULT now(),
    CONSTRAINT "messages_author" FOREIGN KEY ("author_id") REFERENCES "public"."user"("id"),
    CONSTRAINT "messages_thread" FOREIGN KEY ("thread_id") REFERENCES "public"."thread"("id"),
    PRIMARY KEY ("id")
);

INSERT INTO "public"."user" ("id", "name", "avatar")
VALUES
	('6d6ba1eb-3f9f-41b3-88af-fd3a959faeaa', 'Angelisium',    '/assets/alexis.ava.png' ),
	('f0059590-a2ff-4c3a-84a5-ad081e06b68f', 'Le grabataire', '/assets/socrate.ava.png'),
	('e6d8b859-22ea-4d4d-a958-f7677a23a38b', 'Alice',         '/assets/alice.ava.png'  ),
	('3264ad20-d695-4b06-8989-5d33a710cfd8', 'asmaria',       '/assets/anna.ava.png'),
	('2b477890-5472-4e35-9ff7-3ff39149ac49', 'Max',           '/assets/max.ava.png'),
	('e95c7e57-2ca4-4878-9e65-deed5fe760b9', 'AstreLune',     '/assets/poupee.ava.png'),
	('49f745ec-063f-41ae-96ce-8cac357e9dd3', 'azaml',         '/assets/azaml.ava.png'),
	('5ecded0e-8742-49eb-bf29-f5c5a23d25c9', 'Farid',         '/assets/deadpool.ava.png'),
	('f59e99dd-0fd7-43fc-8e83-b789a3cffe32', 'Fab',           '/assets/avatar.ava.png');

INSERT INTO "public"."thread" ("id", "label", "locked")
VALUES
	('6c77bdf7-477d-4147-b5fc-b849021936be', 'Général',      true ),
	('4cb26429-38ad-45f5-9d66-60ebb4a24e1e', 'Hello 🌎',     false),
	('023b9fc1-3126-4864-8f7e-ff3a88908cd8', 'El Pistolero', false);

INSERT INTO "public"."message" ("id", "author_id", "thread_id", "content", "date")
VALUES (
	'f693ee69-8020-419f-ae23-2822875ebfb2',
	'e6d8b859-22ea-4d4d-a958-f7677a23a38b',
	'6c77bdf7-477d-4147-b5fc-b849021936be',
	E'Bonjour tout le monde, j''esp&egrave;re que vous allez bien !\n\nPetite mise &agrave; jour des fonctionnalit&eacute;s de discussion, maintenant, vous pouvez mettre le texte **en gras** (**), //en italique// (//), --le barr&eacute;-- (--) et __le soulign&eacute;__ (__) !\n\nVous pouvez &eacute;galement utiliser des outils de jeu de r&ocirc;le, les d&egrave;s (d4, 6, 8, 10, 12, 20 et 100) : {d4:1}, {d6:6}, {d8:1}, {d10:2}, {d12:4}, {d20:18} et {d100:52}',
	'2023-09-02 12:49:58.662259'
),(
	'7d317a8a-d611-4893-9cbe-0f82a1ce9104',
	'6d6ba1eb-3f9f-41b3-88af-fd3a959faeaa',
	'4cb26429-38ad-45f5-9d66-60ebb4a24e1e',
	E'Salut &agrave; tous,\nAujourd''hui j''ai manger de la pizza et vous ?\n\nD''ailleurs, &ccedil;a me fait pensez, qui ici est chaud pour une pizza-party ?',
	'2023-09-02 12:10:45.843813'
),(
	'a24b8b82-24bf-457f-a47b-6fbae46bd90f',
	'e6d8b859-22ea-4d4d-a958-f7677a23a38b',
	'4cb26429-38ad-45f5-9d66-60ebb4a24e1e',
	E'Let''s go !!\nTrop h&acirc;te 😋',
	'2023-09-02 12:51:04.45488'
),(
	'1aaf0ad6-2f45-4582-9ff2-b028ba47511b',
	'6d6ba1eb-3f9f-41b3-88af-fd3a959faeaa',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'El Pistolero, le meilleur tireur de l''Outre-monde, est une l&eacute;gende vivante. Son regard per&ccedil;ant et son adresse in&eacute;gal&eacute;e font de lui une force redoutable. Il manie son //Lance-pile Mark II// avec une pr&eacute;cision mortelle, abattant ses ennemis avant m&ecirc;me qu''ils aient le temps de r&eacute;agir.\n\nMais la mort l''a finalement rattrap&eacute;, laissant derri&egrave;re lui un titre vacant. D&eacute;sormais, les aspirants tireurs doivent se battre &agrave; mort pour obtenir le titre tant convoit&eacute; d'' &laquo; El Pistolero &raquo;. Les balles vont siffler et les Lance-pile vont surchauffer dans cette lutte impitoyable pour la supr&eacute;matie. Seul le plus habile et le plus impitoyable pourra revendiquer le titre et h&eacute;riter de la l&eacute;gende d''El Pistolero.\n\n**Les r&egrave;gles :**\n\nChoisis ta cible parmi les survivants, puis lance un {d****6} !\n\nSi le destin te sourit avec un 6, ta cible sera &eacute;limin&eacute;e, t''approchant ainsi du titre redout&eacute; d'' &laquo; El Pistolero &raquo;.\n\nMais m&eacute;fie-toi, un malheureux 1 te blessera gravement, t''emp&ecirc;chant de rejouer pendant une heure.\n\nChaque nuit, apr&egrave;s l''attaque, les &eacute;limin&eacute;s peuvent revenir ! Pr&eacute;pare-toi &agrave; affronter tes adversaires, car m&ecirc;me les morts peuvent revenir hanter tes pas.\n\nSauras-tu prendre les risques n&eacute;cessaires pour obtenir le meilleur score et r&eacute;gner en tant que ma&icirc;tre du jeu ?\nPr&eacute;pare-toi &agrave; affronter les t&eacute;n&egrave;bres et &agrave; laisser ta marque ind&eacute;l&eacute;bile dans ce jeu impitoyable.',
	'2023-09-04 09:55:37.636571'
),(
	'70aa0282-b2ae-42c0-9d0b-2577fe527b61',
	'e6d8b859-22ea-4d4d-a958-f7677a23a38b',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'Je commence !\nAngelisium &rarr; {d6:5}', '2023-09-04 11:36:14.935401'
),(
	'5a49522d-286c-4542-9b2e-d01d77acb944',
	'f0059590-a2ff-4c3a-84a5-ad081e06b68f',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'**Angelisium**, on peut pas tirer &agrave; r&eacute;p&eacute;tition quand m&ecirc;me, ne sommes nous pas tous &eacute;quip&eacute; du fameux lance pile 6 coups ?',
	'2023-09-04 11:39:18.451649'
),(
	'3593950f-10a4-4750-ad91-87245177a225',
	'6d6ba1eb-3f9f-41b3-88af-fd3a959faeaa',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'Tu peux tirer &agrave; l''infini, mais pas le droit de tirer deux fois de suite (faut un tir de quelqu''un d''autre entre les deux quoi).\nJe vais tirer Alice du coup : {d6:1} 👀',
	'2023-09-04 11:40:37.343544'
),(
	'29bdf66c-1bc2-4d8b-961b-e85101483773',
	'e6d8b859-22ea-4d4d-a958-f7677a23a38b',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'Ah ah ah, Angelisium s''empare d''un lance pile tra&icirc;nant dans les parages et, dans son empressement, s''explose un pied.\nPas d''inqui&eacute;tude, dans une heure, quand la douleur se sera att&eacute;nu&eacute;, tu pourras rejouer !\n\nLe grabataire, prend ta pile &rarr; {d6:6}',
	'2023-09-04 11:41:35.119119'
),(
	'800a9e1c-a375-4b14-ad3a-c400cf26b2d7',
	'e6d8b859-22ea-4d4d-a958-f7677a23a38b',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'Yeah 😎\n\n**score :**\nAlice : 1',
	'2023-09-04 11:41:52.047498'
),(
	'f19f3804-93fd-48ab-baae-96e0a0161497',
	'3264ad20-d695-4b06-8989-5d33a710cfd8',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'un {d6:5} en plein dans Alice',
	'2023-09-04 11:43:48.339192'
),(
	'48f32212-bdf5-45a6-9ea8-ff26799415d9',
	'2b477890-5472-4e35-9ff7-3ff39149ac49',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'Pan pan {d6:5}',
	'2023-09-04 11:44:10.187263'
),(
	'5c513795-79c0-48e6-ac53-44e6338da69a',
	'e95c7e57-2ca4-4878-9e65-deed5fe760b9',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'{d6:3} pan !',
	'2023-09-04 11:44:28.750293'
),(
	'4042e117-e55f-4a41-8f42-f2cfcd25fcc3',
	'6d6ba1eb-3f9f-41b3-88af-fd3a959faeaa',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'S''il vous pla&icirc;t, pensez &agrave; bien mettre la cible et le d&eacute; dans le m&ecirc;me message.\nMax &rarr; {d6:6}',
	'2023-09-04 11:45:02.025317'
),(
	'5bd888a4-8cf1-4d91-923b-ae565f6a5e3d',
	'6d6ba1eb-3f9f-41b3-88af-fd3a959faeaa',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'//score ://\nAlice, Angelisium : 1',
	'2023-09-04 11:45:24.499796'
),(
	'0f9c75ca-ce60-4e76-a0c5-ea3196d8611c',
	'e6d8b859-22ea-4d4d-a958-f7677a23a38b',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'Faites gaffes ! Les piles filent de partout et vous ne pr&eacute;venez m&ecirc;me plus sur qui vous tirez !\nTiens &ccedil;a vas te calmer un peu AstreLune ! {d6:1}',
	'2023-09-04 11:46:42.433725'
),(
	'951d7542-d14a-414f-a843-b53a014dac31',
	'e6d8b859-22ea-4d4d-a958-f7677a23a38b',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'Alice, vise fi&egrave;rement AstreLune mais le rate de peu. En revanche, elle ne rate pas la banque juste derri&egrave;re... Une grosse poutre rafistol&eacute;e lui tombe dessus ... Il lui faudra une bonne heure, le temps de sortir des d&eacute;combres 🙃',
	'2023-09-04 11:48:23.531511'
),(
	'2be49ec6-4b42-49ac-9219-70dd7e62e6e2',
	'49f745ec-063f-41ae-96ce-8cac357e9dd3',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'Merde mon pistolet a tir&eacute; tout seul toi Alice {d6:3}',
	'2023-09-04 11:54:32.992454'
),(
	'a07a9ae2-bb4b-49c6-ba22-87a074a55df1',
	'3264ad20-d695-4b06-8989-5d33a710cfd8',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'vise azaml le traitre {d6:1}',
	'2023-09-04 11:55:12.012175'
),(
	'ab5ea2de-0d0f-4cb8-a145-6d329dd7d957',
	'e6d8b859-22ea-4d4d-a958-f7677a23a38b',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'asmaria tente un tir sur azaml, mais l''arme reste coinc&eacute;e dans sa ceinture &agrave; poches. La blessure au pied lui arrache un cri de douleur, il lui faudra au moins une heure avant de pouvoir se battre &agrave; nouveau.',
	'2023-09-04 11:56:03.23396'
),(
	'a6e5020d-a45c-4fb8-b94d-0ba40d685918',
	'2b477890-5472-4e35-9ff7-3ff39149ac49',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'Prend &ccedil;a le grabataire ! {d6:3}',
	'2023-09-04 11:57:29.309795'
),(
	'e8b14671-c560-405d-9ae9-d861b00a2d7f',
	'f0059590-a2ff-4c3a-84a5-ad081e06b68f',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'Moi je dit cheh + vengeance {d6:5} !',
	'2023-09-04 11:58:02.849784'
),(
	'd65f1470-f5ef-42ce-8468-a7187ba1dcb5',
	'e95c7e57-2ca4-4878-9e65-deed5fe760b9',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'Je vise asmarie : {d6:1}',
	'2023-09-04 12:01:12.930876'
),(
	'55a71020-14fd-45c2-b272-23f3312c70d8',
	'e95c7e57-2ca4-4878-9e65-deed5fe760b9',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	E'wesh 😭',
	'2023-09-04 12:01:23.730677'
),(
	'bf48ef2c-41b9-41d2-a9a7-72418efdaa55',
	'e6d8b859-22ea-4d4d-a958-f7677a23a38b',
	'023b9fc1-3126-4864-8f7e-ff3a88908cd8',
	'Ah ah, vous &ecirc;tes chaud aujourd''hui !',
	'2023-09-04 12:40:21.82667'
);
