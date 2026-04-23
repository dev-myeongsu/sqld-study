-- USERS 테이블의 '모든 컬럼'과 '모든 데이터'를 조회합니다.
SELECT * FROM USERS;


-- USERS 테이블에서 username과 email 컬럼만 조회합니다.
SELECT username, email FROM USERS;


-- email을 먼저, username을 나중에 조회합니다.
SELECT email, username FROM USERS;


-- POSTS 테이블에 있는 게시물 종류를 모두 조회합니다.
-- ALL은 모든 행을 보여달라는 의미이며, 기본값이라 보통 생략합니다.
SELECT ALL post_type FROM POSTS;


-- POSTS 테이블의 post_type을 '중복 없이' 조회합니다.
SELECT DISTINCT post_type FROM POSTS;


-- username은 "사용자 아이디"로, registration_date는 "가입 일자"로 별명을 붙여 조회합니다.
SELECT username AS "사용자 아이디",
       registration_date AS "가입 일자"
FROM USERS;


-- username 컬럼과 문자열을 합쳐 "환영인사"라는 별명의 컬럼을 만듭니다.
SELECT username || '님, 환영합니다!' AS "환영인사" 
FROM USERS;


-- 사용자의 아이디와 가입일을 조합해서 자기소개 문구를 만듭니다. 
SELECT username || '(가입일: ' || registration_date || ')' AS "사용자 정보"
FROM USERS;


/* 
    연습 문제 ①  
    
        HASHTAGS 테이블에 있는 모든 정보를 조회합니다. */

SELECT * 
FROM HASHTAGS;


/* 
    연습 문제 ② 
    
        모든 게시물(POSTS 테이블)의 내용(content)과 작성일(creation_date)를 조회합니다. */

SELECT content, creation_date
FROM POSTS;


/* 
    연습 문제 ③
    
        LIKES 테이블을 이용해서 '좋아요'를 누른 사용자의 아이디(user_id)를 중복 없이 조회합니다. */

SELECT DISTINCT user_id
FROM LIKES;


/* 
    연습 문제 ④
    
        USER_PROFILES 테이블에서 모든 사용자의 full_name과 bio를 조회합니다.
        full_name은 "전체 이름"으로, bio는 "자기소개"라는 이름표를 달아서 보여줍니다. */

SELECT full_name AS "전체 이름",
       bio AS "자기소개"
FROM USER_PROFILES;


/* 
    연습 문제 ⑤
    
        COMMENTS 테이블의 정보를 이용해서 "[사용자 아이디]님이 [댓글 내용] 라고 댓글을 남겼습니다." 형태의 문장을 만듭니다.
        완성된 문장이 담긴 컬럼의 이름은 "댓글 알림"으로 지정합니다. */

SELECT user_id || '님이 ' || comment_text || ' 라고 댓글을 남겼습니다.' AS "댓글 알림"
FROM COMMENTS ;