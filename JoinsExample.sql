SELECT * FROM tblAlbum 
INNER JOIN tblArtist ON 
tblAlbum.artistID = tblArtist.artistID;

SELECT * FROM tblArtist
LEFT OUTER JOIN tblAlbum ON
tblArtist.artistID = tblAlbum.artistID;

SELECT *  FROM tblArtist 
RIGHT OUTER JOIN tblAlbum ON 
tblArtist.artistID = tblAlbum.artistID;

SELECT * FROM tblArtist
FULL OUTER JOIN tblAlbum ON
tblArtist.artistID = tblAlbum.artistID
WHERE
tblArtist.artistID = NULL or tblAlbum.artistID = NULL;

SELECT * FROM [dbo].[tblAlbum]
CROSS JOIN [dbo].[tblArtist] 

SELECT * FROM tblArtist t1
LEFT OUTER JOIN (select * from tblAlbum where 1= 2) as t2 ON
t1.artistID = t2.artistID;

SELECT * FROM tblArtist t1
FULL OUTER JOIN (select * from tblAlbum where 1= 2) as t2 ON
t1.artistID = t2.artistID;