USE [master]
GO
/****** Object:  Database [lotnisko]    Script Date: 17.06.2022 12:36:52 ******/
CREATE DATABASE [lotnisko]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'lotnisko', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\lotnisko.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'lotnisko_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\lotnisko_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [lotnisko] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [lotnisko].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [lotnisko] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [lotnisko] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [lotnisko] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [lotnisko] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [lotnisko] SET ARITHABORT OFF 
GO
ALTER DATABASE [lotnisko] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [lotnisko] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [lotnisko] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [lotnisko] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [lotnisko] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [lotnisko] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [lotnisko] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [lotnisko] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [lotnisko] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [lotnisko] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [lotnisko] SET  DISABLE_BROKER 
GO
ALTER DATABASE [lotnisko] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [lotnisko] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [lotnisko] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [lotnisko] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [lotnisko] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [lotnisko] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [lotnisko] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [lotnisko] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [lotnisko] SET  MULTI_USER 
GO
ALTER DATABASE [lotnisko] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [lotnisko] SET DB_CHAINING OFF 
GO
ALTER DATABASE [lotnisko] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [lotnisko] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [lotnisko]
GO
/****** Object:  DatabaseRole [admin]    Script Date: 17.06.2022 12:36:52 ******/
CREATE ROLE [admin]
GO
/****** Object:  StoredProcedure [dbo].[Ceny_przed_i_po_promocji]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Ceny_przed_i_po_promocji]
AS
begin
BEGIN TRANSACTION 
SELECT lotnisko.dbo.bilet.IDSamolotu, 
	   lotnisko.dbo.bilet.cena, 
	   lotniskoB.dbo.promocje.cena_promocyjna
FROM lotnisko.dbo.bilet
INNER JOIN lotniskoB.dbo.promocje 
ON lotnisko.dbo.bilet.polaczenie_lotnicze = lotniskoB.dbo.promocje.polaczenie_lotnicze
COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dbo].[Dane_pasazerow_i_pracownikow]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dane_pasazerow_i_pracownikow] AS
begin
BEGIN TRANSACTION
SELECT lotnisko.dbo.pasazer.Imie AS imie_pasazera, 
	   lotnisko.dbo.pasazer.Nazwisko AS nazwisko_pasazera, 
	   lotniskoB.dbo.pracownicy.ImieP AS imie_pracownika, 
	   lotniskoB.dbo.pracownicy.NazwiskoP AS nazwisko_pracownika
FROM lotnisko.dbo.pasazer, lotniskoB.dbo.pracownicy
COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dbo].[Dodaj_pasazera]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dodaj_pasazera]
@Imie varchar(50),
@Nazwisko varchar(50),
@Telefon varchar(50),
@Paszport varchar(50),
@Kod_IATA char(10)
AS
begin
BEGIN TRANSACTION
INSERT INTO lotnisko.dbo.pasazer(Imie, Nazwisko, Telefon, Paszport, Kod_IATA)
VALUES (@Imie, @Nazwisko, @Telefon, @Paszport, @Kod_IATA)
WAITFOR DELAY '00:00:03'
COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dbo].[Dodawanie_kodu_lotniska]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dodawanie_kodu_lotniska]
@Kod_IATA char(10) = NULL,
@Nazwa varchar(50) = NULL
 
AS
begin
INSERT INTO lotnisko.dbo.kraj(Kod_IATA, Nazwa)
VALUES (@Kod_IATA, @Nazwa);

INSERT INTO lotniskoB.dbo.krajB(Kod_IATA, Nazwa)
VALUES (@Kod_IATA, @Nazwa);
END
GO
/****** Object:  StoredProcedure [dbo].[Lotniska_polskie]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Lotniska_polskie] AS
begin
SELECT Kod_IATA, Nazwa
FROM lotnisko.dbo.kraj
WHERE Nazwa LIKE 'Polska'
UNION
SELECT Kod_IATA, Nazwa
FROM lotniskoB.dbo.krajB
WHERE Nazwa LIKE 'Polska'
END
GO
/****** Object:  StoredProcedure [dbo].[Lotniska_z_obu_baz]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Lotniska_z_obu_baz]
AS
begin
BEGIN TRANSACTION
SELECT Kod_IATA_lotniska, Nazwa 
FROM lotnisko.dbo.lotnisko
UNION
SELECT Kod_IATA_lotniska, Nazwa 
FROM lotniskoB.dbo.lotniskoB
COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dbo].[lotnisko_dane]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[lotnisko_dane] AS
begin
SELECT *
FROM lotnisko.dbo.awaria_samolotu
SELECT *
FROM lotnisko.dbo.bilet
SELECT *
FROM lotnisko.dbo.booking
SELECT *
FROM lotnisko.dbo.klasa_p
SELECT *
FROM lotnisko.dbo.kraj
SELECT *
FROM lotnisko.dbo.lot
SELECT *
FROM lotnisko.dbo.lotnisko
SELECT *
FROM lotnisko.dbo.opoznienie_lotu
SELECT *
FROM lotnisko.dbo.pasazer
SELECT *
FROM lotnisko.dbo.producent_samolotu
SELECT *
FROM lotnisko.dbo.rozklad
SELECT *
FROM lotnisko.dbo.samolot
SELECT *
FROM lotnisko.dbo.samolot_m
SELECT *
FROM lotnisko.dbo.status
END
GO
/****** Object:  StoredProcedure [dbo].[Modyfikacja_pasazerow]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Modyfikacja_pasazerow]
@IDPasazera int,
@Imie varchar(50),
@Nazwisko varchar(50),
@Telefon varchar(50),
@Paszport varchar(50),
@Kod_IATA char(10)
AS
begin
BEGIN TRANSACTION
UPDATE lotnisko.dbo.pasazer
SET Imie = @Imie, Nazwisko = @Nazwisko, Telefon = @Telefon, Paszport = @Paszport, Kod_IATA = @Kod_IATA
WHERE IDPasazera = @IDPasazera
COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dbo].[Nazwiska_zaczynajace_na_N]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Nazwiska_zaczynajace_na_N]
AS
begin
BEGIN TRANSACTION
SELECT lotnisko.dbo.pasazer.Imie AS imie_pasazera, 
	   lotnisko.dbo.pasazer.Nazwisko AS nazwisko_pasazera, 
	   lotniskoB.dbo.pracownicy.ImieP AS imie_pracownika, 
	   lotniskoB.dbo.pracownicy.NazwiskoP AS nazwisko_pracownika
FROM lotnisko.dbo.pasazer, lotniskoB.dbo.pracownicy
WHERE NazwiskoP LIKE 'N%'
AND Nazwisko LIKE 'N%'
COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dbo].[Usuwanie_pasazera]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usuwanie_pasazera] @IDPasazera int AS
begin
DELETE FROM lotnisko.dbo.pasazer
WHERE IDPasazera = @IDPasazera;
END
GO
/****** Object:  StoredProcedure [dbo].[Wyszukaj_pracownika]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Wyszukaj_pracownika] @NazwiskoP varchar(50)
AS
begin
SELECT * 
FROM lotniskoB.dbo.pracownicy
where NazwiskoP = @NazwiskoP
END
GO
/****** Object:  StoredProcedure [dbo].[Znizka_biletu_o_5_procent]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Znizka_biletu_o_5_procent]
AS
BEGIN
UPDATE lotnisko.dbo.bilet
SET cena = cena - ((cena * 5) / 100)
WHERE polaczenie_lotnicze = 4
UPDATE lotniskoB.dbo.promocje
SET cena_promocyjna = cena_promocyjna - ((cena_promocyjna * 5) / 100)
WHERE polaczenie_lotnicze = 4
END
GO
/****** Object:  Table [dbo].[awaria_samolotu]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[awaria_samolotu](
	[IDAwarii] [int] IDENTITY(1,1) NOT NULL,
	[IDSamolotu] [int] NULL,
 CONSTRAINT [PK_awaria_samolotu] PRIMARY KEY CLUSTERED 
(
	[IDAwarii] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bilet]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bilet](
	[polaczenie_lotnicze] [int] NOT NULL,
	[IDSamolotu] [int] NOT NULL,
	[IDMiejsca] [int] NOT NULL,
	[cena] [decimal](18, 0) NULL,
 CONSTRAINT [PK_bilet] PRIMARY KEY CLUSTERED 
(
	[polaczenie_lotnicze] ASC,
	[IDSamolotu] ASC,
	[IDMiejsca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[booking]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[booking](
	[IDPasazera] [int] NOT NULL,
	[polaczenie_lotnicze] [int] NOT NULL,
	[IDSamolotu] [int] NOT NULL,
	[IDMiejsca] [int] NOT NULL,
 CONSTRAINT [PK_booking] PRIMARY KEY CLUSTERED 
(
	[IDPasazera] ASC,
	[polaczenie_lotnicze] ASC,
	[IDSamolotu] ASC,
	[IDMiejsca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kierunek]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[kierunek](
	[start_lotu_IATA] [char](10) NOT NULL,
	[koniec_lotu_IATA] [char](10) NOT NULL,
 CONSTRAINT [PK_kierunek] PRIMARY KEY CLUSTERED 
(
	[start_lotu_IATA] ASC,
	[koniec_lotu_IATA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[klasa_p]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[klasa_p](
	[IDKlasy] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [varchar](50) NULL,
 CONSTRAINT [PK_klasa_p] PRIMARY KEY CLUSTERED 
(
	[IDKlasy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[kraj]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[kraj](
	[Kod_IATA] [char](10) NOT NULL,
	[Nazwa] [varchar](50) NULL,
 CONSTRAINT [PK_kraj] PRIMARY KEY CLUSTERED 
(
	[Kod_IATA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lot]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lot](
	[polaczenie_lotnicze] [int] IDENTITY(1,1) NOT NULL,
	[IDRozkladu] [int] NULL,
	[IDLotu] [int] NULL,
 CONSTRAINT [PK_lot] PRIMARY KEY CLUSTERED 
(
	[polaczenie_lotnicze] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[lotnisko]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lotnisko](
	[Kod_IATA_lotniska] [char](10) NOT NULL,
	[Nazwa] [varchar](50) NULL,
	[Miasto] [varchar](50) NULL,
	[Kod_IATA] [char](10) NULL,
 CONSTRAINT [PK_lotnisko] PRIMARY KEY CLUSTERED 
(
	[Kod_IATA_lotniska] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[opoznienie_lotu]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[opoznienie_lotu](
	[polaczenie_lotnicze] [int] NOT NULL,
	[IDAwarii] [int] NOT NULL,
 CONSTRAINT [PK_opoznienie_lotu] PRIMARY KEY CLUSTERED 
(
	[polaczenie_lotnicze] ASC,
	[IDAwarii] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pasazer]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pasazer](
	[IDPasazera] [int] IDENTITY(1,1) NOT NULL,
	[Imie] [varchar](50) NULL,
	[Nazwisko] [varchar](50) NULL,
	[Telefon] [varchar](50) NULL,
	[Paszport] [varchar](50) NULL,
	[Kod_IATA] [char](10) NULL,
 CONSTRAINT [PK_pasazer] PRIMARY KEY CLUSTERED 
(
	[IDPasazera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[producent_samolotu]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[producent_samolotu](
	[IDProducenta] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [varchar](50) NULL,
 CONSTRAINT [PK_producent_samolotu] PRIMARY KEY CLUSTERED 
(
	[IDProducenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[rozklad]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[rozklad](
	[IDRozkladu] [int] IDENTITY(1,1) NOT NULL,
	[start_lotu_IATA] [char](10) NULL,
	[koniec_lotu_IATA] [char](10) NULL,
	[godzina_wylotu] [datetime] NULL,
	[godzina_przylotu] [datetime] NULL,
 CONSTRAINT [PK_rozklad] PRIMARY KEY CLUSTERED 
(
	[IDRozkladu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[samolot]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[samolot](
	[IDSamolotu] [int] IDENTITY(1,1) NOT NULL,
	[IDProducenta] [int] NULL,
	[model] [varchar](50) NULL,
 CONSTRAINT [PK_samolot] PRIMARY KEY CLUSTERED 
(
	[IDSamolotu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[samolot_m]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[samolot_m](
	[IDSamolotu] [int] NOT NULL,
	[IDMiejsca] [int] NOT NULL,
	[IDKlasy] [int] NULL,
 CONSTRAINT [PK_samolot_m] PRIMARY KEY CLUSTERED 
(
	[IDSamolotu] ASC,
	[IDMiejsca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[status]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[status](
	[IDLotu] [int] IDENTITY(1,1) NOT NULL,
	[Informacje] [varchar](50) NULL,
 CONSTRAINT [PK_status] PRIMARY KEY CLUSTERED 
(
	[IDLotu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[raport]    Script Date: 17.06.2022 12:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[raport] AS
SELECT IDPasazera, SUM(cena) AS 'Raport_sprzedazy'
FROM booking, bilet 
WHERE bilet.IDSamolotu = booking.IDSamolotu
GROUP BY IDPasazera

GO
SET IDENTITY_INSERT [dbo].[awaria_samolotu] ON 

INSERT [dbo].[awaria_samolotu] ([IDAwarii], [IDSamolotu]) VALUES (2, 1)
INSERT [dbo].[awaria_samolotu] ([IDAwarii], [IDSamolotu]) VALUES (3, 2)
INSERT [dbo].[awaria_samolotu] ([IDAwarii], [IDSamolotu]) VALUES (4, 3)
INSERT [dbo].[awaria_samolotu] ([IDAwarii], [IDSamolotu]) VALUES (5, 4)
INSERT [dbo].[awaria_samolotu] ([IDAwarii], [IDSamolotu]) VALUES (8, 5)
SET IDENTITY_INSERT [dbo].[awaria_samolotu] OFF
INSERT [dbo].[bilet] ([polaczenie_lotnicze], [IDSamolotu], [IDMiejsca], [cena]) VALUES (3, 1, 1, CAST(79 AS Decimal(18, 0)))
INSERT [dbo].[bilet] ([polaczenie_lotnicze], [IDSamolotu], [IDMiejsca], [cena]) VALUES (4, 2, 2, CAST(719 AS Decimal(18, 0)))
INSERT [dbo].[bilet] ([polaczenie_lotnicze], [IDSamolotu], [IDMiejsca], [cena]) VALUES (5, 3, 3, CAST(250 AS Decimal(18, 0)))
INSERT [dbo].[bilet] ([polaczenie_lotnicze], [IDSamolotu], [IDMiejsca], [cena]) VALUES (6, 4, 4, CAST(1900 AS Decimal(18, 0)))
INSERT [dbo].[bilet] ([polaczenie_lotnicze], [IDSamolotu], [IDMiejsca], [cena]) VALUES (7, 5, 5, CAST(1800 AS Decimal(18, 0)))
INSERT [dbo].[booking] ([IDPasazera], [polaczenie_lotnicze], [IDSamolotu], [IDMiejsca]) VALUES (2, 3, 1, 1)
INSERT [dbo].[booking] ([IDPasazera], [polaczenie_lotnicze], [IDSamolotu], [IDMiejsca]) VALUES (3, 4, 2, 2)
INSERT [dbo].[booking] ([IDPasazera], [polaczenie_lotnicze], [IDSamolotu], [IDMiejsca]) VALUES (4, 5, 3, 3)
INSERT [dbo].[booking] ([IDPasazera], [polaczenie_lotnicze], [IDSamolotu], [IDMiejsca]) VALUES (5, 6, 4, 4)
INSERT [dbo].[booking] ([IDPasazera], [polaczenie_lotnicze], [IDSamolotu], [IDMiejsca]) VALUES (6, 7, 5, 5)
INSERT [dbo].[kierunek] ([start_lotu_IATA], [koniec_lotu_IATA]) VALUES (N'DKR       ', N'ORY       ')
INSERT [dbo].[kierunek] ([start_lotu_IATA], [koniec_lotu_IATA]) VALUES (N'KTW       ', N'ORD       ')
INSERT [dbo].[kierunek] ([start_lotu_IATA], [koniec_lotu_IATA]) VALUES (N'POZ       ', N'WAW       ')
INSERT [dbo].[kierunek] ([start_lotu_IATA], [koniec_lotu_IATA]) VALUES (N'VNO       ', N'WRO       ')
INSERT [dbo].[kierunek] ([start_lotu_IATA], [koniec_lotu_IATA]) VALUES (N'WAW       ', N'AAR       ')
SET IDENTITY_INSERT [dbo].[klasa_p] ON 

INSERT [dbo].[klasa_p] ([IDKlasy], [Nazwa]) VALUES (1, N'Ekonomiczna')
INSERT [dbo].[klasa_p] ([IDKlasy], [Nazwa]) VALUES (2, N'Biznesowa')
SET IDENTITY_INSERT [dbo].[klasa_p] OFF
INSERT [dbo].[kraj] ([Kod_IATA], [Nazwa]) VALUES (N'AAR       ', N'Dania')
INSERT [dbo].[kraj] ([Kod_IATA], [Nazwa]) VALUES (N'DKR       ', N'Senegal')
INSERT [dbo].[kraj] ([Kod_IATA], [Nazwa]) VALUES (N'KTW       ', N'Polska')
INSERT [dbo].[kraj] ([Kod_IATA], [Nazwa]) VALUES (N'ORD       ', N'USA')
INSERT [dbo].[kraj] ([Kod_IATA], [Nazwa]) VALUES (N'ORY       ', N'Francja')
INSERT [dbo].[kraj] ([Kod_IATA], [Nazwa]) VALUES (N'POZ       ', N'Polska')
INSERT [dbo].[kraj] ([Kod_IATA], [Nazwa]) VALUES (N'VNO       ', N'Litwa')
INSERT [dbo].[kraj] ([Kod_IATA], [Nazwa]) VALUES (N'WAW       ', N'Polska')
INSERT [dbo].[kraj] ([Kod_IATA], [Nazwa]) VALUES (N'WRO       ', N'Polska')
SET IDENTITY_INSERT [dbo].[lot] ON 

INSERT [dbo].[lot] ([polaczenie_lotnicze], [IDRozkladu], [IDLotu]) VALUES (3, 4, 1)
INSERT [dbo].[lot] ([polaczenie_lotnicze], [IDRozkladu], [IDLotu]) VALUES (4, 5, 2)
INSERT [dbo].[lot] ([polaczenie_lotnicze], [IDRozkladu], [IDLotu]) VALUES (5, 6, 3)
INSERT [dbo].[lot] ([polaczenie_lotnicze], [IDRozkladu], [IDLotu]) VALUES (6, 7, 4)
INSERT [dbo].[lot] ([polaczenie_lotnicze], [IDRozkladu], [IDLotu]) VALUES (7, 8, 5)
SET IDENTITY_INSERT [dbo].[lot] OFF
INSERT [dbo].[lotnisko] ([Kod_IATA_lotniska], [Nazwa], [Miasto], [Kod_IATA]) VALUES (N'AAR       ', N'Port Lotniczy Aarhus', N'Aarhus', N'AAR       ')
INSERT [dbo].[lotnisko] ([Kod_IATA_lotniska], [Nazwa], [Miasto], [Kod_IATA]) VALUES (N'DKR       ', N'Port Lotniczy Dakar', N'Dakar', N'DKR       ')
INSERT [dbo].[lotnisko] ([Kod_IATA_lotniska], [Nazwa], [Miasto], [Kod_IATA]) VALUES (N'KTW       ', N'Port lotniczy Katowice-Pyrzowice', N'Katowice', N'KTW       ')
INSERT [dbo].[lotnisko] ([Kod_IATA_lotniska], [Nazwa], [Miasto], [Kod_IATA]) VALUES (N'ORD       ', N'Port lotniczy Chicago-O’Hare', N'Chicago', N'ORD       ')
INSERT [dbo].[lotnisko] ([Kod_IATA_lotniska], [Nazwa], [Miasto], [Kod_IATA]) VALUES (N'ORY       ', N'Port lotniczy Paryż-Orly', N'Paryż', N'ORY       ')
INSERT [dbo].[lotnisko] ([Kod_IATA_lotniska], [Nazwa], [Miasto], [Kod_IATA]) VALUES (N'POZ       ', N'Port Lotniczy Poznań-Ławica ', N'Poznań', N'POZ       ')
INSERT [dbo].[lotnisko] ([Kod_IATA_lotniska], [Nazwa], [Miasto], [Kod_IATA]) VALUES (N'VNO       ', N'Port lotniczy Wilno', N'Wilno', N'VNO       ')
INSERT [dbo].[lotnisko] ([Kod_IATA_lotniska], [Nazwa], [Miasto], [Kod_IATA]) VALUES (N'WAW       ', N'Lotnisko Chopina ', N'Warszawa', N'WAW       ')
INSERT [dbo].[lotnisko] ([Kod_IATA_lotniska], [Nazwa], [Miasto], [Kod_IATA]) VALUES (N'WRO       ', N'Port Lotniczy Wrocław S.A.', N'Wrocław', N'WRO       ')
INSERT [dbo].[opoznienie_lotu] ([polaczenie_lotnicze], [IDAwarii]) VALUES (3, 2)
INSERT [dbo].[opoznienie_lotu] ([polaczenie_lotnicze], [IDAwarii]) VALUES (4, 3)
INSERT [dbo].[opoznienie_lotu] ([polaczenie_lotnicze], [IDAwarii]) VALUES (5, 4)
INSERT [dbo].[opoznienie_lotu] ([polaczenie_lotnicze], [IDAwarii]) VALUES (6, 5)
INSERT [dbo].[opoznienie_lotu] ([polaczenie_lotnicze], [IDAwarii]) VALUES (7, 8)
SET IDENTITY_INSERT [dbo].[pasazer] ON 

INSERT [dbo].[pasazer] ([IDPasazera], [Imie], [Nazwisko], [Telefon], [Paszport], [Kod_IATA]) VALUES (2, N'Piotr', N'Kowalski', N'667809182', N'ZT6378945', N'POZ       ')
INSERT [dbo].[pasazer] ([IDPasazera], [Imie], [Nazwisko], [Telefon], [Paszport], [Kod_IATA]) VALUES (3, N'Kamil', N'Bayer', N'01632 960367', N'806324043', N'DKR       ')
INSERT [dbo].[pasazer] ([IDPasazera], [Imie], [Nazwisko], [Telefon], [Paszport], [Kod_IATA]) VALUES (4, N'Mariusz', N'Nowak', N'687102903', N'ZE6735179', N'VNO       ')
INSERT [dbo].[pasazer] ([IDPasazera], [Imie], [Nazwisko], [Telefon], [Paszport], [Kod_IATA]) VALUES (5, N'Maria', N'Kral', N'773098172', N'ZT6395392', N'KTW       ')
INSERT [dbo].[pasazer] ([IDPasazera], [Imie], [Nazwisko], [Telefon], [Paszport], [Kod_IATA]) VALUES (6, N'Adrian', N'Nowak', N'552874617', N'ZT6395392', N'POZ       ')
INSERT [dbo].[pasazer] ([IDPasazera], [Imie], [Nazwisko], [Telefon], [Paszport], [Kod_IATA]) VALUES (7, N'Eugeniusz', N'Wójcik', N'557332112', N'ZT4325323', N'WAW       ')
INSERT [dbo].[pasazer] ([IDPasazera], [Imie], [Nazwisko], [Telefon], [Paszport], [Kod_IATA]) VALUES (8, N'Adrian', N'Nowak', N'552874617', N'ZT6395392', N'POZ       ')
INSERT [dbo].[pasazer] ([IDPasazera], [Imie], [Nazwisko], [Telefon], [Paszport], [Kod_IATA]) VALUES (11, N'Eugeniusz', N'Kowalski', N'442332122', N'ZT738372', N'WRO       ')
SET IDENTITY_INSERT [dbo].[pasazer] OFF
SET IDENTITY_INSERT [dbo].[producent_samolotu] ON 

INSERT [dbo].[producent_samolotu] ([IDProducenta], [Nazwa]) VALUES (1, N'Boeing')
INSERT [dbo].[producent_samolotu] ([IDProducenta], [Nazwa]) VALUES (2, N'Airbus')
SET IDENTITY_INSERT [dbo].[producent_samolotu] OFF
SET IDENTITY_INSERT [dbo].[rozklad] ON 

INSERT [dbo].[rozklad] ([IDRozkladu], [start_lotu_IATA], [koniec_lotu_IATA], [godzina_wylotu], [godzina_przylotu]) VALUES (4, N'POZ       ', N'WAW       ', CAST(0x0000AB47003550D4 AS DateTime), CAST(0x0000AB4700378354 AS DateTime))
INSERT [dbo].[rozklad] ([IDRozkladu], [start_lotu_IATA], [koniec_lotu_IATA], [godzina_wylotu], [godzina_przylotu]) VALUES (5, N'DKR       ', N'ORY       ', CAST(0x0000AB4900DB3594 AS DateTime), CAST(0x0000AB490127977C AS DateTime))
INSERT [dbo].[rozklad] ([IDRozkladu], [start_lotu_IATA], [koniec_lotu_IATA], [godzina_wylotu], [godzina_przylotu]) VALUES (6, N'VNO       ', N'WRO       ', CAST(0x0000AB4D00A8F264 AS DateTime), CAST(0x0000AB4D00B54E74 AS DateTime))
INSERT [dbo].[rozklad] ([IDRozkladu], [start_lotu_IATA], [koniec_lotu_IATA], [godzina_wylotu], [godzina_przylotu]) VALUES (7, N'KTW       ', N'ORD       ', CAST(0x0000AB4D00CC1A64 AS DateTime), CAST(0x0000AB4D01557B88 AS DateTime))
INSERT [dbo].[rozklad] ([IDRozkladu], [start_lotu_IATA], [koniec_lotu_IATA], [godzina_wylotu], [godzina_przylotu]) VALUES (8, N'WAW       ', N'AAR       ', CAST(0x0000AB47005524E0 AS DateTime), CAST(0x0000AB470100CE30 AS DateTime))
SET IDENTITY_INSERT [dbo].[rozklad] OFF
SET IDENTITY_INSERT [dbo].[samolot] ON 

INSERT [dbo].[samolot] ([IDSamolotu], [IDProducenta], [model]) VALUES (1, 1, N'747')
INSERT [dbo].[samolot] ([IDSamolotu], [IDProducenta], [model]) VALUES (2, 2, N'A380')
INSERT [dbo].[samolot] ([IDSamolotu], [IDProducenta], [model]) VALUES (3, 1, N'777')
INSERT [dbo].[samolot] ([IDSamolotu], [IDProducenta], [model]) VALUES (4, 1, N'747-8')
INSERT [dbo].[samolot] ([IDSamolotu], [IDProducenta], [model]) VALUES (5, 1, N'747-A')
SET IDENTITY_INSERT [dbo].[samolot] OFF
INSERT [dbo].[samolot_m] ([IDSamolotu], [IDMiejsca], [IDKlasy]) VALUES (1, 1, 1)
INSERT [dbo].[samolot_m] ([IDSamolotu], [IDMiejsca], [IDKlasy]) VALUES (2, 2, 2)
INSERT [dbo].[samolot_m] ([IDSamolotu], [IDMiejsca], [IDKlasy]) VALUES (3, 3, 1)
INSERT [dbo].[samolot_m] ([IDSamolotu], [IDMiejsca], [IDKlasy]) VALUES (4, 4, 1)
INSERT [dbo].[samolot_m] ([IDSamolotu], [IDMiejsca], [IDKlasy]) VALUES (5, 5, 1)
SET IDENTITY_INSERT [dbo].[status] ON 

INSERT [dbo].[status] ([IDLotu], [Informacje]) VALUES (1, N'Zakończony')
INSERT [dbo].[status] ([IDLotu], [Informacje]) VALUES (2, N'Zakończony')
INSERT [dbo].[status] ([IDLotu], [Informacje]) VALUES (3, N'Zakończony')
INSERT [dbo].[status] ([IDLotu], [Informacje]) VALUES (4, N'Zakończony')
INSERT [dbo].[status] ([IDLotu], [Informacje]) VALUES (5, N'Zakończony')
SET IDENTITY_INSERT [dbo].[status] OFF
ALTER TABLE [dbo].[awaria_samolotu]  WITH CHECK ADD  CONSTRAINT [FK_awaria_samolotu_samolot] FOREIGN KEY([IDSamolotu])
REFERENCES [dbo].[samolot] ([IDSamolotu])
GO
ALTER TABLE [dbo].[awaria_samolotu] CHECK CONSTRAINT [FK_awaria_samolotu_samolot]
GO
ALTER TABLE [dbo].[bilet]  WITH CHECK ADD  CONSTRAINT [FK_bilet_lot] FOREIGN KEY([polaczenie_lotnicze])
REFERENCES [dbo].[lot] ([polaczenie_lotnicze])
GO
ALTER TABLE [dbo].[bilet] CHECK CONSTRAINT [FK_bilet_lot]
GO
ALTER TABLE [dbo].[bilet]  WITH CHECK ADD  CONSTRAINT [FK_bilet_samolot_m] FOREIGN KEY([IDSamolotu], [IDMiejsca])
REFERENCES [dbo].[samolot_m] ([IDSamolotu], [IDMiejsca])
GO
ALTER TABLE [dbo].[bilet] CHECK CONSTRAINT [FK_bilet_samolot_m]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_bilet] FOREIGN KEY([polaczenie_lotnicze], [IDSamolotu], [IDMiejsca])
REFERENCES [dbo].[bilet] ([polaczenie_lotnicze], [IDSamolotu], [IDMiejsca])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK_booking_bilet]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_pasazer] FOREIGN KEY([IDPasazera])
REFERENCES [dbo].[pasazer] ([IDPasazera])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK_booking_pasazer]
GO
ALTER TABLE [dbo].[kierunek]  WITH CHECK ADD  CONSTRAINT [FK_kierunek_lotnisko] FOREIGN KEY([start_lotu_IATA])
REFERENCES [dbo].[lotnisko] ([Kod_IATA_lotniska])
GO
ALTER TABLE [dbo].[kierunek] CHECK CONSTRAINT [FK_kierunek_lotnisko]
GO
ALTER TABLE [dbo].[lot]  WITH CHECK ADD  CONSTRAINT [FK_lot_rozklad] FOREIGN KEY([IDRozkladu])
REFERENCES [dbo].[rozklad] ([IDRozkladu])
GO
ALTER TABLE [dbo].[lot] CHECK CONSTRAINT [FK_lot_rozklad]
GO
ALTER TABLE [dbo].[lot]  WITH CHECK ADD  CONSTRAINT [FK_lot_status] FOREIGN KEY([IDLotu])
REFERENCES [dbo].[status] ([IDLotu])
GO
ALTER TABLE [dbo].[lot] CHECK CONSTRAINT [FK_lot_status]
GO
ALTER TABLE [dbo].[lotnisko]  WITH CHECK ADD  CONSTRAINT [FK_lotnisko_kraj] FOREIGN KEY([Kod_IATA])
REFERENCES [dbo].[kraj] ([Kod_IATA])
GO
ALTER TABLE [dbo].[lotnisko] CHECK CONSTRAINT [FK_lotnisko_kraj]
GO
ALTER TABLE [dbo].[opoznienie_lotu]  WITH CHECK ADD  CONSTRAINT [FK_opoznienie_lotu_awaria_samolotu] FOREIGN KEY([IDAwarii])
REFERENCES [dbo].[awaria_samolotu] ([IDAwarii])
GO
ALTER TABLE [dbo].[opoznienie_lotu] CHECK CONSTRAINT [FK_opoznienie_lotu_awaria_samolotu]
GO
ALTER TABLE [dbo].[opoznienie_lotu]  WITH CHECK ADD  CONSTRAINT [FK_opoznienie_lotu_lot] FOREIGN KEY([polaczenie_lotnicze])
REFERENCES [dbo].[lot] ([polaczenie_lotnicze])
GO
ALTER TABLE [dbo].[opoznienie_lotu] CHECK CONSTRAINT [FK_opoznienie_lotu_lot]
GO
ALTER TABLE [dbo].[pasazer]  WITH CHECK ADD  CONSTRAINT [FK_pasazer_kraj] FOREIGN KEY([Kod_IATA])
REFERENCES [dbo].[kraj] ([Kod_IATA])
GO
ALTER TABLE [dbo].[pasazer] CHECK CONSTRAINT [FK_pasazer_kraj]
GO
ALTER TABLE [dbo].[rozklad]  WITH CHECK ADD  CONSTRAINT [FK_rozklad_kierunek] FOREIGN KEY([start_lotu_IATA], [koniec_lotu_IATA])
REFERENCES [dbo].[kierunek] ([start_lotu_IATA], [koniec_lotu_IATA])
GO
ALTER TABLE [dbo].[rozklad] CHECK CONSTRAINT [FK_rozklad_kierunek]
GO
ALTER TABLE [dbo].[samolot]  WITH CHECK ADD  CONSTRAINT [FK_samolot_producent_samolotu] FOREIGN KEY([IDProducenta])
REFERENCES [dbo].[producent_samolotu] ([IDProducenta])
GO
ALTER TABLE [dbo].[samolot] CHECK CONSTRAINT [FK_samolot_producent_samolotu]
GO
ALTER TABLE [dbo].[samolot_m]  WITH CHECK ADD  CONSTRAINT [FK_samolot_m_klasa_p] FOREIGN KEY([IDKlasy])
REFERENCES [dbo].[klasa_p] ([IDKlasy])
GO
ALTER TABLE [dbo].[samolot_m] CHECK CONSTRAINT [FK_samolot_m_klasa_p]
GO
ALTER TABLE [dbo].[samolot_m]  WITH CHECK ADD  CONSTRAINT [FK_samolot_m_samolot] FOREIGN KEY([IDSamolotu])
REFERENCES [dbo].[samolot] ([IDSamolotu])
GO
ALTER TABLE [dbo].[samolot_m] CHECK CONSTRAINT [FK_samolot_m_samolot]
GO
USE [master]
GO
ALTER DATABASE [lotnisko] SET  READ_WRITE 
GO
