USE [master]
GO
/****** Object:  Database [STOKTAKIPOTOMASYONU]    Script Date: 15.05.2022 00:48:56 ******/
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
/****** Object:  Table [dbo].[orderProducts]    Script Date: 15.05.2022 00:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderProducts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[orderId] [int] NOT NULL,
	[productId] [int] NOT NULL,
	[type] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK_orderProducts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 15.05.2022 00:48:56 ******/
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
/****** Object:  Table [dbo].[products]    Script Date: 15.05.2022 00:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[productCode] [nchar](10) NOT NULL,
	[productName] [nvarchar](50) NOT NULL,
	[productDesc] [nvarchar](150) NULL,
	[productPrice] [float] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 15.05.2022 00:48:56 ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 15.05.2022 00:48:56 ******/
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
/****** Object:  Table [dbo].[warehouseProduct]    Script Date: 15.05.2022 00:48:56 ******/
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
/****** Object:  Table [dbo].[warehouses]    Script Date: 15.05.2022 00:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[warehouses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[warehouseCode] [nchar](10) NOT NULL,
	[warehouseName] [nchar](10) NOT NULL,
	[warehouseAddress] [nvarchar](50) NOT NULL,
	[warehouseCapacity] [int] NOT NULL,
	[warehouseAdminId] [int] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_warehouses] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[orderProducts] ON 

INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (3, 2, 2, 0, 0, 15)
INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (4, 2, 2, 0, 0, 0)
INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (5, 2, 2, 0, 1, 0)
INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (6, 2, 2, 0, 1, 0)
INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (7, 2, 2, 0, 0, 0)
INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (8, 2, 2, 0, 0, 0)
INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (9, 2, 2, 0, 0, 0)
INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (10, 2, 2, 0, 0, 0)
INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (11, 2, 2, 0, 0, 0)
INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (12, 2, 2, 0, 0, 0)
INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (13, 2, 2, 0, 0, 0)
INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (14, 2, 2, 0, 0, 0)
INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (15, 2, 2, 0, 0, 0)
INSERT [dbo].[orderProducts] ([id], [orderId], [productId], [type], [isDeleted], [quantity]) VALUES (16, 2, 2, 0, 0, 30)
SET IDENTITY_INSERT [dbo].[orderProducts] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (2, 4, 6750, CAST(N'2022-05-14' AS Date), 1, 1)
INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (9, 4, 600, CAST(N'2022-05-14' AS Date), 0, 0)
INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (10, 4, 600, CAST(N'2022-12-14' AS Date), 0, 0)
INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (12, 4, 600, CAST(N'2022-12-14' AS Date), 0, 0)
INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (14, 4, 600, CAST(N'2022-05-14' AS Date), 0, 0)
INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (15, 4, 600, CAST(N'2022-05-14' AS Date), 0, 0)
INSERT [dbo].[orders] ([id], [userId], [orderPrice], [orderDate], [isCompleted], [isDeleted]) VALUES (16, 4, 600, CAST(N'2022-05-14' AS Date), 0, 0)
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([id], [productCode], [productName], [productDesc], [productPrice], [isDeleted]) VALUES (2, N'aaa       ', N'Deneme', N'Denem', 150, 0)
SET IDENTITY_INSERT [dbo].[products] OFF
GO
SET IDENTITY_INSERT [dbo].[roles] ON 

INSERT [dbo].[roles] ([id], [roleName], [roleDesc], [isDeleted]) VALUES (1, N'Admin     ', N'Update Test', 0)
SET IDENTITY_INSERT [dbo].[roles] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [userName], [userSurname], [userEmail], [userPassword], [userBirthDay], [userRole], [isActive], [isDeleted]) VALUES (4, N'string11  ', N'string    ', N'string', N'string', CAST(N'1894-06-28T00:00:00.000' AS DateTime), 1, 1, 0)
INSERT [dbo].[users] ([id], [userName], [userSurname], [userEmail], [userPassword], [userBirthDay], [userRole], [isActive], [isDeleted]) VALUES (12, N'string1234', N'string    ', N'string', N'string', CAST(N'1894-06-28T00:00:00.000' AS DateTime), 1, 1, 0)
INSERT [dbo].[users] ([id], [userName], [userSurname], [userEmail], [userPassword], [userBirthDay], [userRole], [isActive], [isDeleted]) VALUES (13, N'string11  ', N'string    ', N'string', N'string', CAST(N'1894-06-28T00:00:00.000' AS DateTime), 1, 1, 0)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET IDENTITY_INSERT [dbo].[warehouseProduct] ON 

INSERT [dbo].[warehouseProduct] ([id], [productId], [warehouseId], [quantity], [date], [isDeleted]) VALUES (5, 2, 1, 1000000, CAST(N'2022-05-14' AS Date), 0)
INSERT [dbo].[warehouseProduct] ([id], [productId], [warehouseId], [quantity], [date], [isDeleted]) VALUES (9, 2, 1, 151515, CAST(N'2022-05-14' AS Date), 0)
INSERT [dbo].[warehouseProduct] ([id], [productId], [warehouseId], [quantity], [date], [isDeleted]) VALUES (10, 2, 1, 151515, CAST(N'2022-05-14' AS Date), 0)
INSERT [dbo].[warehouseProduct] ([id], [productId], [warehouseId], [quantity], [date], [isDeleted]) VALUES (11, 2, 1, 151515, CAST(N'2022-05-14' AS Date), 0)
SET IDENTITY_INSERT [dbo].[warehouseProduct] OFF
GO
SET IDENTITY_INSERT [dbo].[warehouses] ON 

INSERT [dbo].[warehouses] ([id], [warehouseCode], [warehouseName], [warehouseAddress], [warehouseCapacity], [warehouseAdminId], [isDeleted]) VALUES (1, N'string    ', N'string    ', N'string', 1500, 4, 1)
INSERT [dbo].[warehouses] ([id], [warehouseCode], [warehouseName], [warehouseAddress], [warehouseCapacity], [warehouseAdminId], [isDeleted]) VALUES (2, N'aaaa      ', N'bbbb      ', N'bbbbb', 10000, 4, 0)
SET IDENTITY_INSERT [dbo].[warehouses] OFF
GO
ALTER TABLE [dbo].[orderProducts] ADD  CONSTRAINT [DF_orderProducts_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[orderProducts] ADD  CONSTRAINT [DF_orderProducts_quantity]  DEFAULT ((0)) FOR [quantity]
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
ALTER TABLE [dbo].[warehouseProduct] ADD  CONSTRAINT [DF_warehouseProduct_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[warehouses] ADD  CONSTRAINT [DF_warehouses_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[orderProducts]  WITH CHECK ADD  CONSTRAINT [FK_orderProducts_products] FOREIGN KEY([productId])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[orderProducts] CHECK CONSTRAINT [FK_orderProducts_products]
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
USE [master]
GO
ALTER DATABASE [STOKTAKIPOTOMASYONU] SET  READ_WRITE 
GO
