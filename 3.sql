-- 1. List the titles of all movies directed by ‘Hitchcock’.
SELECT MOV_TITLE FROM MOVIES WHERE DIR_ID IN (
    SELECT DIR_ID FROM DIRECTOR WHERE DIR_NAME = 'HITCHCOCK');

-- 2. Find the movie names where one or more actors acted in two or moremovies.
SELECT MOV_TITLE FROM MOVIES M, MOVIE_CAST MV
WHERE M.MOV_ID=MV.MOV_ID AND ACT_ID IN (
    SELECT ACT_ID FROM MOVIE_CAST GROUP BY ACT_ID  HAVING COUNT (ACT_ID)>1)
GROUP BY MOV_TITLE 
HAVING COUNT (*)>1;

-- 3. List all actors who acted in amovie before 2000 and also in amovie after 2015 (use JOIN operation).

SELECT A.ACT_NAME, A.ACT_NAME, C.MOV_TITLE, C.MOV_YEAR FROM ACTOR A, MOVIE_CAST B, MOVIES C
WHERE A.ACT_ID=B.ACT_ID 
AND B.MOV_ID=C.MOV_ID
AND C.MOV_YEAR NOT BETWEEN 2000 AND 2015;

-- 4. Find the title of movies and number of stars for each movie that has at least one rating and find the highest number of stars that movie received. Sort the result by movietitle.
SELECT MOV_TITLE, MAX(REV_STARS) FROM MOVIES
INNER JOIN RATING USING (MOV_ID) GROUP 
BY MOV_TITLE
HAVING MAX 
(REV_STARS)>0 ORDER BY 
MOV_TITLE;

-- 5. Update rating of all movies directed by ‘Steven Spielberg’ to 5

UPDATE RATING SET REV_STARS=5
WHERE MOV_ID IN (SELECT MOV_ID FROM MOVIES
WHERE DIR_ID IN (SELECT DIR_ID
FROM DIRECTOR WHERE DIR_NAME = 'STEVEN SPIELBERG'));


