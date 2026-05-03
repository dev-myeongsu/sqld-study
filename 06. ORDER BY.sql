-- registration_date 기준 내림차순 정렬합니다.
-- 최신 날짜가 가장 위로 올라옵니다.
SELECT user_id, username, registration_date 
FROM USERS 
ORDER BY registration_date DESC;


-- view_count(조회수) 컬럼을 기준으로 내림차순(DESC) 정렬합니다. 
-- 가장 큰 숫자가 위로 올라오게 됩니다. 
SELECT post_id, user_id, view_count 
FROM POSTS 
ORDER BY view_count DESC;


-- username 기준 오름차순 정렬합니다. 
-- ASC 기본값이므로 생략 가능합니다. 
SELECT user_id, username 
FROM USERS 
ORDER BY username ASC;


-- 콤마(,)로 정렬 기준을 여러 개 지정합니다. 
-- 1차: user_id 오름차순 정렬합니다. 
-- 2차: creation_date 내림차순 정렬합니다. 
SELECT user_id, post_id, creation_date 
FROM POSTS 
ORDER BY user_id ASC, creation_date DESC;


-- COUNT(*)에 post_count 별칭을 부여합니다. 
-- ORDER BY에서 깔끔한 별칭을 사용합니다. 
SELECT user_id, COUNT(*) AS post_count 
FROM POSTS 
GROUP BY user_id 
ORDER BY post_count DESC;


-- CASE 문으로 정렬 순서를 임의로 부여합니다. 
-- video는 1번, 나머지는 2번으로 우선순위를 설정합니다. 
SELECT post_id, user_id, post_type, creation_date 
FROM POSTS 
ORDER BY 
    CASE WHEN post_type = 'video' THEN 1 
         ELSE 2 END,    -- 1차 정렬 기준
    creation_date DESC; -- 2차 정렬 기준


-- 2번째 컬럼인 username 기준 오름차순 정렬합니다. 
SELECT user_id, username, registration_date 
FROM USERS 
ORDER BY 2; -- ORDER BY username; 과 동일


