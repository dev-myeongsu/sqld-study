-- USERS 테이블에서 username이 정확히 'ryan'인 사용자의 모든 정보를 찾습니다.
SELECT * 
FROM USERS 
WHERE username = 'ryan';


-- POSTS 테이블에서 작성자가 '라이언(user_id=1)'이면서 동시에 게시물 종류는 'video'인 것만 찾습니다.
SELECT *
FROM POSTS 
WHERE user_id = 1 AND post_type = 'video';


-- 작성자가 '라이언(user_id=1)'이거나 혹은 종류가 'video'이기만 하면 다 보여줍니다. 
SELECT *
FROM POSTS 
WHERE user_id = 1 OR post_type = 'video';


-- SQL에서는 AND를 OR보다 항상 먼저 처리합니다. (연산자 우선순위)
SELECT * 
FROM POSTS 
WHERE user_id = 1 OR user_id = 2 AND post_type = 'photo';


-- 수학에서처럼 괄호 ()를 사용해서 "이것부터 계산해!"라고 명확하게 알려줄 수 있습니다. 
SELECT * 
FROM POSTS 
WHERE (user_id = 1 or user_id = 2) AND post_type = 'photo';


-- 2022년 1월 1일부터 2022년 12월 31일 사이에 가입한 사용자를 모두 찾습니다. 
SELECT username, registration_date
FROM USERS 
WHERE registration_date 
    BETWEEN DATE '2022-01-01'
    AND TIMESTAMP '2022-12-3 23:59:59.99';


-- 대표 인플루언서인 라이언(1), 헬로키티(9), 피카츄(21)의 프로필만 골라서 보여줍니다. 
SELECT *
FROM USERS 
WHERE user_id IN (1, 9, 21);


-- 사용자 아이디가 'p'로 시작하는 모든 사용자를 찾습니다. (pikachu, pompompurin 등)
SELECT username 
FROM USERS 
WHERE username LIKE 'p%';


-- 게시물 내용에 '#일상'이라는 해시태크가 포함된 모든 게시물을 찾습니다.
SELECT post_id, content 
FROM POSTS 
WHERE content LIKE '%#일상%';


/* 
    연습 문제 ①
    
        USERS 테이블에서 username이 'pikachu'인 사용자의 모든 정보를 조회합니다. (= 연산자 사용) */

SELECT * 
FROM USERS 
WHERE username = 'pikachu';


/* 
    연습 문제 ②
    
        POSTS 테이블에서 2023년 1월 1일부터 2023년 12월 31일 사이에 작성된 모든 게시물을 찾습니다. (BETWEEN 사용) */

SELECT *
FROM POSTS 
WHERE creation_date 
    BETWEEN DATE '2023-01-01' 
    AND TIMESTAMP '2023-12-31 23:59:59.999';


/* 
    연습 문제 ③
    
        USERS 테이블에서 카카오프렌즈 소속인 사용자들(라이언(1), 춘식이(2), 어피치(3), 리틀어피치(4), 무지(5), 콘(6), 프로도(7), 네오(8))의 username과 email만 조회합니다. (IN 사용) */

SELECT username, email 
FROM USERS 
WHERE user_id IN (1, 2, 3, 4, 5, 6, 7, 8);


/* 
    연슴 문제 ④
    
        POSTS 테이블에서 내용(content)에 '#먹스타그램'이라는 글자가 포함된 모든 게시물의 post_id와 content를 조회합니다. (LIKE 사용) */

SELECT post_id, content 
FROM POSTS 
WHERE content LIKE '%#먹스타그램%';


/* 
    연습 문제 ⑤
    
        POSTS 테이블에서 작성자 ID(user_id)가 1번인 '라이언'이 올린 게시물 중, 종류(post_type)가 'photo'인 것만 모두 조회합니다. (AND 사용) */

SELECT *
FROM POSTS 
WHERE user_id = 1 AND post_type = 'photo';


/* 
    연습 문제 ⑥
    
        USERS 테이블에서 산리오 소속 사용자들(user_id 9번부터 20번까지)을 제외한 나머지 모든 사용자들의 username을 조회합니다. (NOT BETWEEN 또는 < 와 > 사용) */

SELECT username 
FROM USERS 
WHERE user_id 
    NOT BETWEEN 9
    AND 20;

SELECT username 
FROM USERS 
WHERE user_id < 9 OR user_id > 20;