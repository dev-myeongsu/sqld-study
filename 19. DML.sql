-- 새로운 포켓몬 유저, '잠만보'의 동생인 '먹고자(munchlax)'를 USERS 테이블에 추가합니다.
INSERT INTO USERS (user_id, username, email, registration_date, manager_id)
VALUES (43, 'munchlax', 'munchlax@example.com', SYSDATE, 26);

SELECT * FROM USERS ORDER BY registration_date DESC;


-- 게시물을 10개 이상 작성한 '헤비 유저'들만 따로 모아서, HEAVY_USERS라는 새로운 백업 테이블에 저장합니다. 
-- 1. 먼저 백업 테이블을 만듭니다. 
CREATE TABLE HEAVY_USERS (
    user_id NUMBER,
    username VARCHAR2(50),
    post_count NUMBER
);
-- 2. 서브쿼리를 이용해 대량의 데이터를 한 번에 INSERT 합니다. 
INSERT INTO HEAVY_USERS (user_id, username, post_count)
SELECT u.user_id, u.username, COUNT(p.post_id)
FROM USERS u 
JOIN POSTS p ON u.user_id = p.user_id 
GROUP BY u.user_id, u.username 
HAVING COUNT(p.post_id) >= 10;

SELECT * FROM HEAVY_USERS;


-- USER_PROFILES 테이블에서 user_id가 1번인 '라이언'의 bio를 '카카오프렌즈의 믿음직한 리더!'로 수정합니다. 
SELECT * FROM USER_PROFILES WHERE user_id = 1;

UPDATE USER_PROFILES
SET bio = '카카오프렌즈의 믿음직한 리더!'
WHERE user_id = 1;


-- 모든 게시물의 view_count를 (현재 view_count + 전체 게시물의 평균 view_count) 값으로 업데이트하는 조회수 상승 이벤트를 진행합니다. 
UPDATE POSTS 
SET view_count = view_count + (SELECT ROUND(AVG(view_count)) FROM POSTS);


-- INSERT로 추가했던 '먹고자(munchlax)' 사용자를 USERS 테이블에서 삭제합니다. 
DELETE FROM USERS 
WHERE username = 'munchlax';


-- '좋아요' 없는 비인기 게시물을 정리합니다. 
DELETE FROM POSTS 
WHERE post_id NOT IN (
    SELECT DISTINCT post_id 
    FROM LIKES 
);


/* 
    연습 문제 ①
    
        pikachu(user_id 21)가 ryan(user_id 1)의 게시물 (post_id 15)을 보고 감명받아
        '피카피카! (최고에요!)'라는 댓글을 남기는 상황을 COMMENTS 테이블에 INSERT 합니다.
        
        Hint: comment_id는 기존 데이터와 겹치지 않게 임의의 번호(예:20068)을 사용하고,
        creation_date는 SYSDATE를 사용합니다. */
INSERT INTO COMMENTS (comment_id, post_id, user_id, comment_text, creation_date)
VALUES (20068, 15, 21, '피카피카! (최고에요!)', SYSDATE);


/* 
    연습 문제 ②
    
        카카오프렌즈(user_id 1~8) 캐릭터들이 작성한 모든 게시물의
        view_count를 100씩 증가시키는 '특별 홍보 이벤트'를 진행합니다.
        
        Hint: UPDATE 문의 WHERE 절에 IN과 서브쿼리를 사용하거나,
        BETWEEN을 사용하여 카카오프렌즈가 작성한 게시물만 대상을 한정해야 합니다. */
UPDATE POSTS 
SET view_count = view_count + 100 
WHERE user_id BETWEEN 1 AND 8;


/* 
    연습 문제 ③
    
        오래된 데이터를 정리하려고 합니다. 2023년 이전에 작성된 모든 '좋아요' 기록을 LIKES 테이블에서 삭제합니다.
        
        Hint: WHERE 절에서 날짜 비교가 필요합니다.
        TO_DATE 함수를 사용하여 '2023-01-01'과 비교합니다. */
DELETE FROM LIKES 
WHERE creation_date < DATE '2023-01-01';


-- [TEAM] 테이블과 [TEAM_TMP] 테이블을 MERGE합니다.
/* 
    MERGE INTO TEAM T -- 대상 테이블
    USING TEAM_TMP TMP -- 참조 테이블
        ON (T.TEAM = TMP.TEAM_ID) -- 두 테이블의 TEAM_ID 값을 비교함
    WHEN MATCHED THEN -- [TEAM_TMP]의 TEAM_ID가 TEAM에 이미 존재하는 경우 실행
        UPDATE SET 
            T.OWNER = TMP.OWNER 
    WHEN NOT MATCHED THEN -- [TEAM_TMP]의 TEAM_ID가 TEAM에 존재하지 않는 경우 실행 
        INSERT (TEAM_ID, TEAM_NAME, OWNER)
        VALUES (TMP.TEAM_ID, TMP.TEAM_NAME, TMP.OWNER);

    SELECT * FROM TEAM; -- TEAM 테이블 조회 
*/