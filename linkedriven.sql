-- Questão 1
SELECT u.id, u.name, c.name AS city FROM users u
JOIN cities c ON u."cityId" = c.id
WHERE c.name = 'Rio de Janeiro';

-- Questão 2
SELECT t.id, u1.name AS writer, u2.name AS recipient, message FROM testimonials t
JOIN users u1 ON t."writerId" = u1.id
JOIN users u2 ON t."recipientId" = u2.id;

-- Questão 3
SELECT e."userId" as id, u.name, c.name AS course, s.name AS school, "endDate" FROM educations e
JOIN users u ON e."userId" = u.id
JOIN courses c ON e."courseId" = c.id
JOIN schools s ON e."schoolId" = s.id
WHERE "userId" = 30 AND status = 'finished';

-- Questão 4
SELECT "userId" AS id, u.name, r.name AS role, c.name AS company, "startDate" FROM experiences e
JOIN users u ON e."userId" = u.id
JOIN roles r ON e."roleId" = r.id
JOIN companies c ON e."companyId" = c.id
WHERE "userId" = 50 AND "endDate" IS null;