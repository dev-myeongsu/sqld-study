-- 날짜 함수 종합 실습을 진행합니다. 
SELECT registration_date AS "라이언 가입일",
       ADD_MONTHS(registration_date, 6) AS "가입 6개월 기념일",
       MONTHS_BETWEEN(SYSDATE, registration_date) AS "총 활동 개월 수",
       LAST_DAY(registration_date) AS "가입한 달의 마지막 날",
       NEXT_DAY(registration_date, '금요일') AS "가입 후 첫 금요일"
FROM USERS 
WHERE username = 'ryan';


-- '라이언'의 가입일 (2020-02-08)과 '춘식이'의 가입일(2021-07-21)을 '월(MM)' 기준으로 버리고 반올림하여 비교합니다. 
SELECT username, 
       registration_date AS "가입일",
       TRUNC(registration_date, 'MM') AS "가입 월 (버림)",
       ROUND(registration_date, 'MM') AS "가입 월 (반올림)"
FROM USERS 
WHERE username IN ('ryan', 'choonsik');


-- 1번 게시물이 등록된 시점을 기준으로, 정확히 24시간 뒤(하루 뒤)는 언제인지, 그리고 1시간 뒤는 언제인지 계산합니다. 
SELECT creation_date AS "게시물 등록 시각",
       creation_date + 1 AS "24시간 뒤 (하루 뒤)",
       creation_date + (1 / 24) AS "1시간 뒤",
       SYSDATE - creation_date AS "등록 후 흐른 시간 (일 단위)"
FROM POSTS 
WHERE post_id = 1;


-- '라이언'의 가입일(registration_date)을 이용해서, 한국인에게 가장 친숙한 형식의 가입일 안내 문구를 만듭니다.
SELECT username, registration_date AS "원본 날짜",
       TO_CHAR(registration_date, 'YYYY"년" MM"월" DD"일"') AS "가입일 (상세)",
       TO_CHAR(registration_date, 'YYYY-MM-DD (DY)') AS "가입일 (요일포함)"
FROM USERS 
WHERE username = 'ryan';


-- POSTS 테이블에 있는 게시물 조회 수(view_count)를 천 단위 쉼표를 넣어서 보기 좋게 만듭니다. 
SELECT post_id, 
       view_count AS "원본 조회 수",
       TO_CHAR(view_count, '999,999,999') AS "스타일링 된 조회 수"
FROM POSTS 
WHERE view_count > 150;


-- POSTS 테이블에 있는 게시물 조회 수(view_count)를 천 단위 쉼표를 넣어서 보기 좋게 만듭니다. 
SELECT post_id,
       view_count AS "원본 조회 수",
       TO_CHAR(view_count, '999,999,999') AS "스타일링 된 조회 수"
FROM POSTS 
WHERE view_count > 150;


-- '20240520'이라는 문자열을 실제 날짜로 바꿔서, 2024년 5월 20일 이후에 작성된 게시물만 필터링합니다. 
SELECT post_id, content, creation_date 
FROM POSTS 
WHERE creation_date > TO_DATE('20240520', 'YYYYMMDD');


-- DB에는 자기소개(bio)가 있는 '춘식이'와, bio가 없는 '케로피'가 있습니다. 
-- NVL 함수를 이용해서 케로피의 프로필에 안내 문구를 채워 넣습니다. 
SELECT u.username,
       p.bio AS "원본 자기소개",
       NVL(p.bio, '자기소개가 없습니다.') AS "NVL 처리 후"
FROM USERS u, USER_PROFILES p 
WHERE u.user_id = p.user_id(+) 
    AND u.user_id IN (2, 14);


-- 자기소개가 있으면 '프로필 있음', 없으면 '프로필 없음' 상태를 표시합니다. 
SELECT u.username, 
       NVL2(p.bio, '프로필 있음', '프로필 없음') AS "프로필 상태"
FROM USERS u, USER_PROFILES p 
WHERE u.user_id = p.user_id(+)
    AND u.user_id IN (2, 14);


-- 전체 이름(full_name)이 있는 '라이언'과, 없는 '케로피'의 '최종 표시 이름'을 COALESCE 함수로 정합니다. 
SELECT u.username, p.full_name,
       COALESCE(p.full_name, u.username) AS "최종 표시 이름"
FROM USERS u, USER_PROFILES p 
WHERE u.user_id = p.user_id(+)
    AND u.user_id IN (1, 14);


-- 가상의 게시물 통계 데이터를 만들어서, 조회 수가 0일 때도 오류 없이 '참여율'을 안전하게 계산합니다.
WITH POST_STATS AS (
    SELECT 1 AS post_id, 50 AS like_count, 1000 AS view_count FROM DUAL 
    UNION ALL 
    SELECT 2 AS post_id, 0 AS like_count, 0 AS view_count FROM DUAL 
)
SELECT post_id, like_count, view_count,
       like_count / NULLIF(view_count, 0) AS "안전한 참여율"
FROM POST_STATS;


-- 사용자들의 가입 연도(registration_date)를 기준으로, 2023년 이후 가입자는 '새싹 유저',
-- 2021년 이후 가입자는 '기존 유저', 그 이전 가입자는 '고인물 유저'로 등급을 나눕니다. 
SELECT username, registration_date,
    CASE
        WHEN registration_date >= TO_DATE('20230101', 'YYYYMMDD') THEN '새싹 유저'
        WHEN registration_date >= TO_DATE('20210101', 'YYYYMMDD') THEN '기존 유저'
        ELSE '고인물 유저'
    END AS "유저 등급"
FROM USERS 
WHERE user_id IN (1, 4, 38);


-- POSTS 테이블의 post_type 컬럼 값을 '사진' 또는 '영상'으로 바꿔서 보여줍니다. 
SELECT post_id, 
       post_type AS "원본 타입",
       CASE post_type 
            WHEN 'photo' THEN '사진'
            WHEN 'video' THEN '영상'
            ELSE '기타'
       END AS "게시물 종류"
FROM POSTS 
WHERE user_id = 1 AND ROWNUM <= 5;