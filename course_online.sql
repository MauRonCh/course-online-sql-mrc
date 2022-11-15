-- Tables

CREATE TABLE "users" (
  "id" uuid PRIMARY KEY,
  "first_name" varchar,
  "last_name" varchar,
  "email" varchar,
  "password" varchar,
  "age" int8,
  "rol_id" int
);

CREATE TABLE "teacher" (
  "id" uuid PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "courses" (
  "id" uuid PRIMARY KEY,
  "title" varchar,
  "level" varchar,
  "teacher_id" uuid
);

CREATE TABLE "course_video" (
  "id" uuid PRIMARY KEY,
  "course_id" uuid,
  "title" varchar,
  "url" varchar
);

CREATE TABLE "categories" (
  "id" serial PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "courses_categories" (
  "id" uuid PRIMARY KEY,
  "course_id" uuid,
  "category_id" int
);

CREATE TABLE "users_courses" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid,
  "course_id" uuid,
  "review" varchar,
  "progress" int8
);

CREATE TABLE "roles" (
  "id" serial PRIMARY KEY,
  "name" varchar
);

ALTER TABLE "courses_categories" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "courses_categories" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("rol_id") REFERENCES "roles" ("id");

ALTER TABLE "courses" ADD FOREIGN KEY ("teacher_id") REFERENCES "teacher" ("id");

ALTER TABLE "users_courses" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "users_courses" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "course_video" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

-- Data

insert into roles (
		id,
		name
	) values (
		1,
		'admin'
	), (
		2,
		'teacher'
	), (
		3,
		'student'
	), (
		4,
		'no_account'
	);

insert into users (
	id,
	first_name,
	last_name,
	email,
	"password",
	age,
	rol_id 
) values (
	'b00fa4b6-902b-45be-88e5-4b70b1565562',
	'Mauricio',
	'Ronceros',
	'mronceroschavez@gmail.com',
	'contrase12',
	21,
	1
)
, (
	'161115d0-2adf-4309-b595-0fd62b39d22a',
	'Irving',
	'Gonzales',
	'kingtheslendykiller@gmail.com',
	'user1234',
	21,
	1
);

insert into teacher (
	id,
	name
) values (
	'02b9764d-4998-4bb6-88c8-0b58ff0520eb',
	'Nicolás Molina'
), (
	'6ef3e408-4453-4857-8039-a35f7532cb00',
	'Carlos Jimenez'
), (
	'a59bfd4a-19f9-4b79-8f34-7247314aa176',
	'Diana Martínez'
);

insert into courses (
	id,
	title,
	level,
	teacher_id
) values (
	'c0d010ee-0e90-4f28-8e2f-29c6f0b8063f',
	'Curso de Fundamentos de Angular',
	'begginer',
	'02b9764d-4998-4bb6-88c8-0b58ff0520eb'
), (
	'ca765afb-1c06-47e3-8665-02398d338941',
	'Curso Básico de Photoshop',
	'begginer',
	'6ef3e408-4453-4857-8039-a35f7532cb00'
);

insert into course_video (
	id,
	course_id,
	title,
	url
) values (
	'1a794808-3599-498a-9e41-e636c902abb4',
	'c0d010ee-0e90-4f28-8e2f-29c6f0b8063f',
	'Qué es Angular: ventajas y cómo aprenderlo',
	'https://platzi.com/clases/2478-angular/41035-que-es-angular-y-como-aprenderlo/'
), (
	'f03972d6-d89a-407d-99ab-a4d0ff71037b',
	'c0d010ee-0e90-4f28-8e2f-29c6f0b8063f',
	'Instalación de Angular CLI',
	'https://platzi.com/clases/2478-angular/41036-instalacion-de-angular-cli/'
), (
	'0295d3c2-91b2-4c21-be5f-c3acb4549468',
	'ca765afb-1c06-47e3-8665-02398d338941',
	'¿Qué es Adobe Photoshop?',
	'https://platzi.com/clases/1230-photoshop-basico/10200-que-es-adobe-photoshop/'
), (
	'b6605cd9-ec57-426f-ba22-3817deb18ee0',
	'ca765afb-1c06-47e3-8665-02398d338941',
	'Mapas de Bits e Imágenes Vectoriales',
	'https://platzi.com/clases/1230-photoshop-basico/10201-mapas-de-bits-e-imagenes-vectoriales/'
);

insert into categories (
	id,
	name	
) values (
	1,
	'DESARROLLO E INGENIERÍA'
), (
	2,
	'DISEÑO Y UX'
);

insert into courses_categories (
	id,
	course_id,
	category_id
) values (
	'7dfc2d3a-20e4-4887-80ea-500ce118ad2f',
	'c0d010ee-0e90-4f28-8e2f-29c6f0b8063f',
	1
), (
	'f2fd5c5f-4dde-438e-8b74-bd458f41a842',
	'ca765afb-1c06-47e3-8665-02398d338941',
	2
);

insert into users_courses (
	id,
	user_id,
	course_id,
	review,
	progress
) values (
	'09f952bc-cf31-47ec-9718-93d58fb569ba',
	'b00fa4b6-902b-45be-88e5-4b70b1565562',
	'c0d010ee-0e90-4f28-8e2f-29c6f0b8063f',
	'A very well explained course to become better in Angular, would recommend!',
	50
), (
	'e8f93b7d-90c7-4a47-afa9-31cca0b7eece',
	'161115d0-2adf-4309-b595-0fd62b39d22a',
	'ca765afb-1c06-47e3-8665-02398d338941',
	'',
	10
);

-- Select of courses and relations
select categories.name, courses.title, c_v.title, teacher.name, c_v.url from courses left join course_video as c_v on courses.id = c_v.course_id inner join courses_categories as c_c on courses.id = c_c.course_id  inner join categories on categories.id = c_c.category_id  left join teacher on teacher_id = teacher.id;