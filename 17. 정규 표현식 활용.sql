-- USERS 테이블에서 username에 숫자가 하나라도 포함된 모든 사용자를 조회합니다. 
SELECT username
FROM USERS 
WHERE REGEXP_LIKE(username, '\d');


-- USERS 테이블에서 email 주소가 'c'로 시작하고 'com'으로 끝나는 모든 사용자를 조회합니다. 
SELECT email 
FROM USERS 
WHERE REGEXP_LIKE(email, '^c.*com$');


-- POSTS 테이블의 content 컬럼에서 첫 번째로 등장하는 해시태그(# + 단어)만 추출합니다. 
SELECT content, 
       REGEXP_SUBSTR(content, '#\w+') AS "첫 번째 해시태그"
FROM POSTS 
WHERE REGEXP_LIKE(content, '#\w+');


/* 
    연습 문제 ①
        
        REGEXP_LIKE를 사용하여, usernamedp _(언더바)를 포함하는 모든 사용자를 조회합니다. 
        
        Hint: LIKE에서는 _가 와일드카드였지만, 정규 표현식에서는 일반 문자입니다. */
SELECT username
FROM USERS 
WHERE REGEXP_LIKE(username, '_');


/* 
    연습 문제 ②
    
        REGEXP_LIKE를 사용하여, username이 모음(a, e, i, o, u)으로 시작하는 모든 사용자를 조회합니다. */
SELECT username 
FROM USERS 
WHERE REGEXP_LIKE(username, '^[aeiou]');