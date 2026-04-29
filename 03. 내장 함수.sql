-- 인스타그램 인플루언서 username을 대소문자 변환합니다.
SELECT username,
       UPPER(username) AS "대문자로 변환",
       LOWER(username) AS "소문자로 변환",
       INITCAP(username) AS "첫 글자만 대문자"
FROM USERS 
WHERE user_id IN (1, 9, 21);


-- 고양이 집사들의 자기소개(bio) 길이와 '고양이' 단어 위치를 확인합니다. 
SELECT user_id, bio,
       LENGTH(bio) AS "자기소개 길이",
       INSTR(bio, '고양이') AS "'고양이'의 위치"
FROM USER_PROFILES
WHERE user_id IN (2, 8);


-- 댓글 내용 앞에서 10글자만 잘라내고 '...'을 붙여 미리보기를 만듭니다. 
SELECT comment_text AS "원본 댓글",
       SUBSTR(comment_text, 1, 10) || '...' AS "댓글 미리보기"
FROM COMMENTS 
WHERE comment_id = 20001;


-- 왼쪽(L)에 특정 문자를 채워 길이를 맞춥니다. 
-- 오른쪽(R)에 특정 문자를 채워 길이를 맞춥니다. 
SELECT user_id,
       LPAD(user_id, 5, '0') AS "5자리 사용자 ID",
       RPAD(username, 15, '*') AS "오른쪽 채우기 예시"
FROM USERS 
WHERE user_id IN (1, 21, 40);


-- 해시태그를 변경합니다. 
SELECT content AS "원본 내용",
       REPLACE(content, '#일상', '#데일리') AS "해시태그 교체"
FROM POSTS 
WHERE post_id = 1;


-- 문자열 양옆의 공백을 제거합니다. 
SELECT '  ryan  ' AS "원본",
       TRIM('  ryan  ') AS "TRIM 처리 후",
       LENGTH('  ryan  ') AS "원본 길이",
       LENGTH(TRIM('  ryan  ')) AS "TRIM 처리 후 길이"
FROM DUAL;


-- 지정한 자리수에서 숫자를 반올림합니다. 
-- 지정한 자리수 이하를 그냥 버립니다. 
SELECT post_id, 
       reaction_score AS "원본 점수",
       ROUND(reaction_score) AS "정수로 반올림",
       TRUNC(reaction_score) AS "정수로 버림",
       ROUND(reaction_score, 1) AS "소수점 첫째자리까지"
FROM POSTS
WHERE post_id IN (2, 5);


-- 양수와 음수에 대한 CEIL, FLOOR 결과를 비교합니다.
SELECT CEIL(3.14) AS "CEIL(양수)",
       FLOOR(3.14) AS "FLOOR(양수)",
       CEIL(-3.14) AS "CEIL(음수)",
       FLOOR(-3.14) AS "FLOOR(음수)"
FROM DUAL;


-- USERS 테이블의 user_id로 짝수/홀수 ID를 구분합니다. 
SELECT user_id, 
       MOD(user_id, 2) AS "나머지",
       CASE
            WHEN MOD(user_id, 2) = 0 THEN '짝수 ID 사용자'
            ELSE '홀수 ID 사용자'
        END AS "ID 유형"
FROM USERS 
WHERE user_id BETWEEN 1 AND 5;