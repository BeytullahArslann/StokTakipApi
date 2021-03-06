USE [master]
GO
/****** Object:  Database [STOKTAKIPOTOMASYONU]    Script Date: 24.05.2022 00:20:45 ******/
CREATE DATABASE [STOKTAKIPOTOMASYONU]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'STOKTAKIPOTOMASYONU', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\STOKTAKIPOTOMASYONU.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'STOKTAKIPOTOMASYONU_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\STOKTAKIPOTOMASYONU_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [STOKTAKIPOTOMASYONU].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET ARITHABORT OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET  DISABLE_BROKER 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET RECOVERY FULL 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET  MULTI_USER 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET DB_CHAINING OFF 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'STOKTAKIPOTOMASYONU', N'ON'
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET QUERY_STORE = OFF
GO
USE [STOKTAKIPOTOMASYONU]
GO
/****** Object:  Table [dbo].[orderProducts]    Script Date: 24.05.2022 00:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderProducts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[productId] [int] NOT NULL,
	[warehouseId] [int] NOT NULL,
	[type] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[quantity] [int] NOT NULL,
	[createdAt] [date] NOT NULL,
 CONSTRAINT [PK_orderProducts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 24.05.2022 00:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[orderPrice] [int] NOT NULL,
	[orderDate] [date] NOT NULL,
	[isCompleted] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 24.05.2022 00:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[productCode] [nchar](10) NOT NULL,
	[productName] [nvarchar](50) NOT NULL,
	[productDesc] [nvarchar](150) NULL,
	[productPrice] [int] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 24.05.2022 00:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[roleName] [nchar](10) NOT NULL,
	[roleDesc] [nvarchar](50) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_roles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 24.05.2022 00:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userName] [nchar](10) NOT NULL,
	[userSurname] [nchar](10) NOT NULL,
	[userEmail] [nvarchar](50) NOT NULL,
	[userPassword] [nvarchar](50) NOT NULL,
	[userBirthDay] [datetime] NOT NULL,
	[userRole] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[warehouseProduct]    Script Date: 24.05.2022 00:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[warehouseProduct](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[productId] [int] NOT NULL,
	[warehouseId] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[date] [date] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_warehouseProduct] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[warehouses]    Script Date: 24.05.2022 00:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[warehouses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[warehouseCode] [nchar](10) NOT NULL,
	[warehouseName] [nvarchar](50) NOT NULL,
	[warehouseAddress] [nvarchar](150) NOT NULL,
	[warehouseCapacity] [int] NOT NULL,
	[warehouseAdminId] [int] NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[isActive] [bit] NOT NULL,
 CONSTRAINT [PK_warehouses] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[orderProducts] ON 

INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (3, 4, 2, 2, 0, 0, 15, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (16, 4, 2, 2, 0, 0, 30, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (17, 17, 2, 2, 1, 0, 123123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (18, 12, 2, 2, 1, 0, 12312312, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (19, 12, 2, 2, 1, 0, 123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (20, 17, 2, 2, 1, 0, 123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (21, 17, 2, 2, 1, 0, 123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (22, 12, 2, 2, 1, 0, 123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (23, 17, 2, 2, 1, 0, 123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (24, 12, 2, 2, 1, 0, 123123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (25, 17, 2, 2, 1, 0, 11111, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (26, 17, 2, 2, 0, 0, 100000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (27, 17, 4, 3, 0, 0, 11000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (28, 17, 4, 3, 0, 0, 21001, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (29, 17, 4, 3, 1, 0, 43000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (30, 17, 4, 3, 1, 0, 42000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (31, 17, 4, 3, 1, 0, 42000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (32, 17, 4, 3, 1, 0, 42000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (33, 17, 4, 3, 1, 0, 50000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (34, 17, 4, 3, 0, 0, 50000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (35, 17, 4, 3, 1, 0, 51000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (36, 17, 2, 3, 1, 0, 10000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (37, 17, 2, 3, 0, 0, 10000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (39, 12, 3, 2, 1, 0, 20000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (40, 4, 2, 2, 0, 0, 15000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (41, 4, 2, 2, 0, 0, 15000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (42, 17, 3, 2, 0, 0, 1515, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (44, 17, 3, 2, 0, 0, 123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (45, 4, 2, 2, 0, 0, 123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (46, 4, 2, 2, 0, 0, 123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (47, 4, 2, 2, 0, 0, 123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (48, 4, 2, 2, 0, 0, 123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (49, 4, 2, 2, 0, 0, 123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (50, 4, 2, 2, 0, 0, 123, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (51, 17, 2, 10, 1, 0, 15000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (52, 17, 2, 10, 0, 0, 15000, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (53, 4, 2, 2, 0, 0, 1234, CAST(N'2022-05-16' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (54, 4, 2, 10, 0, 0, 20000, CAST(N'2022-05-18' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (55, 4, 4, 3, 0, 0, 15000, CAST(N'2022-05-23' AS Date))
INSERT [dbo].[orderProducts] ([id], [userId], [productId], [warehouseId], [type], [isDeleted], [quantity], [createdAt]) VALUES (56, 12, 2, 2, 1, 0, 500000, CAST(N'2022-05-23' AS Date))
SET IDENTITY_INSERT [dbo].[orderProducts] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (2, 4, 6750, CAST(N'2022-05-14' AS Date), 0, 1)
INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (9, 4, 600, CAST(N'2022-05-14' AS Date), 0, 1)
INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (10, 4, 600, CAST(N'2022-12-14' AS Date), 0, 1)
INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (12, 4, 600, CAST(N'2022-12-14' AS Date), 0, 1)
INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (14, 4, 600, CAST(N'2022-05-14' AS Date), 1, 0)
INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (15, 4, 600, CAST(N'2022-05-14' AS Date), 1, 0)
INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (16, 4, 600, CAST(N'2022-05-14' AS Date), 0, 0)
INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (17, 17, 0, CAST(N'2001-01-01' AS Date), 0, 0)
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([id], [productCode], [productName], [productDesc], [productPrice], [isDeleted]) VALUES (2, N'BX        ', N'Box', N'Denem', 3, 0)
INSERT [dbo].[products] ([id], [productCode], [productName], [productDesc], [productPrice], [isDeleted]) VALUES (3, N'PLT       ', N'Palet', N'Plaet Desc', 11, 0)
INSERT [dbo].[products] ([id], [productCode], [productName], [productDesc], [productPrice], [isDeleted]) VALUES (4, N'PST01     ', N'Poset', N'PST test 123222', 1, 0)
INSERT [dbo].[products] ([id], [productCode], [productName], [productDesc], [productPrice], [isDeleted]) VALUES (5, N'KS        ', N'Kasa', N'Kasa Desc', 15, 0)
SET IDENTITY_INSERT [dbo].[products] OFF
GO
SET IDENTITY_INSERT [dbo].[roles] ON 

INSERT [dbo].[roles] ([id], [roleName], [roleDesc], [isDeleted]) VALUES (1, N'Admin     ', N'Update Test', 0)
INSERT [dbo].[roles] ([id], [roleName], [roleDesc], [isDeleted]) VALUES (2, N'Tedarikci ', N'Depoya Mal Satar', 0)
INSERT [dbo].[roles] ([id], [roleName], [roleDesc], [isDeleted]) VALUES (3, N'Musteri   ', N'Depodan Mal Alir', 0)
SET IDENTITY_INSERT [dbo].[roles] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [userName], [userSurname], [userEmail], [userPassword], [userBirthDay], [userRole], [isActive], [isDeleted]) VALUES (4, N'Arda      ', N'Catalkaya ', N'arda@123.com', N'arda123', CAST(N'1894-11-14T00:00:00.000' AS DateTime), 2, 1, 0)
INSERT [dbo].[users] ([id], [userName], [userSurname], [userEmail], [userPassword], [userBirthDay], [userRole], [isActive], [isDeleted]) VALUES (12, N'Samet     ', N'Bellur    ', N'samet@123.com', N'samet123', CAST(N'1894-06-28T00:00:00.000' AS DateTime), 3, 1, 0)
INSERT [dbo].[users] ([id], [userName], [userSurname], [userEmail], [userPassword], [userBirthDay], [userRole], [isActive], [isDeleted]) VALUES (14, N'Ramazan   ', N'Ozkan     ', N'ramazan@123.com', N'ramazan123', CAST(N'1894-06-29T00:00:00.000' AS DateTime), 2, 1, 0)
INSERT [dbo].[users] ([id], [userName], [userSurname], [userEmail], [userPassword], [userBirthDay], [userRole], [isActive], [isDeleted]) VALUES (17, N'Beytullah ', N'Arslan    ', N'yazilim2@drheclinic.com', N'beytullah123', CAST(N'1894-06-27T00:00:00.000' AS DateTime), 1, 1, 0)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET IDENTITY_INSERT [dbo].[warehouseProduct] ON 

INSERT [dbo].[warehouseProduct] ([id], [productId], [warehouseId], [quantity], [date], [isDeleted]) VALUES (5, 2, 1, 1000100, CAST(N'2022-05-14' AS Date), 0)
INSERT [dbo].[warehouseProduct] ([id], [productId], [warehouseId], [quantity], [date], [isDeleted]) VALUES (10, 2, 2, 149008, CAST(N'2022-05-14' AS Date), 0)
INSERT [dbo].[warehouseProduct] ([id], [productId], [warehouseId], [quantity], [date], [isDeleted]) VALUES (11, 3, 2, 143153, CAST(N'2022-05-14' AS Date), 0)
INSERT [dbo].[warehouseProduct] ([id], [productId], [warehouseId], [quantity], [date], [isDeleted]) VALUES (12, 4, 3, 65001, CAST(N'2022-05-14' AS Date), 0)
INSERT [dbo].[warehouseProduct] ([id], [productId], [warehouseId], [quantity], [date], [isDeleted]) VALUES (16, 4, 2, 0, CAST(N'2001-01-01' AS Date), 0)
INSERT [dbo].[warehouseProduct] ([id], [productId], [warehouseId], [quantity], [date], [isDeleted]) VALUES (17, 2, 3, 10000, CAST(N'2001-01-01' AS Date), 0)
INSERT [dbo].[warehouseProduct] ([id], [productId], [warehouseId], [quantity], [date], [isDeleted]) VALUES (18, 2, 10, 35000, CAST(N'2022-05-16' AS Date), 0)
SET IDENTITY_INSERT [dbo].[warehouseProduct] OFF
GO
SET IDENTITY_INSERT [dbo].[warehouses] ON 

INSERT [dbo].[warehouses] ([id], [warehouseCode], [warehouseName], [warehouseAddress], [warehouseCapacity], [warehouseAdminId], [isDeleted], [isActive]) VALUES (1, N'IST       ', N'Istanbul Depo', N'string', 150000, 4, 1, 1)
INSERT [dbo].[warehouses] ([id], [warehouseCode], [warehouseName], [warehouseAddress], [warehouseCapacity], [warehouseAdminId], [isDeleted], [isActive]) VALUES (2, N'IZM       ', N'Izmır Depo', N'bbbbb', 3500000, 4, 0, 1)
INSERT [dbo].[warehouses] ([id], [warehouseCode], [warehouseName], [warehouseAddress], [warehouseCapacity], [warehouseAdminId], [isDeleted], [isActive]) VALUES (3, N'AKS       ', N'Aksaray Depo', N'Aksaray Gazi Mah no:15', 150000, 4, 0, 1)
INSERT [dbo].[warehouses] ([id], [warehouseCode], [warehouseName], [warehouseAddress], [warehouseCapacity], [warehouseAdminId], [isDeleted], [isActive]) VALUES (10, N'ANK       ', N'Ankara Depo', N'Ankara ulus', 500000, 4, 0, 1)
SET IDENTITY_INSERT [dbo].[warehouses] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__products__0A9CBBE0F514E474]    Script Date: 24.05.2022 00:20:45 ******/
ALTER TABLE [dbo].[products] ADD UNIQUE NONCLUSTERED 
(
	[productName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__products__C20683899401FB8C]    Script Date: 24.05.2022 00:20:45 ******/
ALTER TABLE [dbo].[products] ADD UNIQUE NONCLUSTERED 
(
	[productCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__roles__B194786135BD1586]    Script Date: 24.05.2022 00:20:45 ******/
ALTER TABLE [dbo].[roles] ADD UNIQUE NONCLUSTERED 
(
	[roleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__D54ADF551664F725]    Script Date: 24.05.2022 00:20:45 ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[userEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__warehous__39EC929000847771]    Script Date: 24.05.2022 00:20:45 ******/
ALTER TABLE [dbo].[warehouses] ADD UNIQUE NONCLUSTERED 
(
	[warehouseName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__warehous__CFC9B62D04DF218D]    Script Date: 24.05.2022 00:20:45 ******/
ALTER TABLE [dbo].[warehouses] ADD UNIQUE NONCLUSTERED 
(
	[warehouseCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[orderProducts] ADD  CONSTRAINT [DF_orderProducts_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[orderProducts] ADD  CONSTRAINT [DF_orderProducts_quantity]  DEFAULT ((0)) FOR [quantity]
GO
ALTER TABLE [dbo].[orderProducts] ADD  CONSTRAINT [DF_orderProducts_createdAt]  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[orders] ADD  CONSTRAINT [DF_orders_isCompleted]  DEFAULT ((0)) FOR [isCompleted]
GO
ALTER TABLE [dbo].[orders] ADD  CONSTRAINT [DF_orders_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[products] ADD  CONSTRAINT [DF_products_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[roles] ADD  CONSTRAINT [DF_roles_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[warehouseProduct] ADD  CONSTRAINT [DF_warehouseProduct_date]  DEFAULT (getdate()) FOR [date]
GO
ALTER TABLE [dbo].[warehouseProduct] ADD  CONSTRAINT [DF_warehouseProduct_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[warehouses] ADD  CONSTRAINT [DF_warehouses_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[warehouses] ADD  CONSTRAINT [DF_warehouses_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[orderProducts]  WITH CHECK ADD  CONSTRAINT [FK_orderProducts_products] FOREIGN KEY([productId])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[orderProducts] CHECK CONSTRAINT [FK_orderProducts_products]
GO
ALTER TABLE [dbo].[orderProducts]  WITH CHECK ADD  CONSTRAINT [FK_orderProducts_users] FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[orderProducts] CHECK CONSTRAINT [FK_orderProducts_users]
GO
ALTER TABLE [dbo].[orderProducts]  WITH CHECK ADD  CONSTRAINT [FK_orderProducts_warehouses] FOREIGN KEY([warehouseId])
REFERENCES [dbo].[warehouses] ([id])
GO
ALTER TABLE [dbo].[orderProducts] CHECK CONSTRAINT [FK_orderProducts_warehouses]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FK_orders_users] FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FK_orders_users]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_roles] FOREIGN KEY([userRole])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_users_roles]
GO
ALTER TABLE [dbo].[warehouseProduct]  WITH CHECK ADD  CONSTRAINT [FK_warehouseProduct_products] FOREIGN KEY([productId])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[warehouseProduct] CHECK CONSTRAINT [FK_warehouseProduct_products]
GO
ALTER TABLE [dbo].[warehouseProduct]  WITH CHECK ADD  CONSTRAINT [FK_warehouseProduct_warehouses] FOREIGN KEY([warehouseId])
REFERENCES [dbo].[warehouses] ([id])
GO
ALTER TABLE [dbo].[warehouseProduct] CHECK CONSTRAINT [FK_warehouseProduct_warehouses]
GO
ALTER TABLE [dbo].[warehouses]  WITH CHECK ADD  CONSTRAINT [FK_warehouses_users] FOREIGN KEY([warehouseAdminId])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[warehouses] CHECK CONSTRAINT [FK_warehouses_users]
GO
ALTER TABLE [dbo].[warehouseProduct]  WITH CHECK ADD  CONSTRAINT [stockControl] CHECK  (([quantity]>=(0)))
GO
ALTER TABLE [dbo].[warehouseProduct] CHECK CONSTRAINT [stockControl]
GO
USE [master]
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET  READ_WRITE 
GO
