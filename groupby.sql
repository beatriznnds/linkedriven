-- Questão 1
SELECT COUNT("endDate")
AS "currentExperiences"
FROM experiences;


--Questão 2
SELECT "userId" AS id, COUNT("courseId") AS educations
FROM educations
GROUP BY "userId";

--Questão 3
SELECT users.name AS writer, COUNT(testimonials.id) AS "testimonialCount"
FROM testimonials
JOIN users
ON users.id = testimonials."writerId"
WHERE "writerId" = 435
GROUP BY writer;

-- Questão 4
SELECT MAX(jobs.salary) AS "maximumSalary", roles.name AS role
FROM jobs
JOIN roles ON roles.id = jobs."roleId"
WHERE jobs.active = true
GROUP BY role ORDER BY "maximumSalary" ASC;

--Questão 5
SELECT schools.name AS school, courses.name AS course, COUNT(educations."userId") AS "studentCount", educations.status AS role
FROM educations
JOIN schools ON schools.id = educations."schoolId"
JOIN courses ON courses.id = educations."courseId"
GROUP BY school, course, role
ORDER BY "studentCount" DESC LIMIT 3;