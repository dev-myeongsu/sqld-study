-- 전체 사용자 수와 매니저가 지정된 직원 수를 구합니다. 
-- 전체 사용자 수
SELECT COUNT(*) AS "전체 사용자 수"
FROM USERS;
-- 매니저가 있는 직원수
SELECT COUNT(manager_id) AS "매니저가 있는 직원 수"
FROM USERS;


-- 최고/최저 조회수를 찾습니다. 
SELECT MAX(view_count) AS "최고 조회수",
       MIN(view_count) AS "최저 조회수"
FROM POSTS;


-- 총 조회수와 평균 조회수를 구합니다. 
-- 모든 게시물의 총 조회수 
SELECT SUM(view_count) AS "총 조회수"
FROM POSTS;
-- 게시물 당 평균 조회수 (반올림)
SELECT ROUND(AVG(view_count)) AS "게시물 당 평균 조회수"
FROM POSTS;


-- POSTS 테이블을 user_id가 같은 것끼리 그룹으로 묶은 다음, 각 그룹별로 게시물이 몇 개인지 셉니다. 
SELECT user_id, 
       COUNT(*) AS "작성한 게시물 수"
FROM POSTS 
GROUP BY user_id;


-- 에러가 발생하는 쿼리입니다. 
SELECT user_id,
       content -- 어떤 content를 대표로 보여줘야 할지 알 수 없습니다. 
FROM POSTS 
GROUP BY user_id;


-- user_id로 먼저 그룹화하고, 그 안에서 post_type으로 다시 그룹화합니다. 
SELECT user_id, post_type,
       COUNT(*) AS "종류별 게시물 수"
FROM POSTS 
GROUP BY user_id, post_type  -- 콤마(,)로 구분하여 여러 기준
ORDER BY user_id, post_type; -- 보기 좋게 정렬


-- 게시물을 10개 이상 올린 사용자만 골라서 보여줍니다. 
SELECT user_id, 
       COUNT(*) AS post_count 
FROM POSTS 
GROUP BY user_id 
HAVING COUNT(*) >= 10;


-- 2024년에 달린 '좋아요' 데이터들 중에서만, '좋아요'를 20개 이상 받은 인기 게시물을 찾습니다. 
SELECT post_id, 
       COUNT(*) AS like_count 
FROM LIKES 
WHERE creation_date >= TO_DATE('2024-01-01', 'YYYY-MM-DD') -- 1. 2024년 데이터만 먼저 고르고
GROUP BY post_id -- 2. 게시물 ID별로 그룹화
HAVING COUNT(*) >= 20; -- 3. 그룹별 좋아요 수가 20개 이상인 그룹만 최정 선택


/* 
    연습 문제 ①
    
        POSTS 테이블을 사용하여 각 게시물 종류(post_type)별로 몇 개의 게시물이 있는지 조회합니다.
        결과에는 post_type과 게시물 수를 표시합니다. */
SELECT post_type, 
       COUNT(*) AS "종류별 게시물 수"
FROM POSTS 
GROUP BY post_type;


/* 
    연습 문제 ② 
    
        COMMENTS 테이블을 사용하여 각 게시물(post_id)별로 댓글 수를 계산합니다. 
        결과에는 post_id와 댓글 수를 표시합니다. */
SELECT post_id,
       COUNT(*) AS "댓글 수"
FROM COMMENTS 
GROUP BY post_id
ORDER BY post_id;


/* 
    연습 문제 ③

        FOLLOWS 테이블을 사용하여 각 사용자별로 팔로워 수를 계산합니다.
        following_id를 기준으로 그룹화합니다.
        결과에는 following_id와 팔로워 수를 표시합니다. */
SELECT following_id,
       COUNT(*) AS "팔로워 수"
FROM FOLLOWS
GROUP BY following_id;


/* 
    연습 문제 ④ 
    
        COMMENTS 테이블을 사용하여 댓글이 5개 이상 달린 게시물만 조회합니다. 
        각 게시물별로 댓글 수를 계산합니다. 
        결과에는 post_id와 댓글 수를 표시합니다. 
        
        Hint: 문제 4는 그룹화한 뒤 조건을 걸어야 합니다. */
SELECT post_id,
       COUNT(*) AS "댓글 수"
FROM COMMENTS
GROUP BY post_id
HAVING COUNT(*) >= 5;


/* 
    연습 문제 ⑤
    
        카카오프렌즈 사용자들(user_id가 1부터 8까지)이 작성한 게시물에 대해서만 분석합니다.
        각 사용자별로 총 게시물 수를 계산합니다.
        POSTS 테이블을 사용합니다. 
        결과에는 user_id와 작성 게시물 수를 표시합니다. */
SELECT user_id,
       COUNT(*) AS "작성 게시물 수"
FROM POSTS 
WHERE user_id BETWEEN 1 AND 8
GROUP BY user_id ;