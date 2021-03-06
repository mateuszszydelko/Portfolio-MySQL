USE [master]
GO
/****** Object:  Database [kawiarnia]    Script Date: 17.06.2022 12:36:26 ******/
CREATE DATABASE [kawiarnia]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'hurtownia', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\hurtownia.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'hurtownia_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\hurtownia_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [kawiarnia] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [kawiarnia].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [kawiarnia] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [kawiarnia] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [kawiarnia] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [kawiarnia] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [kawiarnia] SET ARITHABORT OFF 
GO
ALTER DATABASE [kawiarnia] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [kawiarnia] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [kawiarnia] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [kawiarnia] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [kawiarnia] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [kawiarnia] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [kawiarnia] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [kawiarnia] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [kawiarnia] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [kawiarnia] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [kawiarnia] SET  DISABLE_BROKER 
GO
ALTER DATABASE [kawiarnia] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [kawiarnia] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [kawiarnia] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [kawiarnia] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [kawiarnia] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [kawiarnia] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [kawiarnia] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [kawiarnia] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [kawiarnia] SET  MULTI_USER 
GO
ALTER DATABASE [kawiarnia] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [kawiarnia] SET DB_CHAINING OFF 
GO
ALTER DATABASE [kawiarnia] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [kawiarnia] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [kawiarnia]
GO
/****** Object:  StoredProcedure [dbo].[dodajPlatnosc]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[dodajPlatnosc]
 
@Typ_platnosci nvarchar(50) = NULL,
@Suma decimal(18,0) = NULL
 
AS

INSERT INTO platnosc(Typ_platnosci, Suma)
VALUES (@Typ_platnosci, @Suma);

GO
/****** Object:  StoredProcedure [dbo].[nazwiska]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[nazwiska] @Nazwisko nvarchar(50)
AS
SELECT * FROM pracownik
where Nazwisko = @Nazwisko
GO
/****** Object:  StoredProcedure [dbo].[usp_grupy_produktuDelete]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_grupy_produktuDelete] 
    @IDGrupy int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[grupy_produktu]
	WHERE  [IDGrupy] = @IDGrupy

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_grupy_produktuInsert]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_grupy_produktuInsert] 
    @Nazwa nvarchar(50) = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[grupy_produktu] ([Nazwa])
	SELECT @Nazwa
	SELECT [IDGrupy], [Nazwa]
	FROM   [dbo].[grupy_produktu]
	WHERE  [IDGrupy] = SCOPE_IDENTITY()
               
	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_grupy_produktuSelect]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_grupy_produktuSelect] 
    @IDGrupy int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [IDGrupy], [Nazwa] 
	FROM   [dbo].[grupy_produktu] 
	WHERE  ([IDGrupy] = @IDGrupy OR @IDGrupy IS NULL) 

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_grupy_produktuUpdate]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_grupy_produktuUpdate] 
    @IDGrupy int,
    @Nazwa nvarchar(50) = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[grupy_produktu]
	SET    [Nazwa] = @Nazwa
	WHERE  [IDGrupy] = @IDGrupy
	SELECT [IDGrupy], [Nazwa]
	FROM   [dbo].[grupy_produktu]
	WHERE  [IDGrupy] = @IDGrupy	

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_kawiarniaDelete]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_kawiarniaDelete] 
    @IDKawiarni int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[kawiarnia]
	WHERE  [IDKawiarni] = @IDKawiarni

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_kawiarniaInsert]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_kawiarniaInsert] 
    @IDKawiarni int,
    @IDMiasta int = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[kawiarnia] ([IDKawiarni], [IDMiasta])
	SELECT @IDKawiarni, @IDMiasta
	
	-- Begin Return Select <- do not remove
	SELECT [IDKawiarni], [IDMiasta]
	FROM   [dbo].[kawiarnia]
	WHERE  [IDKawiarni] = @IDKawiarni
	-- End Return Select <- do not remove
               
	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_kawiarniaSelect]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_kawiarniaSelect] 
    @IDKawiarni int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [IDKawiarni], [IDMiasta] 
	FROM   [dbo].[kawiarnia] 
	WHERE  ([IDKawiarni] = @IDKawiarni OR @IDKawiarni IS NULL) 

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_kawiarniaUpdate]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_kawiarniaUpdate] 
    @IDKawiarni int,
    @IDMiasta int = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[kawiarnia]
	SET    [IDMiasta] = @IDMiasta
	WHERE  [IDKawiarni] = @IDKawiarni
	
	-- Begin Return Select <- do not remove
	SELECT [IDKawiarni], [IDMiasta]
	FROM   [dbo].[kawiarnia]
	WHERE  [IDKawiarni] = @IDKawiarni	
	-- End Return Select <- do not remove

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_miastoDelete]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_miastoDelete] 
    @IDMiasta int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[miasto]
	WHERE  [IDMiasta] = @IDMiasta

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_miastoInsert]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_miastoInsert] 
    @Nazwa nvarchar(50) = NULL,
    @IDRegionu int = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[miasto] ([Nazwa], [IDRegionu])
	SELECT @Nazwa, @IDRegionu
	
	-- Begin Return Select <- do not remove
	SELECT [IDMiasta], [Nazwa], [IDRegionu]
	FROM   [dbo].[miasto]
	WHERE  [IDMiasta] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_miastoSelect]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_miastoSelect] 
    @IDMiasta int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [IDMiasta], [Nazwa], [IDRegionu] 
	FROM   [dbo].[miasto] 
	WHERE  ([IDMiasta] = @IDMiasta OR @IDMiasta IS NULL) 

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_miastoUpdate]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_miastoUpdate] 
    @IDMiasta int,
    @Nazwa nvarchar(50) = NULL,
    @IDRegionu int = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[miasto]
	SET    [Nazwa] = @Nazwa, [IDRegionu] = @IDRegionu
	WHERE  [IDMiasta] = @IDMiasta
	
	-- Begin Return Select <- do not remove
	SELECT [IDMiasta], [Nazwa], [IDRegionu]
	FROM   [dbo].[miasto]
	WHERE  [IDMiasta] = @IDMiasta	
	-- End Return Select <- do not remove

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_paragonDelete]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_paragonDelete] 
    @IDParagonu int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[paragon]
	WHERE  [IDParagonu] = @IDParagonu

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_paragonInsert]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_paragonInsert] 
    @Cena decimal(18, 0) = NULL,
    @Rabat nvarchar(50) = NULL,
    @IDPlatnosci int = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[paragon] ([Cena], [Rabat], [IDPlatnosci])
	SELECT @Cena, @Rabat, @IDPlatnosci
	
	-- Begin Return Select <- do not remove
	SELECT [IDParagonu], [Cena], [Rabat], [IDPlatnosci]
	FROM   [dbo].[paragon]
	WHERE  [IDParagonu] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_paragonSelect]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_paragonSelect] 
    @IDParagonu int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [IDParagonu], [Cena], [Rabat], [IDPlatnosci] 
	FROM   [dbo].[paragon] 
	WHERE  ([IDParagonu] = @IDParagonu OR @IDParagonu IS NULL) 

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_paragonUpdate]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_paragonUpdate] 
    @IDParagonu int,
    @Cena decimal(18, 0) = NULL,
    @Rabat nvarchar(50) = NULL,
    @IDPlatnosci int = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[paragon]
	SET    [Cena] = @Cena, [Rabat] = @Rabat, [IDPlatnosci] = @IDPlatnosci
	WHERE  [IDParagonu] = @IDParagonu
	
	-- Begin Return Select <- do not remove
	SELECT [IDParagonu], [Cena], [Rabat], [IDPlatnosci]
	FROM   [dbo].[paragon]
	WHERE  [IDParagonu] = @IDParagonu	
	-- End Return Select <- do not remove

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_platnoscDelete]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_platnoscDelete] 
    @IDPlatnosci int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[platnosc]
	WHERE  [IDPlatnosci] = @IDPlatnosci

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_platnoscInsert]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_platnoscInsert] 
    @Typ_platnosci nvarchar(50) = NULL,
    @Suma decimal(18, 0) = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[platnosc] ([Typ_platnosci], [Suma])
	SELECT @Typ_platnosci, @Suma
	
	-- Begin Return Select <- do not remove
	SELECT [IDPlatnosci], [Typ_platnosci], [Suma]
	FROM   [dbo].[platnosc]
	WHERE  [IDPlatnosci] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_platnoscSelect]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_platnoscSelect] 
    @IDPlatnosci int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [IDPlatnosci], [Typ_platnosci], [Suma] 
	FROM   [dbo].[platnosc] 
	WHERE  ([IDPlatnosci] = @IDPlatnosci OR @IDPlatnosci IS NULL) 

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_platnoscUpdate]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_platnoscUpdate] 
    @IDPlatnosci int,
    @Typ_platnosci nvarchar(50) = NULL,
    @Suma decimal(18, 0) = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[platnosc]
	SET    [Typ_platnosci] = @Typ_platnosci, [Suma] = @Suma
	WHERE  [IDPlatnosci] = @IDPlatnosci
	
	-- Begin Return Select <- do not remove
	SELECT [IDPlatnosci], [Typ_platnosci], [Suma]
	FROM   [dbo].[platnosc]
	WHERE  [IDPlatnosci] = @IDPlatnosci	
	-- End Return Select <- do not remove

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_pracownikDelete]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_pracownikDelete] 
    @IDPracownika int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[pracownik]
	WHERE  [IDPracownika] = @IDPracownika

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_pracownikInsert]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_pracownikInsert] 
    @Imie nvarchar(50) = NULL,
    @Nazwisko nvarchar(50) = NULL,
    @IDStanowiska int = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[pracownik] ([Imie], [Nazwisko], [IDStanowiska])
	SELECT @Imie, @Nazwisko, @IDStanowiska
	
	-- Begin Return Select <- do not remove
	SELECT [IDPracownika], [Imie], [Nazwisko], [IDStanowiska]
	FROM   [dbo].[pracownik]
	WHERE  [IDPracownika] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_pracownikSelect]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_pracownikSelect] 
    @IDPracownika int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [IDPracownika], [Imie], [Nazwisko], [IDStanowiska] 
	FROM   [dbo].[pracownik] 
	WHERE  ([IDPracownika] = @IDPracownika OR @IDPracownika IS NULL) 

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_pracownikUpdate]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_pracownikUpdate] 
    @IDPracownika int,
    @Imie nvarchar(50) = NULL,
    @Nazwisko nvarchar(50) = NULL,
    @IDStanowiska int = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[pracownik]
	SET    [Imie] = @Imie, [Nazwisko] = @Nazwisko, [IDStanowiska] = @IDStanowiska
	WHERE  [IDPracownika] = @IDPracownika
	
	-- Begin Return Select <- do not remove
	SELECT [IDPracownika], [Imie], [Nazwisko], [IDStanowiska]
	FROM   [dbo].[pracownik]
	WHERE  [IDPracownika] = @IDPracownika	
	-- End Return Select <- do not remove

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_produktDelete]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_produktDelete] 
    @IDProduktu int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[produkt]
	WHERE  [IDProduktu] = @IDProduktu

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_produktInsert]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_produktInsert] 
    @IDGrupy int = NULL,
    @Nazwa nvarchar(50) = NULL,
    @Cena decimal(18, 0) = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[produkt] ([IDGrupy], [Nazwa], [Cena])
	SELECT @IDGrupy, @Nazwa, @Cena
	
	-- Begin Return Select <- do not remove
	SELECT [IDProduktu], [IDGrupy], [Nazwa], [Cena]
	FROM   [dbo].[produkt]
	WHERE  [IDProduktu] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_produktSelect]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_produktSelect] 
    @IDProduktu int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [IDProduktu], [IDGrupy], [Nazwa], [Cena] 
	FROM   [dbo].[produkt] 
	WHERE  ([IDProduktu] = @IDProduktu OR @IDProduktu IS NULL) 

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_produktUpdate]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_produktUpdate] 
    @IDProduktu int,
    @IDGrupy int = NULL,
    @Nazwa nvarchar(50) = NULL,
    @Cena decimal(18, 0) = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[produkt]
	SET    [IDGrupy] = @IDGrupy, [Nazwa] = @Nazwa, [Cena] = @Cena
	WHERE  [IDProduktu] = @IDProduktu
	
	-- Begin Return Select <- do not remove
	SELECT [IDProduktu], [IDGrupy], [Nazwa], [Cena]
	FROM   [dbo].[produkt]
	WHERE  [IDProduktu] = @IDProduktu	
	-- End Return Select <- do not remove

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_regionDelete]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_regionDelete] 
    @IDRegionu int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[region]
	WHERE  [IDRegionu] = @IDRegionu

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_regionInsert]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_regionInsert] 
    @Nazwa nvarchar(50) = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[region] ([Nazwa])
	SELECT @Nazwa
	
	-- Begin Return Select <- do not remove
	SELECT [IDRegionu], [Nazwa]
	FROM   [dbo].[region]
	WHERE  [IDRegionu] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_regionSelect]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_regionSelect] 
    @IDRegionu int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [IDRegionu], [Nazwa] 
	FROM   [dbo].[region] 
	WHERE  ([IDRegionu] = @IDRegionu OR @IDRegionu IS NULL) 

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_regionUpdate]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_regionUpdate] 
    @IDRegionu int,
    @Nazwa nvarchar(50) = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[region]
	SET    [Nazwa] = @Nazwa
	WHERE  [IDRegionu] = @IDRegionu
	
	-- Begin Return Select <- do not remove
	SELECT [IDRegionu], [Nazwa]
	FROM   [dbo].[region]
	WHERE  [IDRegionu] = @IDRegionu	
	-- End Return Select <- do not remove

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_sprzedazDelete]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_sprzedazDelete] 
    @IDSprzedazy int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[sprzedaz]
	WHERE  [IDSprzedazy] = @IDSprzedazy

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_sprzedazInsert]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_sprzedazInsert] 
    @IDProduktu int = NULL,
    @IDKawiarni int = NULL,
    @Liczba_sztuk nvarchar(50) = NULL,
    @Wartosc nvarchar(50) = NULL,
    @IDPracownika int = NULL,
    @IDParagonu int = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[sprzedaz] ([IDProduktu], [IDKawiarni], [Liczba_sztuk], [Wartosc], [IDPracownika], [IDParagonu])
	SELECT @IDProduktu, @IDKawiarni, @Liczba_sztuk, @Wartosc, @IDPracownika, @IDParagonu
	
	-- Begin Return Select <- do not remove
	SELECT [IDSprzedazy], [IDProduktu], [IDKawiarni], [Liczba_sztuk], [Wartosc], [IDPracownika], [IDParagonu]
	FROM   [dbo].[sprzedaz]
	WHERE  [IDSprzedazy] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_sprzedazSelect]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_sprzedazSelect] 
    @IDSprzedazy int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [IDSprzedazy], [IDProduktu], [IDKawiarni], [Liczba_sztuk], [Wartosc], [IDPracownika], [IDParagonu] 
	FROM   [dbo].[sprzedaz] 
	WHERE  ([IDSprzedazy] = @IDSprzedazy OR @IDSprzedazy IS NULL) 

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_sprzedazUpdate]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_sprzedazUpdate] 
    @IDSprzedazy int,
    @IDProduktu int = NULL,
    @IDKawiarni int = NULL,
    @Liczba_sztuk nvarchar(50) = NULL,
    @Wartosc nvarchar(50) = NULL,
    @IDPracownika int = NULL,
    @IDParagonu int = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[sprzedaz]
	SET    [IDProduktu] = @IDProduktu, [IDKawiarni] = @IDKawiarni, [Liczba_sztuk] = @Liczba_sztuk, [Wartosc] = @Wartosc, [IDPracownika] = @IDPracownika, [IDParagonu] = @IDParagonu
	WHERE  [IDSprzedazy] = @IDSprzedazy
	
	-- Begin Return Select <- do not remove
	SELECT [IDSprzedazy], [IDProduktu], [IDKawiarni], [Liczba_sztuk], [Wartosc], [IDPracownika], [IDParagonu]
	FROM   [dbo].[sprzedaz]
	WHERE  [IDSprzedazy] = @IDSprzedazy	
	-- End Return Select <- do not remove

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_stanowiskaDelete]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_stanowiskaDelete] 
    @IDStanowiska int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[stanowiska]
	WHERE  [IDStanowiska] = @IDStanowiska

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_stanowiskaInsert]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_stanowiskaInsert] 
    @Nazwa nvarchar(50) = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[stanowiska] ([Nazwa])
	SELECT @Nazwa
	
	-- Begin Return Select <- do not remove
	SELECT [IDStanowiska], [Nazwa]
	FROM   [dbo].[stanowiska]
	WHERE  [IDStanowiska] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_stanowiskaSelect]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_stanowiskaSelect] 
    @IDStanowiska int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [IDStanowiska], [Nazwa] 
	FROM   [dbo].[stanowiska] 
	WHERE  ([IDStanowiska] = @IDStanowiska OR @IDStanowiska IS NULL) 

	COMMIT

GO
/****** Object:  StoredProcedure [dbo].[usp_stanowiskaUpdate]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_stanowiskaUpdate] 
    @IDStanowiska int,
    @Nazwa nvarchar(50) = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[stanowiska]
	SET    [Nazwa] = @Nazwa
	WHERE  [IDStanowiska] = @IDStanowiska
	
	-- Begin Return Select <- do not remove
	SELECT [IDStanowiska], [Nazwa]
	FROM   [dbo].[stanowiska]
	WHERE  [IDStanowiska] = @IDStanowiska	
	-- End Return Select <- do not remove

	COMMIT

GO
/****** Object:  Table [dbo].[grupy_produktu]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[grupy_produktu](
	[IDGrupy] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [nvarchar](50) NULL,
 CONSTRAINT [PK_grupy_produktu] PRIMARY KEY CLUSTERED 
(
	[IDGrupy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kawiarnia]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kawiarnia](
	[IDKawiarni] [int] NOT NULL,
	[IDMiasta] [int] NULL,
 CONSTRAINT [PK_kawiarnia] PRIMARY KEY CLUSTERED 
(
	[IDKawiarni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[logi]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[logi](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Data_modyfikacji] [datetime] NOT NULL,
	[Komenda] [nchar](6) NOT NULL,
	[Uzytkownik] [nchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[miasto]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[miasto](
	[IDMiasta] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [nvarchar](50) NULL,
	[IDRegionu] [int] NULL,
 CONSTRAINT [PK_miasto] PRIMARY KEY CLUSTERED 
(
	[IDMiasta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[paragon]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[paragon](
	[IDParagonu] [int] IDENTITY(1,1) NOT NULL,
	[Cena] [decimal](18, 0) NULL,
	[Rabat] [nvarchar](50) NULL,
	[IDPlatnosci] [int] NULL,
 CONSTRAINT [PK_paragon] PRIMARY KEY CLUSTERED 
(
	[IDParagonu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[platnosc]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platnosc](
	[IDPlatnosci] [int] IDENTITY(1,1) NOT NULL,
	[Typ_platnosci] [nvarchar](50) NULL,
	[Suma] [decimal](18, 0) NULL,
 CONSTRAINT [PK_platnosc] PRIMARY KEY CLUSTERED 
(
	[IDPlatnosci] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pracownik]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pracownik](
	[IDPracownika] [int] IDENTITY(1,1) NOT NULL,
	[Imie] [nvarchar](50) NULL,
	[Nazwisko] [nvarchar](50) NULL,
	[IDStanowiska] [int] NULL,
 CONSTRAINT [PK_pracownik] PRIMARY KEY CLUSTERED 
(
	[IDPracownika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[produkt]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[produkt](
	[IDProduktu] [int] IDENTITY(1,1) NOT NULL,
	[IDGrupy] [int] NULL,
	[Nazwa] [nvarchar](50) NULL,
	[Cena] [decimal](18, 0) NULL,
 CONSTRAINT [PK_produkt] PRIMARY KEY CLUSTERED 
(
	[IDProduktu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[region]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[region](
	[IDRegionu] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [nvarchar](50) NULL,
 CONSTRAINT [PK_region] PRIMARY KEY CLUSTERED 
(
	[IDRegionu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sprzedaz]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sprzedaz](
	[IDSprzedazy] [int] IDENTITY(1,1) NOT NULL,
	[IDProduktu] [int] NULL,
	[IDKawiarni] [int] NULL,
	[Liczba_sztuk] [nvarchar](50) NULL,
	[Wartosc] [nvarchar](50) NULL,
	[IDPracownika] [int] NULL,
	[IDParagonu] [int] NULL,
 CONSTRAINT [PK_sprzedaz] PRIMARY KEY CLUSTERED 
(
	[IDSprzedazy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[stanowiska]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stanowiska](
	[IDStanowiska] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [nvarchar](50) NULL,
 CONSTRAINT [PK_stanowiska] PRIMARY KEY CLUSTERED 
(
	[IDStanowiska] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[pracownikStanowisko]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pracownikStanowisko]
AS
SELECT dbo.pracownik.IDPracownika, dbo.pracownik.Nazwisko, dbo.pracownik.Imie, dbo.stanowiska.Nazwa
FROM     dbo.pracownik INNER JOIN
                  dbo.stanowiska ON dbo.pracownik.IDStanowiska = dbo.stanowiska.IDStanowiska

GO
/****** Object:  View [dbo].[produktGrupa]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[produktGrupa]
AS
SELECT dbo.produkt.IDProduktu, dbo.produkt.Nazwa, dbo.produkt.Cena, dbo.grupy_produktu.Nazwa AS Expr1
FROM     dbo.produkt INNER JOIN
                  dbo.grupy_produktu ON dbo.produkt.IDGrupy = dbo.grupy_produktu.IDGrupy

GO
/****** Object:  View [dbo].[widok]    Script Date: 17.06.2022 12:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[widok] AS
SELECT produkt.Cena, grupy_produktu.Nazwa
FROM produkt
INNER JOIN grupy_produktu ON produkt.IDGrupy = grupy_produktu.IDGrupy
GO
SET IDENTITY_INSERT [dbo].[grupy_produktu] ON 

INSERT [dbo].[grupy_produktu] ([IDGrupy], [Nazwa]) VALUES (1, N'Lody')
INSERT [dbo].[grupy_produktu] ([IDGrupy], [Nazwa]) VALUES (2, N'Kawa')
INSERT [dbo].[grupy_produktu] ([IDGrupy], [Nazwa]) VALUES (3, N'Kawa')
INSERT [dbo].[grupy_produktu] ([IDGrupy], [Nazwa]) VALUES (4, N'Lody')
INSERT [dbo].[grupy_produktu] ([IDGrupy], [Nazwa]) VALUES (5, N'Ciasto')
SET IDENTITY_INSERT [dbo].[grupy_produktu] OFF
INSERT [dbo].[kawiarnia] ([IDKawiarni], [IDMiasta]) VALUES (1, 1)
INSERT [dbo].[kawiarnia] ([IDKawiarni], [IDMiasta]) VALUES (2, 2)
INSERT [dbo].[kawiarnia] ([IDKawiarni], [IDMiasta]) VALUES (3, 3)
INSERT [dbo].[kawiarnia] ([IDKawiarni], [IDMiasta]) VALUES (4, 4)
INSERT [dbo].[kawiarnia] ([IDKawiarni], [IDMiasta]) VALUES (5, 5)
SET IDENTITY_INSERT [dbo].[logi] ON 

INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (1, CAST(0x0000AD0900D2DC96 AS DateTime), N'Insert', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (2, CAST(0x0000AD4000B22C0B AS DateTime), N'Insert', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (3, CAST(0x0000AD4000B3DFD3 AS DateTime), N'Delete', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (4, CAST(0x0000AD4000B3E67E AS DateTime), N'Delete', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (5, CAST(0x0000AD4000EA076B AS DateTime), N'Delete', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (6, CAST(0x0000AD4000F5B9EC AS DateTime), N'Insert', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (7, CAST(0x0000AD4000F5DF96 AS DateTime), N'Insert', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (8, CAST(0x0000AD4001055B4A AS DateTime), N'Delete', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (9, CAST(0x0000AD4001055F69 AS DateTime), N'Delete', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (10, CAST(0x0000AD4001056DD3 AS DateTime), N'Insert', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (11, CAST(0x0000AD400106304B AS DateTime), N'Insert', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (12, CAST(0x0000AD400106355B AS DateTime), N'Delete', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (13, CAST(0x0000AD40010638A4 AS DateTime), N'Delete', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (14, CAST(0x0000AD40010B2229 AS DateTime), N'Insert', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (15, CAST(0x0000AD40010B31B2 AS DateTime), N'Update', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (16, CAST(0x0000AD40010B366F AS DateTime), N'Delete', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (17, CAST(0x0000AD4100E47F77 AS DateTime), N'Insert', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (18, CAST(0x0000AD4100E4A562 AS DateTime), N'Insert', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (19, CAST(0x0000AD4100E4AE50 AS DateTime), N'Insert', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (20, CAST(0x0000AD4100E4C3A5 AS DateTime), N'Insert', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (21, CAST(0x0000AD4100E4D14A AS DateTime), N'Insert', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (22, CAST(0x0000AD4100E576A1 AS DateTime), N'Delete', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (23, CAST(0x0000AD4100E57A53 AS DateTime), N'Delete', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (24, CAST(0x0000AD4100E57E40 AS DateTime), N'Delete', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (25, CAST(0x0000AD4100E581FA AS DateTime), N'Delete', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (26, CAST(0x0000AD4100E584EA AS DateTime), N'Delete', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (27, CAST(0x0000AD4300BB113A AS DateTime), N'Insert', N'dbo                                                                                                 ')
INSERT [dbo].[logi] ([Id], [Data_modyfikacji], [Komenda], [Uzytkownik]) VALUES (28, CAST(0x0000AD4300BB1D24 AS DateTime), N'Delete', N'dbo                                                                                                 ')
SET IDENTITY_INSERT [dbo].[logi] OFF
SET IDENTITY_INSERT [dbo].[miasto] ON 

INSERT [dbo].[miasto] ([IDMiasta], [Nazwa], [IDRegionu]) VALUES (1, N'Wroclaw', 1)
INSERT [dbo].[miasto] ([IDMiasta], [Nazwa], [IDRegionu]) VALUES (2, N'Warszawa', 2)
INSERT [dbo].[miasto] ([IDMiasta], [Nazwa], [IDRegionu]) VALUES (3, N'Opole', 3)
INSERT [dbo].[miasto] ([IDMiasta], [Nazwa], [IDRegionu]) VALUES (4, N'Wroclaw', 4)
INSERT [dbo].[miasto] ([IDMiasta], [Nazwa], [IDRegionu]) VALUES (5, N'Wroclaw', 5)
SET IDENTITY_INSERT [dbo].[miasto] OFF
SET IDENTITY_INSERT [dbo].[paragon] ON 

INSERT [dbo].[paragon] ([IDParagonu], [Cena], [Rabat], [IDPlatnosci]) VALUES (1, CAST(30 AS Decimal(18, 0)), N'0', 1)
INSERT [dbo].[paragon] ([IDParagonu], [Cena], [Rabat], [IDPlatnosci]) VALUES (2, CAST(15 AS Decimal(18, 0)), N'0', 2)
INSERT [dbo].[paragon] ([IDParagonu], [Cena], [Rabat], [IDPlatnosci]) VALUES (3, CAST(12 AS Decimal(18, 0)), N'0', 3)
INSERT [dbo].[paragon] ([IDParagonu], [Cena], [Rabat], [IDPlatnosci]) VALUES (4, CAST(3 AS Decimal(18, 0)), N'0', 4)
INSERT [dbo].[paragon] ([IDParagonu], [Cena], [Rabat], [IDPlatnosci]) VALUES (5, CAST(12 AS Decimal(18, 0)), N'0', 7)
SET IDENTITY_INSERT [dbo].[paragon] OFF
SET IDENTITY_INSERT [dbo].[platnosc] ON 

INSERT [dbo].[platnosc] ([IDPlatnosci], [Typ_platnosci], [Suma]) VALUES (1, N'Karta', CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[platnosc] ([IDPlatnosci], [Typ_platnosci], [Suma]) VALUES (2, N'Gotowka', CAST(15 AS Decimal(18, 0)))
INSERT [dbo].[platnosc] ([IDPlatnosci], [Typ_platnosci], [Suma]) VALUES (3, N'Karta', CAST(12 AS Decimal(18, 0)))
INSERT [dbo].[platnosc] ([IDPlatnosci], [Typ_platnosci], [Suma]) VALUES (4, N'Karta', CAST(3 AS Decimal(18, 0)))
INSERT [dbo].[platnosc] ([IDPlatnosci], [Typ_platnosci], [Suma]) VALUES (7, N'Gotowka', CAST(12 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[platnosc] OFF
SET IDENTITY_INSERT [dbo].[pracownik] ON 

INSERT [dbo].[pracownik] ([IDPracownika], [Imie], [Nazwisko], [IDStanowiska]) VALUES (5, N'Jan', N'Nowak', 1)
INSERT [dbo].[pracownik] ([IDPracownika], [Imie], [Nazwisko], [IDStanowiska]) VALUES (6, N'Agnieszka', N'Kowalska', 2)
INSERT [dbo].[pracownik] ([IDPracownika], [Imie], [Nazwisko], [IDStanowiska]) VALUES (7, N'Mariusz', N'Wójcik', 3)
INSERT [dbo].[pracownik] ([IDPracownika], [Imie], [Nazwisko], [IDStanowiska]) VALUES (8, N'Maciej', N'Kowalczyk', 4)
INSERT [dbo].[pracownik] ([IDPracownika], [Imie], [Nazwisko], [IDStanowiska]) VALUES (9, N'Ewa', N'Wiśniewska', 5)
SET IDENTITY_INSERT [dbo].[pracownik] OFF
SET IDENTITY_INSERT [dbo].[produkt] ON 

INSERT [dbo].[produkt] ([IDProduktu], [IDGrupy], [Nazwa], [Cena]) VALUES (1, 1, N'Waniliowe', CAST(3 AS Decimal(18, 0)))
INSERT [dbo].[produkt] ([IDProduktu], [IDGrupy], [Nazwa], [Cena]) VALUES (2, 2, N'Americano', CAST(15 AS Decimal(18, 0)))
INSERT [dbo].[produkt] ([IDProduktu], [IDGrupy], [Nazwa], [Cena]) VALUES (3, 3, N'Espresso', CAST(12 AS Decimal(18, 0)))
INSERT [dbo].[produkt] ([IDProduktu], [IDGrupy], [Nazwa], [Cena]) VALUES (4, 4, N'Czekoladowe', CAST(3 AS Decimal(18, 0)))
INSERT [dbo].[produkt] ([IDProduktu], [IDGrupy], [Nazwa], [Cena]) VALUES (5, 5, N'Jablecznik', CAST(12 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[produkt] OFF
SET IDENTITY_INSERT [dbo].[region] ON 

INSERT [dbo].[region] ([IDRegionu], [Nazwa]) VALUES (1, N'Dolnoslaskie')
INSERT [dbo].[region] ([IDRegionu], [Nazwa]) VALUES (2, N'Mazowieckie')
INSERT [dbo].[region] ([IDRegionu], [Nazwa]) VALUES (3, N'Opolskie')
INSERT [dbo].[region] ([IDRegionu], [Nazwa]) VALUES (4, N'Dolnoslaskie')
INSERT [dbo].[region] ([IDRegionu], [Nazwa]) VALUES (5, N'Dolnoslaskie')
SET IDENTITY_INSERT [dbo].[region] OFF
SET IDENTITY_INSERT [dbo].[sprzedaz] ON 

INSERT [dbo].[sprzedaz] ([IDSprzedazy], [IDProduktu], [IDKawiarni], [Liczba_sztuk], [Wartosc], [IDPracownika], [IDParagonu]) VALUES (5, 1, 1, N'10', N'30', 5, 1)
INSERT [dbo].[sprzedaz] ([IDSprzedazy], [IDProduktu], [IDKawiarni], [Liczba_sztuk], [Wartosc], [IDPracownika], [IDParagonu]) VALUES (6, 2, 2, N'1', N'15', 6, 2)
INSERT [dbo].[sprzedaz] ([IDSprzedazy], [IDProduktu], [IDKawiarni], [Liczba_sztuk], [Wartosc], [IDPracownika], [IDParagonu]) VALUES (8, 3, 3, N'1', N'12', 7, 3)
INSERT [dbo].[sprzedaz] ([IDSprzedazy], [IDProduktu], [IDKawiarni], [Liczba_sztuk], [Wartosc], [IDPracownika], [IDParagonu]) VALUES (9, 4, 4, N'1', N'3', 8, 4)
INSERT [dbo].[sprzedaz] ([IDSprzedazy], [IDProduktu], [IDKawiarni], [Liczba_sztuk], [Wartosc], [IDPracownika], [IDParagonu]) VALUES (10, 5, 5, N'1', N'12', 9, 5)
SET IDENTITY_INSERT [dbo].[sprzedaz] OFF
SET IDENTITY_INSERT [dbo].[stanowiska] ON 

INSERT [dbo].[stanowiska] ([IDStanowiska], [Nazwa]) VALUES (1, N'Barista')
INSERT [dbo].[stanowiska] ([IDStanowiska], [Nazwa]) VALUES (2, N'Barista')
INSERT [dbo].[stanowiska] ([IDStanowiska], [Nazwa]) VALUES (3, N'Kelner')
INSERT [dbo].[stanowiska] ([IDStanowiska], [Nazwa]) VALUES (4, N'Barista')
INSERT [dbo].[stanowiska] ([IDStanowiska], [Nazwa]) VALUES (5, N'Barista')
SET IDENTITY_INSERT [dbo].[stanowiska] OFF
ALTER TABLE [dbo].[logi] ADD  DEFAULT (getdate()) FOR [Data_modyfikacji]
GO
ALTER TABLE [dbo].[kawiarnia]  WITH CHECK ADD  CONSTRAINT [FK_kawiarnia_miasto] FOREIGN KEY([IDMiasta])
REFERENCES [dbo].[miasto] ([IDMiasta])
GO
ALTER TABLE [dbo].[kawiarnia] CHECK CONSTRAINT [FK_kawiarnia_miasto]
GO
ALTER TABLE [dbo].[miasto]  WITH CHECK ADD  CONSTRAINT [FK_miasto_region] FOREIGN KEY([IDRegionu])
REFERENCES [dbo].[region] ([IDRegionu])
GO
ALTER TABLE [dbo].[miasto] CHECK CONSTRAINT [FK_miasto_region]
GO
ALTER TABLE [dbo].[paragon]  WITH CHECK ADD  CONSTRAINT [FK_paragon_platnosc] FOREIGN KEY([IDPlatnosci])
REFERENCES [dbo].[platnosc] ([IDPlatnosci])
GO
ALTER TABLE [dbo].[paragon] CHECK CONSTRAINT [FK_paragon_platnosc]
GO
ALTER TABLE [dbo].[pracownik]  WITH CHECK ADD  CONSTRAINT [FK_pracownik_stanowiska] FOREIGN KEY([IDStanowiska])
REFERENCES [dbo].[stanowiska] ([IDStanowiska])
GO
ALTER TABLE [dbo].[pracownik] CHECK CONSTRAINT [FK_pracownik_stanowiska]
GO
ALTER TABLE [dbo].[produkt]  WITH CHECK ADD  CONSTRAINT [FK_produkt_grupy_produktu] FOREIGN KEY([IDGrupy])
REFERENCES [dbo].[grupy_produktu] ([IDGrupy])
GO
ALTER TABLE [dbo].[produkt] CHECK CONSTRAINT [FK_produkt_grupy_produktu]
GO
ALTER TABLE [dbo].[sprzedaz]  WITH CHECK ADD  CONSTRAINT [FK_sprzedaz_kawiarnia] FOREIGN KEY([IDKawiarni])
REFERENCES [dbo].[kawiarnia] ([IDKawiarni])
GO
ALTER TABLE [dbo].[sprzedaz] CHECK CONSTRAINT [FK_sprzedaz_kawiarnia]
GO
ALTER TABLE [dbo].[sprzedaz]  WITH CHECK ADD  CONSTRAINT [FK_sprzedaz_paragon] FOREIGN KEY([IDParagonu])
REFERENCES [dbo].[paragon] ([IDParagonu])
GO
ALTER TABLE [dbo].[sprzedaz] CHECK CONSTRAINT [FK_sprzedaz_paragon]
GO
ALTER TABLE [dbo].[sprzedaz]  WITH CHECK ADD  CONSTRAINT [FK_sprzedaz_pracownik] FOREIGN KEY([IDPracownika])
REFERENCES [dbo].[pracownik] ([IDPracownika])
GO
ALTER TABLE [dbo].[sprzedaz] CHECK CONSTRAINT [FK_sprzedaz_pracownik]
GO
ALTER TABLE [dbo].[sprzedaz]  WITH CHECK ADD  CONSTRAINT [FK_sprzedaz_produkt] FOREIGN KEY([IDProduktu])
REFERENCES [dbo].[produkt] ([IDProduktu])
GO
ALTER TABLE [dbo].[sprzedaz] CHECK CONSTRAINT [FK_sprzedaz_produkt]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pracownik"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "stanowiska"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 126
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pracownikStanowisko'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pracownikStanowisko'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "produkt"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "grupy_produktu"
            Begin Extent = 
               Top = 7
               Left = 289
               Bottom = 144
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'produktGrupa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'produktGrupa'
GO
USE [master]
GO
ALTER DATABASE [kawiarnia] SET  READ_WRITE 
GO
