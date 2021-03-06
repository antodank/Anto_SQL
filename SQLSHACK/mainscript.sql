USE [mydb]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2/16/2019 8:28:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](20) NULL,
	[LastName] [varchar](20) NULL,
	[Email] [varchar](20) NULL,
	[PhoneNumber] [int] NULL,
	[DEPTID] [int] NOT NULL,
	[CITYCODE] [nvarchar](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 2/16/2019 8:28:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DEPTID] [int] IDENTITY(1,1) NOT NULL,
	[DeptName] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[DEPTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InsuranceClaims]    Script Date: 2/16/2019 8:28:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InsuranceClaims](
	[RecKey] [tinyint] IDENTITY(1,1) NOT NULL,
	[PolID] [tinyint] NOT NULL,
	[PolNumber] [varchar](10) NULL,
	[PolType] [varchar](15) NULL,
	[Effective Date] [date] NULL,
	[DocID] [smallint] NULL,
	[DocName] [varchar](10) NULL,
	[Submitted] [tinyint] NULL,
	[Outstanding] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbOrganicFoodOrders]    Script Date: 2/16/2019 8:28:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbOrganicFoodOrders](
	[OrderId] [int] NOT NULL,
	[OrganicFoodId] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbOrganicFoodsList]    Script Date: 2/16/2019 8:28:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbOrganicFoodsList](
	[OrganicFoodId] [smallint] NOT NULL,
	[OrganicFood] [varchar](50) NOT NULL,
 CONSTRAINT [PK_OrganicFoodId_List] PRIMARY KEY CLUSTERED 
(
	[OrganicFoodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbPerson]    Script Date: 2/16/2019 8:28:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbPerson](
	[PID] [int] IDENTITY(1,1) NOT NULL,
	[FName] [nvarchar](50) NULL,
	[LName] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbPerson] PRIMARY KEY CLUSTERED 
(
	[PID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[InsuranceClaims] ON 

INSERT [dbo].[InsuranceClaims] ([RecKey], [PolID], [PolNumber], [PolType], [Effective Date], [DocID], [DocName], [Submitted], [Outstanding]) VALUES (1, 2, N'Pol002', N'Hospital Cover', CAST(N'2007-10-01' AS Date), 1, N'Doc A', 0, 1)
INSERT [dbo].[InsuranceClaims] ([RecKey], [PolID], [PolNumber], [PolType], [Effective Date], [DocID], [DocName], [Submitted], [Outstanding]) VALUES (2, 2, N'Pol002', N'Hospital Cover', CAST(N'2007-10-01' AS Date), 4, N'Doc B', 0, 1)
INSERT [dbo].[InsuranceClaims] ([RecKey], [PolID], [PolNumber], [PolType], [Effective Date], [DocID], [DocName], [Submitted], [Outstanding]) VALUES (3, 2, N'Pol002', N'Hospital Cover', CAST(N'2007-10-01' AS Date), 5, N'Doc C', 1, 0)
INSERT [dbo].[InsuranceClaims] ([RecKey], [PolID], [PolNumber], [PolType], [Effective Date], [DocID], [DocName], [Submitted], [Outstanding]) VALUES (4, 2, N'Pol002', N'Hospital Cover', CAST(N'2007-10-01' AS Date), 7, N'Doc D', 1, 0)
INSERT [dbo].[InsuranceClaims] ([RecKey], [PolID], [PolNumber], [PolType], [Effective Date], [DocID], [DocName], [Submitted], [Outstanding]) VALUES (5, 2, N'Pol002', N'Hospital Cover', CAST(N'2007-10-01' AS Date), 10, N'Doc E', 1, 0)
INSERT [dbo].[InsuranceClaims] ([RecKey], [PolID], [PolNumber], [PolType], [Effective Date], [DocID], [DocName], [Submitted], [Outstanding]) VALUES (6, 2, N'Pol002', N'Hospital Cover', CAST(N'2007-10-01' AS Date), 11, N'Doc F', 1, 0)
INSERT [dbo].[InsuranceClaims] ([RecKey], [PolID], [PolNumber], [PolType], [Effective Date], [DocID], [DocName], [Submitted], [Outstanding]) VALUES (7, 3, N'Pol003', N'Hospital Cover', CAST(N'2008-11-01' AS Date), 1, N'Doc A', 1, 0)
INSERT [dbo].[InsuranceClaims] ([RecKey], [PolID], [PolNumber], [PolType], [Effective Date], [DocID], [DocName], [Submitted], [Outstanding]) VALUES (8, 3, N'Pol003', N'Hospital Cover', CAST(N'2008-11-01' AS Date), 4, N'Doc B', 0, 1)
INSERT [dbo].[InsuranceClaims] ([RecKey], [PolID], [PolNumber], [PolType], [Effective Date], [DocID], [DocName], [Submitted], [Outstanding]) VALUES (9, 3, N'Pol003', N'Hospital Cover', CAST(N'2008-11-01' AS Date), 5, N'Doc C', 0, 1)
INSERT [dbo].[InsuranceClaims] ([RecKey], [PolID], [PolNumber], [PolType], [Effective Date], [DocID], [DocName], [Submitted], [Outstanding]) VALUES (10, 3, N'Pol003', N'Hospital Cover', CAST(N'2008-11-01' AS Date), 7, N'Doc D', 0, 1)
INSERT [dbo].[InsuranceClaims] ([RecKey], [PolID], [PolNumber], [PolType], [Effective Date], [DocID], [DocName], [Submitted], [Outstanding]) VALUES (11, 3, N'Pol003', N'Hospital Cover', CAST(N'2008-11-01' AS Date), 10, N'Doc E', 0, 1)
INSERT [dbo].[InsuranceClaims] ([RecKey], [PolID], [PolNumber], [PolType], [Effective Date], [DocID], [DocName], [Submitted], [Outstanding]) VALUES (12, 3, N'Pol003', N'Hospital Cover', CAST(N'2008-11-01' AS Date), 11, N'Doc F', 0, 1)
SET IDENTITY_INSERT [dbo].[InsuranceClaims] OFF
INSERT [dbo].[tbOrganicFoodOrders] ([OrderId], [OrganicFoodId]) VALUES (1, 2)
INSERT [dbo].[tbOrganicFoodOrders] ([OrderId], [OrganicFoodId]) VALUES (1, 3)
INSERT [dbo].[tbOrganicFoodOrders] ([OrderId], [OrganicFoodId]) VALUES (2, 1)
INSERT [dbo].[tbOrganicFoodOrders] ([OrderId], [OrganicFoodId]) VALUES (2, 5)
INSERT [dbo].[tbOrganicFoodOrders] ([OrderId], [OrganicFoodId]) VALUES (3, 6)
INSERT [dbo].[tbOrganicFoodOrders] ([OrderId], [OrganicFoodId]) VALUES (3, 1)
INSERT [dbo].[tbOrganicFoodOrders] ([OrderId], [OrganicFoodId]) VALUES (4, 5)
INSERT [dbo].[tbOrganicFoodOrders] ([OrderId], [OrganicFoodId]) VALUES (4, 6)
INSERT [dbo].[tbOrganicFoodOrders] ([OrderId], [OrganicFoodId]) VALUES (5, 3)
INSERT [dbo].[tbOrganicFoodOrders] ([OrderId], [OrganicFoodId]) VALUES (5, 2)
INSERT [dbo].[tbOrganicFoodsList] ([OrganicFoodId], [OrganicFood]) VALUES (1, N'Broccoli')
INSERT [dbo].[tbOrganicFoodsList] ([OrganicFoodId], [OrganicFood]) VALUES (2, N'Apple')
INSERT [dbo].[tbOrganicFoodsList] ([OrganicFoodId], [OrganicFood]) VALUES (3, N'Fig')
INSERT [dbo].[tbOrganicFoodsList] ([OrganicFoodId], [OrganicFood]) VALUES (4, N'Potato')
INSERT [dbo].[tbOrganicFoodsList] ([OrganicFoodId], [OrganicFood]) VALUES (5, N'Kale')
INSERT [dbo].[tbOrganicFoodsList] ([OrganicFoodId], [OrganicFood]) VALUES (6, N'Cucumber')
SET IDENTITY_INSERT [dbo].[tbPerson] ON 

INSERT [dbo].[tbPerson] ([PID], [FName], [LName], [City]) VALUES (1, N'Ankit', N'Todankar', N'Kalyan')
INSERT [dbo].[tbPerson] ([PID], [FName], [LName], [City]) VALUES (2, N'Viraj', N'Todankar', N'Dombivali')
INSERT [dbo].[tbPerson] ([PID], [FName], [LName], [City]) VALUES (3, N'Krishna', N'Todankar', N'Mumbai')
SET IDENTITY_INSERT [dbo].[tbPerson] OFF
ALTER TABLE [dbo].[tbOrganicFoodOrders]  WITH CHECK ADD  CONSTRAINT [FK_OrganicFoodId_Orders] FOREIGN KEY([OrganicFoodId])
REFERENCES [dbo].[tbOrganicFoodsList] ([OrganicFoodId])
GO
ALTER TABLE [dbo].[tbOrganicFoodOrders] CHECK CONSTRAINT [FK_OrganicFoodId_Orders]
GO

-- OnlineExamination


USE [OnlineExamination]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 01/20/2018 21:56:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Designation] [nvarchar](50) NULL,
	[Salary] [decimal](18, 0) NULL,
	[Age] [int] NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


-- USE [dbEmployee]
GO
/****** Object:  Table [dbo].[tbl_Employee]    Script Date: 01/20/2018 21:56:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Employee](
	[emp_id] [int] NOT NULL,
	[emp_fname] [nvarchar](100) NOT NULL,
	[emp_lname] [nvarchar](100) NULL,
	[gender] [nvarchar](1) NULL,
	[mobile] [nvarchar](15) NULL,
	[city] [nvarchar](50) NULL,
	[dept_id] [int] NULL,
 CONSTRAINT [PK_tbl_Employee] PRIMARY KEY CLUSTERED 
(
	[emp_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
