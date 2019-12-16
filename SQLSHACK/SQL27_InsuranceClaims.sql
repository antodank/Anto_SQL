
/****** Create Table ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [dbo].[InsuranceClaims]
([RecKey]         [TINYINT] IDENTITY(1, 1) NOT NULL,
 [PolID]          [TINYINT] NOT NULL,
 [PolNumber]      [VARCHAR](10) NULL,
 [PolType]        [VARCHAR](15) NULL,
 [Effective Date] [DATE] NULL,
 [DocID]          [SMALLINT] NULL,
 [DocName]        [VARCHAR](10) NULL,
 [Submitted]      [TINYINT] NULL,
 [Outstanding]    [TINYINT] NULL
)
ON [PRIMARY];
GO

/****** Populate Table ******/

INSERT INTO [dbo].[InsuranceClaims]
([PolID],
 [PolNumber],
 [PolType],
 [Effective Date],
 [DocID],
 [DocName],
 [Submitted],
 [Outstanding]
)
VALUES
(2,
 'Pol002',
 'Hospital Cover',
 '01-Oct-07',
 1,
 'Doc A',
 0,
 1
),
(2,
 'Pol002',
 'Hospital Cover',
 '01-Oct-07',
 4,
 'Doc B',
 0,
 1
),
(2,
 'Pol002',
 'Hospital Cover',
 '01-Oct-07',
 5,
 'Doc C',
 1,
 0
),
(2,
 'Pol002',
 'Hospital Cover',
 '01-Oct-07',
 7,
 'Doc D',
 1,
 0
),
(2,
 'Pol002',
 'Hospital Cover',
 '01-Oct-07',
 10,
 'Doc E',
 1,
 0
),
(2,
 'Pol002',
 'Hospital Cover',
 '01-Oct-07',
 11,
 'Doc F',
 1,
 0
),
(3,
 'Pol003',
 'Hospital Cover',
 '01-Nov-08',
 1,
 'Doc A',
 1,
 0
),
(3,
 'Pol003',
 'Hospital Cover',
 '01-Nov-08',
 4,
 'Doc B',
 0,
 1
),
(3,
 'Pol003',
 'Hospital Cover',
 '01-Nov-08',
 5,
 'Doc C',
 0,
 1
),
(3,
 'Pol003',
 'Hospital Cover',
 '01-Nov-08',
 7,
 'Doc D',
 0,
 1
),
(3,
 'Pol003',
 'Hospital Cover',
 '01-Nov-08',
 10,
 'Doc E',
 0,
 1
),
(3,
 'Pol003',
 'Hospital Cover',
 '01-Nov-08',
 11,
 'Doc F',
 0,
 1
);
