-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 20, 2019 at 12:17 AM
-- Server version: 5.7.20-log
-- PHP Version: 5.6.31

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbsimcan_simulasi_merah`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `setAutoIncrement`$$
CREATE PROCEDURE `setAutoIncrement` ()  BEGIN
DECLARE done int default false;
    DECLARE table_name CHAR(255);
DECLARE cur1 cursor for SELECT t.table_name FROM INFORMATION_SCHEMA.TABLES t 
        WHERE t.table_schema = "dbsimcan_master";

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    open cur1;

    myloop: loop
        fetch cur1 into table_name;
        if done then
            leave myloop;
        end if;
        set @sql = CONCAT('ALTER TABLE ',table_name, ' AUTO_INCREMENT = 1');
        prepare stmt from @sql;
        execute stmt;
        drop prepare stmt;
    end loop;

    close cur1;
END$$

--
-- Functions
--
DROP FUNCTION IF EXISTS `GantiEnter`$$
CREATE FUNCTION `GantiEnter` (`uraian` VARCHAR(1000)) RETURNS VARCHAR(1000) CHARSET latin1 BEGIN 
  DECLARE xUraian VARCHAR(1000); 
  SET xUraian = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(uraian, CHAR(9), ''), CHAR(10), ''),CHAR(11),''),CHAR(12),''),CHAR(13),'')); 
	WHILE INSTR(xUraian,'  ')>0 DO
		SET xUraian = REPLACE(xUraian,'  ',' ');
	END WHILE;
  RETURN (xUraian); 
END$$

DROP FUNCTION IF EXISTS `HTML_UnEncode`$$
CREATE FUNCTION `HTML_UnEncode` (`X` VARCHAR(1000)) RETURNS VARCHAR(1000) CHARSET latin1 BEGIN 

    DECLARE TextString VARCHAR(1000) ; 
    SET TextString = X ; 

    #quotation mark 
    IF INSTR( X , '&quot;' ) 
    THEN SET TextString = REPLACE(TextString, '&quot;',') ; 
    END IF ; 

    #apostrophe  
    IF INSTR( X , &apos; ) 
    THEN SET TextString = REPLACE(TextString, &apos;,') ; 
    END IF ; 

    #ampersand 
    IF INSTR( X , '&amp;' ) 
    THEN SET TextString = REPLACE(TextString, '&amp;','&') ; 
    END IF ; 

    #less-than 
    IF INSTR( X , '&lt;' ) 
    THEN SET TextString = REPLACE(TextString, '&lt;','<') ; 
    END IF ; 

    #greater-than 
    IF INSTR( X , '&gt;' ) 
    THEN SET TextString = REPLACE(TextString, '&gt;','>') ; 
    END IF ; 

    #non-breaking space 
    IF INSTR( X , '&nbsp;' ) 
    THEN SET TextString = REPLACE(TextString, '&nbsp;',' ') ; 
    END IF ; 

    #inverted exclamation mark 
    IF INSTR( X , '&iexcl;' ) 
    THEN SET TextString = REPLACE(TextString, '&iexcl;','¡') ; 
    END IF ; 

    #cent 
    IF INSTR( X , '&cent;' ) 
    THEN SET TextString = REPLACE(TextString, '&cent;','¢') ; 
    END IF ; 

    #pound 
    IF INSTR( X , '&pound;' ) 
    THEN SET TextString = REPLACE(TextString, '&pound;','£') ; 
    END IF ; 

    #currency 
    IF INSTR( X , '&curren;' ) 
    THEN SET TextString = REPLACE(TextString, '&curren;','¤') ; 
    END IF ; 

    #yen 
    IF INSTR( X , '&yen;' ) 
    THEN SET TextString = REPLACE(TextString, '&yen;','¥') ; 
    END IF ; 

    #broken vertical bar 
    IF INSTR( X , '&brvbar;' ) 
    THEN SET TextString = REPLACE(TextString, '&brvbar;','¦') ; 
    END IF ; 

    #section 
    IF INSTR( X , '&sect;' ) 
    THEN SET TextString = REPLACE(TextString, '&sect;','§') ; 
    END IF ; 

    #spacing diaeresis 
    IF INSTR( X , '&uml;' ) 
    THEN SET TextString = REPLACE(TextString, '&uml;','¨') ; 
    END IF ; 

    #copyright 
    IF INSTR( X , '&copy;' ) 
    THEN SET TextString = REPLACE(TextString, '&copy;','©') ; 
    END IF ; 

    #feminine ordinal indicator 
    IF INSTR( X , '&ordf;' ) 
    THEN SET TextString = REPLACE(TextString, '&ordf;','ª') ; 
    END IF ; 

    #angle quotation mark (left) 
    IF INSTR( X , '&laquo;' ) 
    THEN SET TextString = REPLACE(TextString, '&laquo;','«') ; 
    END IF ; 

    #negation 
    IF INSTR( X , '&not;' ) 
    THEN SET TextString = REPLACE(TextString, '&not;','¬') ; 
    END IF ; 

    #soft hyphen 
    IF INSTR( X , '&shy;' ) 
    THEN SET TextString = REPLACE(TextString, '&shy;','­') ; 
    END IF ; 

    #registered trademark 
    IF INSTR( X , '&reg;' ) 
    THEN SET TextString = REPLACE(TextString, '&reg;','®') ; 
    END IF ; 

    #spacing macron 
    IF INSTR( X , '&macr;' ) 
    THEN SET TextString = REPLACE(TextString, '&macr;','¯') ; 
    END IF ; 

    #degree 
    IF INSTR( X , '&deg;' ) 
    THEN SET TextString = REPLACE(TextString, '&deg;','°') ; 
    END IF ; 

    #plus-or-minus  
    IF INSTR( X , '&plusmn;' ) 
    THEN SET TextString = REPLACE(TextString, '&plusmn;','±') ; 
    END IF ; 

    #superscript 2 
    IF INSTR( X , '&sup2;' ) 
    THEN SET TextString = REPLACE(TextString, '&sup2;','²') ; 
    END IF ; 

    #superscript 3 
    IF INSTR( X , '&sup3;' ) 
    THEN SET TextString = REPLACE(TextString, '&sup3;','³') ; 
    END IF ; 

    #spacing acute 
    IF INSTR( X , '&acute;' ) 
    THEN SET TextString = REPLACE(TextString, '&acute;','´') ; 
    END IF ; 

    #micro 
    IF INSTR( X , '&micro;' ) 
    THEN SET TextString = REPLACE(TextString, '&micro;','µ') ; 
    END IF ; 

    #paragraph 
    IF INSTR( X , '&para;' ) 
    THEN SET TextString = REPLACE(TextString, '&para;','¶') ; 
    END IF ; 

    #middle dot 
    IF INSTR( X , '&middot;' ) 
    THEN SET TextString = REPLACE(TextString, '&middot;','·') ; 
    END IF ; 

    #spacing cedilla 
    IF INSTR( X , '&cedil;' ) 
    THEN SET TextString = REPLACE(TextString, '&cedil;','¸') ; 
    END IF ; 

    #superscript 1 
    IF INSTR( X , '&sup1;' ) 
    THEN SET TextString = REPLACE(TextString, '&sup1;','¹') ; 
    END IF ; 

    #masculine ordinal indicator 
    IF INSTR( X , '&ordm;' ) 
    THEN SET TextString = REPLACE(TextString, '&ordm;','º') ; 
    END IF ; 

    #angle quotation mark (right) 
    IF INSTR( X , '&raquo;' ) 
    THEN SET TextString = REPLACE(TextString, '&raquo;','»') ; 
    END IF ; 

    #fraction 1/4 
    IF INSTR( X , '&frac14;' ) 
    THEN SET TextString = REPLACE(TextString, '&frac14;','¼') ; 
    END IF ; 

    #fraction 1/2 
    IF INSTR( X , '&frac12;' ) 
    THEN SET TextString = REPLACE(TextString, '&frac12;','½') ; 
    END IF ; 

    #fraction 3/4 
    IF INSTR( X , '&frac34;' ) 
    THEN SET TextString = REPLACE(TextString, '&frac34;','¾') ; 
    END IF ; 

    #inverted question mark 
    IF INSTR( X , '&iquest;' ) 
    THEN SET TextString = REPLACE(TextString, '&iquest;','¿') ; 
    END IF ; 

    #multiplication 
    IF INSTR( X , '&times;' ) 
    THEN SET TextString = REPLACE(TextString, '&times;','×') ; 
    END IF ; 

    #division 
    IF INSTR( X , '&divide;' ) 
    THEN SET TextString = REPLACE(TextString, '&divide;','÷') ; 
    END IF ; 

    #capital a, grave accent 
    IF INSTR( X , '&Agrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&Agrave;','À') ; 
    END IF ; 

    #capital a, acute accent 
    IF INSTR( X , '&Aacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&Aacute;','Á') ; 
    END IF ; 

    #capital a, circumflex accent 
    IF INSTR( X , '&Acirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&Acirc;','Â') ; 
    END IF ; 

    #capital a, tilde 
    IF INSTR( X , '&Atilde;' ) 
    THEN SET TextString = REPLACE(TextString, '&Atilde;','Ã') ; 
    END IF ; 

    #capital a, umlaut mark 
    IF INSTR( X , '&Auml;' ) 
    THEN SET TextString = REPLACE(TextString, '&Auml;','Ä') ; 
    END IF ; 

    #capital a, ring 
    IF INSTR( X , '&Aring;' ) 
    THEN SET TextString = REPLACE(TextString, '&Aring;','Å') ; 
    END IF ; 

    #capital ae 
    IF INSTR( X , '&AElig;' ) 
    THEN SET TextString = REPLACE(TextString, '&AElig;','Æ') ; 
    END IF ; 

    #capital c, cedilla 
    IF INSTR( X , '&Ccedil;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ccedil;','Ç') ; 
    END IF ; 

    #capital e, grave accent 
    IF INSTR( X , '&Egrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&Egrave;','È') ; 
    END IF ; 

    #capital e, acute accent 
    IF INSTR( X , '&Eacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&Eacute;','É') ; 
    END IF ; 

    #capital e, circumflex accent 
    IF INSTR( X , '&Ecirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ecirc;','Ê') ; 
    END IF ; 

    #capital e, umlaut mark 
    IF INSTR( X , '&Euml;' ) 
    THEN SET TextString = REPLACE(TextString, '&Euml;','Ë') ; 
    END IF ; 

    #capital i, grave accent 
    IF INSTR( X , '&Igrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&Igrave;','Ì') ; 
    END IF ; 

    #capital i, acute accent 
    IF INSTR( X , '&Iacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&Iacute;','Í') ; 
    END IF ; 

    #capital i, circumflex accent 
    IF INSTR( X , '&Icirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&Icirc;','Î') ; 
    END IF ; 

    #capital i, umlaut mark 
    IF INSTR( X , '&Iuml;' ) 
    THEN SET TextString = REPLACE(TextString, '&Iuml;','Ï') ; 
    END IF ; 

    #capital eth, Icelandic 
    IF INSTR( X , '&ETH;' ) 
    THEN SET TextString = REPLACE(TextString, '&ETH;','Ð') ; 
    END IF ; 

    #capital n, tilde 
    IF INSTR( X , '&Ntilde;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ntilde;','Ñ') ; 
    END IF ; 

    #capital o, grave accent 
    IF INSTR( X , '&Ograve;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ograve;','Ò') ; 
    END IF ; 

    #capital o, acute accent 
    IF INSTR( X , '&Oacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&Oacute;','Ó') ; 
    END IF ; 

    #capital o, circumflex accent 
    IF INSTR( X , '&Ocirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ocirc;','Ô') ; 
    END IF ; 

    #capital o, tilde 
    IF INSTR( X , '&Otilde;' ) 
    THEN SET TextString = REPLACE(TextString, '&Otilde;','Õ') ; 
    END IF ; 

    #capital o, umlaut mark 
    IF INSTR( X , '&Ouml;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ouml;','Ö') ; 
    END IF ; 

    #capital o, slash 
    IF INSTR( X , '&Oslash;' ) 
    THEN SET TextString = REPLACE(TextString, '&Oslash;','Ø') ; 
    END IF ; 

    #capital u, grave accent 
    IF INSTR( X , '&Ugrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ugrave;','Ù') ; 
    END IF ; 

    #capital u, acute accent 
    IF INSTR( X , '&Uacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&Uacute;','Ú') ; 
    END IF ; 

    #capital u, circumflex accent 
    IF INSTR( X , '&Ucirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ucirc;','Û') ; 
    END IF ; 

    #capital u, umlaut mark 
    IF INSTR( X , '&Uuml;' ) 
    THEN SET TextString = REPLACE(TextString, '&Uuml;','Ü') ; 
    END IF ; 

    #capital y, acute accent 
    IF INSTR( X , '&Yacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&Yacute;','Ý') ; 
    END IF ; 

    #capital THORN, Icelandic 
    IF INSTR( X , '&THORN;' ) 
    THEN SET TextString = REPLACE(TextString, '&THORN;','Þ') ; 
    END IF ; 

    #small sharp s, German 
    IF INSTR( X , '&szlig;' ) 
    THEN SET TextString = REPLACE(TextString, '&szlig;','ß') ; 
    END IF ; 

    #small a, grave accent 
    IF INSTR( X , '&agrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&agrave;','à') ; 
    END IF ; 

    #small a, acute accent 
    IF INSTR( X , '&aacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&aacute;','á') ; 
    END IF ; 

    #small a, circumflex accent 
    IF INSTR( X , '&acirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&acirc;','â') ; 
    END IF ; 

    #small a, tilde 
    IF INSTR( X , '&atilde;' ) 
    THEN SET TextString = REPLACE(TextString, '&atilde;','ã') ; 
    END IF ; 

    #small a, umlaut mark 
    IF INSTR( X , '&auml;' ) 
    THEN SET TextString = REPLACE(TextString, '&auml;','ä') ; 
    END IF ; 

    #small a, ring 
    IF INSTR( X , '&aring;' ) 
    THEN SET TextString = REPLACE(TextString, '&aring;','å') ; 
    END IF ; 

    #small ae 
    IF INSTR( X , '&aelig;' ) 
    THEN SET TextString = REPLACE(TextString, '&aelig;','æ') ; 
    END IF ; 

    #small c, cedilla 
    IF INSTR( X , '&ccedil;' ) 
    THEN SET TextString = REPLACE(TextString, '&ccedil;','ç') ; 
    END IF ; 

    #small e, grave accent 
    IF INSTR( X , '&egrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&egrave;','è') ; 
    END IF ; 

    #small e, acute accent 
    IF INSTR( X , '&eacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&eacute;','é') ; 
    END IF ; 

    #small e, circumflex accent 
    IF INSTR( X , '&ecirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&ecirc;','ê') ; 
    END IF ; 

    #small e, umlaut mark 
    IF INSTR( X , '&euml;' ) 
    THEN SET TextString = REPLACE(TextString, '&euml;','ë') ; 
    END IF ; 

    #small i, grave accent 
    IF INSTR( X , '&igrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&igrave;','ì') ; 
    END IF ; 

    #small i, acute accent 
    IF INSTR( X , '&iacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&iacute;','í') ; 
    END IF ; 

    #small i, circumflex accent 
    IF INSTR( X , '&icirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&icirc;','î') ; 
    END IF ; 

    #small i, umlaut mark 
    IF INSTR( X , '&iuml;' ) 
    THEN SET TextString = REPLACE(TextString, '&iuml;','ï') ; 
    END IF ; 

    #small eth, Icelandic 
    IF INSTR( X , '&eth;' ) 
    THEN SET TextString = REPLACE(TextString, '&eth;','ð') ; 
    END IF ; 

    #small n, tilde 
    IF INSTR( X , '&ntilde;' ) 
    THEN SET TextString = REPLACE(TextString, '&ntilde;','ñ') ; 
    END IF ; 

    #small o, grave accent 
    IF INSTR( X , '&ograve;' ) 
    THEN SET TextString = REPLACE(TextString, '&ograve;','ò') ; 
    END IF ; 

    #small o, acute accent 
    IF INSTR( X , '&oacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&oacute;','ó') ; 
    END IF ; 

    #small o, circumflex accent 
    IF INSTR( X , '&ocirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&ocirc;','ô') ; 
    END IF ; 

    #small o, tilde 
    IF INSTR( X , '&otilde;' ) 
    THEN SET TextString = REPLACE(TextString, '&otilde;','õ') ; 
    END IF ; 

    #small o, umlaut mark 
    IF INSTR( X , '&ouml;' ) 
    THEN SET TextString = REPLACE(TextString, '&ouml;','ö') ; 
    END IF ; 

    #small o, slash 
    IF INSTR( X , '&oslash;' ) 
    THEN SET TextString = REPLACE(TextString, '&oslash;','ø') ; 
    END IF ; 

    #small u, grave accent 
    IF INSTR( X , '&ugrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&ugrave;','ù') ; 
    END IF ; 

    #small u, acute accent 
    IF INSTR( X , '&uacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&uacute;','ú') ; 
    END IF ; 

    #small u, circumflex accent 
    IF INSTR( X , '&ucirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&ucirc;','û') ; 
    END IF ; 

    #small u, umlaut mark 
    IF INSTR( X , '&uuml;' ) 
    THEN SET TextString = REPLACE(TextString, '&uuml;','ü') ; 
    END IF ; 

    #small y, acute accent 
    IF INSTR( X , '&yacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&yacute;','ý') ; 
    END IF ; 

    #small thorn, Icelandic 
    IF INSTR( X , '&thorn;' ) 
    THEN SET TextString = REPLACE(TextString, '&thorn;','þ') ; 
    END IF ; 

    #small y, umlaut mark 
    IF INSTR( X , '&yuml;' ) 
    THEN SET TextString = REPLACE(TextString, '&yuml;','ÿ') ; 
    END IF ; 

    RETURN TextString ; 

END$$

DROP FUNCTION IF EXISTS `PaguASB`$$
CREATE FUNCTION `PaguASB` (`jns_biaya` INT, `hub_driver` INT, `vol1` DECIMAL(15,4), `vol2` DECIMAL(15,4), `r1` DECIMAL(15,4), `r2` DECIMAL(15,4), `m1` DECIMAL(15,4), `m2` DECIMAL(15,4), `k1` DECIMAL(15,4), `k2` DECIMAL(15,4), `k3` DECIMAL(15,4), `harga` DECIMAL(15,4)) RETURNS DECIMAL(15,4) BEGIN
    DECLARE hargax DECIMAL(15,4);
    DECLARE kmax DECIMAL(15,4);
    DECLARE rx1 DECIMAL(15,4);
    DECLARE rx2 DECIMAL(15,4);
    DECLARE koef DECIMAL(15,4);
    
    SET koef = (k1*k2*k3);
    
    IF m1 = 1 THEN
      IF m2 = 1 THEN
        SET kmax = 1;
      ELSE
        IF m1 <= m2 THEN
              SET kmax = CEILING(vol1/m1);
            ELSE
              SET kmax = CEILING(vol2/m2);
            END IF;
      END IF;
    ELSE
      IF m1 <= m2 THEN
        SET kmax = CEILING(vol2/m2);
      ELSE
        SET kmax = CEILING(vol1/m1);
      END IF;
    END IF;

    IF r1 <= 1 THEN 
      SET rx1= CEILING(vol1/vol1); 
    ELSE 
      SET rx1= CEILING(vol1/r1); 
    END IF;
    
    IF r2 <= 1 THEN 
      SET rx2= CEILING(vol2/vol2); 
    ELSE 
      SET rx2= CEILING(vol2/r2); 
    END IF;

    IF jns_biaya =1 THEN 
      SET hargax = (koef*kmax*harga);
    ELSE      
      IF hub_driver=1 THEN 
        SET hargax = (vol1*koef*harga); 
      END IF;
      
      IF hub_driver=2 THEN 
        SET hargax = (vol2*koef*harga); 
      END IF;
      
      IF hub_driver=3 THEN 
        SET hargax = (vol1*vol2*koef*harga); 
      END IF;
      
      IF hub_driver=4 THEN 
        SET hargax = (koef*rx1*harga); 
      END IF;
      
      IF hub_driver=5 THEN 
        SET hargax = (koef*rx2*harga); 
      END IF;
      
      IF hub_driver=6 THEN 
        SET hargax = (koef*rx1*rx2*harga); 
      END IF;
      
      IF hub_driver=7 THEN 
        SET hargax = (vol2*koef*rx1*harga); 
      END IF;
      
      IF hub_driver=8 THEN 
        SET hargax = (vol1*koef*rx2*harga); 
      END IF;
      
    END IF;
 
 RETURN (hargax);
END$$

DROP FUNCTION IF EXISTS `PaguASBDistribusi`$$
CREATE FUNCTION `PaguASBDistribusi` (`jns_biaya` INT, `hub_driver` INT, `vol1` DECIMAL(15,4), `vol2` DECIMAL(15,4), `r1` DECIMAL(15,4), `r2` DECIMAL(15,4), `m1` DECIMAL(15,4), `m2` DECIMAL(15,4), `k1` DECIMAL(15,4), `k2` DECIMAL(15,4), `k3` DECIMAL(15,4), `harga` DECIMAL(15,4), `persen` DECIMAL(15,4)) RETURNS DECIMAL(15,4) BEGIN
		DECLARE hargax DECIMAL(15,4);
		DECLARE kmax DECIMAL(15,4);
		DECLARE rx1 DECIMAL(15,4);
		DECLARE rx2 DECIMAL(15,4);
		DECLARE koef DECIMAL(15,4);
		DECLARE koef_dis DECIMAL(15,4);
		
		SET koef = (k1*k2*k3);
		
		IF persen <= 0 OR persen > 100 THEN 
			SET koef_dis = 1;
		ELSE
			SET koef_dis = persen/100;
		END IF;
		
		IF m1 = 1 THEN
			IF m2 = 1 THEN
				SET kmax = 1;
			ELSE
				IF m1 <= m2 THEN
							SET kmax = CEILING(vol1/m1);
						ELSE
							SET kmax = CEILING(vol2/m2);
						END IF;
			END IF;
		ELSE
			IF m1 <= m2 THEN
				SET kmax = CEILING(vol1/m1);
			ELSE
				SET kmax = CEILING(vol2/m2);
			END IF;
		END IF;

    IF r1 <= 1 THEN 
			SET rx1= CEILING(vol1/vol1); 
		ELSE 
			SET rx1= CEILING(vol1/r1); 
		END IF;
		
		IF r2 <= 1 THEN 
			SET rx2= CEILING(vol2/vol2); 
		ELSE 
			SET rx2= CEILING(vol2/r2); 
		END IF;

		IF jns_biaya =1 THEN 
			SET hargax = (koef*kmax*harga*koef_dis); 
		END IF;
		
		IF jns_biaya =2 AND hub_driver=1 THEN 
			SET hargax = (vol1*koef*rx1*harga); 
		END IF;
		
		IF jns_biaya =2 AND hub_driver=2 THEN 
			SET hargax = (vol2*koef*rx2*harga); 
		END IF;
		
		IF jns_biaya =3 AND hub_driver=1 THEN 
			SET hargax = (vol1*koef*harga); 
		END IF;
		
		IF jns_biaya =3 AND hub_driver=2 THEN 
			SET hargax = (vol2*koef*harga); 
		END IF;
		
		IF jns_biaya =3 AND hub_driver=3 THEN 
			SET hargax = (vol1*vol2*koef*harga); 
		END IF;
 
 RETURN (hargax);
END$$

DROP FUNCTION IF EXISTS `TglIndonesia`$$
CREATE FUNCTION `TglIndonesia` (`tanggal` DATE) RETURNS VARCHAR(255) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci BEGIN
  DECLARE varTanggal varchar(255);

  SELECT CONCAT(
    DAY(tanggal),' ',
    CASE MONTH(tanggal) 
      WHEN 1 THEN 'Januari' 
      WHEN 2 THEN 'Februari' 
      WHEN 3 THEN 'Maret' 
      WHEN 4 THEN 'April' 
      WHEN 5 THEN 'Mei' 
      WHEN 6 THEN 'Juni' 
      WHEN 7 THEN 'Juli' 
      WHEN 8 THEN 'Agustus' 
      WHEN 9 THEN 'September'
      WHEN 10 THEN 'Oktober' 
      WHEN 11 THEN 'November' 
      WHEN 12 THEN 'Desember' 
    END,' ',
    YEAR(tanggal)
  ) INTO varTanggal;

  RETURN varTanggal;
END$$

DROP FUNCTION IF EXISTS `XML_Encode`$$
CREATE FUNCTION `XML_Encode` (`X` VARCHAR(1000)) RETURNS VARCHAR(1000) CHARSET latin1 BEGIN 

    DECLARE TextString VARCHAR(1000) ; 
    SET TextString = X ; 

    #quotation mark 
    IF INSTR( X , '"' ) 
    THEN SET TextString = REPLACE(TextString,'"' , '&quot;') ; 
    END IF ; 

    #apostrophe  
    IF INSTR( X , "'" ) 
    THEN SET TextString = REPLACE(TextString,"'" , '&apos;') ; 
    END IF ; 

    #ampersand 
    IF INSTR( X , '&' ) 
    THEN SET TextString = REPLACE(TextString, '&', '&amp;') ; 
    END IF ; 

    #less-than 
    IF INSTR( X , '<' ) 
    THEN SET TextString = REPLACE(TextString, '<', '&lt;') ; 
    END IF ; 

    #greater-than 
    IF INSTR( X , '>' ) 
    THEN SET TextString = REPLACE(TextString, '>', '&gt;') ; 
    END IF ; 
		
		#remove-horizontal-tab
    IF INSTR( X , CHAR(9)) 
    THEN SET TextString = REPLACE(TextString, CHAR(9), '') ;
    END IF ; 
		
		#remove-new-line
    IF INSTR( X , CHAR(10) ) 
    THEN SET TextString = REPLACE(TextString,CHAR(10) , '') ; 
    END IF ; 
		
		#remove-vertical-tab
		IF INSTR( X , CHAR(11)) 
    THEN SET TextString = REPLACE(TextString, CHAR(11), '') ; 
    END IF ; 
		
		#remove-new-page
    IF INSTR( X , CHAR(12)) 
    THEN SET TextString = REPLACE(TextString, CHAR(12), '') ;
    END IF ;  
		
		#remove-carriage-return
		IF INSTR( X , CHAR(13) ) 
    THEN SET TextString = REPLACE(TextString,CHAR(13) , '') ; 
    END IF ;
		
		RETURN TextString ; 

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_cascading_indikator_kegiatan_pd`
--

DROP TABLE IF EXISTS `kin_trx_cascading_indikator_kegiatan_pd`;
CREATE TABLE IF NOT EXISTS `kin_trx_cascading_indikator_kegiatan_pd` (
  `id_indikator_kegiatan_pd` int(11) NOT NULL AUTO_INCREMENT,
  `id_hasil_kegiatan` int(11) NOT NULL DEFAULT '0',
  `id_renstra_kegiatan_indikator` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_indikator_kegiatan_pd`) USING BTREE,
  KEY `FK_kin_trx_cascading_indikator_program_pd_1` (`id_hasil_kegiatan`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_cascading_indikator_program_pd`
--

DROP TABLE IF EXISTS `kin_trx_cascading_indikator_program_pd`;
CREATE TABLE IF NOT EXISTS `kin_trx_cascading_indikator_program_pd` (
  `id_indikator_program_pd` int(11) NOT NULL AUTO_INCREMENT,
  `id_hasil_program` int(11) NOT NULL DEFAULT '0',
  `id_renstra_program_indikator` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_indikator_program_pd`) USING BTREE,
  UNIQUE KEY `FK_kin_trx_cascading_indikator_program_pd_1` (`id_hasil_program`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_cascading_kegiatan_opd`
--

DROP TABLE IF EXISTS `kin_trx_cascading_kegiatan_opd`;
CREATE TABLE IF NOT EXISTS `kin_trx_cascading_kegiatan_opd` (
  `id_hasil_kegiatan` int(11) NOT NULL AUTO_INCREMENT,
  `id_unit` int(11) NOT NULL DEFAULT '0',
  `id_hasil_program` int(11) NOT NULL DEFAULT '0',
  `id_renstra_kegiatan` int(11) NOT NULL DEFAULT '0',
  `uraian_hasil_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_hasil_kegiatan`) USING BTREE,
  KEY `FK_kin_trx_cascading_kegiatan_opd_kin_trx_cascading_program_opd` (`id_hasil_program`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_cascading_program_opd`
--

DROP TABLE IF EXISTS `kin_trx_cascading_program_opd`;
CREATE TABLE IF NOT EXISTS `kin_trx_cascading_program_opd` (
  `id_hasil_program` int(11) NOT NULL AUTO_INCREMENT,
  `tahun` int(11) NOT NULL DEFAULT '2019',
  `id_unit` int(11) NOT NULL DEFAULT '0',
  `id_renstra_sasaran` int(11) NOT NULL DEFAULT '0',
  `id_renstra_program` int(11) NOT NULL DEFAULT '0',
  `uraian_hasil_program` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_hasil_program`) USING BTREE,
  UNIQUE KEY `tahun` (`tahun`,`id_unit`,`id_renstra_sasaran`,`id_renstra_program`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_iku_opd_dok`
--

DROP TABLE IF EXISTS `kin_trx_iku_opd_dok`;
CREATE TABLE IF NOT EXISTS `kin_trx_iku_opd_dok` (
  `id_dokumen` int(11) NOT NULL AUTO_INCREMENT,
  `no_dokumen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_dokumen` date NOT NULL,
  `uraian_dokumen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_renstra` int(11) NOT NULL DEFAULT '1',
  `id_perubahan` int(11) DEFAULT NULL,
  `status_dokumen` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_unit` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_dokumen`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_iku_opd_kegiatan`
--

DROP TABLE IF EXISTS `kin_trx_iku_opd_kegiatan`;
CREATE TABLE IF NOT EXISTS `kin_trx_iku_opd_kegiatan` (
  `id_iku_opd_kegiatan` int(11) NOT NULL AUTO_INCREMENT,
  `id_iku_opd_program` int(11) NOT NULL,
  `id_indikator_kegiatan_renstra` int(11) NOT NULL,
  `id_indikator` int(11) NOT NULL,
  `flag_iku` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_esl4` int(11) NOT NULL DEFAULT '0',
  `id_kegiatan_renstra` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_iku_opd_kegiatan`) USING BTREE,
  KEY `id_dokumen` (`id_iku_opd_program`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_iku_opd_program`
--

DROP TABLE IF EXISTS `kin_trx_iku_opd_program`;
CREATE TABLE IF NOT EXISTS `kin_trx_iku_opd_program` (
  `id_iku_opd_program` int(11) NOT NULL AUTO_INCREMENT,
  `id_iku_opd_sasaran` int(11) NOT NULL,
  `id_indikator_program_renstra` int(11) NOT NULL,
  `id_indikator` int(11) NOT NULL,
  `flag_iku` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_program_renstra` int(11) NOT NULL DEFAULT '0',
  `id_esl3` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_iku_opd_program`) USING BTREE,
  KEY `id_dokumen` (`id_iku_opd_sasaran`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_iku_opd_sasaran`
--

DROP TABLE IF EXISTS `kin_trx_iku_opd_sasaran`;
CREATE TABLE IF NOT EXISTS `kin_trx_iku_opd_sasaran` (
  `id_iku_opd_sasaran` int(11) NOT NULL AUTO_INCREMENT,
  `id_dokumen` int(11) NOT NULL,
  `id_indikator_sasaran_renstra` int(11) NOT NULL,
  `id_indikator` int(11) NOT NULL,
  `flag_iku` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_sasaran_renstra` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_iku_opd_sasaran`) USING BTREE,
  KEY `id_dokumen` (`id_dokumen`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_iku_pemda_dok`
--

DROP TABLE IF EXISTS `kin_trx_iku_pemda_dok`;
CREATE TABLE IF NOT EXISTS `kin_trx_iku_pemda_dok` (
  `id_dokumen` int(11) NOT NULL AUTO_INCREMENT,
  `no_dokumen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_dokumen` date NOT NULL,
  `uraian_dokumen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_rpjmd` int(11) NOT NULL DEFAULT '1',
  `id_perubahan` int(11) DEFAULT NULL,
  `status_dokumen` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_dokumen`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_iku_pemda_rinci`
--

DROP TABLE IF EXISTS `kin_trx_iku_pemda_rinci`;
CREATE TABLE IF NOT EXISTS `kin_trx_iku_pemda_rinci` (
  `id_iku_pemda` int(11) NOT NULL AUTO_INCREMENT,
  `id_dokumen` int(11) NOT NULL,
  `id_indikator_sasaran_rpjmd` int(11) NOT NULL,
  `id_indikator` int(11) NOT NULL,
  `flag_iku` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `unit_penanggung_jawab` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_iku_pemda`) USING BTREE,
  KEY `id_dokumen` (`id_dokumen`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es3_dok`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es3_dok`;
CREATE TABLE IF NOT EXISTS `kin_trx_perkin_es3_dok` (
  `id_dokumen_perkin` int(11) NOT NULL AUTO_INCREMENT,
  `id_sotk_es3` int(11) NOT NULL,
  `tahun` int(11) DEFAULT NULL,
  `no_dokumen` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_dokumen` date DEFAULT NULL,
  `tanggal_mulai` date NOT NULL DEFAULT '2018-01-01',
  `id_pegawai` int(11) NOT NULL DEFAULT '0',
  `nama_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jabatan_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pangkat_penandatangan` int(11) NOT NULL DEFAULT '0',
  `uraian_pangkat_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_penandatangan` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_dokumen_perkin`) USING BTREE,
  KEY `id_unit` (`id_sotk_es3`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es3_kegiatan`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es3_kegiatan`;
CREATE TABLE IF NOT EXISTS `kin_trx_perkin_es3_kegiatan` (
  `id_perkin_kegiatan` int(11) NOT NULL AUTO_INCREMENT,
  `id_perkin_program` int(11) DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_sotk_es4` int(11) NOT NULL DEFAULT '0',
  `status_data` int(2) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_perkin_kegiatan`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_perkin_program`) USING BTREE,
  KEY `id_program` (`id_kegiatan_renstra`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es3_program`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es3_program`;
CREATE TABLE IF NOT EXISTS `kin_trx_perkin_es3_program` (
  `id_perkin_program` int(11) NOT NULL AUTO_INCREMENT,
  `id_dokumen_perkin` int(11) NOT NULL DEFAULT '0',
  `id_perkin_program_opd` int(11) NOT NULL,
  `id_program_renstra` int(11) NOT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_perkin_program`) USING BTREE,
  KEY `id_program` (`id_program_renstra`) USING BTREE,
  KEY `id_dokumen_perkin` (`id_dokumen_perkin`) USING BTREE,
  KEY `id_perkin_program_opd` (`id_perkin_program_opd`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es3_program_indikator`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es3_program_indikator`;
CREATE TABLE IF NOT EXISTS `kin_trx_perkin_es3_program_indikator` (
  `id_perkin_indikator` int(11) NOT NULL AUTO_INCREMENT,
  `id_perkin_program` int(11) DEFAULT NULL,
  `id_indikator_program_renstra` int(11) DEFAULT NULL,
  `target_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t2` decimal(20,2) NOT NULL,
  `target_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_perkin_indikator`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_perkin_program`) USING BTREE,
  KEY `id_program` (`id_indikator_program_renstra`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es4_dok`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es4_dok`;
CREATE TABLE IF NOT EXISTS `kin_trx_perkin_es4_dok` (
  `id_dokumen_perkin` int(11) NOT NULL AUTO_INCREMENT,
  `id_sotk_es4` int(11) NOT NULL,
  `tahun` int(11) DEFAULT NULL,
  `no_dokumen` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_dokumen` date DEFAULT NULL,
  `tanggal_mulai` date NOT NULL DEFAULT '2018-01-01',
  `id_pegawai` int(11) DEFAULT NULL,
  `nama_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jabatan_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pangkat_penandatangan` int(11) NOT NULL DEFAULT '0',
  `uraian_pangkat_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_penandatangan` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_dokumen_perkin`) USING BTREE,
  KEY `id_unit` (`id_sotk_es4`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es4_kegiatan`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es4_kegiatan`;
CREATE TABLE IF NOT EXISTS `kin_trx_perkin_es4_kegiatan` (
  `id_perkin_kegiatan` int(11) NOT NULL AUTO_INCREMENT,
  `id_dokumen_perkin` int(11) NOT NULL DEFAULT '0',
  `id_perkin_kegiatan_es3` int(11) DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t2` decimal(20,2) NOT NULL,
  `pagu_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_perkin_kegiatan`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_perkin_kegiatan_es3`) USING BTREE,
  KEY `id_program` (`id_kegiatan_renstra`) USING BTREE,
  KEY `id_dokumen_perkin` (`id_dokumen_perkin`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es4_kegiatan_indikator`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es4_kegiatan_indikator`;
CREATE TABLE IF NOT EXISTS `kin_trx_perkin_es4_kegiatan_indikator` (
  `id_perkin_indikator` int(11) NOT NULL AUTO_INCREMENT,
  `id_perkin_kegiatan` int(11) DEFAULT NULL,
  `id_indikator_kegiatan_renstra` int(11) DEFAULT NULL,
  `target_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t2` decimal(20,2) NOT NULL,
  `target_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_perkin_indikator`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_perkin_kegiatan`) USING BTREE,
  KEY `id_program` (`id_indikator_kegiatan_renstra`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_opd_dok`
--

DROP TABLE IF EXISTS `kin_trx_perkin_opd_dok`;
CREATE TABLE IF NOT EXISTS `kin_trx_perkin_opd_dok` (
  `id_dokumen_perkin` int(11) NOT NULL AUTO_INCREMENT,
  `id_sotk_es2` int(11) NOT NULL,
  `tahun` int(11) DEFAULT NULL,
  `no_dokumen` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_dokumen` date DEFAULT NULL,
  `tanggal_mulai` date NOT NULL DEFAULT '2018-01-01',
  `id_pegawai` int(11) NOT NULL DEFAULT '0',
  `nama_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jabatan_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pangkat_penandatangan` int(11) NOT NULL DEFAULT '0',
  `uraian_pangkat_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_penandatangan` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_dokumen_perkin`) USING BTREE,
  KEY `id_unit` (`id_sotk_es2`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_opd_program`
--

DROP TABLE IF EXISTS `kin_trx_perkin_opd_program`;
CREATE TABLE IF NOT EXISTS `kin_trx_perkin_opd_program` (
  `id_perkin_program` int(11) NOT NULL AUTO_INCREMENT,
  `id_perkin_sasaran` int(11) NOT NULL,
  `id_hasil_program` int(11) NOT NULL DEFAULT '0',
  `id_program_renstra` int(11) NOT NULL,
  `id_sotk_es3` int(11) NOT NULL DEFAULT '0',
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_perkin_program`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_perkin_sasaran`) USING BTREE,
  KEY `id_program` (`id_program_renstra`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_opd_program_indikator`
--

DROP TABLE IF EXISTS `kin_trx_perkin_opd_program_indikator`;
CREATE TABLE IF NOT EXISTS `kin_trx_perkin_opd_program_indikator` (
  `id_perkin_indikator` bigint(255) NOT NULL AUTO_INCREMENT,
  `id_perkin_program` bigint(255) NOT NULL,
  `id_indikator_program_pd` bigint(255) NOT NULL,
  `id_renstra_program_indikator` bigint(255) NOT NULL,
  `jml_target` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_perkin_indikator`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_opd_program_pelaksana`
--

DROP TABLE IF EXISTS `kin_trx_perkin_opd_program_pelaksana`;
CREATE TABLE IF NOT EXISTS `kin_trx_perkin_opd_program_pelaksana` (
  `id_perkin_pelaksana` bigint(255) NOT NULL AUTO_INCREMENT,
  `id_perkin_indikator` bigint(255) NOT NULL,
  `id_sotk_es3` bigint(255) NOT NULL,
  `jml_target` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_perkin_pelaksana`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_opd_sasaran`
--

DROP TABLE IF EXISTS `kin_trx_perkin_opd_sasaran`;
CREATE TABLE IF NOT EXISTS `kin_trx_perkin_opd_sasaran` (
  `id_perkin_sasaran` int(11) NOT NULL AUTO_INCREMENT,
  `id_dokumen_perkin` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_perkin_sasaran`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_dokumen_perkin`) USING BTREE,
  KEY `id_program` (`id_sasaran_renstra`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_opd_sasaran_indikator`
--

DROP TABLE IF EXISTS `kin_trx_perkin_opd_sasaran_indikator`;
CREATE TABLE IF NOT EXISTS `kin_trx_perkin_opd_sasaran_indikator` (
  `id_perkin_indikator` int(11) NOT NULL AUTO_INCREMENT,
  `id_perkin_sasaran` int(11) DEFAULT NULL,
  `id_indikator_sasaran_renstra` int(11) DEFAULT NULL,
  `target_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t2` decimal(20,2) NOT NULL,
  `target_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_perkin_indikator`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_perkin_sasaran`) USING BTREE,
  KEY `id_program` (`id_indikator_sasaran_renstra`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es2_dok`
--

DROP TABLE IF EXISTS `kin_trx_real_es2_dok`;
CREATE TABLE IF NOT EXISTS `kin_trx_real_es2_dok` (
  `id_dokumen_real` int(11) NOT NULL AUTO_INCREMENT,
  `id_dokumen_perkin` int(11) DEFAULT NULL,
  `id_sotk_es2` int(11) NOT NULL,
  `tahun` int(11) DEFAULT NULL,
  `triwulan` int(11) NOT NULL DEFAULT '1',
  `no_dokumen` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_dokumen` date DEFAULT NULL,
  `id_pegawai` int(11) DEFAULT NULL,
  `nama_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jabatan_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pangkat_penandatangan` int(11) NOT NULL DEFAULT '0',
  `uraian_pangkat_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_penandatangan` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_dokumen_real`) USING BTREE,
  KEY `id_unit` (`id_sotk_es2`) USING BTREE,
  KEY `id_dokumen_perkin` (`id_dokumen_perkin`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es2_program`
--

DROP TABLE IF EXISTS `kin_trx_real_es2_program`;
CREATE TABLE IF NOT EXISTS `kin_trx_real_es2_program` (
  `id_real_program` int(11) NOT NULL AUTO_INCREMENT,
  `id_real_sasaran` int(11) NOT NULL DEFAULT '0',
  `id_real_program_es3` int(11) DEFAULT NULL,
  `id_perkin_program` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t2` decimal(20,2) NOT NULL,
  `pagu_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_real_program`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_perkin_program`) USING BTREE,
  KEY `id_program` (`id_program_renstra`) USING BTREE,
  KEY `id_dokumen_perkin` (`id_real_sasaran`) USING BTREE,
  KEY `id_real_program_es3` (`id_real_program_es3`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es2_sasaran`
--

DROP TABLE IF EXISTS `kin_trx_real_es2_sasaran`;
CREATE TABLE IF NOT EXISTS `kin_trx_real_es2_sasaran` (
  `id_real_sasaran` int(11) NOT NULL AUTO_INCREMENT,
  `id_dokumen_real` int(11) DEFAULT NULL,
  `id_perkin_sasaran` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_real_sasaran`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_dokumen_real`) USING BTREE,
  KEY `id_program` (`id_sasaran_renstra`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es2_sasaran_indikator`
--

DROP TABLE IF EXISTS `kin_trx_real_es2_sasaran_indikator`;
CREATE TABLE IF NOT EXISTS `kin_trx_real_es2_sasaran_indikator` (
  `id_real_indikator` int(11) NOT NULL AUTO_INCREMENT,
  `id_real_sasaran` int(11) DEFAULT NULL,
  `id_perkin_indikator` int(11) DEFAULT NULL,
  `id_indikator_sasaran_renstra` int(11) DEFAULT NULL,
  `target_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t2` decimal(20,2) NOT NULL,
  `target_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_fisik` decimal(20,2) NOT NULL DEFAULT '0.00',
  `uraian_deviasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_renaksi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_real_indikator`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_real_sasaran`) USING BTREE,
  KEY `id_program` (`id_indikator_sasaran_renstra`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es3_dok`
--

DROP TABLE IF EXISTS `kin_trx_real_es3_dok`;
CREATE TABLE IF NOT EXISTS `kin_trx_real_es3_dok` (
  `id_dokumen_real` int(11) NOT NULL AUTO_INCREMENT,
  `id_dokumen_perkin` int(11) DEFAULT NULL,
  `id_sotk_es3` int(11) NOT NULL,
  `tahun` int(11) DEFAULT NULL,
  `triwulan` int(11) NOT NULL DEFAULT '1',
  `no_dokumen` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_dokumen` date DEFAULT NULL,
  `id_pegawai` int(11) DEFAULT NULL,
  `nama_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jabatan_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pangkat_penandatangan` int(11) NOT NULL DEFAULT '0',
  `uraian_pangkat_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_penandatangan` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_dokumen_real`) USING BTREE,
  KEY `id_unit` (`id_sotk_es3`) USING BTREE,
  KEY `id_dokumen_perkin` (`id_dokumen_perkin`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es3_kegiatan`
--

DROP TABLE IF EXISTS `kin_trx_real_es3_kegiatan`;
CREATE TABLE IF NOT EXISTS `kin_trx_real_es3_kegiatan` (
  `id_real_kegiatan` int(11) NOT NULL AUTO_INCREMENT,
  `id_real_program` int(11) NOT NULL DEFAULT '0',
  `id_perkin_kegiatan` int(11) DEFAULT NULL,
  `id_real_kegiatan_es4` int(11) DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t2` decimal(20,2) NOT NULL,
  `pagu_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_real_kegiatan_4` int(11) NOT NULL,
  PRIMARY KEY (`id_real_kegiatan`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_perkin_kegiatan`) USING BTREE,
  KEY `id_program` (`id_kegiatan_renstra`) USING BTREE,
  KEY `id_dokumen_perkin` (`id_real_program`) USING BTREE,
  KEY `id_real_kegiatan_es4` (`id_real_kegiatan_es4`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es3_program`
--

DROP TABLE IF EXISTS `kin_trx_real_es3_program`;
CREATE TABLE IF NOT EXISTS `kin_trx_real_es3_program` (
  `id_real_program` int(11) NOT NULL AUTO_INCREMENT,
  `id_dokumen_real` int(11) NOT NULL DEFAULT '0',
  `id_perkin_program` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t2` decimal(20,2) NOT NULL,
  `pagu_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `uraian_deviasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_renaksi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_real_program`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_perkin_program`) USING BTREE,
  KEY `id_program` (`id_program_renstra`) USING BTREE,
  KEY `id_dokumen_perkin` (`id_dokumen_real`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es3_program_indikator`
--

DROP TABLE IF EXISTS `kin_trx_real_es3_program_indikator`;
CREATE TABLE IF NOT EXISTS `kin_trx_real_es3_program_indikator` (
  `id_real_indikator` int(11) NOT NULL AUTO_INCREMENT,
  `id_real_program` int(11) NOT NULL,
  `id_perkin_indikator` int(11) DEFAULT NULL,
  `id_indikator_program_renstra` int(11) DEFAULT NULL,
  `target_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t2` decimal(20,2) NOT NULL,
  `target_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_fisik` decimal(20,2) NOT NULL DEFAULT '0.00',
  `uraian_deviasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_renaksi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reviu_deviasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reviu_real` decimal(20,2) NOT NULL DEFAULT '0.00',
  `reviu_renaksi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_real_indikator`) USING BTREE,
  KEY `id_program` (`id_indikator_program_renstra`) USING BTREE,
  KEY `id_real_program` (`id_real_program`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es4_dok`
--

DROP TABLE IF EXISTS `kin_trx_real_es4_dok`;
CREATE TABLE IF NOT EXISTS `kin_trx_real_es4_dok` (
  `id_dokumen_real` int(11) NOT NULL AUTO_INCREMENT,
  `id_dokumen_perkin` int(11) DEFAULT NULL,
  `id_sotk_es4` int(11) NOT NULL,
  `tahun` int(11) DEFAULT NULL,
  `triwulan` int(11) NOT NULL DEFAULT '1',
  `no_dokumen` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_dokumen` date DEFAULT NULL,
  `id_pegawai` int(11) DEFAULT NULL,
  `nama_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jabatan_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pangkat_penandatangan` int(11) NOT NULL DEFAULT '0',
  `uraian_pangkat_penandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_penandatangan` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_dokumen_real`) USING BTREE,
  KEY `id_unit` (`id_sotk_es4`) USING BTREE,
  KEY `id_dokumen_perkin` (`id_dokumen_perkin`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es4_kegiatan`
--

DROP TABLE IF EXISTS `kin_trx_real_es4_kegiatan`;
CREATE TABLE IF NOT EXISTS `kin_trx_real_es4_kegiatan` (
  `id_real_kegiatan` int(11) NOT NULL AUTO_INCREMENT,
  `id_dokumen_real` int(11) NOT NULL DEFAULT '0',
  `id_perkin_kegiatan` int(11) DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t2` decimal(20,2) NOT NULL,
  `pagu_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `uraian_deviasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_renaksi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_real_kegiatan`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_perkin_kegiatan`) USING BTREE,
  KEY `id_program` (`id_kegiatan_renstra`) USING BTREE,
  KEY `id_dokumen_perkin` (`id_dokumen_real`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es4_kegiatan_indikator`
--

DROP TABLE IF EXISTS `kin_trx_real_es4_kegiatan_indikator`;
CREATE TABLE IF NOT EXISTS `kin_trx_real_es4_kegiatan_indikator` (
  `id_real_indikator` int(11) NOT NULL AUTO_INCREMENT,
  `id_real_kegiatan` int(11) DEFAULT NULL,
  `id_perkin_indikator` int(11) DEFAULT NULL,
  `id_indikator_kegiatan_renstra` int(11) DEFAULT NULL,
  `target_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t2` decimal(20,2) NOT NULL,
  `target_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_fisik` decimal(20,2) NOT NULL,
  `uraian_deviasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_renaksi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reviu_renaksi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reviu_deviasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reviu_real` decimal(20,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_real_indikator`) USING BTREE,
  KEY `id_sasaran_kinerja_skpd` (`id_real_kegiatan`) USING BTREE,
  KEY `id_program` (`id_indikator_kegiatan_renstra`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_api_manajemen`
--

DROP TABLE IF EXISTS `ref_api_manajemen`;
CREATE TABLE IF NOT EXISTS `ref_api_manajemen` (
  `id_setting` int(11) NOT NULL AUTO_INCREMENT,
  `id_app` int(11) NOT NULL,
  `url_api` varchar(255) DEFAULT NULL,
  `key_barrier` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_setting`),
  UNIQUE KEY `id_app` (`id_app`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ref_aspek_pembangunan`
--

DROP TABLE IF EXISTS `ref_aspek_pembangunan`;
CREATE TABLE IF NOT EXISTS `ref_aspek_pembangunan` (
  `id_aspek` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_aspek_pembangunan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_aspek`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `ref_aspek_pembangunan`
--

INSERT INTO `ref_aspek_pembangunan` (`id_aspek`, `uraian_aspek_pembangunan`, `status_data`, `created_at`, `updated_at`) VALUES
(1, 'Aspek Geografi dan Demografi', 0, '2019-03-09 05:37:26', '2019-03-09 05:37:51'),
(2, 'Aspek Kesejahteraan Masyarakat', 0, '2019-03-09 05:37:40', '2019-03-09 05:37:40'),
(3, 'Aspek Pelayanan Umum', 0, '2019-03-09 05:38:15', '2019-03-09 05:38:15'),
(4, 'Aspek Daya Saing Daerah', 0, '2019-03-09 05:38:31', '2019-03-09 05:38:31');

-- --------------------------------------------------------

--
-- Table structure for table `ref_bidang`
--

DROP TABLE IF EXISTS `ref_bidang`;
CREATE TABLE IF NOT EXISTS `ref_bidang` (
  `id_bidang` int(11) NOT NULL AUTO_INCREMENT,
  `kd_urusan` int(255) NOT NULL,
  `kd_bidang` int(255) NOT NULL,
  `nm_bidang` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kd_fungsi` int(255) DEFAULT NULL,
  PRIMARY KEY (`id_bidang`) USING BTREE,
  UNIQUE KEY `idx_ref_bidang` (`kd_urusan`,`kd_bidang`) USING BTREE,
  KEY `fk_ref_fungsi` (`kd_fungsi`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_bidang`
--

INSERT INTO `ref_bidang` (`id_bidang`, `kd_urusan`, `kd_bidang`, `nm_bidang`, `kd_fungsi`) VALUES
(1, 1, 1, 'Pendidikan', 10),
(2, 1, 2, 'Kesehatan', 7),
(3, 1, 3, 'Pekerjaan Umum dan Penataan Ruang', 6),
(4, 1, 4, 'Perumahan Rakyat dan Kawasan Pemukiman', 6),
(5, 1, 5, 'Ketentraman dan Ketertiban Umum serta Perlindungan Masyarakat', 3),
(6, 1, 6, 'Sosial', 11),
(7, 2, 1, 'Tenaga Kerja', 4),
(8, 2, 2, 'Pemberdayaan Perempuan dan Perlindungan Anak', 11),
(9, 2, 3, 'Pangan', 1),
(10, 2, 4, 'Pertanahan', 5),
(11, 2, 5, 'Lingkungan Hidup', 5),
(12, 2, 6, 'Administrasi Kependudukan dan Capil', 11),
(13, 2, 7, 'Pemberdayaan Masyarakat Desa', 4),
(14, 2, 8, 'Pengendalian Penduduk dan Keluarga Berencana', 7),
(15, 2, 9, 'Perhubungan', 4),
(16, 2, 10, 'Komunikasi dan Informatika', 1),
(17, 2, 11, 'Koperasi, Usaha Kecil dan Menengah', 4),
(18, 2, 12, 'Penanaman Modal', 4),
(19, 2, 13, 'Kepemudaan dan Olah Raga', 10),
(20, 2, 14, 'Statistik', 1),
(21, 2, 15, 'Persandian', 1),
(22, 2, 16, 'Kebudayaan', 8),
(23, 2, 17, 'Perpustakaan', 10),
(24, 2, 18, 'Kearsipan', 1),
(25, 3, 1, 'Kelautan dan Perikanan', 4),
(26, 3, 2, 'Pariwisata', 8),
(27, 3, 3, 'Pertanian', 4),
(28, 3, 4, 'Kehutanan', 4),
(29, 3, 5, 'Energi dan Sumberdaya Mineral', 4),
(30, 3, 6, 'Perdagangan', 4),
(31, 3, 7, 'Perindustrian', 4),
(32, 3, 8, 'Transmigrasi', 4),
(33, 4, 1, 'Administrasi Pemerintahan', 1),
(34, 4, 2, 'Pengawasan', 1),
(35, 4, 3, 'Perencanaan', 1),
(36, 4, 4, 'Keuangan', 1),
(37, 4, 5, 'Kepegawaian', 1),
(38, 4, 6, 'Pendidikan dan Pelatihan', 1),
(39, 4, 7, 'Penelitian dan Pengembangan', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ref_data_sub_unit`
--

DROP TABLE IF EXISTS `ref_data_sub_unit`;
CREATE TABLE IF NOT EXISTS `ref_data_sub_unit` (
  `tahun` int(11) NOT NULL,
  `id_rincian_unit` int(11) NOT NULL AUTO_INCREMENT,
  `id_sub_unit` int(11) NOT NULL,
  `alamat_sub_unit` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kota_sub_unit` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_jabatan_pimpinan_skpd` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_pimpinan_skpd` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_pimpinan_skpd` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_rincian_unit`) USING BTREE,
  UNIQUE KEY `tahun` (`tahun`,`id_sub_unit`) USING BTREE,
  KEY `id_sub_unit` (`id_sub_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_desa`
--

DROP TABLE IF EXISTS `ref_desa`;
CREATE TABLE IF NOT EXISTS `ref_desa` (
  `id_kecamatan` int(11) NOT NULL,
  `kd_desa` int(11) NOT NULL COMMENT 'kode desa / kelurahan',
  `id_desa` int(11) NOT NULL AUTO_INCREMENT,
  `status_desa` int(11) NOT NULL COMMENT '2 = Desa 1 = Kelurahan',
  `nama_desa` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_zona` int(11) NOT NULL,
  PRIMARY KEY (`id_desa`) USING BTREE,
  UNIQUE KEY `id_kecamatan` (`id_kecamatan`,`kd_desa`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_dokumen`
--

DROP TABLE IF EXISTS `ref_dokumen`;
CREATE TABLE IF NOT EXISTS `ref_dokumen` (
  `id_dokumen` int(255) NOT NULL,
  `nm_dokumen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_proses` int(11) NOT NULL DEFAULT '0' COMMENT '0 = rkpd 1 = renja 2 = rpjmd 3 = renstra',
  `urut_tampil` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_dokumen`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_dokumen`
--

INSERT INTO `ref_dokumen` (`id_dokumen`, `nm_dokumen`, `jenis_proses`, `urut_tampil`) VALUES
(0, 'RPJMD Rancangan Revisi', 1, 7),
(1, 'Rancangan Awal RPJMD', 1, 1),
(2, 'Rancangan RPJMD', 1, 2),
(3, 'Musrenbang RPJMD', 1, 3),
(4, 'Rancangan Akhir RPJMD', 1, 4),
(5, 'RPJMD Final', 1, 5),
(6, 'RPJMD Final Revisi', 1, 7),
(7, 'Rancangan Awal Renstra Perangkat Daerah', 2, 2),
(8, 'Rancangan Akhir Renstra Perangkat Daerah', 2, 6),
(9, 'Renstra Perangkat Daerah Final', 2, 7),
(10, 'Renstra Perangkat Daerah Revisi', 2, 9),
(11, 'Rancangan Awal RKPD', 3, 1),
(12, 'Rancangan RKPD', 3, 2),
(13, 'Rancangan Akhir RKPD', 3, 3),
(14, 'RKPD Final', 3, 4),
(15, 'Rancangan Awal Renja Perangkat Daerah', 4, 1),
(16, 'Rancangan Renja Perangkat Daerah', 4, 2),
(17, 'Renja Perangkat Daerah Final', 4, 3),
(18, 'Musrenbang RKPD Desa/Kelurahan', 5, 1),
(19, 'Musrenbang RKPD Kecamatan', 5, 2),
(20, 'Musrenbang RKPD Kabupaten/Kota', 5, 3),
(21, 'Musrenbang RKPD Propinsi', 5, 4),
(23, 'Renstra Rancangan Revisi', 2, 8),
(24, 'Renstra Teknokratik', 2, 1),
(25, 'Penyesuaian Musrenbang RPJMD', 2, 5),
(26, 'Rancangan Renstra Perangkat Daerah', 2, 4),
(27, 'Forum Perangkat Daerah/Lintas PD', 2, 3),
(28, 'RPJMD Teknokratik', 1, 0),
(50, 'PPAS Murni', 7, 1),
(51, 'PPAS Perubahan', 7, 2),
(52, 'RAPBD Murni', 7, 3),
(53, 'APBD Murni', 7, 4),
(54, 'APBD Pergeseran 1', 7, 5),
(55, 'RAPBD Perubahan 1', 7, 6),
(56, 'APBD Perubahan 1', 7, 7),
(57, 'APBD Pergeseran 2', 7, 8),
(58, 'Parameter', 0, 1),
(59, 'SSH', 0, 2),
(60, 'ASB', 0, 3);

-- --------------------------------------------------------

--
-- Table structure for table `ref_fungsi`
--

DROP TABLE IF EXISTS `ref_fungsi`;
CREATE TABLE IF NOT EXISTS `ref_fungsi` (
  `kd_fungsi` int(11) NOT NULL,
  `nm_fungsi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`kd_fungsi`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_fungsi`
--

INSERT INTO `ref_fungsi` (`kd_fungsi`, `nm_fungsi`) VALUES
(1, 'Pelayanan Umum'),
(2, 'Pertahanan'),
(3, 'Ketertiban dan Keamanan'),
(4, 'Ekonomi'),
(5, 'Lingkungan Hidup'),
(6, 'Perumahan dan Fasilitas Umum'),
(7, 'Kesehatan'),
(8, 'Pariwisata dan Budaya'),
(9, 'Agama'),
(10, 'Pendidikan'),
(11, 'Perlindungan Sosial');

-- --------------------------------------------------------

--
-- Table structure for table `ref_group`
--

DROP TABLE IF EXISTS `ref_group`;
CREATE TABLE IF NOT EXISTS `ref_group` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_roles` int(11) NOT NULL,
  `keterangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_group`
--

INSERT INTO `ref_group` (`id`, `name`, `id_roles`, `keterangan`) VALUES
(1, 'super_admin', 0, 'Group user yang memiliki kewenangan super admin'),
(2, 'Admin', 0, 'Administrator SKPD');

-- --------------------------------------------------------

--
-- Table structure for table `ref_indikator`
--

DROP TABLE IF EXISTS `ref_indikator`;
CREATE TABLE IF NOT EXISTS `ref_indikator` (
  `id_indikator` int(11) NOT NULL AUTO_INCREMENT,
  `type_indikator` int(11) NOT NULL DEFAULT '0' COMMENT '0 keluaran 1 hasil 2 dampak 3 masukan',
  `jenis_indikator` int(11) NOT NULL DEFAULT '0' COMMENT '1 positif 0 negatif',
  `sifat_indikator` int(11) NOT NULL DEFAULT '0' COMMENT '1 Incremental 2 Absolut  3 Komulatif',
  `nm_indikator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flag_iku` int(11) NOT NULL DEFAULT '0' COMMENT '0 non iku 1 iku pemda 2 iku skpd',
  `asal_indikator` int(11) DEFAULT '0' COMMENT '0 rpjmd 1 renstra 2 rkpd 3 renja',
  `metode_penghitungan` blob COMMENT 'file image ',
  `sumber_data_indikator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_satuan_output` int(255) DEFAULT NULL,
  `kualitas_indikator` int(255) NOT NULL DEFAULT '0' COMMENT '0 kualitas 1 kuantitas 2 persentase 3 rata-rata 4 rasio',
  `id_bidang` int(11) NOT NULL DEFAULT '0',
  `id_aspek` int(11) NOT NULL DEFAULT '0',
  `nama_file` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_indikator`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_jadwal`
--

DROP TABLE IF EXISTS `ref_jadwal`;
CREATE TABLE IF NOT EXISTS `ref_jadwal` (
  `tahun` int(11) NOT NULL,
  `id_proses` int(11) NOT NULL AUTO_INCREMENT,
  `id_langkah` int(11) NOT NULL,
  `jenis_proses` int(11) NOT NULL DEFAULT '0' COMMENT '0 = rkpd 1 = renja 2 = rpjmd 3 = renstra',
  `uraian_proses` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_mulai` date DEFAULT NULL,
  `tgl_akhir` date DEFAULT NULL,
  `status_proses` int(255) DEFAULT '0' COMMENT '0 = belum 1 = proses 2 = selesai 3 = kedaluwarsa 4 = batal',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_proses`) USING BTREE,
  UNIQUE KEY `idx_ref_jadwal` (`tahun`,`id_langkah`,`jenis_proses`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `ref_jadwal`
--

INSERT INTO `ref_jadwal` (`tahun`, `id_proses`, `id_langkah`, `jenis_proses`, `uraian_proses`, `tgl_mulai`, `tgl_akhir`, `status_proses`, `created_at`, `updated_at`) VALUES
(2019, 16, 15, 0, NULL, '2018-01-15', '2018-01-26', 1, '2018-04-10 21:29:06', '2018-04-10 21:29:06'),
(2020, 17, 15, 0, NULL, '2018-12-10', '2018-12-21', 2, '2019-02-01 05:41:08', '2019-02-01 05:42:31'),
(2020, 18, 16, 0, NULL, '2018-12-26', '2019-01-18', 2, '2019-02-01 05:42:55', '2019-02-01 05:42:55'),
(2020, 19, 19, 1, NULL, '2018-12-26', '2019-01-11', 2, '2019-02-01 05:43:27', '2019-02-01 05:43:27'),
(2020, 20, 22, 0, NULL, '2019-01-14', '2019-02-15', 1, '2019-02-01 05:43:54', '2019-02-01 05:43:54');

-- --------------------------------------------------------

--
-- Table structure for table `ref_jenis_lokasi`
--

DROP TABLE IF EXISTS `ref_jenis_lokasi`;
CREATE TABLE IF NOT EXISTS `ref_jenis_lokasi` (
  `id_jenis` int(11) NOT NULL,
  `nm_jenis` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_jenis`) USING BTREE,
  UNIQUE KEY `id_jenis` (`id_jenis`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_jenis_lokasi`
--

INSERT INTO `ref_jenis_lokasi` (`id_jenis`, `nm_jenis`) VALUES
(0, 'Kewilayahan'),
(1, 'Jalan Lokal Primer'),
(2, 'Jalan Kolektor Primer'),
(3, 'Jalan Sekunder'),
(4, 'Daerah Irigasi Teknis'),
(5, 'Daerah Irigasi Semi Teknis'),
(6, 'Daerah Irigasi Sederhana'),
(99, 'Lainnya');

-- --------------------------------------------------------

--
-- Table structure for table `ref_kabupaten`
--

DROP TABLE IF EXISTS `ref_kabupaten`;
CREATE TABLE IF NOT EXISTS `ref_kabupaten` (
  `id_pemda` int(11) NOT NULL,
  `id_prov` int(11) NOT NULL,
  `id_kab` int(11) NOT NULL AUTO_INCREMENT,
  `kd_kab` int(11) NOT NULL,
  `nama_kab_kota` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kab`) USING BTREE,
  UNIQUE KEY `id_pemda` (`id_pemda`,`id_prov`,`id_kab`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_kecamatan`
--

DROP TABLE IF EXISTS `ref_kecamatan`;
CREATE TABLE IF NOT EXISTS `ref_kecamatan` (
  `id_pemda` int(11) NOT NULL,
  `kd_kecamatan` int(11) NOT NULL,
  `id_kecamatan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_kecamatan` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kecamatan`) USING BTREE,
  UNIQUE KEY `id_kecamatan` (`id_pemda`,`kd_kecamatan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_kegiatan`
--

DROP TABLE IF EXISTS `ref_kegiatan`;
CREATE TABLE IF NOT EXISTS `ref_kegiatan` (
  `id_kegiatan` int(11) NOT NULL AUTO_INCREMENT,
  `id_program` int(11) NOT NULL,
  `kd_kegiatan` int(11) NOT NULL,
  `nm_kegiatan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kegiatan`) USING BTREE,
  UNIQUE KEY `idx_ref_kegiatan` (`id_program`,`kd_kegiatan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3982 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_kegiatan`
--

INSERT INTO `ref_kegiatan` (`id_kegiatan`, `id_program`, `kd_kegiatan`, `nm_kegiatan`) VALUES
(1, 1, 0, 'Non Kegiatan'),
(2, 2, 1, 'Penyediaan jasa surat menyurat'),
(3, 2, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(4, 2, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(5, 2, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(6, 2, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(7, 2, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(8, 2, 7, 'Penyediaan jasa administrasi keuangan'),
(9, 2, 8, 'Penyediaan jasa kebersihan kantor'),
(10, 2, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(11, 2, 10, 'Penyediaan alat tulis kantor'),
(12, 2, 11, 'Penyediaan barang cetakan dan penggandaan'),
(13, 2, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(14, 2, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(15, 2, 14, 'Penyediaan peralatan rumah tangga'),
(16, 2, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(17, 2, 16, 'Penyediaan bahan logistik kantor'),
(18, 2, 17, 'Penyediaan makanan dan minuman'),
(19, 2, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(20, 2, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(21, 3, 1, 'Pembangunan rumah jabatan'),
(22, 3, 2, 'Pembangunan rumah dinas'),
(23, 3, 3, 'Pembangunan gedung kantor'),
(24, 3, 4, 'Pengadaan mobil jabatan'),
(25, 3, 5, 'pengadaan Kendaraan dinas/operasional'),
(26, 3, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(27, 3, 7, 'Pengadaan perlengkapan gedung kantor'),
(28, 3, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(29, 3, 9, 'Pengadaan peralatan gedung kantor'),
(30, 3, 10, 'Pengadaan mebeleur'),
(31, 3, 11, 'Pengadaan ……'),
(32, 3, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(33, 3, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(34, 3, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(35, 3, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(36, 3, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(37, 3, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(38, 3, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(39, 3, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(40, 3, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(41, 3, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(42, 3, 30, 'Pemeliharaan rutin/berkala …..'),
(43, 3, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(44, 3, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(45, 3, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(46, 3, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(47, 3, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(48, 4, 1, 'Pengadaan mesin/kartu absensi'),
(49, 4, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(50, 4, 3, 'Pengadaan pakaian kerja lapangan'),
(51, 4, 4, 'Pengadaan pakaian KORPRI'),
(52, 4, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(53, 5, 1, 'Pemulangan pegawai yang pensiun'),
(54, 5, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(55, 5, 3, 'Pemindahan tugas PNS'),
(56, 6, 1, 'Pendidikan dan pelatihan formal'),
(57, 6, 2, 'Sosialisasi peraturan perundang-undangan'),
(58, 6, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(59, 7, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(60, 7, 2, 'Penyusunan pelaporan keuangan semesteran'),
(61, 7, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(62, 7, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(63, 8, 1, 'Pembangunan gedung sekolah'),
(64, 8, 2, 'Pembangunan rumah dinas kepala sekolah, guru, penjaga sekolah'),
(65, 8, 3, 'Penambahan ruang kelas sekolah'),
(66, 8, 4, 'Penambahan ruang guru sekolah'),
(67, 8, 5, 'Pembangunan ruang locker siswa'),
(68, 8, 6, 'Pembangunan sarana dan prasarana olahraga'),
(69, 8, 7, 'pembangunan sarana dan Prasarana bermain'),
(70, 8, 8, 'Pembangunan ruang serba guna/aula'),
(71, 8, 9, 'Pembangunan taman, lapangan upacara dan fasilitas parkir'),
(72, 8, 10, 'Pembangunan ruang unit kesehatan sekolah'),
(73, 8, 11, 'Pembangunan ruang ibadah'),
(74, 8, 12, 'Pembangunan perpustakaan sekolah'),
(75, 8, 13, 'Pembangunan jaringan instalasi listrik sekolah dan perlengkapannya'),
(76, 8, 14, 'Pembangunan sarana air bersih dan sanitary'),
(77, 8, 15, 'Pengadaan buku-buku dan alat tulis siswa'),
(78, 8, 16, 'Pengadan pakaian seragam sekolah'),
(79, 8, 17, 'Pengadaan pakaian olahraga'),
(80, 8, 18, 'Pengadaan alat praktik dan peraga siswa'),
(81, 8, 19, 'Pengadaan mebeluer sekolah'),
(82, 8, 20, 'Pengadaan perlengkapan sekolah'),
(83, 8, 21, 'Pengadaan alat rumah tangga sekolah'),
(84, 8, 22, 'Pengadaan sarana mobilitas sekolah'),
(85, 8, 23, 'Pemeliharaan rutin/berkala bangunan sekolah'),
(86, 8, 24, 'Pemeliharaan rutin/berkala rumah dinas kepala sekolah, guru, penjaga sekolah'),
(87, 8, 25, 'Pemeliharaan rutin/berkala ruang kelas sekolah'),
(88, 8, 26, 'Pemeliharaan rutin/berkala ruang guru sekolah'),
(89, 8, 27, 'Pemeliharaan rutin/berkala ruang locker siswa'),
(90, 8, 28, 'Pemeliharaan rutin/berkala sarana dan prasarana olahraga'),
(91, 8, 29, 'Pemeliharaan rutin/berkala sarana dan prasarana bermain'),
(92, 8, 30, 'Pemeliharaan rutin/berkala ruang serba guna/aula'),
(93, 8, 31, 'Pemeliharaan rutin/berkala taman, lapangan upacara dan fasilitas parkir'),
(94, 8, 32, 'Pemeliharaan rutin/berkala ruang unit kesehatan sekolah'),
(95, 8, 33, 'Pemeliharaan rutin/berkala ruang ibadah'),
(96, 8, 34, 'Pemeliharaan rutin/berkala perpustakaan sekolah'),
(97, 8, 35, 'Pemeliharaan rutin/berkala jaringan instalasi listrik sekolah dan perlengkapannya'),
(98, 8, 36, 'Pemeliharaan rutin/berkala sarana air bersih dan sanitary'),
(99, 8, 37, 'Pemeliharaan rutin/berkala alat praktik dan peraga siswa'),
(100, 8, 38, 'Pemeliharaan rutin/berkala mebeluer sekolah'),
(101, 8, 39, 'Pemeliharaan rutin/berkala perlengkapan sekolah'),
(102, 8, 40, 'Pemeliharaan rutin/berkala alat rumah tangga sekolah'),
(103, 8, 41, 'Pemeliharaan rutin/berkala sarana mobilitas sekolah'),
(104, 8, 42, 'Rehabilitasi sedang/berat bangunan sekolah'),
(105, 8, 43, 'Rehabilitasi sedang/berat rumah dinas kepala sekolah, guru, penjaga sekolah'),
(106, 8, 44, 'Rehabilitasi sedang/berat asrama siswa'),
(107, 8, 45, 'Rehabilitasi sedang/berat ruang kelas sekolah'),
(108, 8, 46, 'Rehabilitasi sedang/berat ruang guru sekolah'),
(109, 8, 47, 'Rehabilitasi sedang/berat ruang locker siswa'),
(110, 8, 48, 'Rehabilitasi sedang/berat sarana olahraga'),
(111, 8, 49, 'Rehabilitasi sedang/berat sarana bermain'),
(112, 8, 50, 'Rehabilitasi sedang/berat ruang serba guna/aula'),
(113, 8, 51, 'Rehabilitasi sedang/berat taman, lapangan upacara dan fasilitas parkir'),
(114, 8, 52, 'Rehabilitasi sedang/berat ruang unit kesehatan sekolah'),
(115, 8, 53, 'Rehabilitasi sedang/berat ruang ibadah'),
(116, 8, 54, 'Rehabilitasi sedang/berat perpustakaan sekolah'),
(117, 8, 55, 'Rehabilitasi sedang/berat jaringan instalasi sekolah dan perlengkapannya'),
(118, 8, 56, 'Rehabilitasi sedang/berat sarana air bersih dan sanitary'),
(119, 8, 57, 'Pelatihan kompetensi tenaga pendidik'),
(120, 8, 58, 'Pengembangan Pendidikan Anak Usia Dini'),
(121, 8, 59, 'Penyelenggaraan Pendidikan Anak Usia Dini'),
(122, 8, 60, 'Pengembangan data dan informasi Pendidikan Anak Usia Dini'),
(123, 8, 61, 'Penyusunan kebijakan Pendidikan Anak Usia Dini'),
(124, 8, 62, 'Pengembangan kurikulum, bahan ajar dan model pembelajaran Pendidikan Anak Usia Dini'),
(125, 8, 63, 'Penyelenggaraan koordinasi dan kerjasama Pendidikan Anak Usia Dini'),
(126, 8, 64, 'Perencanaan dan penyusunan program Pendidikan Anak Usia Dini'),
(127, 8, 65, 'Publikasi dan sosialisasi Pendidikan Anak Usia Dini'),
(128, 8, 66, 'Monitoring, evaluasi Pendidikan Anak Usia Dini'),
(129, 9, 1, 'Pembangunan gedung sekolah'),
(130, 9, 2, 'Pembangunan rumah dinas kepala sekolah, guru, penjaga sekolah'),
(131, 9, 3, 'Penambahan ruang kelas sekolah'),
(132, 9, 4, 'Penambahan ruang guru sekolah'),
(133, 9, 5, 'Pembangunan laboratorium dan ruang pratikum sekolah'),
(134, 9, 6, 'Pembangunan ruang locker siswa'),
(135, 9, 7, 'Pembangunan sarana dan prasarana olahraga'),
(136, 9, 8, 'Pembangunan ruang serba guna/aula'),
(137, 9, 9, 'Pembangunan taman, lapangan upacara dan fasilitas parkir'),
(138, 9, 10, 'Pembangunan ruang unit kesehatan sekolah'),
(139, 9, 11, 'Pembangunan ruang ibadah'),
(140, 9, 12, 'Pembangunan pepustakaan sekolah'),
(141, 9, 13, 'Pembangunan jaringan instalasi listrik sekolah dan perlengkapannya'),
(142, 9, 14, 'Pembanguna sarana air bersih dan sanitary'),
(143, 9, 15, 'Pengadaan buku-buku dan alat tulis siswa'),
(144, 9, 16, 'Pengadan pakaian seragam sekolah'),
(145, 9, 17, 'Pengadaan pakaian olahraga'),
(146, 9, 18, 'Pengadaan alat praktik dan peraga siswa'),
(147, 9, 19, 'Pengadaan mebeluer sekolah'),
(148, 9, 20, 'Pengadaan perlengkapan sekolah'),
(149, 9, 21, 'Pengadaan alat rumah tangga sekolah'),
(150, 9, 22, 'Pengadaan sarana mobilitas sekolah'),
(151, 9, 23, 'Pemeliharaan rutin/berkala bangunan sekolah'),
(152, 9, 24, 'Pemeliharaan rutin/berkala rumah dinas kepala sekolah, guru, penjaga sekolah'),
(153, 9, 25, 'Pemeliharaan rutin/berkala ruang kelas sekolah'),
(154, 9, 26, 'Pemeliharaan rutin/berkala ruang guru sekolah'),
(155, 9, 27, 'Pemeliharaan rutin/berkala ruang locker siswa'),
(156, 9, 28, 'Pemeliharaan rutin/berkala sarana dan prasarana olahraga'),
(157, 9, 29, 'Pemeliharaan rutin/berkala ruang serba guna/aula'),
(158, 9, 30, 'Pemeliharaan rutin/berkala taman, lapangan upacara dan fasilitas parkir'),
(159, 9, 31, 'Pemeliharaan rutin/berkala ruang unit kesehatan sekolah'),
(160, 9, 32, 'Pemeliharaan rutin/berkala ruang ibadah'),
(161, 9, 33, 'Pemeliharaan rutin/berkala perpustakaan sekolah'),
(162, 9, 34, 'Pemeliharaan rutin/berkala jaringan instalasi listrik sekolah dan perlengkapannya'),
(163, 9, 35, 'Pemeliharaan rutin/berkala sarana air bersih dan sanitary'),
(164, 9, 36, 'Pemeliharaan rutin/berkala alat praktik dan peraga siswa'),
(165, 9, 37, 'Pemeliharaan rutin/berkala mebeluer sekolah'),
(166, 9, 38, 'Pemeliharaan rutin/berkala perlengkapan sekolah'),
(167, 9, 39, 'Pemeliharaan rutin/berkala alat rumah tangga sekolah'),
(168, 9, 40, 'Pemeliharaan rutin/berkala sarana mobilitas sekolah'),
(169, 9, 41, 'Rehabilitasi sedang/berat bangunan sekolah'),
(170, 9, 42, 'Rehabilitasi sedang/berat rumah dinas kepala sekolah, guru, penjaga sekolah'),
(171, 9, 43, 'Rehabilitasi sedang/berat asrama siswa'),
(172, 9, 44, 'Rehabilitasi sedang/berat ruang kelas sekolah'),
(173, 9, 45, 'Rehabilitasi sedang/berat ruang guru sekolah'),
(174, 9, 46, 'Rehabilitasi sedang/berat laboratorium dan ruang pratikum sekolah'),
(175, 9, 47, 'Rehabilitasi sedang/berat sarana mobilitas sekolah'),
(176, 9, 48, 'Rehabilitasi sedang/berat ruang locker siswa'),
(177, 9, 49, 'Rehabilitasi sedang/berat sarana olahraga'),
(178, 9, 50, 'Rehabilitasi sedang/berat ruang serba guna/aula'),
(179, 9, 51, 'Rehabilitasi sedang/berat taman, lapangan upacara dan fasilitas parkir'),
(180, 9, 52, 'Rehabilitasi sedang/berat ruang unit kesehatan sekolah'),
(181, 9, 53, 'Rehabilitasi sedang/berat ruang ibadah'),
(182, 9, 54, 'Rehabilitasi sedang/berat perpustakaan sekolah'),
(183, 9, 55, 'Rehabilitasi sedang/berat jaringan instalasi sekolah dan perlengkapannya'),
(184, 9, 56, 'Rehabilitasi sedang/berat sarana air bersih dan sanitary'),
(185, 9, 57, 'Pelatihan kompetensi tenaga pendidik'),
(186, 9, 58, 'Pelatihan kompetensi siswa berprestasi'),
(187, 9, 59, 'Pelatihan Penyusunan kurikulum'),
(188, 9, 60, 'Pembinaan forum masyarakat peduli pendidikan'),
(189, 9, 61, 'Pembinaan SMP Terbuka'),
(190, 9, 62, 'Penambahan ruang kelas baru SMP/MTS/SMPLB'),
(191, 9, 63, 'Penyediaan Bantuan Operasional Sekolah (BOS) jenjang SD/MI/SDLB dan SMP/MTS serta pesantren Salafiyah dan Satuan Pendidikan Non-Islam Setara SD dan SMP'),
(192, 9, 64, 'Penyediaan Biaya Operasional Madrasah'),
(193, 9, 65, 'Penyediaan buku pelajaran untuk SD/MI/SDLB dan SMP/MTS'),
(194, 9, 66, 'Penyediaan dana pengembangansekolah Untuk SD/MI/SDLB dan SMP/MTS'),
(195, 9, 67, 'Penyelenggaraan Paket A Setara SD'),
(196, 9, 68, 'Penyelenggaraan Paket B Setara SMP'),
(197, 9, 69, 'Pembinaan kelembagaan dan manajemen sekolah dengan penerapan Manajemen Berbasis Sekolah (MBS) di Satuan Pendidikan Dasar'),
(198, 9, 70, 'Pembinaaan minat, bakat, dan kreativitas siswa'),
(199, 9, 71, 'Pengembangan Comprehensive Teaching And Learning (CTL)'),
(200, 9, 72, 'Pengembangan materi belajar mengajar dan metode pembelajaran dengan menggunakan teknologi informasi dan komunikasi'),
(201, 9, 73, 'Penyebarluasan dan sosialisasi berbagai informasi pendidikan dasar'),
(202, 9, 74, 'Penyediaan beasiswa retrieval untuk anak putus sekolah'),
(203, 9, 75, 'Penyediaan beasiswa transisi'),
(204, 9, 76, 'Penyelenggaraan akreditasi sekolah dasar'),
(205, 9, 77, 'Penyelenggaraan Multi-Grade Teaching di daerah terpencil'),
(206, 9, 78, 'Monitoring, evaluasi dan pelaporan'),
(207, 10, 1, 'Pembangunan gedung sekolah'),
(208, 10, 2, 'Pembangunan rumah dinas kepala sekolah, guru, penjaga sekolah'),
(209, 10, 3, 'Penambahan ruang kelas sekolah'),
(210, 10, 4, 'Penambahan ruang guru sekolah'),
(211, 10, 5, 'Pembangunan laboratorium dan ruang pratikum sekolah (labotatorium bahasa, komputer, IPA, IPS dan lain-lain)'),
(212, 10, 6, 'Pembangunan ruang locker siswa'),
(213, 10, 7, 'Pembangunan sarana dan prasarana olahraga'),
(214, 10, 8, 'Pembangunan ruang serba guna/aula'),
(215, 10, 9, 'Pembangunan taman, lapangan upacara dan fasilitas parkir'),
(216, 10, 10, 'Pembangunan ruang unit kesehatan sekolah'),
(217, 10, 11, 'Pembangunan ruang ibadah'),
(218, 10, 12, 'Pembangunan pepustakaan sekolah'),
(219, 10, 13, 'Pembangunan jaringan instalasi listrik sekolah dan perlengkapannya'),
(220, 10, 14, 'Pembanguna sarana air bersih dan sanitary'),
(221, 10, 15, 'Pengadaan buku-buku dan alat tulis siswa'),
(222, 10, 16, 'Pengadan pakaian seragam sekolah'),
(223, 10, 17, 'Pengadaan pakaian olahraga'),
(224, 10, 18, 'Pengadaan alat praktik dan peraga siswa'),
(225, 10, 19, 'Pengadaan mebeluer sekolah'),
(226, 10, 20, 'Pengadaan perlengkapan sekolah'),
(227, 10, 21, 'Pengadaan alat rumah tangga sekolah'),
(228, 10, 22, 'Pengadaan sarana mobilitas sekolah'),
(229, 10, 23, 'Pemeliharaan rutin/berkala bangunan sekolah'),
(230, 10, 24, 'Pemeliharaan rutin/berkala rumah dinas kepala sekolah, guru, penjaga sekolah'),
(231, 10, 25, 'Pemeliharaan rutin/berkala ruang kelas sekolah'),
(232, 10, 26, 'Pemeliharaan rutin/berkala ruang guru sekolah'),
(233, 10, 27, 'Pemeliharaan rutin/berkala ruang locker siswa'),
(234, 10, 28, 'Pemeliharaan rutin/berkala sarana dan prasarana olahraga'),
(235, 10, 29, 'Pemeliharaan rutin/berkala ruang serba guna/aula'),
(236, 10, 30, 'Pemeliharaan rutin/berkala taman, lapangan upacara dan fasilitas parkir'),
(237, 10, 31, 'Pemeliharaan rutin/berkala ruang unit kesehatan sekolah'),
(238, 10, 32, 'Pemeliharaan rutin/berkala ruang ibadah'),
(239, 10, 33, 'Pemeliharaan rutin/berkala perpustakaan sekolah'),
(240, 10, 34, 'Pemeliharaan rutin/berkala jaringan instalasi listrik sekolah dan perlengkapannya'),
(241, 10, 35, 'Pemeliharaan rutin/berkala sarana air bersih dan sanitary'),
(242, 10, 36, 'Pemeliharaan rutin/berkala alat praktik dan peraga siswa'),
(243, 10, 37, 'Pemeliharaan rutin/berkala mebeluer sekolah'),
(244, 10, 38, 'Pemeliharaan rutin/berkala perlengkapan sekolah'),
(245, 10, 39, 'Pemeliharaan rutin/berkala alat rumah tangga sekolah'),
(246, 10, 40, 'Pemeliharaan rutin/berkala sarana mobilitas sekolah'),
(247, 10, 41, 'Rehabilitasi sedang/berat bangunan sekolah'),
(248, 10, 42, 'Rehabilitasi sedang/berat rumah dinas kepala sekolah, guru, penjaga sekolah'),
(249, 10, 43, 'Rehabilitasi sedang/berat asrama siswa'),
(250, 10, 44, 'Rehabilitasi sedang/berat ruang kelas sekolah'),
(251, 10, 45, 'Rehabilitasi sedang/berat ruang guru sekolah'),
(252, 10, 46, 'Rehabilitasi sedang/berat laboratorium dan ruang pratikum sekolah'),
(253, 10, 47, 'Rehabilitasi sedang/berat ruang locker siswa'),
(254, 10, 48, 'Rehabilitasi sedang/berat sarana olahraga'),
(255, 10, 49, 'Rehabilitasi sedang/berat ruang serba guna/aula'),
(256, 10, 50, 'Rehabilitasi sedang/berat taman, lapangan upacara dan fasilitas parkir'),
(257, 10, 51, 'Rehabilitasi sedang/berat ruang unit kesehatan sekolah'),
(258, 10, 52, 'Rehabilitasi sedang/berat ruang ibadah'),
(259, 10, 53, 'Rehabilitasi sedang/berat perpustakaan sekolah'),
(260, 10, 54, 'Rehabilitasi sedang/berat jaringan instalasi sekolah dan perlengkapannya'),
(261, 10, 55, 'Rehabilitasi sedang/berat sarana air bersih dan sanitary'),
(262, 10, 56, 'Rehabilitasi sedang/berat sarana mobilitas sekolah'),
(263, 10, 57, 'Pelatihan kompetensi tenaga pendidik'),
(264, 10, 58, 'Pelatihan Penyusunan kurikulum'),
(265, 10, 59, 'Pembinaan forum masyarakat peduli pendidikan'),
(266, 10, 60, 'Pengembangan alternatif layanan pendidikan menengah untuk daerah-daerah perdesaan, terpencil dan kepulauan'),
(267, 10, 61, 'Penyediaan Bantuan Operasional Manajemen Mutu (BOMM)'),
(268, 10, 62, 'Penyediaan beasiswa bagi keluarga tidak mampu'),
(269, 10, 63, 'Penyelenggaraan paket C setara SMU'),
(270, 10, 64, 'Pembinaan kelembagaan dan manajemen sekolah dengan penerapan Manajemen Berbasis Sekolah (MBS)'),
(271, 10, 65, 'Pengembangan metode belajar dan mengajar dengan menggunakan teknologi informasi dan komunikasi'),
(272, 10, 66, 'Peningkatan Kerjasama dengan dunia usaha dan dunia indutri'),
(273, 10, 67, 'Penyebarluasan dan sosialisasi berbagai informasi pendidikan menengah'),
(274, 10, 68, 'Penyelenggaraan akreditasi sekolah menengah'),
(275, 10, 69, 'Monitoring, evaluasi dan pelaporan'),
(276, 11, 1, 'Pemberdayaan tenaga pendidik non formal'),
(277, 11, 2, 'Pemberian bantuan operasional pendidikan non formal'),
(278, 11, 3, 'Pembinaan pendidikan kursus dan kelembagaan'),
(279, 11, 4, 'Pengembangan pendidikan keaksaraan'),
(280, 11, 5, 'Pengembangan pendidikan kecakapan hidup'),
(281, 11, 6, 'Penyediaan sarana dan prasarana pendidikan non formal'),
(282, 11, 7, 'Pengembangan data dan informasi pendidikan non formal'),
(283, 11, 8, 'Pengembangan kebijakan pendidikan non formal'),
(284, 11, 9, 'Pengembangan kurikulum, bahan ajar dan model pembelajaran pendidikan non formal'),
(285, 11, 10, 'Pengembangan sertifikasi pendidikan non formal'),
(286, 11, 11, 'Perencanaan dan penyusunan program pendidikan non format'),
(287, 11, 12, 'Publikasi dan sosialisasi pendidikan non formal'),
(288, 11, 13, 'Monitoring, evaluasi dan pelaporan'),
(289, 12, 1, 'Pembangunan gedung sekolah'),
(290, 12, 2, 'Pembangunan rumah dinas kepala sekolah, guru, penjaga sekolah'),
(291, 12, 3, 'Penambahan ruang kelas sekolah'),
(292, 12, 4, 'Penambahan ruang guru sekolah'),
(293, 12, 5, 'Pembangunan laboratorium dan ruang pratikum sekolah (labotatorium bahasa, komputer, IPA, IPS dan lain-lain)'),
(294, 12, 6, 'Pembangunan ruang locker siswa'),
(295, 12, 7, 'Pembangunan sarana dan prasarana olahraga'),
(296, 12, 8, 'Pembangunan ruang serba guna/aula'),
(297, 12, 9, 'Pembangunan taman, lapangan upacara dan fasilitas parkir'),
(298, 12, 10, 'Pembangunan ruang unit kesehatan sekolah'),
(299, 12, 11, 'Pembangunan ruang ibadah'),
(300, 12, 12, 'Pembangunan pepustakaan sekolah'),
(301, 12, 13, 'Pembangunan jaringan instalasi listrik sekolah dan perlengkapannya'),
(302, 12, 14, 'Pembangunan sarana air bersih dan sanitary'),
(303, 12, 15, 'Pengadaan buku-buku dan alat tulis siswa'),
(304, 12, 16, 'Pengadan pakaian seragam sekolah dan kelengkapannya serta pakaian olahraga'),
(305, 12, 17, 'Pengadaan alat praktik dan peraga siswa'),
(306, 12, 18, 'Pengadaan mebeluer sekolah'),
(307, 12, 19, 'Pengadaan perlengkapan sekolah'),
(308, 12, 20, 'Pengadaan alat rumah tangga sekolah'),
(309, 12, 21, 'Pengadaan sarana mobilitas sekolah'),
(310, 12, 22, 'Pemeliharaan rutin/berkala bangunan sekolah'),
(311, 12, 23, 'Pemeliharaan rutin/berkala rumah dinas kepala sekolah, guru, penjaga sekolah'),
(312, 12, 24, 'Pemeliharaan rutin/berkala ruang kelas sekolah'),
(313, 12, 25, 'Pemeliharaan rutin/berkala ruang guru sekolah'),
(314, 12, 26, 'Pemeliharaan rutin/berkala ruang locker siswa'),
(315, 12, 27, 'Pemeliharaan rutin/berkala sarana dan prasarana olahraga'),
(316, 12, 28, 'Pemeliharaan rutin/berkala ruang serba guna/aula'),
(317, 12, 29, 'Pemeliharaan rutin/berkala taman, lapangan upacara dan fasilitas parkir'),
(318, 12, 30, 'Pemeliharaan rutin/berkala ruang unit kesehatan sekolah'),
(319, 12, 31, 'Pemeliharaan rutin/berkala ruang ibadah'),
(320, 12, 32, 'Pemeliharaan rutin/berkala perpustakaan sekolah'),
(321, 12, 33, 'Pemeliharaan rutin/berkala jaringan instalasi listrik sekolah dan perlengkapannya'),
(322, 12, 34, 'Pemeliharaan rutin/berkala sarana air bersih dan sanitary'),
(323, 12, 35, 'Pemeliharaan rutin/berkala buku-buku ajar'),
(324, 12, 36, 'Pemeliharaan rutin/berkala alat praktik dan peraga siswa'),
(325, 12, 37, 'Pemeliharaan rutin/berkala mebeluer sekolah'),
(326, 12, 38, 'Pemeliharaan rutin/berkala perlengkapan sekolah'),
(327, 12, 39, 'Pemeliharaan rutin/berkala alat rumah tangga sekolah'),
(328, 12, 40, 'Pemeliharaan rutin/berkala sarana mobilitas sekolah'),
(329, 12, 41, 'Rehabilitasi sedang/berat bangunan sekolah'),
(330, 12, 42, 'Rehabilitasi sedang/berat rumah dinas kepala sekolah, guru, penjaga sekolah'),
(331, 12, 43, 'Rehabilitasi sedang/berat asrama siswa'),
(332, 12, 44, 'Rehabilitasi sedang/berat ruang kelas sekolah'),
(333, 12, 45, 'Rehabilitasi sedang/berat ruang guru sekolah'),
(334, 12, 46, 'Rehabilitasi sedang/berat laboratorium dan ruang pratikum sekolah'),
(335, 12, 47, 'Rehabilitasi sedang/berat ruang locker siswa'),
(336, 12, 48, 'Rehabilitasi sedang/berat sarana olahraga'),
(337, 12, 49, 'Rehabilitasi sedang/berat ruang serba guna/aula'),
(338, 12, 50, 'Rehabilitasi sedang/berat taman, lapangan upacara dan fasilitas parkir'),
(339, 12, 51, 'Rehabilitasi sedang/berat ruang unit kesehatan sekolah'),
(340, 12, 52, 'Rehabilitasi sedang/berat ruang ibadah'),
(341, 12, 53, 'Rehabilitasi sedang/berat perpustakaan sekolah'),
(342, 12, 54, 'Rehabilitasi sedang/berat jaringan instalasi sekolah dan perlengkapannya'),
(343, 12, 55, 'Rehabilitasi sedang/berat sarana air bersih dan sanitary'),
(344, 12, 56, 'Pelatihan kompetensi tenaga pendidik'),
(345, 12, 57, 'Pelatihan Penyusunan kurikulum'),
(346, 12, 58, 'Pembinaan forum masyarakat peduli pendidikan'),
(347, 12, 59, 'Monitoring, evaluasi dan pelaporan'),
(348, 13, 1, 'Pelaksanaan Sertifikasi pendidik'),
(349, 13, 2, 'Pelaksanaan uji kompetensi pendidik dan tenaga kependidikan'),
(350, 13, 3, 'pelatihan bagi pendidik untuk memenuhi standar kompetensi'),
(351, 13, 4, 'Pembinaan Kelompok Kerja Guru (KKG)'),
(352, 13, 5, 'Pembinaan Lembaga Penjamin Mutu Pendidikan (LPMP)'),
(353, 13, 6, 'Pembinaan Pusat Pendidikan dan Pelatihan Guru (PPPG)'),
(354, 13, 7, 'Pendidikan lanjutan bagi pendidik untuk memenuhi standar kualifikasi'),
(355, 13, 8, 'Pengembangan mutu dan kualitas program pendidikan dan pelatihan bagi pendidik dan tenaga kependidikan'),
(356, 13, 9, 'Pengembangan sistem pendataan dan pemetaan pendidik dan tenaga kependidikan'),
(357, 13, 10, 'Pengembangan sistem penghargaan dan perlindungan terhadap profesi pendidik'),
(358, 13, 11, 'Pengembangan sistem perencanaan dan pengendalian program profesi pendidik dan tenaga kependidikan'),
(359, 13, 12, 'Monitoring, evaluasi dan pelaporan'),
(360, 14, 1, 'Pemasyarakatan minat dan kebiasaan membaca untuk mendorong terwujudnya masyarakat pembelajar'),
(361, 14, 2, 'Pengembangan minat dan budaya baca'),
(362, 14, 3, 'Supervisi, pembinaan dan stimulasi pada perpustakaan umum, perpustakaan khusus, perpustakaan sekolah dan perpustakaan masyarakat'),
(363, 14, 4, 'Pelaksanaan koordinasi pengembangan perpustakaan'),
(364, 14, 5, 'Penyediaan bantuan pengembangan perpustakaan dan minat baca di daerah'),
(365, 14, 6, 'Penyelenggaraan koordinasi pengembangan budaya baca'),
(366, 14, 7, 'Perencanaan dan penyusunan program budaya baca'),
(367, 14, 8, 'Publikasi dan sosialisasi minat dan budaya baca'),
(368, 14, 9, 'Penyediaan bahan pustaka perpustakaan umum daerah'),
(369, 14, 10, 'Monitoring, evaluasi dan pelaporan'),
(370, 15, 1, 'Pelaksanaan evaluasi hasil kinerja bidang pendidikan'),
(371, 15, 2, 'Pelaksanaan kerjasama secara kelembagaan di bidang pendidikan'),
(372, 15, 3, 'Pengendalian dan pengawasan penerapan azas efisiensi dan efektivitas penggunaan dana dekonsentrasi dan dana pembantuan'),
(373, 15, 4, 'Sosialisasi dan advokasi berbagai Peraturan Pemerintah di bidang pendidikan'),
(374, 15, 5, 'Pembinaan Dewan Pendidikan'),
(375, 15, 6, 'Pembinaan Komite Sekolah'),
(376, 15, 7, 'Penerapan sistem dan informasi manajemen pendidikan'),
(377, 15, 8, 'Penyelenggaraan pelatihan, seminar dan lokakarya, serta diskusi ilmiah tentang berbagai isu pendidikan'),
(378, 15, 9, 'Monitoring, evaluasi dan pelaporan'),
(379, 16, 0, 'Non Kegiatan'),
(380, 17, 1, 'Penyediaan jasa surat menyurat'),
(381, 17, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(382, 17, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(383, 17, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(384, 17, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(385, 17, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(386, 17, 7, 'Penyediaan jasa administrasi keuangan'),
(387, 17, 8, 'Penyediaan jasa kebersihan kantor'),
(388, 17, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(389, 17, 10, 'Penyediaan alat tulis kantor'),
(390, 17, 11, 'Penyediaan barang cetakan dan penggandaan'),
(391, 17, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(392, 17, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(393, 17, 14, 'Penyediaan peralatan rumah tangga'),
(394, 17, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(395, 17, 16, 'Penyediaan bahan logistik kantor'),
(396, 17, 17, 'Penyediaan makanan dan minuman'),
(397, 17, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(398, 17, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(399, 18, 1, 'Pembangunan rumah jabatan'),
(400, 18, 2, 'Pembangunan rumah dinas'),
(401, 18, 3, 'Pembangunan gedung kantor'),
(402, 18, 4, 'Pengadaan mobil jabatan'),
(403, 18, 5, 'pengadaan Kendaraan dinas/operasional'),
(404, 18, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(405, 18, 7, 'Pengadaan perlengkapan gedung kantor'),
(406, 18, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(407, 18, 9, 'Pengadaan peralatan gedung kantor'),
(408, 18, 10, 'Pengadaan mebeleur'),
(409, 18, 11, 'Pengadaan ……'),
(410, 18, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(411, 18, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(412, 18, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(413, 18, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(414, 18, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(415, 18, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(416, 18, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(417, 18, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(418, 18, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(419, 18, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(420, 18, 30, 'Pemeliharaan rutin/berkala …..'),
(421, 18, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(422, 18, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(423, 18, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(424, 18, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(425, 18, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(426, 19, 1, 'Pengadaan mesin/kartu absensi'),
(427, 19, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(428, 19, 3, 'Pengadaan pakaian kerja lapangan'),
(429, 19, 4, 'Pengadaan pakaian KORPRI'),
(430, 19, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(431, 20, 1, 'Pemulangan pegawai yang pensiun'),
(432, 20, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(433, 20, 3, 'Pemindahan tugas PNS'),
(434, 21, 1, 'Pendidikan dan pelatihan formal'),
(435, 21, 2, 'Sosialisasi peraturan perundang-undangan'),
(436, 21, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(437, 22, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(438, 22, 2, 'Penyusunan pelaporan keuangan semesteran'),
(439, 22, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(440, 22, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(441, 23, 1, 'Pengadaaan Obat dan Perbekalan Kesehatan'),
(442, 23, 2, 'Peningkatan pemerataan obat dan perbekalan kesehatan'),
(443, 23, 3, 'Peningkatan keterjangkauan harga obat dan perbekalan kesehatan terutama untuk penduduk miskin'),
(444, 23, 4, 'Peningkatan mutu pelayanan farmasi komunitas dan rumah sakit'),
(445, 23, 5, 'Peningkatan Mutu Penggunaan Obat dan Perbekalan Kesehatan'),
(446, 23, 6, 'Monitoring, evaluasi dan pelaporan'),
(447, 24, 1, 'Pelayanan kesehatan penduduk miskin di puskesmas jaringannya'),
(448, 24, 2, 'Pemeliharaan dan pemulihan kesehatan'),
(449, 24, 3, 'Pengadaan, peningkatan, dan perbaikan sarana dan prasarana puskesmas dan jaringannya'),
(450, 24, 4, 'Penyelenggaraan pencegahan dan pemberantasan penyakit menular dan wabah'),
(451, 24, 5, 'Perbaikan gizi masyarakat'),
(452, 24, 6, 'Revitalisasi sistem kesehatan'),
(453, 24, 7, 'Pelayanan kefarmasian dan alat kesehatan'),
(454, 24, 8, 'Pengadaan peralatan dan perbakalan kesehatan termasuk obat generik esensial'),
(455, 24, 9, 'Peningkatan kesehatan masyarakat'),
(456, 24, 11, 'Peningkatan pelayanan kesehatan bagi pengungsi korban bencana'),
(457, 24, 12, 'Peningkatan pelayanan dan penanggulangan masalah kesehatan'),
(458, 24, 13, 'Penyediaan biaya operasional dan pemeliharaan'),
(459, 24, 14, 'Penyelenggaraan penyehatan lingkungan'),
(460, 24, 15, 'Monitoring, evaluasi dan pelaporan'),
(461, 25, 1, 'Peningkatan pemberdayaan konsumen/masyarakat di bidang obat dan makanan'),
(462, 25, 2, 'Peningkatan pengawasan keaman pangan dan bahan berbahaya'),
(463, 25, 3, 'Peningkatan kapasitas laboratorium pengawasan obat dan makanan'),
(464, 25, 4, 'Peningkatan penyidikan dan penegakan hukum di bidang obat dan makanan'),
(465, 25, 5, 'Monitoring, evaluasi dan pelaporan'),
(466, 26, 1, 'Fasilitasi pengembangan dan penelitian teknologi produksi tanaman obat'),
(467, 26, 2, 'Pengembangan standarisasi tanaman obat bahan alam indonesia'),
(468, 26, 3, 'Peningkatan promosi obat bahan alam indonesia di dalam dan di luar negeri'),
(469, 26, 4, 'Pengembangan sistem dan layanan informasi terpadu'),
(470, 26, 5, 'Peningkatan kerjasama antar lembaga penelitian dan industri terkait'),
(471, 26, 6, 'Monitoring, evaluasi dan pelaporan'),
(472, 27, 1, 'Pengembangan media promosi dan informasi sadar hidup sehat'),
(473, 27, 2, 'Penyuluhan masyarakat pola hidup sehat'),
(474, 27, 3, 'Peningkatan pemanfaatan sarana kesehatan'),
(475, 27, 4, 'Peningkatan pendidikan tenaga penyuluh kesehatan'),
(476, 27, 5, 'Monitoring, evaluasi dan pelaporan'),
(477, 28, 1, 'Penyusunan peta informasi masyarakat kurang gizi'),
(478, 28, 2, 'Pemberian tambahan makanan dan vitamin'),
(479, 28, 3, 'Penanggulangan Kurang Energi Protein (KEP), Anemia Gizi Besi, Gangguan Akibat kurang Yodium (GAKY), Kurang Vitamin A, dan Kekurangan Zat Gizi Mikro Lainnya'),
(480, 28, 4, 'Pemberdayaan masyarakat untuk pencapaian keluarga sadar gizi'),
(481, 28, 5, 'Penanggulangan Gizi-Lebih'),
(482, 28, 6, 'Monitoring, evaluasi dan pelaporan'),
(483, 29, 1, 'Pengkajian pengembangan lingkungan sehat'),
(484, 29, 2, 'Penyuluhan menciptakan lingkungan sehat'),
(485, 29, 3, 'Sosialisasi kebijakan lingkungan sehat'),
(486, 29, 4, 'Monitoring, evaluasi dan pelaporan'),
(487, 30, 1, 'Penyemprotan/fogging sarang nyamuk'),
(488, 30, 2, 'Pengadaan alat fogging dan bahan-bahan fogging'),
(489, 30, 3, 'Pengadaan vaksin penyakit menular'),
(490, 30, 4, 'Pelayanan vaksinasi bagi balita dan anak sekolah'),
(491, 30, 5, 'Pelayanan pencegahan dan penanggulangan penyakit menular'),
(492, 30, 6, 'Pencegahan penularan penyakit Endemik/Epidemik'),
(493, 30, 7, 'Pemusnahan/karantina sumber penyebab penyakit menular'),
(494, 30, 8, 'Peningkatan imuniasasi'),
(495, 30, 9, 'Peningkatan survellance Epidemiologi dan penanggulangan wabah'),
(496, 30, 10, 'Peningkatam komunikasi, informasi dan edukasi (ide) pencegahan dan pemberantasan penyakit'),
(497, 30, 11, 'Monitoring, evaluasi dan pelaporan'),
(498, 31, 1, 'Penyusunan standar pelayanan kesehatan'),
(499, 31, 2, 'Evaluasi dan pengembangan standar pelayanan kesehatan'),
(500, 31, 3, 'Pembangunan dan pemutakhiran data dasar standar pelayanan kesehatan'),
(501, 31, 4, 'Penyusunan naskah akademis standar pelayanan kesehatan'),
(502, 31, 5, 'Penyusunan standar analisis belanja pelayanan kesehatan'),
(503, 31, 6, 'Monitoring, evaluasi dan pelaporan'),
(504, 32, 1, 'Pelayanan operasi katarak'),
(505, 32, 2, 'Pelayanan kesehatan THT'),
(506, 32, 3, 'Pelayanan operasi bibir sumbing'),
(507, 32, 4, 'Pelayanan sunatan masal'),
(508, 32, 5, 'Penanggulangan ISPA'),
(509, 32, 6, 'Penanggulangan penyakit cacingan'),
(510, 32, 7, 'Pelayanan kesehatan kulit dan kelamin'),
(511, 32, 8, 'Pelayanan kesehatan akibat gizi buruk/busung lapar'),
(512, 32, 9, 'pelayanan kesehatan akibat lumpuh layu'),
(513, 32, 10, 'Monitoring, evaluasi dan pelaporan'),
(514, 33, 1, 'Pembangunan puskesmas'),
(515, 33, 2, 'Pembangunan puskesmas pembantu'),
(516, 33, 3, 'Pengadaan puskesmas perairan'),
(517, 33, 4, 'Pengadaan puskesmas keliling'),
(518, 33, 5, 'Pembangunan Posyandu'),
(519, 33, 7, 'Pengadaan sarana dan prasarana puskesmas'),
(520, 33, 8, 'Pengadaan sarana dan prasarana puskesmas pembantu'),
(521, 33, 9, 'Pengadaan sarana dan prasarana puskesmas perairan'),
(522, 33, 10, 'Pengadaan sarana dan prasarana puskesmas keliling'),
(523, 33, 11, 'Pengadaan sarana dan prasarana posyandu'),
(524, 33, 12, 'Peningkatan puskesmas menjadi puskesmas rawat inap'),
(525, 33, 13, 'Peningkatan puskesmas pembantu menjadi puskesmas'),
(526, 33, 14, 'Pemeliharaan rutin/berkala sarana dan prasarana puskesmas'),
(527, 33, 15, 'Pemeliharaan rutin/berkala sarana dan prasarana puskesmas pembantu'),
(528, 33, 16, 'Pemeliharaan rutin/berkala sarana dan prasarana puskesmas perairan'),
(529, 33, 17, 'Pemeliharaan rutin/berkala sarana dan prasarana puskesmas keliling'),
(530, 33, 18, 'Pemeliharaan rutin/berkala sarana dan prasarana posyandu'),
(531, 33, 19, 'Peningkatan puskesmas menjadi puskesmas rawat inap'),
(532, 33, 20, 'Peningkatan puskesmas pembantu menjadi puskesmas'),
(533, 33, 21, 'Rehabilitasi sedang/berat puskesmas pembantu'),
(534, 33, 22, 'Rehabilitasi sedang/berat puskesmas perairan'),
(535, 33, 23, 'Monitoring, evaluasi dan pelaporan'),
(536, 34, 1, 'Pembangunan rumah sakit'),
(537, 34, 2, 'Pembangunan ruang poliklinik rumah sakit'),
(538, 34, 3, 'pembangunan gudang obat/apotik'),
(539, 34, 4, 'penambahan ruang rawat inap rumah sakit (VVIP, VIP, Kelas I, II dan III)'),
(540, 34, 5, 'Pengembangan ruang gawat darurat'),
(541, 34, 6, 'Pengembangan ruang ICU, ICCU, NICU'),
(542, 34, 7, 'Pengembangan ruang operasi'),
(543, 34, 8, 'Pengembangan ruang terapi'),
(544, 34, 9, 'Pengembangan ruang isolasi'),
(545, 34, 10, 'Pengembangan ruang bersalin'),
(546, 34, 11, 'Pengembangan ruang inkubator'),
(547, 34, 12, 'Pengembangan ruang bayi'),
(548, 34, 13, 'Pengembangan ruang rontgen'),
(549, 34, 14, 'Pengembangan ruang laboratorium rumah sakit'),
(550, 34, 15, 'Pembangunan kamar jenazah'),
(551, 34, 16, 'Pembangunan instalasi pengolahan limbah rumah sakit'),
(552, 34, 17, 'Rehabilitasi bangunan rumah sakit'),
(553, 34, 18, 'Pengadaan alat-alat kesehatan rumah sakit'),
(554, 34, 19, 'Pengadaan obat-obatan rumah sakit'),
(555, 34, 20, 'Pengadaan ambulance/mobil jenazah'),
(556, 34, 21, 'Pengadaan mebeuleur rumah sakit'),
(557, 34, 22, 'Pengadaan perlengkapan rumah tangga rumah sakit (dapur, ruang pasien, laundry, ruang tunggu dan lain-lain)'),
(558, 34, 23, 'Pengadaan bahan-bahan logistik rumah sakit'),
(559, 34, 24, 'Pengadaan pencetakan administrasi dan surat menyurat rumah sakit'),
(560, 34, 25, 'Pengembangan tipe rumah sakit'),
(561, 34, 26, 'Monitoring, evaluasi dan pelaporan'),
(562, 35, 1, 'Pemeliharaan rutin/berkala rumah sakit'),
(563, 35, 2, 'Pemeliharaan rutin/berkala ruang poliklinik rumah sakit'),
(564, 35, 3, 'Pemeliharaan rutin/berkala gudang obat/apotik'),
(565, 35, 4, 'Pemeliharaan rutin/berkala ruang rawat inap rumah sakit (VVIP, VIP, Kelas I, II dan III)'),
(566, 35, 5, 'Pemeliharaan rutin/berkala ruang gawat darurat'),
(567, 35, 6, 'Pemeliharaan rutin/berkala ruang ICU, ICCU, NICU'),
(568, 35, 7, 'Pemeliharaan rutin/berkala ruang operasi'),
(569, 35, 8, 'Pemeliharaan rutin/berkala ruang terapi'),
(570, 35, 9, 'Pemeliharaan rutin/berkala ruang isolasi'),
(571, 35, 10, 'Pemeliharaan rutin/berkala ruang bersalin'),
(572, 35, 11, 'Pemeliharaan rutin/berkala ruang inkubator'),
(573, 35, 12, 'Pemeliharaan rutin/berkala ruang bayi'),
(574, 35, 13, 'Pemeliharaan rutin/berkala ruang rontgen'),
(575, 35, 14, 'Pemeliharaan rutin/berkala ruang laboratorium rumah sakit'),
(576, 35, 15, 'Pemeliharaan rutin/berkala kamar jenazah'),
(577, 35, 16, 'Pemeliharaan rutin/berkala instalasi pengolahan limbah rumah sakit'),
(578, 35, 17, 'Pemeliharaan rutin/berkala alat-alat kesehatan rumah sakit'),
(579, 35, 18, 'Pemeliharaan rutin/berkala mobil ambulance/jenazah'),
(580, 35, 19, 'Pemeliharaan rutin/berkala mebeuleur rumah sakit'),
(581, 35, 20, 'Pemeliharaan rutin/berkala perlengkapan rumah sakit'),
(582, 35, 21, 'Monitoring, evaluasi dan pelaporan'),
(583, 36, 1, 'Kemitraan asuransi kesehatan masyarakat'),
(584, 36, 2, 'Kemitraan pencegahan dan pemberantasan penyakit menular'),
(585, 36, 3, 'Kemitraan pengolahan limbah rumah sakit'),
(586, 36, 4, 'Kemitraan alih teknologi kedokteran dan kesehatan'),
(587, 36, 5, 'Kemitraan peningkatan kualitas dokter dan paramedis'),
(588, 36, 6, 'Kemitraan pengobatan lanjutan bagi pasien rujukan'),
(589, 36, 7, 'Kemitraan pengobatan bagi pasien kurang mampu'),
(590, 36, 8, 'Monitoring, evaluasi dan pelaporan'),
(591, 37, 1, 'Penyuluhan kesehatan anak balita'),
(592, 37, 2, 'Immunisasi bagi anak balita'),
(593, 37, 3, 'Rekrutmen tenaga pelayanan kesehatan anak balita'),
(594, 37, 4, 'Pelatihan dan pendidikan perawatan anak balita'),
(595, 37, 5, 'Pembangunan sarana dan prasarana khusus pelayanan perawatan anak balita'),
(596, 37, 6, 'Pembangunan panti asuhan anak terlantar balita'),
(597, 37, 7, 'Monitoring, evaluasi dan pelaporan'),
(598, 38, 1, 'Pelayanan pemeliharaan kesehatan'),
(599, 38, 2, 'Rekrutmen tenaga perawat kesehatan'),
(600, 38, 3, 'Pendidikan dan pelatihan perawatan kesehatan'),
(601, 38, 4, 'Pembangunan pusat-pusat pelayanan kesehatan'),
(602, 38, 5, 'Pembangunan panti asuhan'),
(603, 38, 6, 'Pelayanan kesehatan'),
(604, 38, 7, 'Monitoring, evaluasi dan pelaporan'),
(605, 39, 1, 'Pengawasan keamanan dan kesehatan makanan hasil industri'),
(606, 39, 2, 'Pengawasan dan pengendalian keamanan dan kesehatan makanan hasil produksi rumah tangga'),
(607, 39, 3, 'Pengawasan dan pengendalian keamanan dan kesehatan makanan restaurant'),
(608, 39, 4, 'Monitoring, evaluasi dan pelaporan'),
(609, 40, 1, 'Penyuluhan kesehatan bagi ibu hamil dari keluarga kurang mampu'),
(610, 40, 2, 'Perawatan secara berkala bagi ibu hamil bagi keluarga kurang mampu'),
(611, 40, 3, 'Pertolongan persalinan bagi ibu dari keluarga kurang mampu'),
(612, 41, 0, 'Non Kegiatan'),
(613, 42, 1, 'Penyediaan jasa surat menyurat'),
(614, 42, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(615, 42, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(616, 42, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(617, 42, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(618, 42, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(619, 42, 7, 'Penyediaan jasa administrasi keuangan'),
(620, 42, 8, 'Penyediaan jasa kebersihan kantor'),
(621, 42, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(622, 42, 10, 'Penyediaan alat tulis kantor'),
(623, 42, 11, 'Penyediaan barang cetakan dan penggandaan'),
(624, 42, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(625, 42, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(626, 42, 14, 'Penyediaan peralatan rumah tangga'),
(627, 42, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(628, 42, 16, 'Penyediaan bahan logistik kantor'),
(629, 42, 17, 'Penyediaan makanan dan minuman'),
(630, 42, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(631, 42, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(632, 43, 1, 'Pembangunan rumah jabatan'),
(633, 43, 2, 'Pembangunan rumah dinas'),
(634, 43, 3, 'Pembangunan gedung kantor'),
(635, 43, 4, 'Pengadaan mobil jabatan'),
(636, 43, 5, 'pengadaan Kendaraan dinas/operasional'),
(637, 43, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(638, 43, 7, 'Pengadaan perlengkapan gedung kantor'),
(639, 43, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(640, 43, 9, 'Pengadaan peralatan gedung kantor'),
(641, 43, 10, 'Pengadaan mebeleur'),
(642, 43, 11, 'Pengadaan ……'),
(643, 43, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(644, 43, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(645, 43, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(646, 43, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(647, 43, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(648, 43, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(649, 43, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(650, 43, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(651, 43, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(652, 43, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(653, 43, 30, 'Pemeliharaan rutin/berkala …..'),
(654, 43, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(655, 43, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(656, 43, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(657, 43, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(658, 43, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(659, 44, 1, 'Pengadaan mesin/kartu absensi'),
(660, 44, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(661, 44, 3, 'Pengadaan pakaian kerja lapangan'),
(662, 44, 4, 'Pengadaan pakaian KORPRI'),
(663, 44, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(664, 45, 1, 'Pemulangan pegawai yang pensiun'),
(665, 45, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(666, 45, 3, 'Pemindahan tugas PNS'),
(667, 46, 1, 'Pendidikan dan pelatihan formal'),
(668, 46, 2, 'Sosialisasi peraturan perundang-undangan'),
(669, 46, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(670, 47, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(671, 47, 2, 'Penyusunan pelaporan keuangan semesteran'),
(672, 47, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(673, 47, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(674, 48, 1, 'Perencanaan pembangunan jalan'),
(675, 48, 2, 'Survei kontur jalan dan jembatan'),
(676, 48, 3, 'Pembangunan jalan'),
(677, 48, 4, 'Perencanaan pembangunan jembatan'),
(678, 48, 5, 'Pembangunan jembatan'),
(679, 48, 6, 'Monitoring, evaluasi dan pelaporan'),
(680, 49, 1, 'Perencanaan pembangunan saluran drainase/gorong-gorong'),
(681, 49, 2, 'Survei kontur saluran drainase/gorong-gorong'),
(682, 49, 3, 'Pembangunan saluran drainase/gorong-gorong'),
(683, 49, 4, 'Monitoring, evaluasi dan pelaporan'),
(684, 50, 1, 'Perencanaan turap/talud/bronjong'),
(685, 50, 2, 'Survei kemiringan lereng turap/talud/bronjong'),
(686, 50, 3, 'Pembangunan turap/talud/bronjong'),
(687, 50, 4, 'Monitoring, evaluasi dan pelaporan'),
(688, 51, 1, 'Perencanaan rehabilitasi/pemeliharaan jalan'),
(689, 51, 2, 'Perencanaan rehabilitasi/pemeliharaan jembatan'),
(690, 51, 3, 'Rehabilitasi/pemeliharaan jalan'),
(691, 51, 4, 'Rehabilitasi/pemeliharaan jembatan'),
(692, 51, 5, 'Monitoring, evaluasi dan pelaporan'),
(693, 52, 1, 'Perencanaan rehabilitasi/pemeliharaan talud/bronjong'),
(694, 52, 2, 'Perencanaan rehabilitasi/pemeliharaan talud/bronjong'),
(695, 52, 3, 'Monitoring, evaluasi dan pelaporan'),
(696, 53, 1, 'Inspeksi kondisi jalan'),
(697, 53, 2, 'Inspeksi kondisi jembatan'),
(698, 53, 3, 'Evaluasi dan pelaporan'),
(699, 54, 1, 'Rehabilitasi jalan dalam kondisi tanggap darurat'),
(700, 54, 2, 'Rehabilitasi jembatan dalam kondisi tanggap darurat'),
(701, 54, 3, 'Monitoring, evaluasi dan pelaporan'),
(702, 55, 1, 'Penyusunan sistem informasi/data base jalan'),
(703, 55, 2, 'Penyusunan sistem informasi/data base jembatan'),
(704, 55, 3, 'Monitoring, evaluasi dan pelaporan'),
(705, 56, 1, 'Pembangunan gedung balai latihan kebinamargaan'),
(706, 56, 2, 'Pembangunan gedung workshop'),
(707, 56, 3, 'Pembangunan laboratorium kebinamargaan'),
(708, 56, 4, 'Pengadaan alat-alat berat'),
(709, 56, 5, 'Pengadaan peralatan dan perlengkapan bengkel alat-alat berat'),
(710, 56, 6, 'Pengadaan alat-alat ukur dan bahan laboratorium kebinamargaan'),
(711, 56, 7, 'Rehabilitasi/pemeliharaan gedung balai latihan kebinamargaan'),
(712, 56, 8, 'Rehabilitasi/pemeliharaan gedung workshop'),
(713, 56, 9, 'Rehabilitasi/pemeliharaan laboratorium kebinamargaan'),
(714, 56, 10, 'Rehabilitasi/pemeliharaan alat-alat berat'),
(715, 56, 11, 'Rehabilitasi/pemeliharaan peralatan dan perlengkapan bengkel alat-alat berat'),
(716, 56, 12, 'Rehabilitasi/pemeliharaan alat-alat ukur dan bahan laboratorium kebinamargaan'),
(717, 56, 13, 'Monitoring, evaluasi dan pelaporan'),
(718, 57, 1, 'Perencanaan pembangunan jaringan irigasi'),
(719, 57, 2, 'Perencanaan pembangunan jaringan air bersih/air minum'),
(720, 57, 3, 'Perencanaan pembangunan reservoir'),
(721, 57, 4, 'Perencanaan pembangunan pintu air'),
(722, 57, 5, 'Perencanaan normalisasi saluran sungai'),
(723, 57, 6, 'Pembangunan jaringan air bersih/air minum'),
(724, 57, 7, 'Pembangunan reservoir'),
(725, 57, 8, 'Pembangunan pintu air'),
(726, 57, 9, 'Pelaksanaan normalisasi saluran sungai'),
(727, 57, 10, 'Rehabilitasi/pemeliharaan jaringan irigasi'),
(728, 57, 11, 'Rehabilitasi/pemeliharaan jaringan air bersih/air minum'),
(729, 57, 12, 'Rehabilitasi/pemeliharaan reservoir'),
(730, 57, 13, 'Rehabilitasi/pemeliharaan pintu air'),
(731, 57, 14, 'Rehabilitasi/pemeliharaan normalisasi saluran sungai'),
(732, 57, 15, 'Optimalisasi fungsi jaringan irigasi yang telah dibangun'),
(733, 57, 16, 'Pemberdayaan petani pemakai air'),
(734, 57, 17, 'Monitoring, evaluasi dan pelaporan'),
(735, 58, 1, 'Pembangunan prasarana pengambilan dan saluran pembawa'),
(736, 58, 2, 'Rehabilitasi prasarana pengambilan dan saluran pembawa'),
(737, 58, 3, 'Pemeliharaan prasarana pengambilan dan saluran pembawa'),
(738, 58, 4, 'Pembangunan sumur-sumur air tanah'),
(739, 58, 5, 'Peningkatan partisipasi masyarakat dalam pengelolaan air'),
(740, 58, 6, 'Peningkatan distribusi penyediaan air baku'),
(741, 58, 7, 'Monitoring, evaluasi dan pelaporan'),
(742, 59, 1, 'Pembangunan embung, dan bangunan penampung air lainnya'),
(743, 59, 2, 'Pemeliharaan dan rehabilitasi embung, dan bangunan penampung air lainnya'),
(744, 59, 3, 'Rehabilitasi kawasan kritis daerah tangkapan sungai dan danau'),
(745, 59, 4, 'Rehabilitasi kawasan lindung daerah tangkapan sungai dan danau'),
(746, 59, 5, 'Peningkatan partisipasi masyarakat dalam pengelolaan sungai, danau, dan sumber daya air lainnya'),
(747, 59, 6, 'Peningkatan konservasi air tanah'),
(748, 59, 7, 'Monitoring, evaluasi dan pelaporan'),
(749, 60, 1, 'Penyediaan prasarana dan sarana air minum bagi masyarakat berpenghasilan rendah'),
(750, 60, 2, 'Penyediaan prasarana dan sarana air limbah'),
(751, 60, 3, 'Pengembangan teknologi pengolahan air minum dan air limbah'),
(752, 60, 4, 'Fasilitasi pembinaan teknik pengolahan air limbah'),
(753, 60, 5, 'Fasilitasi pembinaan teknik pengolahan air minum'),
(754, 60, 6, 'Pengembangan sistem distribusi air minum'),
(755, 60, 7, 'Rehabilitasi/pemeliharaan sarana dan prasarana air minum'),
(756, 60, 8, 'Rehabilitasi/pemeliharaan sarana dan prasarana air limbah'),
(757, 60, 9, 'Monitoring, evaluasi dan pelaporan'),
(758, 61, 1, 'Pembangunan reservoir pengendali banjir'),
(759, 61, 2, 'Rehabilitasi dan pemeliharaan reservoir pengendali banjir'),
(760, 61, 3, 'Rehabilitasi dan pemeliharaan bantaran dan tanggul sungai'),
(761, 61, 4, 'Pengembangan pengelolaan daerah rawa dalam rangka pengendalian banjir'),
(762, 61, 5, 'Peningkatan partisipasi masyarakat dalam penanggulangan banjir'),
(763, 61, 6, 'Mengendalikan banjir pada daerah tangkapan air dan badan-badan sungai'),
(764, 61, 7, 'Peningkatan pembersihan dan pengerukan sungai/kali'),
(765, 61, 8, 'Peningkatan pembangunan pusat-pusat pengendali banjir'),
(766, 61, 9, 'Pembangunan prasarana pengaman pantai'),
(767, 61, 10, 'Pembangunan tanggul pemecah ombak'),
(768, 61, 11, 'Monitoring, evaluasi dan pelaporan'),
(769, 62, 1, 'Perencanaan pengembangan infrastruktur'),
(770, 62, 2, 'Pembangunan/peningkatan infrastruktur'),
(771, 62, 3, 'Monitoring, evaluasi dan pelaporan'),
(772, 63, 1, 'Penataan lingkungan pemukiman penduduk perdesaan'),
(773, 63, 2, 'Pembangunan jalan dan jembatan perdesaan'),
(774, 63, 3, 'Pembangunan sarana dan prasarana air bersih perdesaan'),
(775, 63, 4, 'Pembangunan pasar perdesaan'),
(776, 63, 5, 'Rehabilitasi/pemeliharaan jalan dan jembatan perdesaan'),
(777, 63, 6, 'Rehabilitasi/pemeliharaan sarana dan prasarana air bersih perdesaan'),
(778, 63, 7, 'Rehabilitasi/pemeliharaan pasar perdesaan'),
(779, 63, 8, 'Monitoring, evaluasi dan pelaporan'),
(780, 64, 1, 'Penyusunan kebijakan tentang penyusunan rencana tata ruang'),
(781, 64, 2, 'Penetapan kebijakan tentang RDTRK, RTRK, dan RTBL'),
(782, 64, 3, 'Sosialisasi peraturan perundang-undangan tentang rencana tata ruang'),
(783, 64, 4, 'Penyusunan Rencana Tata Ruang Wilayah'),
(784, 64, 5, 'Penyusunan Rencana Detail Tata Ruang Kawasan'),
(785, 64, 6, 'Penyusunan Rencana Teknis Ruang Kawasan'),
(786, 64, 7, 'Penyusunan Rencana tata Bangunan dan Lingkungan'),
(787, 64, 8, 'Penyusunan rancangan peraturan daerah tentang RTRW'),
(788, 64, 9, 'Fasilitasi peningkatan peran serta masyarakat dalam perencanaan tata ruang'),
(789, 64, 10, 'Rapat koordinasi tentang rencana tata ruang'),
(790, 64, 11, 'Revisi rencana tata ruang'),
(791, 64, 12, 'Pelatihan aparat dalam perencanaan tata ruang'),
(792, 64, 13, 'Survey dan pemetaan'),
(793, 64, 14, 'Koordinasi dan fasilitasi penyusunan rencana tata ruang lintas kabupaten/kota'),
(794, 64, 15, 'Monitoring, evaluasi dan pelaporan'),
(795, 65, 1, 'Penyusunan kebijakan peizinan pemanfaatan ruang'),
(796, 65, 2, 'Penyusunan norma, standar, dan kriteria pemanfaatan ruang'),
(797, 65, 3, 'Penyusunan kebijakan pengendalian pemanfaatan ruang'),
(798, 65, 4, 'Fasilitasi peningkatan peran serta masyarakat dalam pemanfaatan ruang'),
(799, 65, 5, 'Survey dan pemetaan'),
(800, 65, 6, 'Pelatihan aparat dalam pemanfaatan ruang'),
(801, 65, 7, 'Sosialisasi kebijakan, norma, standar, prosedur dan manual pemanfaatan ruang'),
(802, 65, 8, 'Koordinasi dan fasilitasi penyusunan pemanfaatan ruang lintas kabupaten/kota'),
(803, 65, 9, 'Monitoring, evaluasi dan pelaporan'),
(804, 66, 1, 'Penyusunan kebijakan pengendalian pemanfaatan ruang'),
(805, 66, 2, 'Penyusunan prosedur dan manual pengendalian pemanfaatan ruang'),
(806, 66, 3, 'Fasilitasi peningkatan peran serta masyarakat dalam pengendalian pemanfaatan ruang'),
(807, 66, 4, 'Pelatihan aparat dalam pengendalian pemanfaatan ruang');
INSERT INTO `ref_kegiatan` (`id_kegiatan`, `id_program`, `kd_kegiatan`, `nm_kegiatan`) VALUES
(808, 66, 5, 'Pengawasan pemanfaatan ruang'),
(809, 66, 6, 'Koordinasi dan fasilitasi pengendalian pemanfaatan ruang lintas kabupaten/kota'),
(810, 66, 7, 'Sosialisasi kebijakan pengendalian pemanfaatan ruang'),
(811, 66, 8, 'Monitoring, evaluasi dan pelaporan'),
(812, 67, 0, 'Non Kegiatan'),
(813, 68, 1, 'Penyediaan jasa surat menyurat'),
(814, 68, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(815, 68, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(816, 68, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(817, 68, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(818, 68, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(819, 68, 7, 'Penyediaan jasa administrasi keuangan'),
(820, 68, 8, 'Penyediaan jasa kebersihan kantor'),
(821, 68, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(822, 68, 10, 'Penyediaan alat tulis kantor'),
(823, 68, 11, 'Penyediaan barang cetakan dan penggandaan'),
(824, 68, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(825, 68, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(826, 68, 14, 'Penyediaan peralatan rumah tangga'),
(827, 68, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(828, 68, 16, 'Penyediaan bahan logistik kantor'),
(829, 68, 17, 'Penyediaan makanan dan minuman'),
(830, 68, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(831, 68, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(832, 69, 1, 'Pembangunan rumah jabatan'),
(833, 69, 2, 'Pembangunan rumah dinas'),
(834, 69, 3, 'Pembangunan gedung kantor'),
(835, 69, 4, 'Pengadaan mobil jabatan'),
(836, 69, 5, 'pengadaan Kendaraan dinas/operasional'),
(837, 69, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(838, 69, 7, 'Pengadaan perlengkapan gedung kantor'),
(839, 69, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(840, 69, 9, 'Pengadaan peralatan gedung kantor'),
(841, 69, 10, 'Pengadaan mebeleur'),
(842, 69, 11, 'Pengadaan ……'),
(843, 69, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(844, 69, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(845, 69, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(846, 69, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(847, 69, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(848, 69, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(849, 69, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(850, 69, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(851, 69, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(852, 69, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(853, 69, 30, 'Pemeliharaan rutin/berkala …..'),
(854, 69, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(855, 69, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(856, 69, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(857, 69, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(858, 69, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(859, 70, 1, 'Pengadaan mesin/kartu absensi'),
(860, 70, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(861, 70, 3, 'Pengadaan pakaian kerja lapangan'),
(862, 70, 4, 'Pengadaan pakaian KORPRI'),
(863, 70, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(864, 71, 1, 'Pemulangan pegawai yang pensiun'),
(865, 71, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(866, 71, 3, 'Pemindahan tugas PNS'),
(867, 72, 1, 'Pendidikan dan pelatihan formal'),
(868, 72, 2, 'Sosialisasi peraturan perundang-undangan'),
(869, 72, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(870, 73, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(871, 73, 2, 'Penyusunan pelaporan keuangan semesteran'),
(872, 73, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(873, 73, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(874, 74, 1, 'Penetapan kebijakan, strategi, dan program perumahan'),
(875, 74, 2, 'Penyusunan Norma, Standar, Pedoman, dan Manual (NSPM)'),
(876, 74, 3, 'Koordinasi penyelenggaraan pengembangan perumahan'),
(877, 74, 4, 'Sosialisasi peraturan perundang-undangan di bidang perumahan'),
(878, 74, 5, 'Koordinasi pembangunan perumahan dengan lembaga/badan usaha'),
(879, 74, 6, 'Fasilitasi dan stimulasi pembangunan perumahan masyarakat kurang mampu'),
(880, 74, 7, 'Pembangunan sarana dan prasarana rumah sederhana sehat'),
(881, 74, 8, 'Monitoring, evaluasi dan pelaporan'),
(882, 75, 1, 'Koordinasi pengawasan dan pengendalian pelaksanaan kebijakan tentang pembangunan perumahan'),
(883, 75, 2, 'Penyediaan sarana air bersih dan sanitasi dasar terutama bagi masyarakat miskin'),
(884, 75, 3, 'Penyuluhan dan pengawasan kualitas lingkungan sehat perumahan'),
(885, 75, 4, 'Pengendalian dampak resiko pencemaran lingkungan'),
(886, 75, 5, 'Penetapan kebijakan dan strategi penyelenggaraan keserasian kawasan dan lingkungan hunian berimbang'),
(887, 75, 6, 'Monitoring, evaluasi dan pelaporan'),
(888, 76, 1, 'Fasilitasi pemberian kredit mikro untuk pembangunan dan perbaikan perumahan'),
(889, 76, 2, 'Fasilitasi pembangunan prasarana dan sarana dasar pemukiman berbasis masyarakat'),
(890, 76, 3, 'Peningkatan peran serta masyarakat dalam pelestarian lingkungan perumahan'),
(891, 76, 4, 'Peningkatan sistem pemberian kredit pemilikan rumah'),
(892, 76, 5, 'Sosialisasi dan fasilitasi jaminan kepastian hukum dan perlindungan hukum'),
(893, 76, 6, 'Koordinasi pengawasan dan pengendalian pelaksanaan peraturan perundang-undangan bidang perumahan'),
(894, 76, 7, 'Monitoring, evaluasi dan pelaporan'),
(895, 77, 1, 'Fasilitasi dan stimulasi rehabilitasi rumah akibat bencana alam'),
(896, 77, 2, 'Fasilitasi dan stimulasi rehabilitasi rumah akibat bencana sosial'),
(897, 77, 3, 'Monitoring, evaluasi dan pelaporan'),
(898, 78, 1, 'Penyusunan norma, standar, prosedur, dan manual pencegahan bahaya kebakaran'),
(899, 78, 2, 'Sosialisasi norma, standar, prosedur, dan manual pencegahan bahaya kebakaran'),
(900, 78, 3, 'Koordinasi peijinan pemanfaatan gedung'),
(901, 78, 4, 'Pengawasan pelaksanaan kebijakan pencegahan kebakaran'),
(902, 78, 5, 'Kegiatan pendidikan dan pelatihan pertolongan dan pencegahan kebakaran'),
(903, 78, 6, 'Kegiatan rekrutmen tenaga sukarela pertolongan bencana kebakaran'),
(904, 78, 7, 'Kegiatan penyuluhan pencegahan bencana kebakaran'),
(905, 78, 8, 'Pengadaan sarana dan prasarana pencegahan bahaya kebakaran'),
(906, 78, 9, 'Pemeliharaan sarana dan prasarana pencegahan bahaya kebakaran'),
(907, 78, 10, 'Rehabilitasi sarana dan prasarana pencegahan bahaya kebakaran'),
(908, 78, 11, 'Kegiatan pencegahan dan pengendalian bahaya kebakaran'),
(909, 78, 12, 'Peningkatan pelayanan penanggulangan bahaya kebakaran'),
(910, 78, 13, 'Monitoring, evaluasi dan pelaporan'),
(911, 79, 1, 'Penyusunan kebijakan, norma, standar, prosedur dan manual pengelolaan areal pemakaman'),
(912, 79, 2, 'Pengumpulan dan analisis data base jumlah jiwa yang meninggal'),
(913, 79, 3, 'Koordinasi pengelolaan areal pemakaman'),
(914, 79, 4, 'Koordinasi penataan areal pemakaman'),
(915, 79, 5, 'Pemberian perijinan pemakaman'),
(916, 79, 6, 'Pembangunan sarana dan prasarana pemakaman'),
(917, 79, 7, 'Pemeliharaan sarana dan prasarana pemakaman'),
(918, 79, 8, 'Monitoring, evaluasi dan pelaporan'),
(919, 80, 0, 'Non Kegiatan'),
(920, 81, 1, 'Penyediaan jasa surat menyurat'),
(921, 81, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(922, 81, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(923, 81, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(924, 81, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(925, 81, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(926, 81, 7, 'Penyediaan jasa administrasi keuangan'),
(927, 81, 8, 'Penyediaan jasa kebersihan kantor'),
(928, 81, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(929, 81, 10, 'Penyediaan alat tulis kantor'),
(930, 81, 11, 'Penyediaan barang cetakan dan penggandaan'),
(931, 81, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(932, 81, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(933, 81, 14, 'Penyediaan peralatan rumah tangga'),
(934, 81, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(935, 81, 16, 'Penyediaan bahan logistik kantor'),
(936, 81, 17, 'Penyediaan makanan dan minuman'),
(937, 81, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(938, 81, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(939, 82, 1, 'Pembangunan rumah jabatan'),
(940, 82, 2, 'Pembangunan rumah dinas'),
(941, 82, 3, 'Pembangunan gedung kantor'),
(942, 82, 4, 'Pengadaan mobil jabatan'),
(943, 82, 5, 'pengadaan Kendaraan dinas/operasional'),
(944, 82, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(945, 82, 7, 'Pengadaan perlengkapan gedung kantor'),
(946, 82, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(947, 82, 9, 'Pengadaan peralatan gedung kantor'),
(948, 82, 10, 'Pengadaan mebeleur'),
(949, 82, 11, 'Pengadaan ……'),
(950, 82, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(951, 82, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(952, 82, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(953, 82, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(954, 82, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(955, 82, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(956, 82, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(957, 82, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(958, 82, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(959, 82, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(960, 82, 30, 'Pemeliharaan rutin/berkala …..'),
(961, 82, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(962, 82, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(963, 82, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(964, 82, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(965, 82, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(966, 83, 1, 'Pengadaan mesin/kartu absensi'),
(967, 83, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(968, 83, 3, 'Pengadaan pakaian kerja lapangan'),
(969, 83, 4, 'Pengadaan pakaian KORPRI'),
(970, 83, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(971, 84, 1, 'Pemulangan pegawai yang pensiun'),
(972, 84, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(973, 84, 3, 'Pemindahan tugas PNS'),
(974, 85, 1, 'Pendidikan dan pelatihan formal'),
(975, 85, 2, 'Sosialisasi peraturan perundang-undangan'),
(976, 85, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(977, 86, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(978, 86, 2, 'Penyusunan pelaporan keuangan semesteran'),
(979, 86, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(980, 86, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(981, 87, 1, 'Penyiapan tenaga pengendali kemanan dan kenyamanan lingkungan'),
(982, 87, 2, 'Pembangunan pos jaga/ronda'),
(983, 87, 3, 'Pelatihan pengendalian keamanan dan kenyamanan lingkungan'),
(984, 87, 4, 'Pengendalian kebisingan, dan gangguan dari kegiatan masyarakat'),
(985, 87, 5, 'Pengendalian keamanan lingkungan'),
(986, 87, 6, 'Monitoring, evaluasi dan pelaporan'),
(987, 88, 1, 'Pengawasan pengendalian dan evaluasi kegiatan polisi pamong praja'),
(988, 88, 2, 'Peningkatan kerjasama dengan aparat keamanan dalam teknik pencegahan kejahatan'),
(989, 88, 3, 'Kerjasama pengembangan kemampuan aparat polisi pamong praja dengan TNI/POLRI dan kejaksaan'),
(990, 88, 4, 'Peningkatan kapasitas aparat dalam rangka pelaksanaan siskamswakarsa di daerah'),
(991, 88, 5, 'Monitoring, evaluasi dan pelaporan'),
(992, 89, 1, 'Peningkatan toleransi dan kerukunan dalam kehidupan beragama'),
(993, 89, 2, 'Peningkatan rasa solidaritas dan ikatan sosial dikalangan masyarakat'),
(994, 89, 3, 'Peningkatan kesadaran masyarakat akan nilai-nilai luhur budaya bangsa'),
(995, 90, 1, 'Fasilitasi pencapaian Halaqoh dan berbagai forum keagamaan lainnya dalam upaya peningkatan wawasan kebangsaan'),
(996, 90, 2, 'Seminar, talk show, diskusi peningkatan wawasan kebangsaan'),
(997, 90, 3, 'Pentas seni dan budaya, festival, lomba cipta dalam upaya peningkatan wawasan kebangsaan'),
(998, 91, 1, 'Pembentukan satuan keamanan lingkungan di masyarakat'),
(999, 92, 1, 'Penyuluhan pencegahan peredaran/penggunaan minuman keras dan narkoba'),
(1000, 92, 2, 'Penyuluhan pencegahan berkembangnya praktek prostitusi'),
(1001, 92, 3, 'Penyuluhan pencegahan peredaran uang palsu'),
(1002, 92, 4, 'Penyuluhan pencegahan dan penertiban aksi premanisme'),
(1003, 92, 5, 'Penyuluhan pencegahan dan penertiban tindak penyelundupan'),
(1004, 92, 6, 'Penyuluhan pencegahan praktek penjudian'),
(1005, 92, 7, 'Penyuluhan pencegahan eksploitasi anak bawah umur'),
(1006, 92, 8, 'Monitoring, evaluasi dan pelaporan'),
(1007, 93, 1, 'Penyuluhan kepada masyarakat'),
(1008, 93, 2, 'fasilitasi penyelesaian perselisihan partai politik'),
(1009, 93, 3, 'Koordinasi forum-forum diskusi politik'),
(1010, 93, 4, 'Penyusunan data base partai politik'),
(1011, 93, 5, 'Monitoring, evaluasi dan pelaporan'),
(1012, 94, 1, 'Pemantauan dan penyebarluasan informasi potensi bencana alam'),
(1013, 94, 2, 'Pengadaan tempat penampungan sementara dan evakuasi penduduk dari ancaman/korban bancana alam'),
(1014, 94, 3, 'Pengadaan sarana dan prasarana evakuasi penduduk dari ancaman/korban bencana alam'),
(1015, 94, 4, 'Pengadaan logistik dan obat-obatab bagi penduduk di tempat penampungan sampah'),
(1016, 95, 0, 'Non Kegiatan'),
(1017, 96, 1, 'Penyediaan jasa surat menyurat'),
(1018, 96, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(1019, 96, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(1020, 96, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(1021, 96, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(1022, 96, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(1023, 96, 7, 'Penyediaan jasa administrasi keuangan'),
(1024, 96, 8, 'Penyediaan jasa kebersihan kantor'),
(1025, 96, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(1026, 96, 10, 'Penyediaan alat tulis kantor'),
(1027, 96, 11, 'Penyediaan barang cetakan dan penggandaan'),
(1028, 96, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(1029, 96, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(1030, 96, 14, 'Penyediaan peralatan rumah tangga'),
(1031, 96, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(1032, 96, 16, 'Penyediaan bahan logistik kantor'),
(1033, 96, 17, 'Penyediaan makanan dan minuman'),
(1034, 96, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(1035, 96, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(1036, 97, 1, 'Pembangunan rumah jabatan'),
(1037, 97, 2, 'Pembangunan rumah dinas'),
(1038, 97, 3, 'Pembangunan gedung kantor'),
(1039, 97, 4, 'Pengadaan mobil jabatan'),
(1040, 97, 5, 'pengadaan Kendaraan dinas/operasional'),
(1041, 97, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(1042, 97, 7, 'Pengadaan perlengkapan gedung kantor'),
(1043, 97, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(1044, 97, 9, 'Pengadaan peralatan gedung kantor'),
(1045, 97, 10, 'Pengadaan mebeleur'),
(1046, 97, 11, 'Pengadaan ……'),
(1047, 97, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(1048, 97, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(1049, 97, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(1050, 97, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(1051, 97, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(1052, 97, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(1053, 97, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(1054, 97, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(1055, 97, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(1056, 97, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(1057, 97, 30, 'Pemeliharaan rutin/berkala …..'),
(1058, 97, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(1059, 97, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(1060, 97, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(1061, 97, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(1062, 97, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(1063, 98, 1, 'Pengadaan mesin/kartu absensi'),
(1064, 98, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(1065, 98, 3, 'Pengadaan pakaian kerja lapangan'),
(1066, 98, 4, 'Pengadaan pakaian KORPRI'),
(1067, 98, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(1068, 99, 1, 'Pemulangan pegawai yang pensiun'),
(1069, 99, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(1070, 99, 3, 'Pemindahan tugas PNS'),
(1071, 100, 1, 'Pendidikan dan pelatihan formal'),
(1072, 100, 2, 'Sosialisasi peraturan perundang-undangan'),
(1073, 100, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(1074, 101, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(1075, 101, 2, 'Penyusunan pelaporan keuangan semesteran'),
(1076, 101, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(1077, 101, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(1078, 102, 1, 'Peningkatan Kemampuan (Capacity Building) petugas dan pedamping sosial pemberdayaan fakir miskin, KAT dan PMKS lainnya'),
(1079, 102, 2, 'Pelatihan ketrampilan berusaha bagi keluarga miskin'),
(1080, 102, 3, 'Fasilitasi manajemen usaha bagi keluarga miskin'),
(1081, 102, 4, 'Pengadaan sarana dan prasarana pendukung usaha bagi keluarga miskin'),
(1082, 102, 5, 'Pelatihan ketrampilan bagi penyandang masalah kesejahteraan sosial'),
(1083, 103, 1, 'Pengembangan kebijakan tentang akses sarana dan prasarana publik bagi penyandang cacat dan lansia'),
(1084, 103, 2, 'Pelayanan dan perlindungan sosial, hukum bagi korban eksploitasi, perdagangan perempuan dan anak'),
(1085, 103, 3, 'Pelaksanaan KIE konseling dan kampanye sosial bagi Penyandang Masalah Kesejahteraan Sosial (PMKS)'),
(1086, 103, 4, 'Pelatihan keterampilan dan praktek belajar kerja bagi anak terlantar termasuk anak jalanan, anak cacat, dan anak nakal'),
(1087, 103, 5, 'Pelayanan psikososial bagi PMKS di trauma centre termasuk bagi korban bencana'),
(1088, 103, 6, 'Pembentukan pusat informasi penyandang cacat dan trauma center'),
(1089, 103, 7, 'Peningkatan kualitas pelayanan, sarana, dan prasarana rehabilitasi kesejahteraan sosial bagi PMKS'),
(1090, 103, 8, 'Penyusunan kebijakan pelayanan dan rehabilitasi sosial bagi Penyandang Masalah Kesejahteraan Sosial'),
(1091, 103, 9, 'Koordinasi perumusan kebijakan dan sikronisasi pelaksanaan upaya-upaya penanggulangan kemiskinan dan penurunan kesenjangan'),
(1092, 103, 10, 'Penanganan masalah-masalah strategis yang menyangkut tanggap cepat darurat dan kejadian luar biasa'),
(1093, 103, 11, 'Monitoring, evaluasi dan pelaporan'),
(1094, 104, 1, 'Pembangunan sarana dan prasarana tempat penampungan anak terlantar'),
(1095, 104, 2, 'Pelatihan ketrampilan dan praktek belajar kerja bagi anak terlantar'),
(1096, 104, 3, 'Penyusunan data dan analisis permasalahan anak terlantar'),
(1097, 104, 4, 'Pengembangan bakat dan ketrampilan anak terlantar'),
(1098, 104, 5, 'Peningkatan keterampilan tenaga pembinaan anak terlantar'),
(1099, 104, 6, 'Monitoring, evaluasi dan pelaporan'),
(1100, 105, 1, 'Pendataan penyandang cacat dan penyakit kejiwaan'),
(1101, 105, 2, 'Pembangunan sarana dan prasarana perawatan para penyandang cacat dan trauma'),
(1102, 105, 3, 'Pendidikan dan pelatihan bagi penyandang cacat dan eks trauma'),
(1103, 105, 4, 'Pendayagunaan para penyandang cacat dan eks trauma'),
(1104, 105, 5, 'Peningkatan keterampilan tenaga pelatih dan pendidik'),
(1105, 106, 1, 'Pembangunan sarana dan prasarana panti asuhan/jompo'),
(1106, 106, 2, 'Rehabilitasi sedang/berat bangunan panti asuhan/jompo'),
(1107, 106, 3, 'Operasi dan pemeliharaan sarana dan prasarana panti asuhan/jompo'),
(1108, 106, 4, 'Pendidikan dan pelatihan bagi penghuni panti asuhan/jompo'),
(1109, 106, 5, 'Peningkatan keterampilan tenaga pelatih dan pendidik'),
(1110, 106, 6, 'Monitoring, evaluasi dan pelaporan'),
(1111, 107, 1, 'Pendidikan dan pelatihan ketrampilan berusaha bagi eks penyandang penyakit sosial'),
(1112, 107, 2, 'Pembangunan pusat bimbingan/konseling bagi eks penyandang penyakit sosial'),
(1113, 107, 3, 'Pemantauan kemajuan perubahan sikap mental eks penyandang penyakit sosial'),
(1114, 107, 4, 'Pemberdayaan eks penyandang penyakit sosial'),
(1115, 107, 5, 'Monitoring, evaluasi dan pelaporan'),
(1116, 108, 1, 'Peningkatan peran aktif masyarakat dan dunia usaha'),
(1117, 108, 2, 'Peningkatan jenjang kerjasama pelaku-pelaku usaha kesejahteraan sosial masyarakat'),
(1118, 108, 3, 'Peningkatan kualitas SDM kesejahteraan sosial masyarakat'),
(1119, 108, 4, 'Pengembangan model kelembagaan perlindungan sosial'),
(1120, 109, 0, 'Non Kegiatan'),
(1121, 110, 1, 'Penyediaan jasa surat menyurat'),
(1122, 110, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(1123, 110, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(1124, 110, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(1125, 110, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(1126, 110, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(1127, 110, 7, 'Penyediaan jasa administrasi keuangan'),
(1128, 110, 8, 'Penyediaan jasa kebersihan kantor'),
(1129, 110, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(1130, 110, 10, 'Penyediaan alat tulis kantor'),
(1131, 110, 11, 'Penyediaan barang cetakan dan penggandaan'),
(1132, 110, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(1133, 110, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(1134, 110, 14, 'Penyediaan peralatan rumah tangga'),
(1135, 110, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(1136, 110, 16, 'Penyediaan bahan logistik kantor'),
(1137, 110, 17, 'Penyediaan makanan dan minuman'),
(1138, 110, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(1139, 110, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(1140, 111, 1, 'Pembangunan rumah jabatan'),
(1141, 111, 2, 'Pembangunan rumah dinas'),
(1142, 111, 3, 'Pembangunan gedung kantor'),
(1143, 111, 4, 'Pengadaan mobil jabatan'),
(1144, 111, 5, 'pengadaan Kendaraan dinas/operasional'),
(1145, 111, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(1146, 111, 7, 'Pengadaan perlengkapan gedung kantor'),
(1147, 111, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(1148, 111, 9, 'Pengadaan peralatan gedung kantor'),
(1149, 111, 10, 'Pengadaan mebeleur'),
(1150, 111, 11, 'Pengadaan ……'),
(1151, 111, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(1152, 111, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(1153, 111, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(1154, 111, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(1155, 111, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(1156, 111, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(1157, 111, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(1158, 111, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(1159, 111, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(1160, 111, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(1161, 111, 30, 'Pemeliharaan rutin/berkala …..'),
(1162, 111, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(1163, 111, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(1164, 111, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(1165, 111, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(1166, 111, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(1167, 112, 1, 'Pengadaan mesin/kartu absensi'),
(1168, 112, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(1169, 112, 3, 'Pengadaan pakaian kerja lapangan'),
(1170, 112, 4, 'Pengadaan pakaian KORPRI'),
(1171, 112, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(1172, 113, 1, 'Pemulangan pegawai yang pensiun'),
(1173, 113, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(1174, 113, 3, 'Pemindahan tugas PNS'),
(1175, 114, 1, 'Pendidikan dan pelatihan formal'),
(1176, 114, 2, 'Sosialisasi peraturan perundang-undangan'),
(1177, 114, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(1178, 115, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(1179, 115, 2, 'Penyusunan pelaporan keuangan semesteran'),
(1180, 115, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(1181, 115, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(1182, 116, 1, 'Penyusunan data base tenaga kerja daerah'),
(1183, 116, 2, 'Pembangunan balai latihan kerja'),
(1184, 116, 3, 'Pengadaan peralatan pendidikan dan ketrampilan bagi pencari kerja'),
(1185, 116, 4, 'Peningkatan profesionalisme tenaga kepelatihan dan instruktur BLK'),
(1186, 116, 5, 'Pengadaan bahan dan materi pendidikan dan ketrampilan kerja'),
(1187, 116, 6, 'Pendidikan dan pelatihan ketrampilan bagi pencari kerja'),
(1188, 116, 7, 'Pemeliharaan rutin/berkala sarana dan prasarana BLK'),
(1189, 116, 8, 'Rehabilitasi sedang/berat sarana dan prasarana BLK'),
(1190, 116, 9, 'Monitoring, evaluasi dan pelaporan'),
(1191, 117, 1, 'Penyusunan informasi bursa tenaga kerja'),
(1192, 117, 2, 'Penyebarluasan informasi bursa tenaga kerja'),
(1193, 117, 3, 'Kerjasama pendidikan dan pelatihan'),
(1194, 117, 4, 'Penyiapan tenaga kerja siap pakai'),
(1195, 117, 5, 'Pengembangan kelembagaan produktivitas dan pelatihan kewirausahaan'),
(1196, 117, 6, 'Pemberian fasilitasi dan mendorong sistem pendanaan pelatihan berbasis masyarakat'),
(1197, 117, 7, 'Monitoring, evaluasi dan pelaporan'),
(1198, 118, 1, 'Pengendalian dan pembinaan lembaga penyalur tenaga kerja'),
(1199, 118, 2, 'Fasilitasi penyelesaian prosedur, penyelesaian perselisihan hubungan industrial'),
(1200, 118, 3, 'Fasilitasi penyelesaian prosedur pemberian perlindungan hukum dan jaminan sosial ketenagakerjaan'),
(1201, 118, 4, 'Sosialisasi berbagai peraturan pelaksanaan tentang ketenagakerjaan'),
(1202, 118, 5, 'Peningkatan pengawasan, perlindungan dan penegakkan hukum terhadap keselamatan dan kesehatan kerja'),
(1203, 118, 6, 'Penyusunan kebijakan standarisasi lembaga penyalur tenaga kerja'),
(1204, 118, 7, 'Pemantauan kinerja lembaga penyalur tenaga kerja'),
(1205, 118, 8, 'Monitoring, evaluasi dan pelaporan'),
(1206, 119, 0, 'Non Kegiatan'),
(1207, 120, 1, 'Penyediaan jasa surat menyurat'),
(1208, 120, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(1209, 120, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(1210, 120, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(1211, 120, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(1212, 120, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(1213, 120, 7, 'Penyediaan jasa administrasi keuangan'),
(1214, 120, 8, 'Penyediaan jasa kebersihan kantor'),
(1215, 120, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(1216, 120, 10, 'Penyediaan alat tulis kantor'),
(1217, 120, 11, 'Penyediaan barang cetakan dan penggandaan'),
(1218, 120, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(1219, 120, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(1220, 120, 14, 'Penyediaan peralatan rumah tangga'),
(1221, 120, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(1222, 120, 16, 'Penyediaan bahan logistik kantor'),
(1223, 120, 17, 'Penyediaan makanan dan minuman'),
(1224, 120, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(1225, 120, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(1226, 121, 1, 'Pembangunan rumah jabatan'),
(1227, 121, 2, 'Pembangunan rumah dinas'),
(1228, 121, 3, 'Pembangunan gedung kantor'),
(1229, 121, 4, 'Pengadaan mobil jabatan'),
(1230, 121, 5, 'pengadaan Kendaraan dinas/operasional'),
(1231, 121, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(1232, 121, 7, 'Pengadaan perlengkapan gedung kantor'),
(1233, 121, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(1234, 121, 9, 'Pengadaan peralatan gedung kantor'),
(1235, 121, 10, 'Pengadaan mebeleur'),
(1236, 121, 11, 'Pengadaan ……'),
(1237, 121, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(1238, 121, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(1239, 121, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(1240, 121, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(1241, 121, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(1242, 121, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(1243, 121, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(1244, 121, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(1245, 121, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(1246, 121, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(1247, 121, 30, 'Pemeliharaan rutin/berkala …..'),
(1248, 121, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(1249, 121, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(1250, 121, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(1251, 121, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(1252, 121, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(1253, 122, 1, 'Pengadaan mesin/kartu absensi'),
(1254, 122, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(1255, 122, 3, 'Pengadaan pakaian kerja lapangan'),
(1256, 122, 4, 'Pengadaan pakaian KORPRI'),
(1257, 122, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(1258, 123, 1, 'Pemulangan pegawai yang pensiun'),
(1259, 123, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(1260, 123, 3, 'Pemindahan tugas PNS'),
(1261, 124, 1, 'Pendidikan dan pelatihan formal'),
(1262, 124, 2, 'Sosialisasi peraturan perundang-undangan'),
(1263, 124, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(1264, 125, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(1265, 125, 2, 'Penyusunan pelaporan keuangan semesteran'),
(1266, 125, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(1267, 125, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(1268, 126, 1, 'Perumusan kebijakan peningkatan kualitas hidup perempuan di bidang ilmu pengetahuan dan teknologi'),
(1269, 126, 2, 'Perumusan kebijakan peningkatan peran dan posisi perempuan di bidang politik dan jabatan publik'),
(1270, 126, 3, 'Pelaksanaan sosilaisasi yang terkait dengan kesetaraan gender, pemberdayaan perempuan dan perlindungan anak'),
(1271, 126, 4, 'Monitoring, evaluasi dan pelaporan'),
(1272, 127, 1, 'Advokasi dan fasilitasi PUG bagi perempuan'),
(1273, 127, 2, 'Fasilitasi pengembangan pusat pelayanan terpadu pemberdayaan perempuan (P2TP2)'),
(1274, 127, 3, 'Pemetaan potensi organisasi dan lembaga masyarakat yang berperan dalam pemberdayaan perempuan dan anak'),
(1275, 127, 4, 'Pengembangan materi dan pelaksanaan KIE tentang kesetaraan dan keadilan gender (KKG)'),
(1276, 127, 5, 'Penguatan kelembagaan pengarusutamaan gender dan anak'),
(1277, 127, 6, 'Peningkatan kapasitas dan jaringan kelembagaan pemberdayaan perempuan dan anak'),
(1278, 127, 7, 'Evaluasi pelaksanaan PUG'),
(1279, 127, 8, 'Pengembangan Sistem Informasi Gender dan Anak'),
(1280, 127, 9, 'Monitoring, evaluasi dan pelaporan'),
(1281, 128, 1, 'Pelaksanaan kebijakan perlindungan perempuan di daerah'),
(1282, 128, 2, 'Pelatihan bagi pelatih (TOT) SDM pelayanan dan pedampingan korban KDRT'),
(1283, 128, 3, 'Penyusunan sistem perlindungan bagi perempuan'),
(1284, 128, 4, 'Sosialisasi dan advokasi kebijakan penghapusan buta aksara perempuan (PBAP)'),
(1285, 128, 5, 'Sosialisasi dan advokasi kebijakan perlindungan tenaga kerja perempuan'),
(1286, 128, 6, 'Sosialisasi sistem pencatatan dan pelaporan KDRT'),
(1287, 128, 7, 'Penyusunan profil perlindungan perempuan terhadap tindak kekerasan'),
(1288, 128, 8, 'Fasilitasi upaya perlindungan perempuan terhadap tindak kekerasan'),
(1289, 128, 9, 'Monitoring, evaluasi dan pelaporan'),
(1290, 129, 1, 'Kegiatan pembinaan organisasi perempuan'),
(1291, 129, 2, 'Kegiatan pendidikan dan pelatihan peningkatan peran serta dan kesetaraan jender'),
(1292, 129, 3, 'Kegiatan penyuluhan bagi ibu rumah tangga dalam membangun keluarga sejahtera'),
(1293, 129, 4, 'Kegiatan bimbingan manajemen usah abagi perempuan dalam mengelola usaha'),
(1294, 129, 5, 'Kegiatan pameran hasil karya perempuan dibidang pembangunan'),
(1295, 129, 6, 'Monitoring, evaluasi dan pelaporan'),
(1296, 130, 1, 'Workshop peningkatan peran perempuan dalam pengambilan keputusan'),
(1297, 130, 2, 'Pemberdayaan lembaga yang berbasis gender'),
(1298, 131, 0, 'Non Kegiatan'),
(1299, 132, 1, 'Penyediaan jasa surat menyurat'),
(1300, 132, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(1301, 132, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(1302, 132, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(1303, 132, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(1304, 132, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(1305, 132, 7, 'Penyediaan jasa administrasi keuangan'),
(1306, 132, 8, 'Penyediaan jasa kebersihan kantor'),
(1307, 132, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(1308, 132, 10, 'Penyediaan alat tulis kantor'),
(1309, 132, 11, 'Penyediaan barang cetakan dan penggandaan'),
(1310, 132, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(1311, 132, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(1312, 132, 14, 'Penyediaan peralatan rumah tangga'),
(1313, 132, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(1314, 132, 16, 'Penyediaan bahan logistik kantor'),
(1315, 132, 17, 'Penyediaan makanan dan minuman'),
(1316, 132, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(1317, 132, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(1318, 133, 1, 'Pembangunan rumah jabatan'),
(1319, 133, 2, 'Pembangunan rumah dinas'),
(1320, 133, 3, 'Pembangunan gedung kantor'),
(1321, 133, 4, 'Pengadaan mobil jabatan'),
(1322, 133, 5, 'pengadaan Kendaraan dinas/operasional'),
(1323, 133, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(1324, 133, 7, 'Pengadaan perlengkapan gedung kantor'),
(1325, 133, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(1326, 133, 9, 'Pengadaan peralatan gedung kantor'),
(1327, 133, 10, 'Pengadaan mebeleur'),
(1328, 133, 11, 'Pengadaan ……'),
(1329, 133, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(1330, 133, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(1331, 133, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(1332, 133, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(1333, 133, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(1334, 133, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(1335, 133, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(1336, 133, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(1337, 133, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(1338, 133, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(1339, 133, 30, 'Pemeliharaan rutin/berkala …..'),
(1340, 133, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(1341, 133, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(1342, 133, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(1343, 133, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(1344, 133, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(1345, 134, 1, 'Pengadaan mesin/kartu absensi'),
(1346, 134, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(1347, 134, 3, 'Pengadaan pakaian kerja lapangan'),
(1348, 134, 4, 'Pengadaan pakaian KORPRI'),
(1349, 134, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(1350, 135, 1, 'Pemulangan pegawai yang pensiun'),
(1351, 135, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(1352, 135, 3, 'Pemindahan tugas PNS'),
(1353, 136, 1, 'Pendidikan dan pelatihan formal'),
(1354, 136, 2, 'Sosialisasi peraturan perundang-undangan'),
(1355, 136, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(1356, 137, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(1357, 137, 2, 'Penyusunan pelaporan keuangan semesteran'),
(1358, 137, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(1359, 137, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(1360, 138, 1, 'Penanganan daerah rawan pangan'),
(1361, 138, 2, 'Penyusunan data base potensi produksi pangan'),
(1362, 138, 3, 'Analisis dan penyusunan pola konsumsi dan suplai pangan'),
(1363, 138, 4, 'Analisis rasio jumlah penduduk terhadap jumlah kebutuhan pangan'),
(1364, 138, 5, 'Laporan berkala kondisi ketahanan pangan daerah'),
(1365, 138, 6, 'Kajian rantai pasokan dan pemasaran pangan'),
(1366, 138, 7, 'Monitoring, evaluasi dan pelaporan kebijakan pemberasan'),
(1367, 138, 8, 'Monitoring, evaluasi dan pelaporan kebijakan subsidi pertanian'),
(1368, 138, 9, 'Pemanfaatan pekarangan untuk pengembangan pangan'),
(1369, 138, 10, 'Pemantauan dan analisis akses pangan masyarakat'),
(1370, 138, 11, 'Pemantauan dan analisis harga pangan pokok'),
(1371, 138, 12, 'Penanganan pasca panen dan pengolahan hasil pertanian'),
(1372, 138, 13, 'Pengembangan cadangan pangan daerah'),
(1373, 138, 14, 'Pengembangan desa mandiri pangan'),
(1374, 138, 15, 'Pengembangan intensifikasi tanaman padi, palawija'),
(1375, 138, 16, 'Pengembangan diversifikasi tanaman'),
(1376, 138, 17, 'Pengembangan pertanian pada lahan kering'),
(1377, 138, 18, 'Pengembangan lumbung pangan desa'),
(1378, 138, 19, 'Pengembangan model distribusi pangan yang efisien'),
(1379, 138, 20, 'Pengembangan perbenihan/perbibitan'),
(1380, 138, 21, 'Pengembangan sistem informasi pasar'),
(1381, 138, 22, 'Peningkatan mutu dan keamanan pangan'),
(1382, 138, 23, 'Koordinasi kebijakan perberasan'),
(1383, 138, 24, 'Koordinasi perumusan kebijakan pertanahan dan infrastruktur pertanian dan perdesaan'),
(1384, 138, 25, 'Penelitian dan pengembangan sumberdaya pertanian'),
(1385, 138, 26, 'Penelitian dan pengembangan teknologi bioteknologi'),
(1386, 138, 27, 'Penelitian dan pengembangan teknologi budidaya'),
(1387, 138, 28, 'Penelitian dan pengembangan teknologi pasca panen'),
(1388, 138, 29, 'Peningkatan produksi, produktivitas dab mutu produk perkebunan, produk pertanian'),
(1389, 138, 30, 'Penyuluhan sumber pangan alternatif'),
(1390, 138, 31, 'Monitoring, evaluasi dan pelaporan'),
(1391, 139, 0, 'Non Kegiatan'),
(1392, 140, 1, 'Penyediaan jasa surat menyurat'),
(1393, 140, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(1394, 140, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(1395, 140, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(1396, 140, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(1397, 140, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(1398, 140, 7, 'Penyediaan jasa administrasi keuangan'),
(1399, 140, 8, 'Penyediaan jasa kebersihan kantor'),
(1400, 140, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(1401, 140, 10, 'Penyediaan alat tulis kantor'),
(1402, 140, 11, 'Penyediaan barang cetakan dan penggandaan'),
(1403, 140, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(1404, 140, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(1405, 140, 14, 'Penyediaan peralatan rumah tangga'),
(1406, 140, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(1407, 140, 16, 'Penyediaan bahan logistik kantor'),
(1408, 140, 17, 'Penyediaan makanan dan minuman'),
(1409, 140, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(1410, 141, 1, 'Pembangunan rumah jabatan'),
(1411, 141, 2, 'Pembangunan rumah dinas'),
(1412, 141, 3, 'Pembangunan gedung kantor'),
(1413, 141, 4, 'Pengadaan mobil jabatan'),
(1414, 141, 5, 'pengadaan Kendaraan dinas/operasional'),
(1415, 141, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(1416, 141, 7, 'Pengadaan perlengkapan gedung kantor'),
(1417, 141, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(1418, 141, 9, 'Pengadaan peralatan gedung kantor'),
(1419, 141, 10, 'Pengadaan mebeleur'),
(1420, 141, 11, 'Pengadaan ……'),
(1421, 141, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(1422, 141, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(1423, 141, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(1424, 141, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(1425, 141, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(1426, 141, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(1427, 141, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(1428, 141, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(1429, 141, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(1430, 141, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(1431, 141, 30, 'Pemeliharaan rutin/berkala …..'),
(1432, 141, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(1433, 141, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(1434, 141, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(1435, 141, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(1436, 141, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(1437, 142, 1, 'Pengadaan mesin/kartu absensi'),
(1438, 142, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(1439, 142, 3, 'Pengadaan pakaian kerja lapangan'),
(1440, 142, 4, 'Pengadaan pakaian KORPRI'),
(1441, 142, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(1442, 143, 1, 'Pemulangan pegawai yang pensiun'),
(1443, 143, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(1444, 143, 3, 'Pemindahan tugas PNS'),
(1445, 144, 1, 'Pendidikan dan pelatihan formal'),
(1446, 144, 2, 'Sosialisasi peraturan perundang-undangan'),
(1447, 144, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(1448, 145, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(1449, 145, 2, 'Penyusunan pelaporan keuangan semesteran'),
(1450, 145, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(1451, 145, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(1452, 146, 1, 'Penyusunan sistem pendaftaran tanah'),
(1453, 146, 2, 'Sosialisasi sistem pendaftaran tanah'),
(1454, 147, 1, 'Penataan penguasaan, pemilikan, penggunaan dan pemanfaatan tanah'),
(1455, 147, 2, 'Penyuluhan hukum pertanahan'),
(1456, 148, 1, 'Fasilitasi penyelesaian konflik-konflik pertanahan'),
(1457, 149, 1, 'Penyusunan sistem informasi pertanahan yang handal'),
(1458, 150, 0, 'Non Kegiatan'),
(1459, 151, 1, 'Penyediaan jasa surat menyurat'),
(1460, 151, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(1461, 151, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(1462, 151, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(1463, 151, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(1464, 151, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(1465, 151, 7, 'Penyediaan jasa administrasi keuangan'),
(1466, 151, 8, 'Penyediaan jasa kebersihan kantor'),
(1467, 151, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(1468, 151, 10, 'Penyediaan alat tulis kantor'),
(1469, 151, 11, 'Penyediaan barang cetakan dan penggandaan'),
(1470, 151, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(1471, 151, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(1472, 151, 14, 'Penyediaan peralatan rumah tangga'),
(1473, 151, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(1474, 151, 16, 'Penyediaan bahan logistik kantor'),
(1475, 151, 17, 'Penyediaan makanan dan minuman'),
(1476, 151, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(1477, 151, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(1478, 152, 1, 'Pembangunan rumah jabatan'),
(1479, 152, 2, 'Pembangunan rumah dinas'),
(1480, 152, 3, 'Pembangunan gedung kantor'),
(1481, 152, 4, 'Pengadaan mobil jabatan'),
(1482, 152, 5, 'pengadaan Kendaraan dinas/operasional'),
(1483, 152, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(1484, 152, 7, 'Pengadaan perlengkapan gedung kantor'),
(1485, 152, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(1486, 152, 9, 'Pengadaan peralatan gedung kantor'),
(1487, 152, 10, 'Pengadaan mebeleur'),
(1488, 152, 11, 'Pengadaan ……'),
(1489, 152, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(1490, 152, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(1491, 152, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(1492, 152, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(1493, 152, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(1494, 152, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(1495, 152, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(1496, 152, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(1497, 152, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(1498, 152, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(1499, 152, 30, 'Pemeliharaan rutin/berkala …..'),
(1500, 152, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(1501, 152, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(1502, 152, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(1503, 152, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(1504, 152, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(1505, 153, 1, 'Pengadaan mesin/kartu absensi'),
(1506, 153, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(1507, 153, 3, 'Pengadaan pakaian kerja lapangan'),
(1508, 153, 4, 'Pengadaan pakaian KORPRI'),
(1509, 153, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(1510, 154, 1, 'Pemulangan pegawai yang pensiun'),
(1511, 154, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(1512, 154, 3, 'Pemindahan tugas PNS'),
(1513, 155, 1, 'Pendidikan dan pelatihan formal'),
(1514, 155, 2, 'Sosialisasi peraturan perundang-undangan'),
(1515, 155, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(1516, 156, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(1517, 156, 2, 'Penyusunan pelaporan keuangan semesteran'),
(1518, 156, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(1519, 156, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(1520, 157, 1, 'Penyusunan kebijakan manajemen pengelolaan sampah'),
(1521, 157, 2, 'Penyediaan prasarana dan sarana pengelolaaan persampahan'),
(1522, 157, 3, 'Penyusunan kebijakan kerjasama pengelolaan sampah'),
(1523, 157, 4, 'Peningkatan operasi dan pemeliharaan prasarana dan sarana persampahan'),
(1524, 157, 5, 'Pengembangan teknologi pengolahan persampahan'),
(1525, 157, 6, 'Bimbingan teknis persampahan'),
(1526, 157, 7, 'Peningkatan kemampuan aparat pengelolaan persampahan'),
(1527, 157, 8, 'Kerjasama pengelolaan sampah'),
(1528, 157, 9, 'Kerjasama pengelolaan sampah antar daerah'),
(1529, 157, 10, 'Sosialisasi kebijakan pengelolaan persampahan'),
(1530, 157, 11, 'Peningkatan peran serta masyarakat dalam pengelolaan persampahan'),
(1531, 157, 12, 'Monitoring, evaluasi dan pelaporan'),
(1532, 158, 1, 'Koordinasi penilaian Kota Sehat/Adipura'),
(1533, 158, 2, 'Koordinasi penilaian langit biru'),
(1534, 158, 3, 'Pemantauan Kualitas Lingkungan'),
(1535, 158, 4, 'Pengawasan pelaksanaan kebijakan bidang lingkungan hidup'),
(1536, 158, 5, 'Koordinasi penertiban kegiatan Pertambangan Tanpa Izin (PETI)'),
(1537, 158, 6, 'Pengelolaan B3 dan Limbah B3'),
(1538, 158, 7, 'Pengkajian dampak lingkungan'),
(1539, 158, 8, 'Peningkatan pengelolaan lingkungan pertambangan'),
(1540, 158, 9, 'Peningkatan peringkat kinerja perusahaan (proper)'),
(1541, 158, 10, 'Koordinasi pengelolaan Prokasih/Superkasih'),
(1542, 158, 11, 'Pengembangan produsi ramah lingkungan'),
(1543, 158, 12, 'Penyusunan kebijakan pengendalian pencemaran dan perusakan lingkungan hidup'),
(1544, 158, 13, 'Koordinasi penyusunan AMDAL'),
(1545, 158, 14, 'Peningkatan peran serta masyarakat dalam pengendalian lingkungan hidup'),
(1546, 158, 15, 'Pengkajian pengembangan sistem insentif dan disinsentif'),
(1547, 158, 16, 'Monitoring, evaluasi dan pelaporan'),
(1548, 159, 1, 'Konservasi Sumber Daya Air dan Pengendalian Kerusakan Sumber-Sumber Air'),
(1549, 159, 2, 'Pantai dan Laut Lestari'),
(1550, 159, 3, 'Pengembangan dan Pemantapan Kawasan Konservasi Laut, Suaka Perikanan, dan keaneragaman Hayati Laut'),
(1551, 159, 4, 'Pengembangan Ekowisata dan Jasa Lingkungan'),
(1552, 159, 5, 'Pengendalian Dampak Perubahan Iklim'),
(1553, 159, 6, 'Pengendalian Kerusakan Hutan dan Lahan'),
(1554, 159, 7, 'Peningkatan Konservasi Daerah tangkapan Air dan Sumber-Sumber Air'),
(1555, 159, 8, 'Pengendalian dan pengawasan pemanfaatan SDA'),
(1556, 159, 9, 'Koordinasi pengelolaan konservasi SDA'),
(1557, 159, 10, 'Pengelolaan keanekaragaman hayati dan ekosistem'),
(1558, 159, 11, 'Pengembangan dan Pengelolaan Kawasan World Hearitage Laut'),
(1559, 159, 12, 'Pengembangan Kerjasama Pengelolaan Kawasan Konservasi Laut Regional'),
(1560, 159, 13, 'Koordinasi pengendalian Kebakaran Hutan'),
(1561, 159, 14, 'Peningkatan peran serta masyarakat dalam perlindungan dan konservasi SDA'),
(1562, 159, 15, 'Koordinasi peningkatan pengelolaan kawasan konservasi'),
(1563, 159, 16, 'Monitoring, evaluasi dan pelaporan'),
(1564, 160, 1, 'Pengelolaan dan rehabilitasi terumbu karang, mangrove, padang lamun, estuaria dan teluk'),
(1565, 160, 2, 'Perencanaan dan penyusunan program pembangunan pengendalian sumber daya alam dan lingkungan hidup'),
(1566, 160, 3, 'Rehabilitasi hutan dan lahan'),
(1567, 160, 4, 'Pengembangan kelembagaan rehabilitasi hutan dan lahan'),
(1568, 160, 5, 'Penyusunan pedoman standar dan prosedur rehabilitasi terumbu karang, mangrove, dan padang lamun'),
(1569, 160, 6, 'Sosialisasi pedoman standar dan prosedur rehabilitasi terumbu karang, mangrove, dan padang lamun'),
(1570, 160, 7, 'Peningkatan peran serta masyarakat dalam rehabilitasi dan pemulihan cadangan SDA'),
(1571, 160, 8, 'Monitoring, evaluasi dan pelaporan'),
(1572, 161, 1, 'Peningkatan edukasi dan komunikasi masyarakat di bidang lingkungan'),
(1573, 161, 2, 'Pengembangan data dan informasi lingkungan'),
(1574, 161, 3, 'Penyusunan data sumberdaya alam dan neraca sumberdaya hutan (NSDH) nasional dan daerah'),
(1575, 161, 4, 'Penguatan, jejaring informasi lingkungan pusat dan daerah'),
(1576, 161, 5, 'Monitoring, evaluasi dan pelaporan'),
(1577, 162, 1, 'Pengujian emisi kendaraan bermotor'),
(1578, 162, 2, 'Pengujian emisi/polusi udara akibat aktivitas industri'),
(1579, 162, 3, 'Pengujian kadar polusi limbah padat dan limbah cair'),
(1580, 162, 4, 'Pembangunan tempat pembuangan benda padat/cair yang menimbulkan polusi'),
(1581, 162, 5, 'Penyuluhan dan pengendalian polusi dan pencemaran'),
(1582, 162, 6, 'Monitoring, evaluasi dan pelaporan'),
(1583, 163, 1, 'Pengembangan ekowisata dan jasa lingkungan dikawasan konservasi'),
(1584, 163, 2, 'Pengembangan konservasi laut dan hutan wisata'),
(1585, 163, 3, 'Monitoring, evaluasi dan pelaporan'),
(1586, 164, 1, 'Pengadaan alat pemadam kebakaran'),
(1587, 164, 2, 'Pemetaan kawasan rawan kebakaran hutan'),
(1588, 164, 3, 'Koordinasi pengendalian kebakaran hutan'),
(1589, 164, 4, 'Penyusunan norma, standar, prosedur, dan manual pengendalian kebakaran hutan'),
(1590, 164, 5, 'Sosialisasi kebijakan pencagahan kebakaran hutan'),
(1591, 164, 6, 'Monitoring, evaluasi dan pelaporan'),
(1592, 165, 1, 'Pengelolaan dan rehabilitasi ekosistem pesisir dan laut'),
(1593, 165, 2, 'Pengembangan sistem manajemen pengelolaan pesisir laut');
INSERT INTO `ref_kegiatan` (`id_kegiatan`, `id_program`, `kd_kegiatan`, `nm_kegiatan`) VALUES
(1594, 166, 1, 'Penyusunan kebijakan, norma, standar, prosedur dan manual pengelolaan RTH'),
(1595, 166, 2, 'Sosiallisasi kebijakan, norma, standar, prosedur dan manual pengelolaan RTH'),
(1596, 166, 3, 'Penyusunan dan analisis data/informasi pengelolaan RTH'),
(1597, 166, 4, 'Penyusunan program pengembahan RTH'),
(1598, 166, 5, 'Penataan RTH'),
(1599, 166, 6, 'Pemeliharaan RTH'),
(1600, 166, 7, 'Pengembangan taman rekreasi'),
(1601, 166, 8, 'Pengawasan dan pengendalian RTH'),
(1602, 166, 9, 'Peningkatan peran serta masyarakat dalam pengelolaan RTH'),
(1603, 166, 10, 'Monitoring dan evaluasi'),
(1604, 167, 0, 'Non Kegiatan'),
(1605, 168, 1, 'Penyediaan jasa surat menyurat'),
(1606, 168, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(1607, 168, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(1608, 168, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(1609, 168, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(1610, 168, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(1611, 168, 7, 'Penyediaan jasa administrasi keuangan'),
(1612, 168, 8, 'Penyediaan jasa kebersihan kantor'),
(1613, 168, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(1614, 168, 10, 'Penyediaan alat tulis kantor'),
(1615, 168, 11, 'Penyediaan barang cetakan dan penggandaan'),
(1616, 168, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(1617, 168, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(1618, 168, 14, 'Penyediaan peralatan rumah tangga'),
(1619, 168, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(1620, 168, 16, 'Penyediaan bahan logistik kantor'),
(1621, 168, 17, 'Penyediaan makanan dan minuman'),
(1622, 168, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(1623, 168, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(1624, 169, 1, 'Pembangunan rumah jabatan'),
(1625, 169, 2, 'Pembangunan rumah dinas'),
(1626, 169, 3, 'Pembangunan gedung kantor'),
(1627, 169, 4, 'Pengadaan mobil jabatan'),
(1628, 169, 5, 'pengadaan Kendaraan dinas/operasional'),
(1629, 169, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(1630, 169, 7, 'Pengadaan perlengkapan gedung kantor'),
(1631, 169, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(1632, 169, 9, 'Pengadaan peralatan gedung kantor'),
(1633, 169, 10, 'Pengadaan mebeleur'),
(1634, 169, 11, 'Pengadaan ……'),
(1635, 169, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(1636, 169, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(1637, 169, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(1638, 169, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(1639, 169, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(1640, 169, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(1641, 169, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(1642, 169, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(1643, 169, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(1644, 169, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(1645, 169, 30, 'Pemeliharaan rutin/berkala …..'),
(1646, 169, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(1647, 169, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(1648, 169, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(1649, 169, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(1650, 169, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(1651, 170, 1, 'Pengadaan mesin/kartu absensi'),
(1652, 170, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(1653, 170, 3, 'Pengadaan pakaian kerja lapangan'),
(1654, 170, 4, 'Pengadaan pakaian KORPRI'),
(1655, 170, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(1656, 171, 1, 'Pemulangan pegawai yang pensiun'),
(1657, 171, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(1658, 171, 3, 'Pemindahan tugas PNS'),
(1659, 172, 1, 'Pendidikan dan pelatihan formal'),
(1660, 172, 2, 'Sosialisasi peraturan perundang-undangan'),
(1661, 172, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(1662, 173, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(1663, 173, 2, 'Penyusunan pelaporan keuangan semesteran'),
(1664, 173, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(1665, 173, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(1666, 174, 1, 'Pembangunan dan pengoperasian SIAK secara terpadu'),
(1667, 174, 2, 'Pelatihan tenaga pengelola SIAK'),
(1668, 174, 3, 'Implementasi Sistem Administrasi Kependudukan (membangun, updating dan pemeliharaan)'),
(1669, 174, 4, 'Pembentukan dan Penataan Sistem Koneksi (Inter-Phase Tahap Awal) NIK'),
(1670, 174, 5, 'Koordinasi pelaksanaan kebijakan kependudukan'),
(1671, 174, 6, 'Pengolahan dalam penyusunan laporan informasi kependudukan'),
(1672, 174, 7, 'Peningkatan pelayanan publik dalam bidang kependudukan'),
(1673, 174, 8, 'Pengembangan data base kependudukan'),
(1674, 174, 9, 'Penyusunan kebijakan kependudukan'),
(1675, 174, 10, 'Peningkatan kapasitas aparat kependudukan dan catatan sipil'),
(1676, 174, 11, 'Sosialisasi kebijakan kependudukan'),
(1677, 174, 12, 'Peningkatan kapasitas kelembagaan kependudukan'),
(1678, 174, 13, 'Monitoring, evaluasi dan pelaporan'),
(1679, 175, 0, 'Non Kegiatan'),
(1680, 176, 1, 'Penyediaan jasa surat menyurat'),
(1681, 176, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(1682, 176, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(1683, 176, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(1684, 176, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(1685, 176, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(1686, 176, 7, 'Penyediaan jasa administrasi keuangan'),
(1687, 176, 8, 'Penyediaan jasa kebersihan kantor'),
(1688, 176, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(1689, 176, 10, 'Penyediaan alat tulis kantor'),
(1690, 176, 11, 'Penyediaan barang cetakan dan penggandaan'),
(1691, 176, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(1692, 176, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(1693, 176, 14, 'Penyediaan peralatan rumah tangga'),
(1694, 176, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(1695, 176, 16, 'Penyediaan bahan logistik kantor'),
(1696, 176, 17, 'Penyediaan makanan dan minuman'),
(1697, 176, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(1698, 176, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(1699, 177, 1, 'Pembangunan rumah jabatan'),
(1700, 177, 2, 'Pembangunan rumah dinas'),
(1701, 177, 3, 'Pembangunan gedung kantor'),
(1702, 177, 4, 'Pengadaan mobil jabatan'),
(1703, 177, 5, 'pengadaan Kendaraan dinas/operasional'),
(1704, 177, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(1705, 177, 7, 'Pengadaan perlengkapan gedung kantor'),
(1706, 177, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(1707, 177, 9, 'Pengadaan peralatan gedung kantor'),
(1708, 177, 10, 'Pengadaan mebeleur'),
(1709, 177, 11, 'Pengadaan ……'),
(1710, 177, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(1711, 177, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(1712, 177, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(1713, 177, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(1714, 177, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(1715, 177, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(1716, 177, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(1717, 177, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(1718, 177, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(1719, 177, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(1720, 177, 30, 'Pemeliharaan rutin/berkala …..'),
(1721, 177, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(1722, 177, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(1723, 177, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(1724, 177, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(1725, 177, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(1726, 178, 1, 'Pengadaan mesin/kartu absensi'),
(1727, 178, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(1728, 178, 3, 'Pengadaan pakaian kerja lapangan'),
(1729, 178, 4, 'Pengadaan pakaian KORPRI'),
(1730, 178, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(1731, 179, 1, 'Pemulangan pegawai yang pensiun'),
(1732, 179, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(1733, 179, 3, 'Pemindahan tugas PNS'),
(1734, 180, 1, 'Pendidikan dan pelatihan formal'),
(1735, 180, 2, 'Sosialisasi peraturan perundang-undangan'),
(1736, 180, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(1737, 181, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(1738, 181, 2, 'Penyusunan pelaporan keuangan semesteran'),
(1739, 181, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(1740, 181, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(1741, 182, 1, 'Pemberdayaan Lembaga dan Organisasi Masyarakat Perdesaan'),
(1742, 182, 2, 'Penyelenggaraan Pendidikan dan Pelatihan Tenaga Teknis dan Masyarakat'),
(1743, 182, 3, 'Penyelenggaraan Diseminasi Informasi bagi Masyarakat Desa'),
(1744, 183, 1, 'Pelatihan ketrampilan usaha budidaya tanaman'),
(1745, 183, 2, 'Pelatihan ketrampilan manajemen badan usaha milik desa'),
(1746, 183, 3, 'Pelatihan ketrampilan usaha industri kerajinan'),
(1747, 183, 4, 'Pelatihan ketrampilan usaha pertanian dan peternakan'),
(1748, 183, 5, 'Fasilitasi permodalan bagi usaha mikro kecil dan menengah di perdesaan'),
(1749, 183, 6, 'Fasilitasi kemitraan swasta dan usaha mikro kecil dan menengah di perdesaan'),
(1750, 183, 7, 'Monitoring, evaluasi dan pelaporan'),
(1751, 184, 1, 'Pembinaan kelompok masyarakat pembangunan desa'),
(1752, 184, 2, 'Pelaksanaan musyawarah pembangunan desa'),
(1753, 184, 3, 'Pemberian stimulan pembangunan desa'),
(1754, 184, 4, 'Monitoring, evaluasi dan pelaporan'),
(1755, 185, 1, 'Pelatihan aparatur pemerintah desa dalam bidang pembangunan kawasan perdesaan'),
(1756, 185, 2, 'Pelatihan aparatur pemerintah desa dalam bidang pengelolaan keuangan daerah'),
(1757, 185, 3, 'Pelatihan aparatur pemerintah desa dalam bidang manajemen pemerintahan desa'),
(1758, 185, 4, 'Monitoring, evaluasi dan pelaporan'),
(1759, 186, 1, 'Pelatihan perempuan di perdesaan dalam bidang usaha ekonomi produktif'),
(1760, 187, 0, 'Non Kegiatan'),
(1761, 188, 1, 'Penyediaan jasa surat menyurat'),
(1762, 188, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(1763, 188, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(1764, 188, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(1765, 188, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(1766, 188, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(1767, 188, 7, 'Penyediaan jasa administrasi keuangan'),
(1768, 188, 8, 'Penyediaan jasa kebersihan kantor'),
(1769, 188, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(1770, 188, 10, 'Penyediaan alat tulis kantor'),
(1771, 188, 11, 'Penyediaan barang cetakan dan penggandaan'),
(1772, 188, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(1773, 188, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(1774, 188, 14, 'Penyediaan peralatan rumah tangga'),
(1775, 188, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(1776, 188, 16, 'Penyediaan bahan logistik kantor'),
(1777, 188, 17, 'Penyediaan makanan dan minuman'),
(1778, 188, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(1779, 188, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(1780, 189, 1, 'Pembangunan rumah jabatan'),
(1781, 189, 2, 'Pembangunan rumah dinas'),
(1782, 189, 3, 'Pembangunan gedung kantor'),
(1783, 189, 4, 'Pengadaan mobil jabatan'),
(1784, 189, 5, 'pengadaan Kendaraan dinas/operasional'),
(1785, 189, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(1786, 189, 7, 'Pengadaan perlengkapan gedung kantor'),
(1787, 189, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(1788, 189, 9, 'Pengadaan peralatan gedung kantor'),
(1789, 189, 10, 'Pengadaan mebeleur'),
(1790, 189, 11, 'Pengadaan ……'),
(1791, 189, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(1792, 189, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(1793, 189, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(1794, 189, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(1795, 189, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(1796, 189, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(1797, 189, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(1798, 189, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(1799, 189, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(1800, 189, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(1801, 189, 30, 'Pemeliharaan rutin/berkala …..'),
(1802, 189, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(1803, 189, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(1804, 189, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(1805, 189, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(1806, 189, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(1807, 190, 1, 'Pengadaan mesin/kartu absensi'),
(1808, 190, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(1809, 190, 3, 'Pengadaan pakaian kerja lapangan'),
(1810, 190, 4, 'Pengadaan pakaian KORPRI'),
(1811, 190, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(1812, 191, 1, 'Pemulangan pegawai yang pensiun'),
(1813, 191, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(1814, 191, 3, 'Pemindahan tugas PNS'),
(1815, 192, 1, 'Pendidikan dan pelatihan formal'),
(1816, 192, 2, 'Sosialisasi peraturan perundang-undangan'),
(1817, 192, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(1818, 193, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(1819, 193, 2, 'Penyusunan pelaporan keuangan semesteran'),
(1820, 193, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(1821, 193, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(1822, 194, 1, 'Penyediaan pelayanan KB dan Alat kontrasepsi bagi Keluarga Miskin'),
(1823, 194, 2, 'Pelayanan KIE'),
(1824, 194, 3, 'Peningkatan Perlindungan Hak Reproduksi Individu'),
(1825, 194, 4, 'Promosi Pelayanan Khiba'),
(1826, 194, 5, 'Pembinaan Keluarga Berencana'),
(1827, 194, 6, 'Pengadaan sarana mobilitas tim KB keliling'),
(1828, 195, 1, 'Advokasi dan KIE tentang Kesehatan Reproduksi Remaja (KRR)'),
(1829, 195, 2, 'Memperkuat dukungan dan partisipasi masyarakat'),
(1830, 196, 1, 'Pelayanan konseling KB'),
(1831, 196, 2, 'Pelayanan pemasangan kontrasepsi KB'),
(1832, 196, 3, 'Pengadaan alat kontrasepsi'),
(1833, 196, 4, 'Pelayanan KB medis operasi'),
(1834, 197, 1, 'Fasilitasi pembentukan kelompok masyarakat peduli KB'),
(1835, 198, 1, 'Penyuluhan kesehatan ibu, bayi dan anak melalui kelompok dimasyarakat'),
(1836, 199, 1, 'Pendirian pusat pelayanan informasi dan konseling KKR'),
(1837, 199, 2, 'Fasilitasi forum pelayanan KKR bagi kelompok remaja dan kelompok sebaya diluar sekolah'),
(1838, 200, 1, 'Penyuluhan penanggulangan narkoba dan PMS di sekolah'),
(1839, 201, 1, 'Pengumpulan bahan informasi tentang pengasuhan dan pembinaan tumbuh kembang anak'),
(1840, 202, 1, 'Pelatihan tenaga pedamping kelompok bina keluarga di kecamatan'),
(1841, 203, 1, 'Pengkajian pengembangan model operasional BKB-Posyandu-PADU'),
(1842, 204, 0, 'Non Kegiatan'),
(1843, 205, 1, 'Penyediaan jasa surat menyurat'),
(1844, 205, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(1845, 205, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(1846, 205, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(1847, 205, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(1848, 205, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(1849, 205, 7, 'Penyediaan jasa administrasi keuangan'),
(1850, 205, 8, 'Penyediaan jasa kebersihan kantor'),
(1851, 205, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(1852, 205, 10, 'Penyediaan alat tulis kantor'),
(1853, 205, 11, 'Penyediaan barang cetakan dan penggandaan'),
(1854, 205, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(1855, 205, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(1856, 205, 14, 'Penyediaan peralatan rumah tangga'),
(1857, 205, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(1858, 205, 16, 'Penyediaan bahan logistik kantor'),
(1859, 205, 17, 'Penyediaan makanan dan minuman'),
(1860, 205, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(1861, 205, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(1862, 206, 1, 'Pembangunan rumah jabatan'),
(1863, 206, 2, 'Pembangunan rumah dinas'),
(1864, 206, 3, 'Pembangunan gedung kantor'),
(1865, 206, 4, 'Pengadaan mobil jabatan'),
(1866, 206, 5, 'pengadaan Kendaraan dinas/operasional'),
(1867, 206, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(1868, 206, 7, 'Pengadaan perlengkapan gedung kantor'),
(1869, 206, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(1870, 206, 9, 'Pengadaan peralatan gedung kantor'),
(1871, 206, 10, 'Pengadaan mebeleur'),
(1872, 206, 11, 'Pengadaan ……'),
(1873, 206, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(1874, 206, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(1875, 206, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(1876, 206, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(1877, 206, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(1878, 206, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(1879, 206, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(1880, 206, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(1881, 206, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(1882, 206, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(1883, 206, 30, 'Pemeliharaan rutin/berkala …..'),
(1884, 206, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(1885, 206, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(1886, 206, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(1887, 206, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(1888, 206, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(1889, 207, 1, 'Pengadaan mesin/kartu absensi'),
(1890, 207, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(1891, 207, 3, 'Pengadaan pakaian kerja lapangan'),
(1892, 207, 4, 'Pengadaan pakaian KORPRI'),
(1893, 207, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(1894, 208, 1, 'Pemulangan pegawai yang pensiun'),
(1895, 208, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(1896, 208, 3, 'Pemindahan tugas PNS'),
(1897, 209, 1, 'Pendidikan dan pelatihan formal'),
(1898, 209, 2, 'Sosialisasi peraturan perundang-undangan'),
(1899, 209, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(1900, 210, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(1901, 210, 2, 'Penyusunan pelaporan keuangan semesteran'),
(1902, 210, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(1903, 210, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(1904, 211, 1, 'Perencanaan pembangunan prasarana dan fasilitas perhubungan'),
(1905, 211, 2, 'Penyusunan kebijakan, norma, standar dan prosedur bidang perhubungan'),
(1906, 211, 3, 'Koordinasi dalam pembangunan prasarana dan fasilitas perhubungan'),
(1907, 211, 4, 'Sosialisasi kebijakan di bidang perhubungan'),
(1908, 211, 5, 'Pembangunan sarana dan prasarana jembatan timbang'),
(1909, 211, 6, 'Peningkatan pengelolaan terminal angkutan sungai, danau dan penyeberangan'),
(1910, 211, 7, 'Peningkatan pengelolaan terminal angkutan darat'),
(1911, 211, 8, 'Monitoring, evaluasi dan pelaporan'),
(1912, 212, 1, 'Rehabilitasi/pemeliharaan sarana alat pengujian kendaraan bermotor'),
(1913, 212, 2, 'Rehabilitasi/pemeliharaan prasarana balai pengujian kendaraan bermotor'),
(1914, 212, 3, 'Rehabilitasi/pemeliharaan sarana dan prasarana jembatan timbang'),
(1915, 212, 4, 'Rehabilitasi/pemeliharaan terminal/pelabuhan'),
(1916, 213, 1, 'Kegiatan penyuluhan bagi para sopir/juru mudi untuk peningkatan keselamatan penumpang'),
(1917, 213, 2, 'Kegiatan peningkatan disiplin masyarakat menggunakan angkutan'),
(1918, 213, 3, 'Kegiatan temu wicana pengelola angkutan umum guna meningkatkan keselamatan penumpang'),
(1919, 213, 4, 'Kegiatan uji kelayakan sarana transportasi guna keselamatan penumpang'),
(1920, 213, 5, 'Kegiatan pengendalian disiplin pengoperasian angkutan umum dijalan raya'),
(1921, 213, 6, 'Kegiatan penciptaan keamanan dan kenyamanan penumpang di lingkungan terminal'),
(1922, 213, 7, 'Kegiatan pengawasan peralatan keamanan dalam keadaan darurat dan perlengkapan pertolongan pertama'),
(1923, 213, 8, 'Kegiatan penataan tempat-tempat pemberhentian angkutan umum'),
(1924, 213, 9, 'Kegiatan penciptaan disiplin dan pemeliharaan kebersihan dilingkungan terminal'),
(1925, 213, 10, 'Kegiatan penciptaan pelayanan cepat, tepat, murah dan mudah'),
(1926, 213, 11, 'Pengumpulan dan analisis data base pelayanan angkutan'),
(1927, 213, 12, 'Pengembangan sarana dan prasarana pelayanan jasa angkutan'),
(1928, 213, 13, 'Fasilitasi perijinan di bidang perhubungan'),
(1929, 213, 14, 'Sosialisasi/penyuluhan ketertiban lalu lintas dan angkutan'),
(1930, 213, 15, 'Kegiatan pemilihan dan pemberian penghargaan sopir/juru mudi/awak kendaraan angkutan umum teladan'),
(1931, 213, 16, 'Koordinasi dalam peningkatan pelayanan angkutan'),
(1932, 213, 17, 'Monitoring, evaluasi dan pelaporan'),
(1933, 214, 1, 'Pembangunan gedung terminal'),
(1934, 214, 2, 'Pembangunan Halte bus, taxi gedung terminal'),
(1935, 214, 3, 'Pembangunan jembatan penyebrangan gedung terminal'),
(1936, 215, 1, 'Pengadaan rambu-rambu lalu lintas'),
(1937, 215, 2, 'Pengadaan marka jalan'),
(1938, 215, 3, 'Pengadaan pagar pengaman jalan'),
(1939, 216, 1, 'Pembangunan balai pengujian kendaraan bermotor'),
(1940, 216, 2, 'Pengadaan alat pengujian kendaraan bermotor'),
(1941, 216, 3, 'Pelaksanaan uji petik kendaraan bermotor'),
(1942, 217, 0, 'Non Kegiatan'),
(1943, 218, 1, 'Penyediaan jasa surat menyurat'),
(1944, 218, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(1945, 218, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(1946, 218, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(1947, 218, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(1948, 218, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(1949, 218, 7, 'Penyediaan jasa administrasi keuangan'),
(1950, 218, 8, 'Penyediaan jasa kebersihan kantor'),
(1951, 218, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(1952, 218, 10, 'Penyediaan alat tulis kantor'),
(1953, 218, 11, 'Penyediaan barang cetakan dan penggandaan'),
(1954, 218, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(1955, 218, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(1956, 218, 14, 'Penyediaan peralatan rumah tangga'),
(1957, 218, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(1958, 218, 16, 'Penyediaan bahan logistik kantor'),
(1959, 218, 17, 'Penyediaan makanan dan minuman'),
(1960, 218, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(1961, 218, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(1962, 219, 1, 'Pembangunan rumah jabatan'),
(1963, 219, 2, 'Pembangunan rumah dinas'),
(1964, 219, 3, 'Pembangunan gedung kantor'),
(1965, 219, 4, 'Pengadaan mobil jabatan'),
(1966, 219, 5, 'pengadaan Kendaraan dinas/operasional'),
(1967, 219, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(1968, 219, 7, 'Pengadaan perlengkapan gedung kantor'),
(1969, 219, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(1970, 219, 9, 'Pengadaan peralatan gedung kantor'),
(1971, 219, 10, 'Pengadaan mebeleur'),
(1972, 219, 11, 'Pengadaan ……'),
(1973, 219, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(1974, 219, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(1975, 219, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(1976, 219, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(1977, 219, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(1978, 219, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(1979, 219, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(1980, 219, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(1981, 219, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(1982, 219, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(1983, 219, 30, 'Pemeliharaan rutin/berkala …..'),
(1984, 219, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(1985, 219, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(1986, 219, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(1987, 219, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(1988, 219, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(1989, 220, 1, 'Pengadaan mesin/kartu absensi'),
(1990, 220, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(1991, 220, 3, 'Pengadaan pakaian kerja lapangan'),
(1992, 220, 4, 'Pengadaan pakaian KORPRI'),
(1993, 220, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(1994, 221, 1, 'Pemulangan pegawai yang pensiun'),
(1995, 221, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(1996, 221, 3, 'Pemindahan tugas PNS'),
(1997, 222, 1, 'Pendidikan dan pelatihan formal'),
(1998, 222, 2, 'Sosialisasi peraturan perundang-undangan'),
(1999, 222, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(2000, 223, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(2001, 223, 2, 'Penyusunan pelaporan keuangan semesteran'),
(2002, 223, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(2003, 223, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(2004, 224, 1, 'Fasilitasi penyempurnaan peraturan perundangan penyiaran dan KMIP'),
(2005, 224, 2, 'Pembinaan dan Pengembangan Jaringan Komunikasi dan Informasi'),
(2006, 224, 3, 'Pembinaan dan pengembangan sumber daya komunikasi dan informasi'),
(2007, 224, 4, 'Pengadaan alat studio dan komunikasi'),
(2008, 224, 5, 'Pengkajian dan pengembangan sistem informasi'),
(2009, 224, 6, 'Perencanaan dan pengembangan kebijakan komunikasi dan informasi'),
(2010, 225, 1, 'Pengkajian dan penelitian bidang informasi dan komunikasi'),
(2011, 226, 1, 'Pelatihan SDM dalam bidang komunikasi dan informasi'),
(2012, 227, 1, 'Penyebarluasan informasi pembangunan daerah'),
(2013, 227, 2, 'Penyebarluasan informasi penyelenggaraan pemerintahan daerah'),
(2014, 227, 3, 'Penyebarluasan informasi yang bersifat penyuluhan bagi masyarakat'),
(2015, 228, 0, 'Non Kegiatan'),
(2016, 229, 1, 'Penyediaan jasa surat menyurat'),
(2017, 229, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(2018, 229, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(2019, 229, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(2020, 229, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(2021, 229, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(2022, 229, 7, 'Penyediaan jasa administrasi keuangan'),
(2023, 229, 8, 'Penyediaan jasa kebersihan kantor'),
(2024, 229, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(2025, 229, 10, 'Penyediaan alat tulis kantor'),
(2026, 229, 11, 'Penyediaan barang cetakan dan penggandaan'),
(2027, 229, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(2028, 229, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(2029, 229, 14, 'Penyediaan peralatan rumah tangga'),
(2030, 229, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(2031, 229, 16, 'Penyediaan bahan logistik kantor'),
(2032, 229, 17, 'Penyediaan makanan dan minuman'),
(2033, 229, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(2034, 229, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(2035, 230, 1, 'Pembangunan rumah jabatan'),
(2036, 230, 2, 'Pembangunan rumah dinas'),
(2037, 230, 3, 'Pembangunan gedung kantor'),
(2038, 230, 4, 'Pengadaan mobil jabatan'),
(2039, 230, 5, 'pengadaan Kendaraan dinas/operasional'),
(2040, 230, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(2041, 230, 7, 'Pengadaan perlengkapan gedung kantor'),
(2042, 230, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(2043, 230, 9, 'Pengadaan peralatan gedung kantor'),
(2044, 230, 10, 'Pengadaan mebeleur'),
(2045, 230, 11, 'Pengadaan ……'),
(2046, 230, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(2047, 230, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(2048, 230, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(2049, 230, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(2050, 230, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(2051, 230, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(2052, 230, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(2053, 230, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(2054, 230, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(2055, 230, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(2056, 230, 30, 'Pemeliharaan rutin/berkala …..'),
(2057, 230, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(2058, 230, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(2059, 230, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(2060, 230, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(2061, 230, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(2062, 231, 1, 'Pengadaan mesin/kartu absensi'),
(2063, 231, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(2064, 231, 3, 'Pengadaan pakaian kerja lapangan'),
(2065, 231, 4, 'Pengadaan pakaian KORPRI'),
(2066, 231, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(2067, 232, 1, 'Pemulangan pegawai yang pensiun'),
(2068, 232, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(2069, 232, 3, 'Pemindahan tugas PNS'),
(2070, 233, 1, 'Pendidikan dan pelatihan formal'),
(2071, 233, 2, 'Sosialisasi peraturan perundang-undangan'),
(2072, 233, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(2073, 234, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(2074, 234, 2, 'Penyusunan pelaporan keuangan semesteran'),
(2075, 234, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(2076, 234, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(2077, 235, 1, 'Penyusunan kebijakan tentang Usaha Kecil Menengah'),
(2078, 235, 2, 'Sosialisasi kebijakan tentang Usaha Kecil Menengah'),
(2079, 235, 3, 'Fasilitasi kemudahan formalisasi badan usaha Usaha Kecil Menengah'),
(2080, 235, 4, 'Pendirian unit penanganan pengaduan'),
(2081, 235, 5, 'Pengkajian dampak regulasi/kebijakan nasional'),
(2082, 235, 6, 'Perencanaan, koordinasi, dan pengembangan Usaha Kecil Menengah'),
(2083, 235, 7, 'Pengembangan jaringan infrastruktur Usaha Kecil Menengah'),
(2084, 235, 8, 'Fasilitasi pengembangan Usaha Kecil Menengah'),
(2085, 235, 9, 'Fasilitasi permasalahan proses produksi Usaha Kecil Menengah'),
(2086, 235, 10, 'Pemberian fasilitasi pengamanan kawasan Usaha Kecil Menengah'),
(2087, 235, 11, 'Monitoring, evaluasi dan pelaporan'),
(2088, 236, 1, 'Fasilitasi pengembangan inkubator teknologi dan bisnis'),
(2089, 236, 2, 'Memfasilitasi peningkatan kemitraan investasi Usaha Kecil Menengah dengan perusahaan asing'),
(2090, 236, 3, 'Memfasilitasi peningkatan kemitraan usaha bagi Usaha Mikro Kecil Menengah'),
(2091, 236, 4, 'Peningkatan kerjasama di bidang HAKI'),
(2092, 236, 5, 'Fasilitasi pengembangan sarana promosi hasil produksi'),
(2093, 236, 6, 'Penyelenggaraan pelatihan kewirausahaan'),
(2094, 236, 7, 'Pelatihan manajemen pengelolaan Koperasi/KUD'),
(2095, 236, 8, 'Sosialisasi HAKI kepada Usaha Mikro Kecil menengah'),
(2096, 236, 9, 'Sosialisasi dan pelatihan pola pengelolaan limbah industri dalam menjaga kelestarian kawasan Usaha Mikro Kecil Menengah'),
(2097, 236, 10, 'Monitoring, evaluasi dan pelaporan'),
(2098, 237, 1, 'Sosialisasi dukungan informasi penyediaan permodalan'),
(2099, 237, 2, 'Pengembangan klaster bisnis'),
(2100, 237, 3, 'Koordinasi pemanfaatan fasilitas pemerintah untuk Usaha Kecil Menengah dan koperasi'),
(2101, 237, 4, 'Koordinasi penggunaan dana pemerintah bagi Usaha Mikro Kecil Menengah'),
(2102, 237, 5, 'Pemantauan pengelolaan penggunaan dana pemerintah bagi Usaha Mikro Kecil Menengah'),
(2103, 237, 6, 'Pengembangan sarana pemasaran produk Usaha Mikro Kecil Menengah'),
(2104, 237, 7, 'Peningkatan jaringan kerjasama antar lembaga'),
(2105, 237, 8, 'Penyelenggaraan pembinaan industri rumah tanggan, industri kecil dan industri menengah'),
(2106, 237, 9, 'Penyelenggaraan promosi produk Usaha Mikro kecil Menengah'),
(2107, 237, 10, 'Pengembangan kebijakan dan program peningkatan ekonomi lokal'),
(2108, 237, 11, 'Monitoring, evaluasi dan pelaporan'),
(2109, 238, 1, 'Koordinasi pelaksanaan kebijakan dan program pembangunan koperasi'),
(2110, 238, 2, 'Peningkatan sarana dan prasarana pendidikan dan pelatihan perkoperasian'),
(2111, 238, 3, 'Pembangunan sistem informasi perencanaan pengembangan perkopersian'),
(2112, 238, 4, 'Sosialisasi prinsip-prinsip pemahaman perkoperasian'),
(2113, 238, 5, 'Pembinaan, pengawasan, dan perhargaan koperasi berprestasi'),
(2114, 238, 6, 'Peningkatan dan pengembangan jaringan kerjasama usaha koperasi'),
(2115, 238, 7, 'Penyebaran model-model pola pengembangan koperasi'),
(2116, 238, 8, 'Rintisan penerapan teknologi sederhana/manajemen modern pada jenis usaha koperasi'),
(2117, 238, 9, 'Monitoring, evaluasi dan pelaporan'),
(2118, 239, 0, 'Non Kegiatan'),
(2119, 240, 1, 'Penyediaan jasa surat menyurat'),
(2120, 240, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(2121, 240, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(2122, 240, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(2123, 240, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(2124, 240, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(2125, 240, 7, 'Penyediaan jasa administrasi keuangan'),
(2126, 240, 8, 'Penyediaan jasa kebersihan kantor'),
(2127, 240, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(2128, 240, 10, 'Penyediaan alat tulis kantor'),
(2129, 240, 11, 'Penyediaan barang cetakan dan penggandaan'),
(2130, 240, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(2131, 240, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(2132, 240, 14, 'Penyediaan peralatan rumah tangga'),
(2133, 240, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(2134, 240, 16, 'Penyediaan bahan logistik kantor'),
(2135, 240, 17, 'Penyediaan makanan dan minuman'),
(2136, 240, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(2137, 240, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(2138, 241, 1, 'Pembangunan rumah jabatan'),
(2139, 241, 2, 'Pembangunan rumah dinas'),
(2140, 241, 3, 'Pembangunan gedung kantor'),
(2141, 241, 4, 'Pengadaan mobil jabatan'),
(2142, 241, 5, 'pengadaan Kendaraan dinas/operasional'),
(2143, 241, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(2144, 241, 7, 'Pengadaan perlengkapan gedung kantor'),
(2145, 241, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(2146, 241, 9, 'Pengadaan peralatan gedung kantor'),
(2147, 241, 10, 'Pengadaan mebeleur'),
(2148, 241, 11, 'Pengadaan ……'),
(2149, 241, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(2150, 241, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(2151, 241, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(2152, 241, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(2153, 241, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(2154, 241, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(2155, 241, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(2156, 241, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(2157, 241, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(2158, 241, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(2159, 241, 30, 'Pemeliharaan rutin/berkala …..'),
(2160, 241, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(2161, 241, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(2162, 241, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(2163, 241, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(2164, 241, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(2165, 242, 1, 'Pengadaan mesin/kartu absensi'),
(2166, 242, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(2167, 242, 3, 'Pengadaan pakaian kerja lapangan'),
(2168, 242, 4, 'Pengadaan pakaian KORPRI'),
(2169, 242, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(2170, 243, 1, 'Pemulangan pegawai yang pensiun'),
(2171, 243, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(2172, 243, 3, 'Pemindahan tugas PNS'),
(2173, 244, 1, 'Pendidikan dan pelatihan formal'),
(2174, 244, 2, 'Sosialisasi peraturan perundang-undangan'),
(2175, 244, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(2176, 245, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(2177, 245, 2, 'Penyusunan pelaporan keuangan semesteran'),
(2178, 245, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(2179, 245, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(2180, 246, 1, 'Peningkatan fasilitasi terwujudnya kerjasama strategis antara usaha besar dan Usaha Kecil Menengah'),
(2181, 246, 2, 'Pengembangan potensi unggulan daerah'),
(2182, 246, 3, 'Fasilitasi dan koordinasi percepatan pembangunan kawasan produksi daerah tertinggal (P2KPDT)'),
(2183, 246, 4, 'Koordinasi antar lembaga dalam pengendalian pelaksanaan investasi PMDN/PMA'),
(2184, 246, 5, 'Koordinasi perencanaan dan pengembangan penanaman modal'),
(2185, 246, 6, 'Peningkatan koordinasi dan kerjasama di bidang penanaman modal dengan instansi pemerintah dan dunia usaha'),
(2186, 246, 7, 'Pengawasan dan evaluasi kinerja dan aparatur Badan Penanaman Modal Daerah'),
(2187, 246, 8, 'Peningkatan kegiatan pemantauan, pembinaan dan pengawasan pelaksanaan penanaman modal'),
(2188, 246, 9, 'Peningkatan kualitas SDM guna peningkatan pelayanan Investasi'),
(2189, 246, 10, 'Penyelenggaraan pameran investasi'),
(2190, 246, 11, 'Monitoring, evaluasi dan pelaporan'),
(2191, 247, 1, 'Penyusunan kebijakan investasi bagi pembangunan fasilitas infrastruktur'),
(2192, 247, 2, 'Memfasilitasi dan koordinasi kerjasama di bidang investasi'),
(2193, 247, 3, 'Penyusunan Cetak Biru (Master Plan) pengembangan penanaman modal'),
(2194, 247, 4, 'Pengembangan System Informasi Penanaman Modal'),
(2195, 247, 5, 'Penyusunan sistem informasi penanaman modal di daerah'),
(2196, 247, 6, 'Penyederhanaan prosedur perijinan dan peningkatan pelayanan penanaman modal'),
(2197, 247, 7, 'Kajian kebijakan penanaman modal'),
(2198, 247, 8, 'Pemberian insentif di wilayah tertinggal'),
(2199, 247, 9, 'Monitoring, evaluasi dan pelaporan'),
(2200, 248, 1, 'Kajian potensi sumberdaya yang terkait dengan investasi'),
(2201, 249, 0, 'Non Kegiatan'),
(2202, 250, 1, 'Penyediaan jasa surat menyurat'),
(2203, 250, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(2204, 250, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(2205, 250, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(2206, 250, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(2207, 250, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(2208, 250, 7, 'Penyediaan jasa administrasi keuangan'),
(2209, 250, 8, 'Penyediaan jasa kebersihan kantor'),
(2210, 250, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(2211, 250, 10, 'Penyediaan alat tulis kantor'),
(2212, 250, 11, 'Penyediaan barang cetakan dan penggandaan'),
(2213, 250, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(2214, 250, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(2215, 250, 14, 'Penyediaan peralatan rumah tangga'),
(2216, 250, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(2217, 250, 16, 'Penyediaan bahan logistik kantor'),
(2218, 250, 17, 'Penyediaan makanan dan minuman'),
(2219, 250, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(2220, 250, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(2221, 251, 1, 'Pembangunan rumah jabatan'),
(2222, 251, 2, 'Pembangunan rumah dinas'),
(2223, 251, 3, 'Pembangunan gedung kantor'),
(2224, 251, 4, 'Pengadaan mobil jabatan'),
(2225, 251, 5, 'pengadaan Kendaraan dinas/operasional'),
(2226, 251, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(2227, 251, 7, 'Pengadaan perlengkapan gedung kantor'),
(2228, 251, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(2229, 251, 9, 'Pengadaan peralatan gedung kantor'),
(2230, 251, 10, 'Pengadaan mebeleur'),
(2231, 251, 11, 'Pengadaan ……'),
(2232, 251, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(2233, 251, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(2234, 251, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(2235, 251, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(2236, 251, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(2237, 251, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(2238, 251, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(2239, 251, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(2240, 251, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(2241, 251, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(2242, 251, 30, 'Pemeliharaan rutin/berkala …..'),
(2243, 251, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(2244, 251, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(2245, 251, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(2246, 251, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(2247, 251, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(2248, 252, 1, 'Pengadaan mesin/kartu absensi'),
(2249, 252, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(2250, 252, 3, 'Pengadaan pakaian kerja lapangan'),
(2251, 252, 4, 'Pengadaan pakaian KORPRI'),
(2252, 252, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(2253, 253, 1, 'Pemulangan pegawai yang pensiun'),
(2254, 253, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(2255, 253, 3, 'Pemindahan tugas PNS'),
(2256, 254, 1, 'Pendidikan dan pelatihan formal'),
(2257, 254, 2, 'Sosialisasi peraturan perundang-undangan'),
(2258, 254, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(2259, 255, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(2260, 255, 2, 'Penyusunan pelaporan keuangan semesteran'),
(2261, 255, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(2262, 255, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(2263, 256, 1, 'Pendataan potensi kepemudaan'),
(2264, 256, 2, 'Pemantauan dan evaluasi pelaksanaan pembangunan pemuda'),
(2265, 256, 3, 'Penelitian dan pengkajian kebijakan-kebijakan pembangunan kepemudaan'),
(2266, 256, 4, 'Pengembangan sistem informasi manajemen kepemudaan berbasis E-YOUTH'),
(2267, 256, 5, 'Peningkatan keimanan dan ketaqwaan kepemudaan'),
(2268, 256, 6, 'Penyusunan pedoman komunikasi, informasi, edukasi, dan advokasi tentang kepemimpinan pemuda'),
(2269, 256, 7, 'Penyusunan rancangan pola kemitraan antar pemuda dengan masyarakat'),
(2270, 256, 8, 'Perluasan penyusunan rencana aksi daerah bidang kepemudaan'),
(2271, 256, 9, 'Perumusan kebijakan kewirausahaan bagi pemuda'),
(2272, 256, 10, 'Monitoring, evaluasi dan pelaporan'),
(2273, 257, 1, 'Pembinaan organisasi kepemudaan'),
(2274, 257, 2, 'Pendidikan dan pelatihan dasar kepemimpinan'),
(2275, 257, 3, 'Fasilitasi aksi bhakti sosial kepemudaan'),
(2276, 257, 4, 'Fasilitasi pekan temu wicara organisasi pemuda'),
(2277, 257, 5, 'Penyuluhan pencegahan penggunaan narkoba dikalangan generasi muda'),
(2278, 257, 6, 'Lomba kreasi dan karya tulis ilmiah dikalangan pemuda'),
(2279, 257, 7, 'Pembinaan pemuda pelopor keamanan lingkungan'),
(2280, 257, 8, 'Pameran prestasi hasil karya pemudan'),
(2281, 257, 9, 'Monitoring, evaluasi dan pelaporan'),
(2282, 258, 1, 'Pelatihan kewirausahaan bagi pemuda'),
(2283, 258, 2, 'Pelatihan ketrampilan bagi pemuda'),
(2284, 259, 1, 'Pemberian penyuluhan tentang bahaya narkoba bagi pemuda'),
(2285, 260, 1, 'Peningkatan mutu organisasi dan tenaga keolahragaan'),
(2286, 260, 2, 'Pengembangan sistem sertifikasi dan standarisasi profesi'),
(2287, 260, 3, 'Pengembangan perencanaan olah raga terpadu'),
(2288, 260, 4, 'Pemantauan dan evaluasi pelaksanaan pengembangan olahraga'),
(2289, 260, 5, 'Pembinaan manajemen organisasi olahraga'),
(2290, 260, 6, 'Pengkajian kebijakan-kebijakan pembangunan olahraga'),
(2291, 260, 7, 'Penyusunan pola kemitraan pemerintah dan masyarakat dalam pembangunan dan pengembangan industri olahraga'),
(2292, 260, 8, 'Monitoring, evaluasi dan pelaporan'),
(2293, 261, 1, 'Pelaksanaan identifikasi bakat dan potensi pelajar dalam olahraga'),
(2294, 261, 2, 'Pelaksanaan identifikasi dan pengembangan olahraga unggulan daerah'),
(2295, 261, 3, 'Pembibitan dan pembinaan olahragawan berbakat'),
(2296, 261, 4, 'Pembinaan cabang olahraga prestasi di tingkat daerah'),
(2297, 261, 5, 'Peningkatan kesegaran jasmani dan rekreasi'),
(2298, 261, 6, 'Penyelenggaraan kompetisi olahraga'),
(2299, 261, 7, 'Permassalan olah raga bagi pelajar, mahasiswa, dan masyarakat'),
(2300, 261, 8, 'Pemberian penghargaan bagi insan olahraga yang berdedikasi dan berprestasi'),
(2301, 261, 9, 'Pengembangan dan pemanfaatan IPTEK olahraga sebagai pendorong peningkatan prestasi olahraga'),
(2302, 261, 10, 'Pengembangan olahraga lanjut usia termasuk penyandang cacat'),
(2303, 261, 11, 'Pengembangan olahraga rekreasi'),
(2304, 261, 12, 'Peningkatan jaminan kesejahteraan bagi masa depan atlet, pelatih, dan teknisi olahraga'),
(2305, 261, 13, 'Peningkatan jumlah dan kualitas serta kompetensi pelatih, peneliti, praktisi, dan teknisi olahraga'),
(2306, 261, 14, 'Pembinaan olahraga yang berkembang di masyarakat'),
(2307, 261, 15, 'Peningkatan manajemen organisasi olahraga tingkat perkumpulan dan tingkat daerah'),
(2308, 261, 16, 'Kerjasama peningkatan olahragawan berbakat dan berprestasi dengan lembaga/instansi lainnya'),
(2309, 262, 1, 'Peningkatan kerjasama pola kemitraan antara pemerintah dan masyarakat untuk pembangunan sarana dan prasarana olahraga'),
(2310, 262, 2, 'Peningkatan pembangunan sarana dan prasarana olah raga'),
(2311, 262, 3, 'Pemantauan dan evaluasi pembangunan sarana dan prasarana olah raga'),
(2312, 262, 5, 'Pengembangan dan pemanfaatan iptek dalam pengembangan sarana dan prasarana olahraga'),
(2313, 262, 6, 'Peningkatan peran dunia usaha dalam pengembangan sarana dan prasarana olahraga'),
(2314, 262, 7, 'Pemeliharaan rutin/berkala sarana dan prasarana olah raga'),
(2315, 263, 0, 'Non Kegiatan'),
(2316, 264, 1, 'Penyediaan jasa surat menyurat'),
(2317, 264, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(2318, 264, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(2319, 264, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(2320, 264, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(2321, 264, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(2322, 264, 7, 'Penyediaan jasa administrasi keuangan'),
(2323, 264, 8, 'Penyediaan jasa kebersihan kantor'),
(2324, 264, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(2325, 264, 10, 'Penyediaan alat tulis kantor'),
(2326, 264, 11, 'Penyediaan barang cetakan dan penggandaan'),
(2327, 264, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(2328, 264, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(2329, 264, 14, 'Penyediaan peralatan rumah tangga'),
(2330, 264, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(2331, 264, 16, 'Penyediaan bahan logistik kantor'),
(2332, 264, 17, 'Penyediaan makanan dan minuman'),
(2333, 264, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(2334, 264, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(2335, 265, 1, 'Pembangunan rumah jabatan'),
(2336, 265, 2, 'Pembangunan rumah dinas'),
(2337, 265, 3, 'Pembangunan gedung kantor'),
(2338, 265, 4, 'Pengadaan mobil jabatan'),
(2339, 265, 5, 'pengadaan Kendaraan dinas/operasional'),
(2340, 265, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(2341, 265, 7, 'Pengadaan perlengkapan gedung kantor'),
(2342, 265, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(2343, 265, 9, 'Pengadaan peralatan gedung kantor'),
(2344, 265, 10, 'Pengadaan mebeleur'),
(2345, 265, 11, 'Pengadaan ……'),
(2346, 265, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(2347, 265, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(2348, 265, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(2349, 265, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(2350, 265, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(2351, 265, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(2352, 265, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(2353, 265, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(2354, 265, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(2355, 265, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(2356, 265, 30, 'Pemeliharaan rutin/berkala …..'),
(2357, 265, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(2358, 265, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(2359, 265, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(2360, 265, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(2361, 265, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(2362, 266, 1, 'Pengadaan mesin/kartu absensi'),
(2363, 266, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(2364, 266, 3, 'Pengadaan pakaian kerja lapangan'),
(2365, 266, 4, 'Pengadaan pakaian KORPRI'),
(2366, 266, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(2367, 267, 1, 'Pemulangan pegawai yang pensiun'),
(2368, 267, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(2369, 267, 3, 'Pemindahan tugas PNS'),
(2370, 268, 1, 'Pendidikan dan pelatihan formal'),
(2371, 268, 2, 'Sosialisasi peraturan perundang-undangan'),
(2372, 268, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(2373, 269, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(2374, 269, 2, 'Penyusunan pelaporan keuangan semesteran'),
(2375, 269, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(2376, 269, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(2377, 270, 1, 'Penyusunan dan pengumpulan data dan statistik daerah'),
(2378, 270, 2, 'Pengolahan, updating dan analisis data dan statistik daerah'),
(2379, 270, 3, 'Penyusunan dan pengumpulan data PDRB'),
(2380, 270, 4, 'Pengolahan, updating dan analisis data PDRB'),
(2381, 271, 0, 'Non Kegiatan'),
(2382, 272, 1, 'Penyediaan jasa surat menyurat'),
(2383, 272, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(2384, 272, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(2385, 272, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(2386, 272, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(2387, 272, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(2388, 272, 7, 'Penyediaan jasa administrasi keuangan'),
(2389, 272, 8, 'Penyediaan jasa kebersihan kantor'),
(2390, 272, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(2391, 272, 10, 'Penyediaan alat tulis kantor'),
(2392, 272, 11, 'Penyediaan barang cetakan dan penggandaan');
INSERT INTO `ref_kegiatan` (`id_kegiatan`, `id_program`, `kd_kegiatan`, `nm_kegiatan`) VALUES
(2393, 272, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(2394, 272, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(2395, 272, 14, 'Penyediaan peralatan rumah tangga'),
(2396, 272, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(2397, 272, 16, 'Penyediaan bahan logistik kantor'),
(2398, 272, 17, 'Penyediaan makanan dan minuman'),
(2399, 272, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(2400, 272, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(2401, 273, 1, 'Pembangunan rumah jabatan'),
(2402, 273, 2, 'Pembangunan rumah dinas'),
(2403, 273, 3, 'Pembangunan gedung kantor'),
(2404, 273, 4, 'Pengadaan mobil jabatan'),
(2405, 273, 5, 'pengadaan Kendaraan dinas/operasional'),
(2406, 273, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(2407, 273, 7, 'Pengadaan perlengkapan gedung kantor'),
(2408, 273, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(2409, 273, 9, 'Pengadaan peralatan gedung kantor'),
(2410, 273, 10, 'Pengadaan mebeleur'),
(2411, 273, 11, 'Pengadaan ……'),
(2412, 273, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(2413, 273, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(2414, 273, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(2415, 273, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(2416, 273, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(2417, 273, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(2418, 273, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(2419, 273, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(2420, 273, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(2421, 273, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(2422, 273, 30, 'Pemeliharaan rutin/berkala …..'),
(2423, 273, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(2424, 273, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(2425, 273, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(2426, 273, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(2427, 273, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(2428, 274, 1, 'Pengadaan mesin/kartu absensi'),
(2429, 274, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(2430, 274, 3, 'Pengadaan pakaian kerja lapangan'),
(2431, 274, 4, 'Pengadaan pakaian KORPRI'),
(2432, 274, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(2433, 275, 1, 'Pemulangan pegawai yang pensiun'),
(2434, 275, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(2435, 275, 3, 'Pemindahan tugas PNS'),
(2436, 276, 1, 'Pendidikan dan pelatihan formal'),
(2437, 276, 2, 'Sosialisasi peraturan perundang-undangan'),
(2438, 276, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(2439, 277, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(2440, 277, 2, 'Penyusunan pelaporan keuangan semesteran'),
(2441, 277, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(2442, 277, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(2443, 278, 0, 'Non Kegiatan'),
(2444, 279, 1, 'Penyediaan jasa surat menyurat'),
(2445, 279, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(2446, 279, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(2447, 279, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(2448, 279, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(2449, 279, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(2450, 279, 7, 'Penyediaan jasa administrasi keuangan'),
(2451, 279, 8, 'Penyediaan jasa kebersihan kantor'),
(2452, 279, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(2453, 279, 10, 'Penyediaan alat tulis kantor'),
(2454, 279, 11, 'Penyediaan barang cetakan dan penggandaan'),
(2455, 279, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(2456, 279, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(2457, 279, 14, 'Penyediaan peralatan rumah tangga'),
(2458, 279, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(2459, 279, 16, 'Penyediaan bahan logistik kantor'),
(2460, 279, 17, 'Penyediaan makanan dan minuman'),
(2461, 279, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(2462, 279, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(2463, 280, 1, 'Pembangunan rumah jabatan'),
(2464, 280, 2, 'Pembangunan rumah dinas'),
(2465, 280, 3, 'Pembangunan gedung kantor'),
(2466, 280, 4, 'Pengadaan mobil jabatan'),
(2467, 280, 5, 'pengadaan Kendaraan dinas/operasional'),
(2468, 280, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(2469, 280, 7, 'Pengadaan perlengkapan gedung kantor'),
(2470, 280, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(2471, 280, 9, 'Pengadaan peralatan gedung kantor'),
(2472, 280, 10, 'Pengadaan mebeleur'),
(2473, 280, 11, 'Pengadaan ……'),
(2474, 280, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(2475, 280, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(2476, 280, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(2477, 280, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(2478, 280, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(2479, 280, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(2480, 280, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(2481, 280, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(2482, 280, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(2483, 280, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(2484, 280, 30, 'Pemeliharaan rutin/berkala …..'),
(2485, 280, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(2486, 280, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(2487, 280, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(2488, 280, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(2489, 280, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(2490, 281, 1, 'Pengadaan mesin/kartu absensi'),
(2491, 281, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(2492, 281, 3, 'Pengadaan pakaian kerja lapangan'),
(2493, 281, 4, 'Pengadaan pakaian KORPRI'),
(2494, 281, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(2495, 282, 1, 'Pemulangan pegawai yang pensiun'),
(2496, 282, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(2497, 282, 3, 'Pemindahan tugas PNS'),
(2498, 283, 1, 'Pendidikan dan pelatihan formal'),
(2499, 283, 2, 'Sosialisasi peraturan perundang-undangan'),
(2500, 283, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(2501, 284, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(2502, 284, 2, 'Penyusunan pelaporan keuangan semesteran'),
(2503, 284, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(2504, 284, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(2505, 285, 1, 'Pelestarian dan aktualisasi adat budaya daerah'),
(2506, 285, 2, 'Penetagunaan naskah kuno nusantara'),
(2507, 285, 3, 'Penyusunan kebijakan tentang budaya lokal daerah'),
(2508, 285, 4, 'Pemantauan dan evaluasi pelaksanaan program pengembangan nilai budaya'),
(2509, 285, 5, 'Pemberian dukungan, penghargaan dan kerjasama di bidang budaya'),
(2510, 286, 1, 'Fasilitasi partisipasi masyarakat dalam pengelolaan kekayaan budaya'),
(2511, 286, 2, 'Pelestarian fisik dan kandungan bahan pustaka termasuk naskah kuno'),
(2512, 286, 3, 'Penyusunan kebijakan pengelolaan kekayaan budaya lokal daerah'),
(2513, 286, 4, 'Sosialisasi pengelolaan kekayaan budaya lokal daerah'),
(2514, 286, 5, 'Pengelolaan dan pengembangan pelestarian peninggalan sejarah purbakala, museum dan peninggalan bawah air'),
(2515, 286, 6, 'Pengembangan kebudayaan dan pariwisata'),
(2516, 286, 7, 'Pengembangan nilai dan geografi sejarah'),
(2517, 286, 8, 'Perekaman dan digitalisasi bahan pustaka'),
(2518, 286, 9, 'Perumusan kebijakan sejarah dan purbakala'),
(2519, 286, 10, 'Pengawasan, Monitoring, evaluasi dan pelaporan pelaksanaan program pengelolaan kekayaan budaya'),
(2520, 286, 11, 'Pendukungan pengelolaan museum dan taman budaya di daerah'),
(2521, 286, 12, 'Pengelolaan karya cetak dan karya rekam'),
(2522, 286, 13, 'Pengembangan database sistem informasi sejarah purbakala'),
(2523, 287, 1, 'Pengembangan kesenian dan kebudayaan daerah'),
(2524, 287, 2, 'Penyusunan sistem informasi database bidang kebudayaan'),
(2525, 287, 3, 'Penyelenggaraan dialog kebudayaan'),
(2526, 287, 4, 'Fasilitasi perkembangan keragaman budaya daerah'),
(2527, 287, 5, 'Fasilitasi penyelenggaraan festival budaya daerah'),
(2528, 287, 6, 'Seminar dalam rangka revitalisasi dan reaktualisasi budaya lokal'),
(2529, 287, 7, 'Monitoring, evaluasi dan pelaporan pelaksanaan pengembangan keanekaragaman budaya'),
(2530, 288, 1, 'Fasilitasi pengembangan kemitraan dengan LSM dan perusahaan swasta'),
(2531, 288, 2, 'Fasilitasi pembentukan kemitraan usaha profesi antar daerah'),
(2532, 288, 3, 'Membangun kemitraanpengelolaan kebudayaan anatar daerah'),
(2533, 288, 4, 'Monitoring, evaluasi dan pelaporan'),
(2534, 289, 0, 'Non Kegiatan'),
(2535, 290, 1, 'Penyediaan Jasa Surat Menyurat'),
(2536, 290, 2, 'Penyediaan Jasa Komunikasi, Sumber Daya Air dan Listrik'),
(2537, 290, 3, 'Penyediaan Jasa Peralatan dan Perlengkapan Kantor'),
(2538, 290, 4, 'Penyediaan Jasa Jaminan Pemeliharaan Kesehatan PNS'),
(2539, 290, 5, 'Penyediaan Jasa Jaminan Barang Milik Daerah'),
(2540, 290, 6, 'Penyediaan Jasa Pemeliharaan dan Perizinan Kendaraan Dinas/Operasional'),
(2541, 290, 7, 'Penyediaan Jasa Administrasi Keuangan'),
(2542, 290, 8, 'Penyediaan Jasa Kebersihan Kantor'),
(2543, 290, 9, 'Penyediaan Jasa Perbaikan Peralatan Kerja'),
(2544, 290, 10, 'Penyediaan Alat Tulis Kantor'),
(2545, 290, 11, 'Penyediaan Barang Cetakan dan Penggandaan'),
(2546, 290, 12, 'Penyediaan Komponen Instalasi Listrik/Penerangan Bangunan Kantor'),
(2547, 290, 13, 'Penyediaan Peralatan dan Perlengkapan Kantor'),
(2548, 290, 14, 'Penyediaan Peralatan Rumah Tangga'),
(2549, 290, 15, 'Penyediaan Bahan Bacaan dan Peraturan Perundang-Undangan'),
(2550, 290, 16, 'Penyediaan Bahan Logistik Kantor'),
(2551, 290, 17, 'Penyediaan Makanan dan Minuman'),
(2552, 290, 18, 'Rapat-Rapat Koordinasi dan Konsultasi Ke Luar Daerah'),
(2553, 291, 1, 'Pembangunan Rumah Jabatan'),
(2554, 291, 2, 'Pembangunan Rumah Dinas'),
(2555, 291, 3, 'Pembangunan Gedung Kantor'),
(2556, 291, 4, 'Pengadaan Mobil Jabatan'),
(2557, 291, 5, 'Pengadaan Kendaraan Dinas/Operasional'),
(2558, 291, 6, 'Pengadaan Perlengkapan Rumah Jabatan/Dinas'),
(2559, 291, 7, 'Pengadaan Perlengkapan Gedung Kantor'),
(2560, 291, 8, 'Pengadaan Peralatan Rumah Jabatan/Dinas'),
(2561, 291, 9, 'Pengadaan Peralatan Gedung Kantor'),
(2562, 291, 10, 'Pengadaan Mebeleur'),
(2563, 291, 11, 'Pengadaan ......'),
(2564, 291, 20, 'Pemeliharaan Rutin/Berkala Rumah Jabatan'),
(2565, 291, 21, 'Pemeliharaan Rutin/Berkala Rumah Dinas'),
(2566, 291, 22, 'Pemeliharaan Rutin/Berkala Gedung Kantor'),
(2567, 291, 23, 'Pemeliharaan Rutin/Berkala Mobil Jabatan'),
(2568, 291, 24, 'Pemeliharaan Rutin/Berkala Kendaraan Dinas/Operasional'),
(2569, 291, 25, 'Pemeliharaan Rutin/Berkala Perlengkapan Rumah Jabatan/Dinas'),
(2570, 291, 26, 'Pemeliharaan Rutin/Berkala Perlengkapan Gedung Kantor'),
(2571, 291, 27, 'Pemeliharaan Rutin/Berkala Peralatan Rumah Jabatan/Dinas'),
(2572, 291, 28, 'Pemeliharaan Rutin/Berkala Peralatan Gedung Kantor'),
(2573, 291, 29, 'Pemeliharaan Rutin/Berkala Mebeleur'),
(2574, 291, 30, 'Pemeliharaan Rutin/Berkala ......'),
(2575, 291, 40, 'Rehabilitasi Sedang/Berat Rumah Jabatan'),
(2576, 291, 41, 'Rehabilitasi Sedang/Berat Rumah Dinas'),
(2577, 291, 42, 'Rehabilitasi Sedang/Berat Gedung Kantor'),
(2578, 291, 43, 'Rehabilitasi Sedang/Berat Mobil Jabatan'),
(2579, 291, 44, 'Rehabilitasi Sedang/Berat Kendaraan Dinas/Operasional'),
(2580, 292, 1, 'Pengadaan Mesin/Kartu Absensi'),
(2581, 292, 2, 'Pengadaan Pakaian Dinas Beserta Perlengkapannya'),
(2582, 292, 3, 'Pengadaan Pakaian Kerja Lapangan'),
(2583, 292, 4, 'Pengadaan Pakaian KORPRI'),
(2584, 292, 5, 'Pengadaan Pakaian Khusus Hari-Hari Tertentu'),
(2585, 293, 1, 'Pemulangan Pegawai yang Pensiun'),
(2586, 293, 2, 'Pemulangan Pegawai yang Tewas Dalam Melaksanakan Tugas'),
(2587, 293, 3, 'Pemindahan Tugas PNS'),
(2588, 294, 1, 'Pendidikan dan Pelatihan Formal'),
(2589, 294, 2, 'Sosialisasi Peraturan Perundang-Undangan'),
(2590, 294, 3, 'Bimbingan Teknis Implementasi Peraturan Perundang-Undangan'),
(2591, 295, 1, 'Penyusunan Laporan Capaian Kinerja dan Ikhtisar Realisasi Kinerja SKPD'),
(2592, 295, 2, 'Penyusunan Pelaporan Keuangan Semesteran'),
(2593, 295, 3, 'Penyusunan Pelaporan Prognosis Realisasi Anggaran'),
(2594, 295, 4, 'Penyusunan Pelaporan Keuangan Akhir Tahun'),
(2595, 296, 1, 'Pemasyarakatan Minat dan Kebiasaan Membaca Untuk Mendorong Terwujudnya Masyarakat Pembelajar'),
(2596, 296, 2, 'Pengembangan Minat dan Budaya Baca'),
(2597, 296, 3, 'Supervisi, Pembinaan dan Stimulasi Pada Perpustakaan Umum, Perpustakaan Khusus, Perpustakaan Sekolah dan Perpustakaan Masyarakat'),
(2598, 296, 4, 'Pelaksanaan Koordinasi Pengembangan Perpustakaan'),
(2599, 296, 5, 'Penyediaan Bantuan Pengembangan Perpustakaan dan Minat Baca Di Daerah'),
(2600, 296, 6, 'Penyelenggaraan Koordinasi Pengembangan Budaya Baca'),
(2601, 296, 7, 'Perencanaan dan Penyusunan Program Budaya Baca'),
(2602, 296, 8, 'Publikasi dan Sosialisasi Minat dan Budaya Baca'),
(2603, 296, 9, 'Penyediaan Bahan Pustaka Perpustakaan Umum Daerah'),
(2604, 296, 10, 'Monitoring, Evaluasi dan Pelaporan'),
(2605, 297, 0, 'Non Kegiatan'),
(2606, 298, 1, 'Penyediaan jasa surat menyurat'),
(2607, 298, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(2608, 298, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(2609, 298, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(2610, 298, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(2611, 298, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(2612, 298, 7, 'Penyediaan jasa administrasi keuangan'),
(2613, 298, 8, 'Penyediaan jasa kebersihan kantor'),
(2614, 298, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(2615, 298, 10, 'Penyediaan alat tulis kantor'),
(2616, 298, 11, 'Penyediaan barang cetakan dan penggandaan'),
(2617, 298, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(2618, 298, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(2619, 298, 14, 'Penyediaan peralatan rumah tangga'),
(2620, 298, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(2621, 298, 16, 'Penyediaan bahan logistik kantor'),
(2622, 298, 17, 'Penyediaan makanan dan minuman'),
(2623, 298, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(2624, 298, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(2625, 299, 1, 'Pembangunan rumah jabatan'),
(2626, 299, 2, 'Pembangunan rumah dinas'),
(2627, 299, 3, 'Pembangunan gedung kantor'),
(2628, 299, 4, 'Pengadaan mobil jabatan'),
(2629, 299, 5, 'pengadaan Kendaraan dinas/operasional'),
(2630, 299, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(2631, 299, 7, 'Pengadaan perlengkapan gedung kantor'),
(2632, 299, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(2633, 299, 9, 'Pengadaan peralatan gedung kantor'),
(2634, 299, 10, 'Pengadaan mebeleur'),
(2635, 299, 11, 'Pengadaan ……'),
(2636, 299, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(2637, 299, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(2638, 299, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(2639, 299, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(2640, 299, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(2641, 299, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(2642, 299, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(2643, 299, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(2644, 299, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(2645, 299, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(2646, 299, 30, 'Pemeliharaan rutin/berkala …..'),
(2647, 299, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(2648, 299, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(2649, 299, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(2650, 299, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(2651, 299, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(2652, 300, 1, 'Pengadaan mesin/kartu absensi'),
(2653, 300, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(2654, 300, 3, 'Pengadaan pakaian kerja lapangan'),
(2655, 300, 4, 'Pengadaan pakaian KORPRI'),
(2656, 300, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(2657, 301, 1, 'Pemulangan pegawai yang pensiun'),
(2658, 301, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(2659, 301, 3, 'Pemindahan tugas PNS'),
(2660, 302, 1, 'Pendidikan dan pelatihan formal'),
(2661, 302, 2, 'Sosialisasi peraturan perundang-undangan'),
(2662, 302, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(2663, 303, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(2664, 303, 2, 'Penyusunan pelaporan keuangan semesteran'),
(2665, 303, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(2666, 303, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(2667, 304, 1, 'Pembangunan data base informasi kearsipan'),
(2668, 304, 2, 'Pengumpulan data'),
(2669, 304, 3, 'Pengklasifikasian data'),
(2670, 304, 4, 'Penyusunan sistem katalog data'),
(2671, 304, 5, 'Pengadaan sarana penyimpanan'),
(2672, 304, 6, 'Kajian sistem administrasi kearsipan'),
(2673, 304, 7, 'Pemeliharaan peralatan jaringan informasi kearsipan'),
(2674, 305, 1, 'Pengadaan sarana pengolahan dan penyimpanan arsip'),
(2675, 305, 2, 'Pendataan dan penataan dokumen/arsip daerah'),
(2676, 305, 3, 'Penduplikasian dokumen/arsip daerah dalam bentuk informatika'),
(2677, 305, 4, 'Pembangunan sistem keamanan penyimpanan data'),
(2678, 306, 1, 'Pemeliharaan rutin/berkala sarana pengolahan dan penyimpanan arsip'),
(2679, 306, 2, 'Pemeliharaan rutin/berkala arsip daerah'),
(2680, 306, 3, 'Monitoring, evaluasi dan pelaporan kondisi situasi data'),
(2681, 307, 1, 'Penyusunan dan penerbitan naskah sumber arsip'),
(2682, 307, 2, 'Penyediaan sarana layanan informasi arsip'),
(2683, 307, 3, 'Sosialisasi/penyuluhan kearsipan dilingkungan instansi pemerintah/swasta'),
(2684, 308, 0, 'Non Kegiatan'),
(2685, 309, 1, 'Penyediaan jasa surat menyurat'),
(2686, 309, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(2687, 309, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(2688, 309, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(2689, 309, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(2690, 309, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(2691, 309, 7, 'Penyediaan jasa administrasi keuangan'),
(2692, 309, 8, 'Penyediaan jasa kebersihan kantor'),
(2693, 309, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(2694, 309, 10, 'Penyediaan alat tulis kantor'),
(2695, 309, 11, 'Penyediaan barang cetakan dan penggandaan'),
(2696, 309, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(2697, 309, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(2698, 309, 14, 'Penyediaan peralatan rumah tangga'),
(2699, 309, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(2700, 309, 16, 'Penyediaan bahan logistik kantor'),
(2701, 309, 17, 'Penyediaan makanan dan minuman'),
(2702, 309, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(2703, 309, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(2704, 310, 1, 'Pembangunan rumah jabatan'),
(2705, 310, 2, 'Pembangunan rumah dinas'),
(2706, 310, 3, 'Pembangunan gedung kantor'),
(2707, 310, 4, 'Pengadaan mobil jabatan'),
(2708, 310, 5, 'pengadaan Kendaraan dinas/operasional'),
(2709, 310, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(2710, 310, 7, 'Pengadaan perlengkapan gedung kantor'),
(2711, 310, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(2712, 310, 9, 'Pengadaan peralatan gedung kantor'),
(2713, 310, 10, 'Pengadaan mebeleur'),
(2714, 310, 11, 'Pengadaan ……'),
(2715, 310, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(2716, 310, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(2717, 310, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(2718, 310, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(2719, 310, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(2720, 310, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(2721, 310, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(2722, 310, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(2723, 310, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(2724, 310, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(2725, 310, 30, 'Pemeliharaan rutin/berkala …..'),
(2726, 310, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(2727, 310, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(2728, 310, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(2729, 310, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(2730, 310, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(2731, 311, 1, 'Pengadaan mesin/kartu absensi'),
(2732, 311, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(2733, 311, 3, 'Pengadaan pakaian kerja lapangan'),
(2734, 311, 4, 'Pengadaan pakaian KORPRI'),
(2735, 311, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(2736, 312, 1, 'Pemulangan pegawai yang pensiun'),
(2737, 312, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(2738, 312, 3, 'Pemindahan tugas PNS'),
(2739, 313, 1, 'Pendidikan dan pelatihan formal'),
(2740, 313, 2, 'Sosialisasi peraturan perundang-undangan'),
(2741, 313, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(2742, 314, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(2743, 314, 2, 'Penyusunan pelaporan keuangan semesteran'),
(2744, 314, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(2745, 314, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(2746, 315, 1, 'Pembinaan kelompok ekonomi masyarakat pesisir'),
(2747, 316, 1, 'Pembentukan kelompok masyarakat swakarsa pengamanan sumberdaya kelautan'),
(2748, 317, 1, 'Penyuluhan hukum dalam pendayagunaan sumberdaya laut'),
(2749, 318, 1, 'Kajian mitigasi bencana alam laut dan prakiraan iklim laut'),
(2750, 319, 1, 'Penyuluhan budaya kelautan'),
(2751, 320, 1, 'Pengembangan bibit ikan unggul'),
(2752, 320, 2, 'Pendampingan pada kelompok tani pembudidaya ikan'),
(2753, 320, 3, 'Pembinaan dan pengembangan perikanan'),
(2754, 321, 1, 'Pendampingan pada kelompok nelayan perikanan tangkap'),
(2755, 321, 2, 'Pembangunan tempat pelelangan ikan'),
(2756, 321, 3, 'Pemeliharaan rutin/berkala tempat pelelangan ikan'),
(2757, 321, 4, 'Rehabilitasi sedang/berat tempat pelelangan ikan'),
(2758, 321, 5, 'Pengembangan lembaga usaha perdagangan perikanan tangkap'),
(2759, 322, 1, 'Kajian sistem penyuluhan perikanan'),
(2760, 323, 1, 'Kajian optimalisasi pengelolaan dan pemasaran produksi perikanan'),
(2761, 324, 1, 'Kajian kawasan budidaya laut, air payau dan air tawar'),
(2762, 325, 0, 'Non Kegiatan'),
(2763, 326, 1, 'Penyediaan jasa surat menyurat'),
(2764, 326, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(2765, 326, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(2766, 326, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(2767, 326, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(2768, 326, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(2769, 326, 7, 'Penyediaan jasa administrasi keuangan'),
(2770, 326, 8, 'Penyediaan jasa kebersihan kantor'),
(2771, 326, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(2772, 326, 10, 'Penyediaan alat tulis kantor'),
(2773, 326, 11, 'Penyediaan barang cetakan dan penggandaan'),
(2774, 326, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(2775, 326, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(2776, 326, 14, 'Penyediaan peralatan rumah tangga'),
(2777, 326, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(2778, 326, 16, 'Penyediaan bahan logistik kantor'),
(2779, 326, 17, 'Penyediaan makanan dan minuman'),
(2780, 326, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(2781, 326, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(2782, 327, 1, 'Pembangunan rumah jabatan'),
(2783, 327, 2, 'Pembangunan rumah dinas'),
(2784, 327, 3, 'Pembangunan gedung kantor'),
(2785, 327, 4, 'Pengadaan mobil jabatan'),
(2786, 327, 5, 'pengadaan Kendaraan dinas/operasional'),
(2787, 327, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(2788, 327, 7, 'Pengadaan perlengkapan gedung kantor'),
(2789, 327, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(2790, 327, 9, 'Pengadaan peralatan gedung kantor'),
(2791, 327, 10, 'Pengadaan mebeleur'),
(2792, 327, 11, 'Pengadaan ……'),
(2793, 327, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(2794, 327, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(2795, 327, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(2796, 327, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(2797, 327, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(2798, 327, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(2799, 327, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(2800, 327, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(2801, 327, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(2802, 327, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(2803, 327, 30, 'Pemeliharaan rutin/berkala …..'),
(2804, 327, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(2805, 327, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(2806, 327, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(2807, 327, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(2808, 327, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(2809, 328, 1, 'Pengadaan mesin/kartu absensi'),
(2810, 328, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(2811, 328, 3, 'Pengadaan pakaian kerja lapangan'),
(2812, 328, 4, 'Pengadaan pakaian KORPRI'),
(2813, 328, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(2814, 329, 1, 'Pemulangan pegawai yang pensiun'),
(2815, 329, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(2816, 329, 3, 'Pemindahan tugas PNS'),
(2817, 330, 1, 'Pendidikan dan pelatihan formal'),
(2818, 330, 2, 'Sosialisasi peraturan perundang-undangan'),
(2819, 330, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(2820, 331, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(2821, 331, 2, 'Penyusunan pelaporan keuangan semesteran'),
(2822, 331, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(2823, 331, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(2824, 332, 1, 'Analisa pasar untuk promosi dan pemasaran objek pariwisata'),
(2825, 332, 2, 'Peningkatan pemanfaatan teknologi informasi dalam pemasaran pariwisata'),
(2826, 332, 3, 'Pengembangan jaringan kerja sama promosi pariwisata'),
(2827, 332, 4, 'Koordinasi dengan sektor pendukung pariwisata'),
(2828, 332, 5, 'Pelaksanaan promosi pariwisata nusantara di dalam dan di luar negeri'),
(2829, 332, 6, 'Pemantauan dan evaluasi pelaksanaan program pengembangan pemasaran pariwisata'),
(2830, 332, 7, 'Pengembangan statistik wisata terpadu'),
(2831, 332, 8, 'Pelatihan pemandu wisata terpadu'),
(2832, 333, 1, 'Pengembangan objek pariwisata unggulan'),
(2833, 333, 2, 'Peningkatan pembangunan sarana dan prasarana pariwisata'),
(2834, 333, 3, 'Pengembangan jenis dan paket wisata unggulan'),
(2835, 333, 4, 'Pelaksanaan koordinasi pembangunan objek pariwisata dengan lembaga/dunia usaha'),
(2836, 333, 5, 'Pemantauan dan evaluasi pelaksanaan program pengembangan destinasi pemasaran pariwisata'),
(2837, 333, 6, 'Pengembangan daerah tujuan wisata'),
(2838, 333, 7, 'Pengembangan, sosialisasi, dan penerapan swera pengawasan standarisasi'),
(2839, 334, 1, 'Pengembangan dan penguatan informasi dan database'),
(2840, 334, 2, 'Pengembangan dan penguatan litbang, kebudayaan dan pariwisata'),
(2841, 334, 3, 'Pengembangan SDM di bidang kebudayaan dan pariwisata bekerjasama dengan lembaga lainnya'),
(2842, 334, 4, 'Fasilitasi pembentukan forum komunikasi antar pelaku industri pariwisata dan budaya'),
(2843, 334, 5, 'Pelaksanaan koordinasi pembangunan kemitraan pariwisata'),
(2844, 334, 6, 'Pemantauan dan evaluasi pelaksanaan program peningkatan kemitraan'),
(2845, 334, 7, 'Pengembangan sumber daya manusia dan profesionalisme bidang pariwisata'),
(2846, 334, 8, 'Peningkatan peran serta masyarakat dalam pengembangan kemitraan pariwisata'),
(2847, 334, 9, 'Monitoring, evaluasi dan pelaporan'),
(2848, 335, 0, 'Non Kegiatan'),
(2849, 336, 1, 'Penyediaan jasa surat menyurat'),
(2850, 336, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(2851, 336, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(2852, 336, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(2853, 336, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(2854, 336, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(2855, 336, 7, 'Penyediaan jasa administrasi keuangan'),
(2856, 336, 8, 'Penyediaan jasa kebersihan kantor'),
(2857, 336, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(2858, 336, 10, 'Penyediaan alat tulis kantor'),
(2859, 336, 11, 'Penyediaan barang cetakan dan penggandaan'),
(2860, 336, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(2861, 336, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(2862, 336, 14, 'Penyediaan peralatan rumah tangga'),
(2863, 336, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(2864, 336, 16, 'Penyediaan bahan logistik kantor'),
(2865, 336, 17, 'Penyediaan makanan dan minuman'),
(2866, 336, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(2867, 337, 1, 'Pembangunan rumah jabatan'),
(2868, 337, 2, 'Pembangunan rumah dinas'),
(2869, 337, 3, 'Pembangunan gedung kantor'),
(2870, 337, 4, 'Pengadaan mobil jabatan'),
(2871, 337, 5, 'pengadaan Kendaraan dinas/operasional'),
(2872, 337, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(2873, 337, 7, 'Pengadaan perlengkapan gedung kantor'),
(2874, 337, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(2875, 337, 9, 'Pengadaan peralatan gedung kantor'),
(2876, 337, 10, 'Pengadaan mebeleur'),
(2877, 337, 11, 'Pengadaan ……'),
(2878, 337, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(2879, 337, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(2880, 337, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(2881, 337, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(2882, 337, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(2883, 337, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(2884, 337, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(2885, 337, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(2886, 337, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(2887, 337, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(2888, 337, 30, 'Pemeliharaan rutin/berkala …..'),
(2889, 337, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(2890, 337, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(2891, 337, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(2892, 337, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(2893, 337, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(2894, 338, 1, 'Pengadaan mesin/kartu absensi'),
(2895, 338, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(2896, 338, 3, 'Pengadaan pakaian kerja lapangan'),
(2897, 338, 4, 'Pengadaan pakaian KORPRI'),
(2898, 338, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(2899, 339, 1, 'Pemulangan pegawai yang pensiun'),
(2900, 339, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(2901, 339, 3, 'Pemindahan tugas PNS'),
(2902, 340, 1, 'Pendidikan dan pelatihan formal'),
(2903, 340, 2, 'Sosialisasi peraturan perundang-undangan'),
(2904, 340, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(2905, 341, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(2906, 341, 2, 'Penyusunan pelaporan keuangan semesteran'),
(2907, 341, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(2908, 341, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(2909, 342, 1, 'Pelatihan petani dan pelaku agribisnis'),
(2910, 342, 2, 'Penyuluhan dan pendampingan petani dan pelaku agribisnis'),
(2911, 342, 3, 'Peningkatan kemampuan lembaga petani'),
(2912, 342, 4, 'Peningkatan sistem insentif dan disinsentif bagi petani/kelompok tani'),
(2913, 342, 5, 'Penyuluhan dan bimbingan pemanfaatan dan produktivitas lahan tidur'),
(2914, 343, 1, 'Penelitian dan pengembangan pemasaran hasil produksi pertanian/perkebunan'),
(2915, 343, 2, 'Fasilitasi kerjasama regional/nasional/internasional penyediaan hasil produksi pertanian/perkebunan komplementer'),
(2916, 343, 3, 'Pembangunan sarana dan prasarana pasar kecamatan/perdesaan produksi hasil pertanian/perkebunan'),
(2917, 343, 4, 'Pembangunan pusat-pusat etalase/eksebisi/promosi atas hasil produksi pertanian/perkebunan'),
(2918, 343, 5, 'Pemeliharaan rutin/berkala sarana dan prasarana pasar kecamatan/perdesaan produksi hasil pertanian/perkebunan'),
(2919, 343, 6, 'Pemeliharaan rutin/berkala pusat-pusat etalase/eksebisi/promosi atas hasil produksi pertanian/perkebunan'),
(2920, 343, 7, 'Promosi atas hasil produksi pertanian/perkebunan unggulan daerah'),
(2921, 343, 8, 'Penyuluhan pemasaran produksi pertanian/perkebunan guna menghindari tengkulak dan sistem ijon'),
(2922, 343, 9, 'Pembangunan pusat-pusat penampungan produksi hasil pertanian/perkebunan masyarakat yang akan dipasarkan'),
(2923, 343, 10, 'Pengolahan informasi permintaan pasar atas hasil produksi pertanian/perkebunan masyarakat'),
(2924, 343, 11, 'Penyuluhan distribusi pemasaran atas hasil produksi pertanian/perkebunan masyarakat'),
(2925, 343, 12, 'Penyuluhan kualitas dan teknis kemasan hasil produksi pertanian/perkebunan yang akan dipasarkan'),
(2926, 343, 13, 'Monitoring, evaluasi dan pelaporan'),
(2927, 344, 1, 'Penelitian dan pengembanan teknologi pertanian/perkebunan tepat guna'),
(2928, 344, 2, 'Pengadaan sarana dan prasarana teknologi pertanian/perkebunan tepat guna'),
(2929, 344, 3, 'Pemeliharaan rutin/berkala sarana dan prasarana teknologi pertanian/perkebunan tepat guna'),
(2930, 344, 4, 'Kegiatan penyuluhan penerapan teknologi pertanian/perkebunan tepat guna'),
(2931, 344, 5, 'Pelatihan dan bimbingan pengoperasian teknologi pertanian/perkebunan tepat guna'),
(2932, 344, 6, 'Pelatihan penerapan teknologi pertanian/perkebunan modern bercocok tanam'),
(2933, 344, 7, 'Monitoring, evaluasi dan pelaporan'),
(2934, 345, 1, 'Penyuluhan peningkatan produksi pertanian/perkebunan'),
(2935, 345, 2, 'Penyediaan sarana produksi pertanian/perkebunan'),
(2936, 345, 3, 'Pengembangan bibit unggul pertanian/perkebunan'),
(2937, 345, 4, 'Sertifikasi bibit unggul pertanian/perkebunan'),
(2938, 345, 5, 'Penyusunan kebijakan pencegahan alih fungsi lahan pertanian'),
(2939, 345, 6, 'Monitoring, evaluasi dan pelaporan'),
(2940, 346, 1, 'Peningkatan kapasitas tenaga penyuluh pertanian/perkebunan'),
(2941, 346, 2, 'Peningkatan kesejahteraan tenaga penyuluh pertanian/perkebunan'),
(2942, 346, 3, 'Penyuluhan dan pendampingan bagi pertanian/perkebunan'),
(2943, 347, 1, 'Pendataan masalah peternakan'),
(2944, 347, 2, 'Pemeliharaan kesehatan dan pencegahan penyakit menular ternak'),
(2945, 347, 3, 'Pemusnahan ternak yang terjangkit penyakit endemik'),
(2946, 347, 4, 'Pengawasan perdagangan ternak antar daerah'),
(2947, 347, 5, 'Monitoring, evaluasi dan pelaporan'),
(2948, 348, 1, 'Pembangunan sarana dan prasarana pembibitan ternak'),
(2949, 348, 2, 'Pembibitan dan perawatan ternak'),
(2950, 348, 3, 'Pendistribusian bibit ternak kepada masyarakat'),
(2951, 348, 4, 'Penyuluhan pengelolaan bibit ternak yang didistribusikan kepada masyarakat'),
(2952, 348, 5, 'Penilitian dan pengolahan gizi dan pakan ternak'),
(2953, 348, 6, 'Pembelian dan pendidistribusian vaksin dan pakan ternak'),
(2954, 348, 7, 'Penyuluhan kualitas gizi dan pakan ternak'),
(2955, 348, 8, 'Pengembangan agribisnis peternakan'),
(2956, 348, 9, 'Monitoring, evaluasi dan pelaporan'),
(2957, 349, 1, 'Penelitian dan pengembangan hasil produksi peternakan'),
(2958, 349, 2, 'Fasilitasi kerjasama regional/nasional/internasional penyediaan hasil produksi peternakan komplementer'),
(2959, 349, 3, 'Pembangunan sarana dan prasarana pasar produksi hasil peternakan'),
(2960, 349, 4, 'Pembangunan pusat-pusat etalase/eksebisi/promosi atas hasil produksi peternakan'),
(2961, 349, 5, 'Promosi atas hasil produksi peternakan unggulan daerah'),
(2962, 349, 6, 'Penyuluhan pemasaran produksi peternakan'),
(2963, 349, 7, 'Pembangunan pusat-pusat penampungan produksi hasil peternakan masyarakat'),
(2964, 349, 8, 'Pengolahan informasi permintaan pasar atas hasil produksi peternakan masyarakat'),
(2965, 349, 9, 'Penyuluhan distribusi pemasaran atas hasil produksi peternakan masyarakat'),
(2966, 349, 10, 'Penyuluhan kualitas dan teknis kemasan hasil produksi peternakan yang akan dipasarkan'),
(2967, 349, 11, 'Monitoring, evaluasi dan pelaporan'),
(2968, 349, 12, 'Pemeliharaan rutin/berkala sarana dan prasarana pasar produksi peternakan'),
(2969, 349, 13, 'Pemeliharaan rutin/berkala pusat-pusat etalase/eksebisi/promosi atas hasil produksi peternakan'),
(2970, 350, 1, 'Penelitian dan pengembangan teknologi peternakan tepat guna'),
(2971, 350, 2, 'Pengadaan sarana dan prasarana teknologi peternakan tepat guna'),
(2972, 350, 3, 'Pemeliharaan rutin/berkala sarana dan prasarana teknologi peternakan tepat guna'),
(2973, 350, 4, 'Kegiatan penyuluhan penerapan teknologi peternakan tepat guna'),
(2974, 350, 5, 'Pelatihan dan bimbingan pengoperasian teknologi peternakan tepat guna'),
(2975, 350, 6, 'Monitoring, evaluasi dan pelaporan'),
(2976, 351, 0, 'Non Kegiatan'),
(2977, 352, 1, 'Penyediaan jasa surat menyurat'),
(2978, 352, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(2979, 352, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(2980, 352, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(2981, 352, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(2982, 352, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(2983, 352, 7, 'Penyediaan jasa administrasi keuangan'),
(2984, 352, 8, 'Penyediaan jasa kebersihan kantor'),
(2985, 352, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(2986, 352, 10, 'Penyediaan alat tulis kantor'),
(2987, 352, 11, 'Penyediaan barang cetakan dan penggandaan'),
(2988, 352, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(2989, 352, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(2990, 352, 14, 'Penyediaan peralatan rumah tangga'),
(2991, 352, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(2992, 352, 16, 'Penyediaan bahan logistik kantor'),
(2993, 352, 17, 'Penyediaan makanan dan minuman'),
(2994, 352, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(2995, 352, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(2996, 353, 1, 'Pembangunan rumah jabatan'),
(2997, 353, 2, 'Pembangunan rumah dinas'),
(2998, 353, 3, 'Pembangunan gedung kantor'),
(2999, 353, 4, 'Pengadaan mobil jabatan'),
(3000, 353, 5, 'pengadaan Kendaraan dinas/operasional'),
(3001, 353, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(3002, 353, 7, 'Pengadaan perlengkapan gedung kantor'),
(3003, 353, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(3004, 353, 9, 'Pengadaan peralatan gedung kantor'),
(3005, 353, 10, 'Pengadaan mebeleur'),
(3006, 353, 11, 'Pengadaan ……'),
(3007, 353, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(3008, 353, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(3009, 353, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(3010, 353, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(3011, 353, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(3012, 353, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(3013, 353, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(3014, 353, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(3015, 353, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(3016, 353, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(3017, 353, 30, 'Pemeliharaan rutin/berkala …..'),
(3018, 353, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(3019, 353, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(3020, 353, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(3021, 353, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(3022, 353, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(3023, 354, 1, 'Pengadaan mesin/kartu absensi'),
(3024, 354, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(3025, 354, 3, 'Pengadaan pakaian kerja lapangan'),
(3026, 354, 4, 'Pengadaan pakaian KORPRI'),
(3027, 354, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(3028, 355, 1, 'Pemulangan pegawai yang pensiun'),
(3029, 355, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(3030, 355, 3, 'Pemindahan tugas PNS'),
(3031, 356, 1, 'Pendidikan dan pelatihan formal'),
(3032, 356, 2, 'Sosialisasi peraturan perundang-undangan'),
(3033, 356, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(3034, 357, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(3035, 357, 2, 'Penyusunan pelaporan keuangan semesteran'),
(3036, 357, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(3037, 357, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(3038, 358, 1, 'Pembentukan kesatuan pengelolaan hutan produksi'),
(3039, 358, 2, 'Pengembangan hutan tanaman'),
(3040, 358, 3, 'Pengembangan hasil hutan non kayu'),
(3041, 358, 4, 'Perencanaan dan pengembangan hutan kemasyarakatan'),
(3042, 358, 5, 'Optimalisasi PNBP'),
(3043, 358, 6, 'Pengelolaan dan pemanfaatan hutan'),
(3044, 358, 7, 'Pengembangan industri dan pemasaran hasil hutan'),
(3045, 358, 8, 'Pengembangan pengujian dan pengendalian peredaran hasil hutan'),
(3046, 358, 9, 'Monitoring, evaluasi dan pelaporan'),
(3047, 359, 1, 'Koordinasi penyelenggaraan reboisasi dan penghijauan hutan'),
(3048, 359, 2, 'Pembuatan bibit/benih tanaman kehutanan'),
(3049, 359, 3, 'Penanaman pohon pada kawasan hutan industri dan hutan wisata'),
(3050, 359, 4, 'Pemeliharaan kawasan hutan industri dan hutan wisata'),
(3051, 359, 5, 'Pembinaan, pengendalian dan pengawasan gerakan rehabilitasi hutan dan lahan'),
(3052, 359, 6, 'Peningkatan peran serta masyarakat dalam rehabilitasi hutan dan lahan'),
(3053, 359, 7, 'Monitoring, evaluasi dan pelaporan'),
(3054, 360, 1, 'Pencegahan dan pengendalian kebakaran hutan dan lahan'),
(3055, 360, 2, 'Sosialisasi pencegahan dan dampak kebakaran hutan dan lahan'),
(3056, 360, 3, 'Bimbingan teknis pengendalian kebakaran hutan dan lahan'),
(3057, 360, 4, 'Penanggulangan kebakaran hutan dan lahan'),
(3058, 360, 5, 'Penyuluhan kesadaran masyarakat mengenai dampak perusakan hutan'),
(3059, 361, 1, 'Pertanian tanaman palawija, padi gogorancah'),
(3060, 362, 1, 'Penyusunan peraturan daerah mengenai pengelolaan industri hasil hutan'),
(3061, 362, 2, 'Sosialisasi peraturan daerah mengenai pengelolaan industri hasil hutan'),
(3062, 362, 3, 'Pengawasan dan penertiban pelaksanaan peraturan daerah mengenai pengelolaan industri hasil hutan'),
(3063, 362, 4, 'Perluasan akses layanan informasi pemasaran hasil hutan'),
(3064, 362, 5, 'Monitoring, evaluasi dan pelaporan'),
(3065, 363, 1, 'Pengembangan hutan masyarakat adat'),
(3066, 363, 2, 'Pendampingan kelompok usaha perhutanan rakyat'),
(3067, 364, 0, 'Non Kegiatan'),
(3068, 365, 1, 'Penyediaan jasa surat menyurat'),
(3069, 365, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(3070, 365, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(3071, 365, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(3072, 365, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(3073, 365, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(3074, 365, 7, 'Penyediaan jasa administrasi keuangan'),
(3075, 365, 8, 'Penyediaan jasa kebersihan kantor'),
(3076, 365, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(3077, 365, 10, 'Penyediaan alat tulis kantor'),
(3078, 365, 11, 'Penyediaan barang cetakan dan penggandaan'),
(3079, 365, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(3080, 365, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(3081, 365, 14, 'Penyediaan peralatan rumah tangga'),
(3082, 365, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(3083, 365, 16, 'Penyediaan bahan logistik kantor'),
(3084, 365, 17, 'Penyediaan makanan dan minuman'),
(3085, 365, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(3086, 365, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(3087, 366, 1, 'Pembangunan rumah jabatan'),
(3088, 366, 2, 'Pembangunan rumah dinas'),
(3089, 366, 3, 'Pembangunan gedung kantor'),
(3090, 366, 4, 'Pengadaan mobil jabatan'),
(3091, 366, 5, 'pengadaan Kendaraan dinas/operasional'),
(3092, 366, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(3093, 366, 7, 'Pengadaan perlengkapan gedung kantor'),
(3094, 366, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(3095, 366, 9, 'Pengadaan peralatan gedung kantor'),
(3096, 366, 10, 'Pengadaan mebeleur'),
(3097, 366, 11, 'Pengadaan ……'),
(3098, 366, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(3099, 366, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(3100, 366, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(3101, 366, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(3102, 366, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(3103, 366, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(3104, 366, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(3105, 366, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(3106, 366, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(3107, 366, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(3108, 366, 30, 'Pemeliharaan rutin/berkala …..'),
(3109, 366, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(3110, 366, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(3111, 366, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(3112, 366, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(3113, 366, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(3114, 367, 1, 'Pengadaan mesin/kartu absensi'),
(3115, 367, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(3116, 367, 3, 'Pengadaan pakaian kerja lapangan'),
(3117, 367, 4, 'Pengadaan pakaian KORPRI'),
(3118, 367, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(3119, 368, 1, 'Pemulangan pegawai yang pensiun'),
(3120, 368, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(3121, 368, 3, 'Pemindahan tugas PNS'),
(3122, 369, 1, 'Pendidikan dan pelatihan formal'),
(3123, 369, 2, 'Sosialisasi peraturan perundang-undangan'),
(3124, 369, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(3125, 370, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(3126, 370, 2, 'Penyusunan pelaporan keuangan semesteran'),
(3127, 370, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(3128, 370, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(3129, 371, 1, 'Penyusunan regulasi mengenai kegiatan penambangan bahan galian C'),
(3130, 371, 2, 'Sosialisasi regulasi mengenai kegiatan penambangan bahan galian C'),
(3131, 371, 3, 'Monitoring dan pengendalian kegiatan penambangan bahan galian C'),
(3132, 371, 4, 'Koordinasi dan pendataan tentang hasil produksi dibidang pertambangan'),
(3133, 371, 5, 'Pengawasan terhadap pelaksanaan kegiatan penambangan bahan galian C'),
(3134, 371, 6, 'Monitoring, evaluasi dan pelaporan'),
(3135, 372, 1, 'Pengawasan penertiban kegiatan pertambangan rakyat'),
(3136, 372, 2, 'Monitoring, evaluasi dan pelaporan dampak kerusakan lingkungan akibat kegiatan pertambangan rakyat'),
(3137, 372, 3, 'Penyebaran peta daerah rawan bencana alam geologi'),
(3138, 373, 1, 'Koordinasi pengembangan ketenaga listrikan'),
(3139, 374, 0, 'Non Kegiatan'),
(3140, 375, 1, 'Penyediaan jasa surat menyurat'),
(3141, 375, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(3142, 375, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(3143, 375, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(3144, 375, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(3145, 375, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(3146, 375, 7, 'Penyediaan jasa administrasi keuangan'),
(3147, 375, 8, 'Penyediaan jasa kebersihan kantor'),
(3148, 375, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(3149, 375, 10, 'Penyediaan alat tulis kantor'),
(3150, 375, 11, 'Penyediaan barang cetakan dan penggandaan'),
(3151, 375, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(3152, 375, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(3153, 375, 14, 'Penyediaan peralatan rumah tangga'),
(3154, 375, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(3155, 375, 16, 'Penyediaan bahan logistik kantor'),
(3156, 375, 17, 'Penyediaan makanan dan minuman'),
(3157, 375, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(3158, 375, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(3159, 376, 1, 'Pembangunan rumah jabatan'),
(3160, 376, 2, 'Pembangunan rumah dinas'),
(3161, 376, 3, 'Pembangunan gedung kantor'),
(3162, 376, 4, 'Pengadaan mobil jabatan'),
(3163, 376, 5, 'pengadaan Kendaraan dinas/operasional'),
(3164, 376, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(3165, 376, 7, 'Pengadaan perlengkapan gedung kantor'),
(3166, 376, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(3167, 376, 9, 'Pengadaan peralatan gedung kantor'),
(3168, 376, 10, 'Pengadaan mebeleur'),
(3169, 376, 11, 'Pengadaan ……'),
(3170, 376, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(3171, 376, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(3172, 376, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(3173, 376, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(3174, 376, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(3175, 376, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(3176, 376, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(3177, 376, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(3178, 376, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(3179, 376, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(3180, 376, 30, 'Pemeliharaan rutin/berkala …..'),
(3181, 376, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(3182, 376, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(3183, 376, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(3184, 376, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(3185, 376, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(3186, 377, 1, 'Pengadaan mesin/kartu absensi'),
(3187, 377, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(3188, 377, 3, 'Pengadaan pakaian kerja lapangan'),
(3189, 377, 4, 'Pengadaan pakaian KORPRI'),
(3190, 377, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(3191, 378, 1, 'Pemulangan pegawai yang pensiun'),
(3192, 378, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(3193, 378, 3, 'Pemindahan tugas PNS');
INSERT INTO `ref_kegiatan` (`id_kegiatan`, `id_program`, `kd_kegiatan`, `nm_kegiatan`) VALUES
(3194, 379, 1, 'Pendidikan dan pelatihan formal'),
(3195, 379, 2, 'Sosialisasi peraturan perundang-undangan'),
(3196, 379, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(3197, 380, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(3198, 380, 2, 'Penyusunan pelaporan keuangan semesteran'),
(3199, 380, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(3200, 380, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(3201, 381, 1, 'koordinasi peningkatan hubungan kerja dengan lembaga perlindungan konsumen'),
(3202, 381, 2, 'Fasilitasi penyelesaian permasalahan-permasalahan pengaduan konsumen'),
(3203, 381, 3, 'Peningkatan pengawasan peredaran barang dan jasa'),
(3204, 381, 4, 'Operasionalisasi dan pengembangan UPT kemetrologian daerah'),
(3205, 382, 1, 'Penyiapan data base kuota setiap jenis barang dan jasa'),
(3206, 382, 2, 'Penyebarluasan informasi data base kuota setiap jenis barang dan jasa'),
(3207, 382, 3, 'Penyusunan tim daerah dalam perundingan perdagangan internasional'),
(3208, 382, 4, 'Fasilitasi penyelesaian sengketa dagang'),
(3209, 382, 5, 'Koordinasi pengelolaan isu-isu perdagangan internasional'),
(3210, 383, 1, 'Koordinasi dan sinkronisasi kebijakan pengembangan industri'),
(3211, 383, 2, 'Pengembangan informasi peluang pasar perdagangan luar negeri'),
(3212, 383, 3, 'Sosialisasi kebijakan penyederhanaan prosedur dan dokumen ekspor dan impor'),
(3213, 383, 4, 'Pengembangan data base informasi potensi unggulan'),
(3214, 383, 5, 'Kerjasama standarisasi mutu produk baik nasional, bilateral, regional dan internasional'),
(3215, 383, 6, 'Kerjasama dengan lembaga internasional dalam rangka pengembangan produk'),
(3216, 383, 7, 'Koordinasi penyelesaian masalah produksi dan distribusi sektor industri'),
(3217, 383, 8, 'Membangun jejaring dengan eksportir'),
(3218, 383, 9, 'Koordinasi program pengembangan ekspor dengan instansi terkait/asosiasi/pengusaha'),
(3219, 383, 10, 'Pengembangan kluster produk ekspor'),
(3220, 383, 11, 'Peningkatan kapasitas lab penguji mutu barang ekspor dan impor'),
(3221, 383, 12, 'Pembangunan promosi perdagangan internasional'),
(3222, 384, 1, 'Penyempurnaan perangkat peraturan, kebijakan dan pelaksanaan operasional'),
(3223, 384, 2, 'Fasilitasi kemudahan perijinan pengembangan usaha'),
(3224, 384, 3, 'Pengembangan pasar dan distribusi barang/produk'),
(3225, 384, 4, 'Pengembangan kelembagaan kerjasama kemitraan'),
(3226, 384, 5, 'Pengembangan pasar lelang daerah'),
(3227, 384, 6, 'Peningkatan sistem dan jaringan informasi perdagangan'),
(3228, 384, 7, 'Sosialisasi peningkatan penggunaan produk dalamnegeri'),
(3229, 385, 1, 'Kegiatan pembinaan organisasi pedagang kakilima dan asongan'),
(3230, 385, 2, 'Kegiatan penyuluhan peningkatan disiplin pedagang kakilima dan asongan'),
(3231, 385, 3, 'Kegiatan penataan tempat berusaha bagi pedagang kakilima dan asongan'),
(3232, 385, 4, 'Kegiatan fasilitasi modal usaha bagi pedagang kakilima dan asongan'),
(3233, 385, 5, 'Kegiatan pengawasan mutu dagangan pedagang kakilima dan asongan'),
(3234, 385, 6, 'Kegiatan pembangunan gudang penyimpanan barang pedagang kakilima dan asongan'),
(3235, 386, 0, 'Non Kegiatan'),
(3236, 387, 1, 'Penyediaan jasa surat menyurat'),
(3237, 387, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(3238, 387, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(3239, 387, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(3240, 387, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(3241, 387, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(3242, 387, 7, 'Penyediaan jasa administrasi keuangan'),
(3243, 387, 8, 'Penyediaan jasa kebersihan kantor'),
(3244, 387, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(3245, 387, 10, 'Penyediaan alat tulis kantor'),
(3246, 387, 11, 'Penyediaan barang cetakan dan penggandaan'),
(3247, 387, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(3248, 387, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(3249, 387, 14, 'Penyediaan peralatan rumah tangga'),
(3250, 387, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(3251, 387, 16, 'Penyediaan bahan logistik kantor'),
(3252, 387, 17, 'Penyediaan makanan dan minuman'),
(3253, 387, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(3254, 387, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(3255, 388, 1, 'Pembangunan rumah jabatan'),
(3256, 388, 2, 'Pembangunan rumah dinas'),
(3257, 388, 3, 'Pembangunan gedung kantor'),
(3258, 388, 4, 'Pengadaan mobil jabatan'),
(3259, 388, 5, 'pengadaan Kendaraan dinas/operasional'),
(3260, 388, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(3261, 388, 7, 'Pengadaan perlengkapan gedung kantor'),
(3262, 388, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(3263, 388, 9, 'Pengadaan peralatan gedung kantor'),
(3264, 388, 10, 'Pengadaan mebeleur'),
(3265, 388, 11, 'Pengadaan ……'),
(3266, 388, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(3267, 388, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(3268, 388, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(3269, 388, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(3270, 388, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(3271, 388, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(3272, 388, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(3273, 388, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(3274, 388, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(3275, 388, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(3276, 388, 30, 'Pemeliharaan rutin/berkala …..'),
(3277, 388, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(3278, 388, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(3279, 388, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(3280, 388, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(3281, 388, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(3282, 389, 1, 'Pengadaan mesin/kartu absensi'),
(3283, 389, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(3284, 389, 3, 'Pengadaan pakaian kerja lapangan'),
(3285, 389, 4, 'Pengadaan pakaian KORPRI'),
(3286, 389, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(3287, 390, 1, 'Pemulangan pegawai yang pensiun'),
(3288, 390, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(3289, 390, 3, 'Pemindahan tugas PNS'),
(3290, 391, 1, 'Pendidikan dan pelatihan formal'),
(3291, 391, 2, 'Sosialisasi peraturan perundang-undangan'),
(3292, 391, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(3293, 392, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(3294, 392, 2, 'Penyusunan pelaporan keuangan semesteran'),
(3295, 392, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(3296, 392, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(3297, 393, 1, 'Koordinasi model ventura bagi industri berbasis teknologi'),
(3298, 393, 2, 'Pelayanan pengembangan modal ventura dan inkubator'),
(3299, 393, 3, 'Pengembangan infrastruktur kelembagaan standarisasi'),
(3300, 393, 4, 'Pengembangan kapasitas pranata pengukuran, standarisasi, pengujian dan kualitas'),
(3301, 393, 5, 'Penegmbangan sistem inovasi teknologi industri'),
(3302, 393, 6, 'Penguatan kemampuan industri berbasis teknologi'),
(3303, 394, 1, 'Fasilitasi bagi industri kecil dan menengah terhadap pemanfaatan sumber daya'),
(3304, 394, 2, 'Pembinaan industri kecil dan menengah dalam memperkuat jaringan klaster industeri'),
(3305, 394, 3, 'Penyusunan kebijakan industri terkait dan industri penunjang industri kecil dan menengah'),
(3306, 394, 4, 'Pemberian kemudahan izin usaha industri kecil dan menengah'),
(3307, 394, 5, 'Pemberian fasilitas kemudahan akses perbankan bagi industri kecil dan menengah'),
(3308, 394, 6, 'Fasilitasi kerjasama kemitraan industri mikro, kecil dan menengah dengan swasta'),
(3309, 395, 1, 'Pembinaan kemampuan teknologi industri'),
(3310, 395, 2, 'Pengembangan dan pelayanan teknologi industri'),
(3311, 395, 3, 'Perluasan penerapan SNI untuk mendorong saya saing industri manufaktur'),
(3312, 395, 4, 'Perluasan penerapan standar produk industri manufaktur'),
(3313, 396, 1, 'Kebijakan keterkaitan industri hulu-hilir'),
(3314, 396, 2, 'Penyediaan sarana maupun prasarana klaster industri'),
(3315, 396, 3, 'Pembinaan keterkaitan produksi industri hulu hingga ke hilir'),
(3316, 397, 1, 'Pembangunan akses transportasi sentra-sentra industri potensial'),
(3317, 397, 2, 'Penyediaan sarana informasi yang dapat diakses masyarakat'),
(3318, 398, 0, 'Non Kegiatan'),
(3319, 399, 1, 'Penyediaan jasa surat menyurat'),
(3320, 399, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(3321, 399, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(3322, 399, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(3323, 399, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(3324, 399, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(3325, 399, 7, 'Penyediaan jasa administrasi keuangan'),
(3326, 399, 8, 'Penyediaan jasa kebersihan kantor'),
(3327, 399, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(3328, 399, 10, 'Penyediaan alat tulis kantor'),
(3329, 399, 11, 'Penyediaan barang cetakan dan penggandaan'),
(3330, 399, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(3331, 399, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(3332, 399, 14, 'Penyediaan peralatan rumah tangga'),
(3333, 399, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(3334, 399, 16, 'Penyediaan bahan logistik kantor'),
(3335, 399, 17, 'Penyediaan makanan dan minuman'),
(3336, 399, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(3337, 399, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(3338, 400, 1, 'Pembangunan rumah jabatan'),
(3339, 400, 2, 'Pembangunan rumah dinas'),
(3340, 400, 3, 'Pembangunan gedung kantor'),
(3341, 400, 4, 'Pengadaan mobil jabatan'),
(3342, 400, 5, 'pengadaan Kendaraan dinas/operasional'),
(3343, 400, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(3344, 400, 7, 'Pengadaan perlengkapan gedung kantor'),
(3345, 400, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(3346, 400, 9, 'Pengadaan peralatan gedung kantor'),
(3347, 400, 10, 'Pengadaan mebeleur'),
(3348, 400, 11, 'Pengadaan ……'),
(3349, 400, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(3350, 400, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(3351, 400, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(3352, 400, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(3353, 400, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(3354, 400, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(3355, 400, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(3356, 400, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(3357, 400, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(3358, 400, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(3359, 400, 30, 'Pemeliharaan rutin/berkala …..'),
(3360, 400, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(3361, 400, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(3362, 400, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(3363, 400, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(3364, 400, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(3365, 401, 1, 'Pengadaan mesin/kartu absensi'),
(3366, 401, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(3367, 401, 3, 'Pengadaan pakaian kerja lapangan'),
(3368, 401, 4, 'Pengadaan pakaian KORPRI'),
(3369, 401, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(3370, 402, 1, 'Pemulangan pegawai yang pensiun'),
(3371, 402, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(3372, 402, 3, 'Pemindahan tugas PNS'),
(3373, 403, 1, 'Pendidikan dan pelatihan formal'),
(3374, 403, 2, 'Sosialisasi peraturan perundang-undangan'),
(3375, 403, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(3376, 404, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(3377, 404, 2, 'Penyusunan pelaporan keuangan semesteran'),
(3378, 404, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(3379, 404, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(3380, 405, 1, 'Penguatan SDM pemerintah daerah dan masyarakat transmigrasi di kawasan transmigrasi di perbatasan'),
(3381, 405, 2, 'Peningkatan kerjasama antar wilayah, antar pelaku dan antar sektor dalam rangka pengembangan kawasan transmigrasi'),
(3382, 405, 3, 'Penyediaan dan pengelolaan prasarana dan sarana sosial dan ekonomi di kawasan transmigrasi'),
(3383, 405, 4, 'Penyediaan Lembaga Keuangan Daerah yang membantu modal usaha dikawasan transmigrasi'),
(3384, 405, 5, 'Pengerahan dan fasilitasi perpindahan serta penempatan transmigrasi untuk memenuhi kebutuhan SDM'),
(3385, 406, 1, 'Penyuluhan transmigrasi lokal'),
(3386, 406, 2, 'Pelatihan transmigrasi lokal'),
(3387, 407, 1, 'Penyuluhan transmigrasi regional'),
(3388, 407, 2, 'Pelatihan transmigrasi regional'),
(3389, 408, 0, 'Non Kegiatan'),
(3390, 409, 1, 'Penyediaan jasa surat menyurat'),
(3391, 409, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(3392, 409, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(3393, 409, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(3394, 409, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(3395, 409, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(3396, 409, 7, 'Penyediaan jasa administrasi keuangan'),
(3397, 409, 8, 'Penyediaan jasa kebersihan kantor'),
(3398, 409, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(3399, 409, 10, 'Penyediaan alat tulis kantor'),
(3400, 409, 11, 'Penyediaan barang cetakan dan penggandaan'),
(3401, 409, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(3402, 409, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(3403, 409, 14, 'Penyediaan peralatan rumah tangga'),
(3404, 409, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(3405, 409, 16, 'Penyediaan bahan logistik kantor'),
(3406, 409, 17, 'Penyediaan makanan dan minuman'),
(3407, 409, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(3408, 409, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(3409, 410, 1, 'Pembangunan rumah jabatan'),
(3410, 410, 2, 'Pembangunan rumah dinas'),
(3411, 410, 3, 'Pembangunan gedung kantor'),
(3412, 410, 4, 'Pengadaan mobil jabatan'),
(3413, 410, 5, 'pengadaan Kendaraan dinas/operasional'),
(3414, 410, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(3415, 410, 7, 'Pengadaan perlengkapan gedung kantor'),
(3416, 410, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(3417, 410, 9, 'Pengadaan peralatan gedung kantor'),
(3418, 410, 10, 'Pengadaan mebeleur'),
(3419, 410, 11, 'Pengadaan ……'),
(3420, 410, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(3421, 410, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(3422, 410, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(3423, 410, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(3424, 410, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(3425, 410, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(3426, 410, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(3427, 410, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(3428, 410, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(3429, 410, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(3430, 410, 30, 'Pemeliharaan rutin/berkala …..'),
(3431, 410, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(3432, 410, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(3433, 410, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(3434, 410, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(3435, 410, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(3436, 411, 1, 'Pengadaan mesin/kartu absensi'),
(3437, 411, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(3438, 411, 3, 'Pengadaan pakaian kerja lapangan'),
(3439, 411, 4, 'Pengadaan pakaian KORPRI'),
(3440, 411, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(3441, 412, 1, 'Pemulangan pegawai yang pensiun'),
(3442, 412, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(3443, 412, 3, 'Pemindahan tugas PNS'),
(3444, 413, 1, 'Pendidikan dan pelatihan formal'),
(3445, 413, 2, 'Sosialisasi peraturan perundang-undangan'),
(3446, 413, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(3447, 414, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(3448, 414, 2, 'Penyusunan pelaporan keuangan semesteran'),
(3449, 414, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(3450, 414, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(3451, 415, 1, 'Pembahasan Rancangan Peraturan Daerah'),
(3452, 415, 2, 'Hearing/Dialog dan Koordinasi Dengan Pejabat Pemerintah Daerah dan Tokoh Masyarakat/Tokoh Agama'),
(3453, 415, 3, 'Rapat-Rapat Alat Kelengkapan Dewan'),
(3454, 415, 4, 'Rapat-Rapat Paripurna'),
(3455, 415, 5, 'Kegiatan Reses'),
(3456, 415, 6, 'Kunjungan Kerja Pimpinan dan Anggota DPRD Dalam Daerah'),
(3457, 415, 7, 'Peningkatan Kapasitas Pimpinan dan Anggota DPRD'),
(3458, 415, 8, 'Sosialisasi Peraturan Perundang-Undangan'),
(3459, 416, 1, 'Dialog/Audiensi Dengan Tokoh-Tokoh Masyarakat, Pimpinan/Anggota Organisasi Sosial dan Kemasyarakatan'),
(3460, 416, 2, 'Penerimaan Kunjungan Kerja Pejabat Negara/Departemen/Lembaga Pemerintah Non Departemen/Luar Negeri'),
(3461, 416, 3, 'Rapat Koordinasi Unsur MUSPIDA'),
(3462, 416, 4, 'Rapat Koordinasi Pejabat Pemerintahan Daerah'),
(3463, 416, 5, 'Kunjunagn Kerja/Inspeksi Kepala Daerah/Wakil Kepala Daerah'),
(3464, 416, 6, 'Koordinasi Dengan Pemerintah Pusat dan Pemerintah Daerah Lainnya'),
(3465, 417, 1, 'Penyusunan Sistem Informasi Terhadap Layanan Publik'),
(3466, 418, 1, 'Pembentukan Unit Khusus Penanganan Pengaduan Masyarakat'),
(3467, 419, 1, 'Fasilitasi/Pembentukan Kerjasama Antar Daerah Dalam Penyediaan Pelayanan Publik'),
(3468, 419, 2, 'Fasilitasi/Pembentukan Perkuatan Kerjasama Antar Daerah Pada Bidang Ekonomi'),
(3469, 419, 3, 'Fasilitasi/Pembentukan Kerjasama Antar Daerah Di Bidang Hukum'),
(3470, 419, 4, 'Fasilitasi/Pembentukan Kerjasama Antar Daerah Dalam Penyediaan Sarana dan Prasarana Publik'),
(3471, 420, 1, 'Koordinasi Kerjasama Permasalahan Peraturan Perundang-Undangan'),
(3472, 420, 2, 'Penyusunan Rencana Kerja Rancangan Peraturan Perundang-Undangan'),
(3473, 420, 3, 'Legislasi Rancangan Peraturan Perundang-Undangan'),
(3474, 420, 4, 'Fasilitasi Sosialisasi Peraturan Perundang-Undangan'),
(3475, 420, 5, 'Publikasi Peraturan Perundang-Undangan'),
(3476, 420, 6, 'Kajian Peraturan Perundang-Undangan Daerah Terhadap Peraturan Perundang-Undangan yang Baru, Lebih Tinggi dan Keserasian Antar Peraturan Peundang-Undangan Daerah'),
(3477, 421, 1, 'Fasilitasi Penyiapan Data dan Informasi Pendukung Proses Pemekaran Daerah'),
(3478, 421, 2, 'Fasilitasi Percepatan Penyerahan P3D Dari Daerah Induk Ke Daerah Pemekaran'),
(3479, 421, 3, 'Fasilitasi Percepatan Penyelesaian Tapal Batas Wilayah Administrasi Antar Daerah'),
(3480, 421, 4, 'Fasilitasi Pemantapan SOTK Pemerintah Daerah Otonom Baru'),
(3481, 422, 0, 'Non Kegiatan'),
(3482, 423, 1, 'Penyediaan jasa surat menyurat'),
(3483, 423, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(3484, 423, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(3485, 423, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(3486, 423, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(3487, 423, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(3488, 423, 7, 'Penyediaan jasa administrasi keuangan'),
(3489, 423, 8, 'Penyediaan jasa kebersihan kantor'),
(3490, 423, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(3491, 423, 10, 'Penyediaan alat tulis kantor'),
(3492, 423, 11, 'Penyediaan barang cetakan dan penggandaan'),
(3493, 423, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(3494, 423, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(3495, 423, 14, 'Penyediaan peralatan rumah tangga'),
(3496, 423, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(3497, 423, 16, 'Penyediaan bahan logistik kantor'),
(3498, 423, 17, 'Penyediaan makanan dan minuman'),
(3499, 423, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(3500, 423, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(3501, 424, 1, 'Pembangunan rumah jabatan'),
(3502, 424, 2, 'Pembangunan rumah dinas'),
(3503, 424, 3, 'Pembangunan gedung kantor'),
(3504, 424, 4, 'Pengadaan mobil jabatan'),
(3505, 424, 5, 'pengadaan Kendaraan dinas/operasional'),
(3506, 424, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(3507, 424, 7, 'Pengadaan perlengkapan gedung kantor'),
(3508, 424, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(3509, 424, 9, 'Pengadaan peralatan gedung kantor'),
(3510, 424, 10, 'Pengadaan mebeleur'),
(3511, 424, 11, 'Pengadaan ……'),
(3512, 424, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(3513, 424, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(3514, 424, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(3515, 424, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(3516, 424, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(3517, 424, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(3518, 424, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(3519, 424, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(3520, 424, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(3521, 424, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(3522, 424, 30, 'Pemeliharaan rutin/berkala …..'),
(3523, 424, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(3524, 424, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(3525, 424, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(3526, 424, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(3527, 424, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(3528, 425, 1, 'Pengadaan mesin/kartu absensi'),
(3529, 425, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(3530, 425, 3, 'Pengadaan pakaian kerja lapangan'),
(3531, 425, 4, 'Pengadaan pakaian KORPRI'),
(3532, 425, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(3533, 426, 1, 'Pemulangan pegawai yang pensiun'),
(3534, 426, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(3535, 426, 3, 'Pemindahan tugas PNS'),
(3536, 427, 1, 'Pendidikan dan pelatihan formal'),
(3537, 427, 2, 'Sosialisasi peraturan perundang-undangan'),
(3538, 427, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(3539, 428, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(3540, 428, 2, 'Penyusunan pelaporan keuangan semesteran'),
(3541, 428, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(3542, 428, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(3543, 429, 1, 'Pelaksanaan Pengawasan Internal Secara Berkala'),
(3544, 429, 2, 'Penanganan Kasus Pengaduan Di Lingkungan Pemerintah Daerah'),
(3545, 429, 3, 'Pengendalian Manajemen Pelaksanaan Kebijakan KDH'),
(3546, 429, 4, 'Penanganan Kasus Pada Wilayah Pemerintahan Dibawahnya'),
(3547, 429, 5, 'Inverisasi Temuan Pengawasan'),
(3548, 429, 6, 'Tindak Lanjut Hasil Temuan Pengawasan'),
(3549, 429, 7, 'Koordinasi Pengawasan yang Lebih Komprehensif'),
(3550, 429, 8, 'Evaluasi Berkala Temuan Hasil Pengawasan'),
(3551, 430, 1, 'Pelatihan Pengembangan Tenaga Pemeriksa dan Aparatur Pengawasan'),
(3552, 430, 2, 'Pelatihan Teknis Pengawasan dan Penilaian Akuntabilitas Kinerja'),
(3553, 431, 1, 'Penyusunan Naskah Akademik Kebijakan Sistem dan Prosedur Pengawasan'),
(3554, 431, 2, 'Penyusunan Kebijakan Sistem dan Prosedur Pengawasan'),
(3555, 432, 0, 'Non Kegiatan'),
(3556, 433, 1, 'Penyediaan jasa surat menyurat'),
(3557, 433, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(3558, 433, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(3559, 433, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(3560, 433, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(3561, 433, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(3562, 433, 7, 'Penyediaan jasa administrasi keuangan'),
(3563, 433, 8, 'Penyediaan jasa kebersihan kantor'),
(3564, 433, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(3565, 433, 10, 'Penyediaan alat tulis kantor'),
(3566, 433, 11, 'Penyediaan barang cetakan dan penggandaan'),
(3567, 433, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(3568, 433, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(3569, 433, 14, 'Penyediaan peralatan rumah tangga'),
(3570, 433, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(3571, 433, 16, 'Penyediaan bahan logistik kantor'),
(3572, 433, 17, 'Penyediaan makanan dan minuman'),
(3573, 433, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(3574, 433, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(3575, 434, 1, 'Pembangunan rumah jabatan'),
(3576, 434, 2, 'Pembangunan rumah dinas'),
(3577, 434, 3, 'Pembangunan gedung kantor'),
(3578, 434, 4, 'Pengadaan mobil jabatan'),
(3579, 434, 5, 'pengadaan Kendaraan dinas/operasional'),
(3580, 434, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(3581, 434, 7, 'Pengadaan perlengkapan gedung kantor'),
(3582, 434, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(3583, 434, 9, 'Pengadaan peralatan gedung kantor'),
(3584, 434, 10, 'Pengadaan mebeleur'),
(3585, 434, 11, 'Pengadaan ……'),
(3586, 434, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(3587, 434, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(3588, 434, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(3589, 434, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(3590, 434, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(3591, 434, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(3592, 434, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(3593, 434, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(3594, 434, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(3595, 434, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(3596, 434, 30, 'Pemeliharaan rutin/berkala …..'),
(3597, 434, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(3598, 434, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(3599, 434, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(3600, 434, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(3601, 434, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(3602, 435, 1, 'Pengadaan mesin/kartu absensi'),
(3603, 435, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(3604, 435, 3, 'Pengadaan pakaian kerja lapangan'),
(3605, 435, 4, 'Pengadaan pakaian KORPRI'),
(3606, 435, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(3607, 436, 1, 'Pemulangan pegawai yang pensiun'),
(3608, 436, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(3609, 436, 3, 'Pemindahan tugas PNS'),
(3610, 437, 1, 'Pendidikan dan pelatihan formal'),
(3611, 437, 2, 'Sosialisasi peraturan perundang-undangan'),
(3612, 437, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(3613, 438, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(3614, 438, 2, 'Penyusunan pelaporan keuangan semesteran'),
(3615, 438, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(3616, 438, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(3617, 439, 1, 'Pengumpulan, updating, dan analisis data informasi capaian target kinerja program dan kegiatan'),
(3618, 439, 2, 'Penyusunan dan pengumpulan data/informasi kebutuhan penyusunan dokumen perencanaan'),
(3619, 439, 3, 'Penyusunan dan analisis data/informasi perencanaan pembangunan kawasan rawan bencana'),
(3620, 439, 4, 'Penyusunan dan anlisi data/informasi perencanaan pembangunan ekonomi'),
(3621, 439, 5, 'Penyusunan profile daerah'),
(3622, 440, 1, 'Koordinasi kerjasama wilayah perbatasan'),
(3623, 440, 2, 'Koordinasi kerjasama pembangunan antar daerah'),
(3624, 440, 3, 'Fasilitasi kerjasama dengan dunia usaha/lembaga'),
(3625, 440, 4, 'Koordinasi dalam pemecahan masalah-masalah daerah'),
(3626, 440, 5, 'Monitoring, evaluasi dan pelaporan'),
(3627, 441, 1, 'Koordinasi penyelesaian masalah perbatasan antar daerah'),
(3628, 441, 2, 'Sosialisasi kebijakan Pemerintah dalam penyelesaian perbatasan antar negara'),
(3629, 441, 3, 'koordinasi penetapan rencana tata ruang perbatasan'),
(3630, 441, 4, 'penyusunan perencanaan pengembangan perbatasan'),
(3631, 441, 5, 'Monitoring, evaluasi dan pelaporan'),
(3632, 442, 1, 'Sosialisasi kebijakan Pemerintah dalam pengembangan wilayah strategis dan cepat tumbuh'),
(3633, 442, 2, 'Koordinasi penetapan rencana tata ruang wilayah strategis dan cepat tumbuh'),
(3634, 442, 3, 'Penyusunan perencanaan pengembangan wilayah strategis dan cepat tumbuh'),
(3635, 442, 4, 'Monitoring, evaluasi dan pelaporan'),
(3636, 443, 1, 'Koordinasi penyelesaian permasalahan penanganan sampai perkotaan'),
(3637, 443, 2, 'Koordinasi penyelesaian permasalahan transportasi perkotaan'),
(3638, 443, 3, 'Koordinasi penanggulangan dan penyelesaian bencana alam/sosial'),
(3639, 443, 4, 'Koordinasi perencanaan penanganan pusat-pusat pertumbuhan ekonomi'),
(3640, 443, 5, 'Koordinasi perencanaan penanganan pusat-pusat industri'),
(3641, 443, 6, 'Koordinasi perencanaan penanganan pusat-pusat pendidikan'),
(3642, 443, 7, 'Koordinasi perencanaan penanganan perumahan'),
(3643, 443, 8, 'Koordinasi perencanaan penanganan perpakiran'),
(3644, 443, 9, 'Koordinasi perencanaan air minum, drainase dan sanitasi perkotaan'),
(3645, 443, 10, 'Koordinasi penanggulangan limbah rumah tangga dan industri perkotaan'),
(3646, 443, 11, 'Monitoring, evaluasi dan pelaporan'),
(3647, 444, 1, 'Peningkatan kemampuan teknis aparat perencana'),
(3648, 444, 2, 'Sosialisasi kebijakan perencanaan pembangunan daerah'),
(3649, 444, 3, 'Bimbingan teknis tentang perencanan pembangunan daerah'),
(3650, 445, 1, 'Pengembangan partisipasi masyarakat dalam perumusan program dan kebijakan layanan publik'),
(3651, 445, 2, 'Penyusunan rancangan RPJPD'),
(3652, 445, 3, 'Penyelenggaraan musrenbang RPJPD'),
(3653, 445, 4, 'Penetapan RPJPD'),
(3654, 445, 5, 'Penyusunan rancangan RPJMD'),
(3655, 445, 6, 'Penyelenggaraan musrenbang RPJMD'),
(3656, 445, 7, 'Penetapan RPJMD'),
(3657, 445, 8, 'Penyusunan rancangan RKPD'),
(3658, 445, 9, 'Penyelenggaraan musrenbang RKPD'),
(3659, 445, 10, 'Penetapan RKPD'),
(3660, 445, 11, 'Koordinasi penyusunan Laporan Kinerja Pemerintah Daerah'),
(3661, 445, 12, 'Koordinasi penyusunan laporan Keterangan Pertanggung Jawaban (LKPJ)'),
(3662, 445, 13, 'Monitoring, evaluasi dan pelaporan'),
(3663, 446, 1, 'Penyusunan masterplan pembangunan ekonomi daerah'),
(3664, 446, 2, 'Penyusunan indikator ekonomi daerah'),
(3665, 446, 3, 'Penyusunan perencanaan pengembangan ekonomi masyarakat'),
(3666, 446, 4, 'koordinasi perencanaan pembangunan bidang ekonomi'),
(3667, 446, 5, 'Penyusunan tabel input output daerah'),
(3668, 446, 6, 'Penyusunan masterplan penanggulangan kemiskinan'),
(3669, 446, 7, 'Penyusunan indikator dan pemetaan daerah rawan pangan'),
(3670, 446, 8, 'Monitoring, evaluasi dan pelaporan'),
(3671, 447, 1, 'Koordinasi penyusunan masterplan pendidikan'),
(3672, 447, 2, 'Koordinasi penyusunan masterplan kesehatan'),
(3673, 447, 3, 'Koordinasi perencanaan pembangunan bidang sosial dan budaya'),
(3674, 447, 4, 'Monitoring, evaluasi dan pelaporan'),
(3675, 448, 1, 'Koordinasi penyusunan masterplan prasarana perhubungan daerah'),
(3676, 448, 2, 'Koordinasi penyusunan masterplan pengendalian sumber daya alam dan lingkungan hidup'),
(3677, 448, 3, 'Monitoring, evaluasi dan pelaporan'),
(3678, 449, 1, 'Koordinasi penyusunan profile daerah rawan bencana'),
(3679, 449, 2, 'Koordinasi pembangunan daerah rawan bencana'),
(3680, 449, 3, 'Monitoring, evaluasi dan pelaporan'),
(3681, 450, 0, 'Non Kegiatan'),
(3682, 451, 1, 'Penyediaan jasa surat menyurat'),
(3683, 451, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(3684, 451, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(3685, 451, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(3686, 451, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(3687, 451, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(3688, 451, 7, 'Penyediaan jasa administrasi keuangan'),
(3689, 451, 8, 'Penyediaan jasa kebersihan kantor'),
(3690, 451, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(3691, 451, 10, 'Penyediaan alat tulis kantor'),
(3692, 451, 11, 'Penyediaan barang cetakan dan penggandaan'),
(3693, 451, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(3694, 451, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(3695, 451, 14, 'Penyediaan peralatan rumah tangga'),
(3696, 451, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(3697, 451, 16, 'Penyediaan bahan logistik kantor'),
(3698, 451, 17, 'Penyediaan makanan dan minuman'),
(3699, 451, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(3700, 451, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(3701, 452, 1, 'Pembangunan rumah jabatan'),
(3702, 452, 2, 'Pembangunan rumah dinas'),
(3703, 452, 3, 'Pembangunan gedung kantor'),
(3704, 452, 4, 'Pengadaan mobil jabatan'),
(3705, 452, 5, 'pengadaan Kendaraan dinas/operasional'),
(3706, 452, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(3707, 452, 7, 'Pengadaan perlengkapan gedung kantor'),
(3708, 452, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(3709, 452, 9, 'Pengadaan peralatan gedung kantor'),
(3710, 452, 10, 'Pengadaan mebeleur'),
(3711, 452, 11, 'Pengadaan ……'),
(3712, 452, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(3713, 452, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(3714, 452, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(3715, 452, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(3716, 452, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(3717, 452, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(3718, 452, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(3719, 452, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(3720, 452, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(3721, 452, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(3722, 452, 30, 'Pemeliharaan rutin/berkala …..'),
(3723, 452, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(3724, 452, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(3725, 452, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(3726, 452, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(3727, 452, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(3728, 453, 1, 'Pengadaan mesin/kartu absensi'),
(3729, 453, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(3730, 453, 3, 'Pengadaan pakaian kerja lapangan'),
(3731, 453, 4, 'Pengadaan pakaian KORPRI'),
(3732, 453, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(3733, 454, 1, 'Pemulangan pegawai yang pensiun'),
(3734, 454, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(3735, 454, 3, 'Pemindahan tugas PNS'),
(3736, 455, 1, 'Pendidikan dan pelatihan formal'),
(3737, 455, 2, 'Sosialisasi peraturan perundang-undangan'),
(3738, 455, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(3739, 456, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(3740, 456, 2, 'Penyusunan pelaporan keuangan semesteran'),
(3741, 456, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(3742, 456, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(3743, 457, 1, 'Penyusunan Analisa Standar Belanja'),
(3744, 457, 2, 'Penyusunan Standar Satuan Harga'),
(3745, 457, 3, 'Penyusunan Kebijakan Akuntansi Pemerintah Daerah'),
(3746, 457, 4, 'Penyusunan Sistem dan Prosedur Pengelolaan Keuangan Daerah'),
(3747, 457, 5, 'Penyusunan Rancangan Peraturan Daerah Tentang Pajak Daerah dan Restribusi'),
(3748, 457, 6, 'Penyusunan Rancangan Peraturan Daerah Tentang APBD'),
(3749, 457, 7, 'Penyusunan Rancangan Peraturan KDH Tentang Penjabaran APBD'),
(3750, 457, 8, 'Penyusunan Rancangan Peraturan Daerah Tentang Perubahan APBD'),
(3751, 457, 9, 'Penyusunan Rancangan Peraturan KDH Tentang Penjabaran Perubahan APBD'),
(3752, 457, 10, 'Penyusunan Rancangan Peraturan Daerah Tentang Pertanggungjawaban Pelaksanaan APBD'),
(3753, 457, 11, 'Penyusunan Rancangan Peraturan KDH Tentang Penjabaran Pertanggungjawaban Pelaksanaan APBD'),
(3754, 457, 12, 'Penyusunan Sistem Informasi Keuangan Daerah'),
(3755, 457, 13, 'Penyusunan Sistem Informasi Pengelolaan Keuangan Daerah'),
(3756, 457, 14, 'Sosialisasi Paket Regulasi Tentang Pengelolaan Keuangan Daerah'),
(3757, 457, 15, 'Bimbingan Teknis Implementasi Paket Regulasi Tentang Pengelolaan Keuangan Daerah'),
(3758, 457, 16, 'Peningkatan Manajemen Aset/Barang Daerah'),
(3759, 457, 17, 'Peningkatan Manajemen Investasi Daerah'),
(3760, 457, 18, 'Revaluasi/Appraisal Aset/Barang Daerah'),
(3761, 457, 19, 'Intensifikasi dan Ekstensifikasi Sumber-Sumber Pendapatan Daerah'),
(3762, 458, 1, 'Evaluasi Rancangan Peraturan Daerah Tentang APBD Kabupaten/Kota'),
(3763, 458, 2, 'Evaluasi Rancangan Peraturan KDH Tentang Penjabaran APBD Kabupaten/Kota'),
(3764, 458, 3, 'Evaluasi Rancangan Peraturan Daerah Tentang Pajak Daerah dan Restribusi Daerah Kabupaten/Kota'),
(3765, 458, 4, 'Penyusunan Standar Evaluasi Rancangan Peraturan Daerah Tentang APBD Kabupaten/Kota'),
(3766, 458, 5, 'Asistensi Penyusunan Rancangan Regulasi Pengelolaan Keuangan Daerah Kabupaten/Kota'),
(3767, 459, 1, 'Evaluasi Rancangan Peraturan Desa Tentang APB Desa'),
(3768, 459, 2, 'Evaluasi Rancangan Peraturan Desa Tentang Pendapatan Desa'),
(3769, 459, 3, 'Penyusunan Pedoman Pengelolaan Keuangan Desa'),
(3770, 460, 0, 'Non Kegiatan'),
(3771, 461, 1, 'Penyediaan jasa surat menyurat'),
(3772, 461, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(3773, 461, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(3774, 461, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(3775, 461, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(3776, 461, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(3777, 461, 7, 'Penyediaan jasa administrasi keuangan'),
(3778, 461, 8, 'Penyediaan jasa kebersihan kantor'),
(3779, 461, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(3780, 461, 10, 'Penyediaan alat tulis kantor'),
(3781, 461, 11, 'Penyediaan barang cetakan dan penggandaan'),
(3782, 461, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(3783, 461, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(3784, 461, 14, 'Penyediaan peralatan rumah tangga'),
(3785, 461, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(3786, 461, 16, 'Penyediaan bahan logistik kantor'),
(3787, 461, 17, 'Penyediaan makanan dan minuman'),
(3788, 461, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(3789, 461, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(3790, 462, 1, 'Pembangunan rumah jabatan'),
(3791, 462, 2, 'Pembangunan rumah dinas'),
(3792, 462, 3, 'Pembangunan gedung kantor'),
(3793, 462, 4, 'Pengadaan mobil jabatan'),
(3794, 462, 5, 'pengadaan Kendaraan dinas/operasional'),
(3795, 462, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(3796, 462, 7, 'Pengadaan perlengkapan gedung kantor'),
(3797, 462, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(3798, 462, 9, 'Pengadaan peralatan gedung kantor'),
(3799, 462, 10, 'Pengadaan mebeleur'),
(3800, 462, 11, 'Pengadaan ……'),
(3801, 462, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(3802, 462, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(3803, 462, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(3804, 462, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(3805, 462, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(3806, 462, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(3807, 462, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(3808, 462, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(3809, 462, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(3810, 462, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(3811, 462, 30, 'Pemeliharaan rutin/berkala …..'),
(3812, 462, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(3813, 462, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(3814, 462, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(3815, 462, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(3816, 462, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(3817, 463, 1, 'Pengadaan mesin/kartu absensi'),
(3818, 463, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(3819, 463, 3, 'Pengadaan pakaian kerja lapangan'),
(3820, 463, 4, 'Pengadaan pakaian KORPRI'),
(3821, 463, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(3822, 464, 1, 'Pemulangan pegawai yang pensiun'),
(3823, 464, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(3824, 464, 3, 'Pemindahan tugas PNS'),
(3825, 465, 1, 'Pendidikan dan pelatihan formal'),
(3826, 465, 2, 'Sosialisasi peraturan perundang-undangan'),
(3827, 465, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(3828, 466, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(3829, 466, 2, 'Penyusunan pelaporan keuangan semesteran'),
(3830, 466, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(3831, 466, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(3832, 467, 1, 'Penyusunan rencana pembinaan karir PNS'),
(3833, 467, 2, 'Seleksi penerimaan calon PNS'),
(3834, 467, 3, 'Penempatan PNS'),
(3835, 467, 4, 'Penataan sistem administrasi kenaikan pangkat otomatis PNS'),
(3836, 467, 5, 'Pembangunan/pengembangan sistem informasi kepegawaian daerah'),
(3837, 467, 6, 'Penyusunan instrumen analisis jabatan PNS'),
(3838, 467, 7, 'Seleksi dan penetapan PNS untuk tugas belajar'),
(3839, 467, 8, 'Pemberian penghargaan bagi PNS yang berprestasi'),
(3840, 467, 9, 'Proses penanganan kasus-kasus pelanggaran disiplin PNS'),
(3841, 467, 10, 'Kajian sistem dan kualitas materi diklat PNS'),
(3842, 467, 11, 'Pemberian bantuan tugas belajar dan ikatan dinas'),
(3843, 467, 12, 'Pemberian bantuan penyelenggaraan penerimaan Praja IPDN'),
(3844, 467, 13, 'Penyelenggaraan diklat teknis, fungsional dan kepemimpinan'),
(3845, 467, 14, 'Pengembangan diklat (Analisis kebutuhan Diklat, Penyusunan Silabi, Penyusunan Modul, Penyusunan Pedoman Diklat)'),
(3846, 467, 15, 'Monitoring, evaluasi dan pelaporan'),
(3847, 467, 16, 'Koordinasi penyelenggaraan diklat'),
(3848, 468, 0, 'Non Kegiatan'),
(3849, 469, 1, 'Penyediaan jasa surat menyurat'),
(3850, 469, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(3851, 469, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(3852, 469, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(3853, 469, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(3854, 469, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(3855, 469, 7, 'Penyediaan jasa administrasi keuangan'),
(3856, 469, 8, 'Penyediaan jasa kebersihan kantor'),
(3857, 469, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(3858, 469, 10, 'Penyediaan alat tulis kantor'),
(3859, 469, 11, 'Penyediaan barang cetakan dan penggandaan'),
(3860, 469, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(3861, 469, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(3862, 469, 14, 'Penyediaan peralatan rumah tangga'),
(3863, 469, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(3864, 469, 16, 'Penyediaan bahan logistik kantor'),
(3865, 469, 17, 'Penyediaan makanan dan minuman'),
(3866, 469, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(3867, 469, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(3868, 470, 1, 'Pembangunan rumah jabatan'),
(3869, 470, 2, 'Pembangunan rumah dinas'),
(3870, 470, 3, 'Pembangunan gedung kantor'),
(3871, 470, 4, 'Pengadaan mobil jabatan'),
(3872, 470, 5, 'pengadaan Kendaraan dinas/operasional'),
(3873, 470, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(3874, 470, 7, 'Pengadaan perlengkapan gedung kantor'),
(3875, 470, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(3876, 470, 9, 'Pengadaan peralatan gedung kantor'),
(3877, 470, 10, 'Pengadaan mebeleur'),
(3878, 470, 11, 'Pengadaan ……'),
(3879, 470, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(3880, 470, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(3881, 470, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(3882, 470, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(3883, 470, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(3884, 470, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(3885, 470, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(3886, 470, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(3887, 470, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(3888, 470, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(3889, 470, 30, 'Pemeliharaan rutin/berkala …..'),
(3890, 470, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(3891, 470, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(3892, 470, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(3893, 470, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(3894, 470, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(3895, 471, 1, 'Pengadaan mesin/kartu absensi'),
(3896, 471, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(3897, 471, 3, 'Pengadaan pakaian kerja lapangan'),
(3898, 471, 4, 'Pengadaan pakaian KORPRI'),
(3899, 471, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(3900, 472, 1, 'Pemulangan pegawai yang pensiun'),
(3901, 472, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(3902, 472, 3, 'Pemindahan tugas PNS'),
(3903, 473, 1, 'Pendidikan dan pelatihan formal'),
(3904, 473, 2, 'Sosialisasi peraturan perundang-undangan'),
(3905, 473, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(3906, 474, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(3907, 474, 2, 'Penyusunan pelaporan keuangan semesteran'),
(3908, 474, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(3909, 474, 4, 'penyusunan pelaporan keuangan akhir tahun'),
(3910, 475, 1, 'Pendidikan dan pelatihan teknis'),
(3911, 475, 2, 'Pendidikan penjenjangan struktural'),
(3912, 475, 3, 'Pemantauan dan evaluasi penyelenggaraan pendidikan'),
(3913, 475, 4, 'Pembuatan buku juknis/juklak'),
(3914, 475, 5, 'Pengembangan kurikulum pendidikan dan pelatihan'),
(3915, 475, 6, 'Peningkatan keterampilan dan profesionalisme'),
(3916, 476, 1, 'Pendidikan dan pelatihan prajabatan bagi calon PNS Daerah'),
(3917, 476, 2, 'Pendidikan dan pelatihan struktural bagi PNS Daerah'),
(3918, 476, 3, 'Pendidikan dan pelatihan teknis tugas dan fungsi bagi PNS Daerah'),
(3919, 476, 4, 'Pendidikan dan pelatihan fungsional bagi PNS Daerah'),
(3920, 477, 0, 'Non Kegiatan'),
(3921, 478, 1, 'Penyediaan jasa surat menyurat'),
(3922, 478, 2, 'Penyediaan jasa komunikasi, sumber daya air dan listrik'),
(3923, 478, 3, 'Penyediaan jasa peralatan dan perlengkapan kantor'),
(3924, 478, 4, 'Penyediaan jasa jaminan pemeliharaan kesehatan PNS'),
(3925, 478, 5, 'Penyediaan jasa jaminan barang milik daerah'),
(3926, 478, 6, 'Penyediaan jasa pemeliharaan dan perizinan kendaraan dinas/operasional'),
(3927, 478, 7, 'Penyediaan jasa administrasi keuangan'),
(3928, 478, 8, 'Penyediaan jasa kebersihan kantor'),
(3929, 478, 9, 'Penyediaan jasa perbaikan peralatan kerja'),
(3930, 478, 10, 'Penyediaan alat tulis kantor'),
(3931, 478, 11, 'Penyediaan barang cetakan dan penggandaan'),
(3932, 478, 12, 'Penyediaan komponen instalasi listrik/penerangan bangunan kantor'),
(3933, 478, 13, 'Penyediaan peralatan dan perlengkapan kantor'),
(3934, 478, 14, 'Penyediaan peralatan rumah tangga'),
(3935, 478, 15, 'Penyediaan bahan bacaan dan peraturan perundang-undangan'),
(3936, 478, 16, 'Penyediaan bahan logistik kantor'),
(3937, 478, 17, 'Penyediaan makanan dan minuman'),
(3938, 478, 18, 'Rapat-rapat koordinasi dan konsultasi ke luar daerah'),
(3939, 478, 19, 'Penyediaan Jasa Administrasi Perkantoran'),
(3940, 479, 1, 'Pembangunan rumah jabatan'),
(3941, 479, 2, 'Pembangunan rumah dinas'),
(3942, 479, 3, 'Pembangunan gedung kantor'),
(3943, 479, 4, 'Pengadaan mobil jabatan'),
(3944, 479, 5, 'pengadaan Kendaraan dinas/operasional'),
(3945, 479, 6, 'Pengadaan perlengkapan rumah jabatan/dinas'),
(3946, 479, 7, 'Pengadaan perlengkapan gedung kantor'),
(3947, 479, 8, 'Pengadaan peralatan rumah jabatan/dinas'),
(3948, 479, 9, 'Pengadaan peralatan gedung kantor'),
(3949, 479, 10, 'Pengadaan mebeleur'),
(3950, 479, 11, 'Pengadaan ……'),
(3951, 479, 20, 'Pemeliharaan rutin/berkala rumah jabatan'),
(3952, 479, 21, 'Pemeliharaan rutin/berkala rumah dinas'),
(3953, 479, 22, 'Pemeliharaan rutin/berkala gedung kantor'),
(3954, 479, 23, 'Pemeliharaan rutin/berkala mobil jabatan'),
(3955, 479, 24, 'Pemeliharaan rutin/berkala kendaraan dinas/operasional'),
(3956, 479, 25, 'Pemeliharaan rutin/berkala perlengkapan rumah jabatan/dinas'),
(3957, 479, 26, 'Pemeliharaan rutin/berkala perlengkapan gedung kantor'),
(3958, 479, 27, 'Pemeliharaan rutin/berkala peralatan rumah jabatan/dinas'),
(3959, 479, 28, 'Pemeliharaan rutin/berkala peralatan gedung kantor'),
(3960, 479, 29, 'Pemeliharaan rutin/berkala mebeleur'),
(3961, 479, 30, 'Pemeliharaan rutin/berkala …..'),
(3962, 479, 40, 'Rehabilitasi sedang/berat rumah jabatan'),
(3963, 479, 41, 'Rehabilitasi sedang/berat rumah dinas'),
(3964, 479, 42, 'Rehabilitasi sedang/berat gedung kantor'),
(3965, 479, 43, 'Rehabilitasi sedang/berat mobil jabatan'),
(3966, 479, 44, 'Rehabilitasi sedang/berat kendaraan dinas/operasional'),
(3967, 480, 1, 'Pengadaan mesin/kartu absensi'),
(3968, 480, 2, 'Pengadaan pakaian dinas beserta perlengkapannya'),
(3969, 480, 3, 'Pengadaan pakaian kerja lapangan'),
(3970, 480, 4, 'Pengadaan pakaian KORPRI'),
(3971, 480, 5, 'Pengadaan pakaian khusus hari-hari tertentu'),
(3972, 481, 1, 'Pemulangan pegawai yang pensiun'),
(3973, 481, 2, 'Pemulangan pegawai yang tewas dalam melaksanakan tugas'),
(3974, 481, 3, 'Pemindahan tugas PNS'),
(3975, 482, 1, 'Pendidikan dan pelatihan formal'),
(3976, 482, 2, 'Sosialisasi peraturan perundang-undangan'),
(3977, 482, 3, 'Bimbingan teknis implementasi peraturan perundang-undangan'),
(3978, 483, 1, 'Penyusunan laporan capaian kinerja dan ikhtisar realisasi kinerja SKPD'),
(3979, 483, 2, 'Penyusunan pelaporan keuangan semesteran'),
(3980, 483, 3, 'Penyusunan pelaporan prognosis realisasi anggaran'),
(3981, 483, 4, 'penyusunan pelaporan keuangan akhir tahun');

-- --------------------------------------------------------

--
-- Table structure for table `ref_kolom_tabel_dasar`
--

DROP TABLE IF EXISTS `ref_kolom_tabel_dasar`;
CREATE TABLE IF NOT EXISTS `ref_kolom_tabel_dasar` (
  `id_kolom_tabel_dasar` int(11) NOT NULL,
  `id_tabel_dasar` int(11) DEFAULT NULL,
  `nama_kolom` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level` int(2) DEFAULT NULL,
  `parent_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id_kolom_tabel_dasar`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `id_tabel_dasar` (`id_tabel_dasar`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `ref_kolom_tabel_dasar`
--

INSERT INTO `ref_kolom_tabel_dasar` (`id_kolom_tabel_dasar`, `id_tabel_dasar`, `nama_kolom`, `level`, `parent_id`) VALUES
(0, 1, 'root', 0, 0),
(1, 1, 'Pertanian', 1, 0),
(2, 1, 'Pertambangan dan penggalian', 1, 0),
(3, 1, 'Industri pengolahan', 1, 0),
(4, 1, 'Listrik, gas dan air bersih', 1, 0),
(5, 1, 'Konstruksi', 1, 0),
(6, 1, 'Perdagangan, hotel dan restoran', 1, 0),
(7, 1, 'Pengangkutan dan komunikasi', 1, 0),
(8, 1, 'Keuangan, sewa dan jasa perusahaan', 1, 0),
(9, 1, 'Jasa-jasa', 1, 0),
(10, 2, 'root', 0, 0),
(11, 2, 'Pertanian', 1, 0),
(12, 2, 'Pertambangan dan penggalian', 1, 0),
(13, 2, 'Industri pengolahan', 1, 0),
(14, 2, 'Listrik, gas dan air bersih', 1, 0),
(15, 2, 'Konstruksi', 1, 0),
(16, 2, 'Perdagangan, hotel dan restoran', 1, 0),
(17, 2, 'Pengangkutan dan komunikasi', 1, 0),
(18, 2, 'Keuangan, sewa dan jasa perusahaan', 1, 0),
(19, 2, 'Jasa-jasa', 1, 0),
(20, 3, 'Jumlah penduduk usia diatas 15 tahun yangbisa membaca dan menulis', 1, 0),
(21, 3, 'Jumlah penduduk usia 15 tahun keatas', 1, 0),
(22, 3, 'Angka Melek Huruf', 1, 0),
(23, 4, 'Rata-rata Lama Sekolah (tahun)', 1, 0),
(24, 5, 'Jumlah grup kesenian per 10.000 penduduk', 1, 0),
(25, 5, 'Jumlah gedung kesenian per 10.000 penduduk', 1, 0),
(26, 5, 'Jumlah klub olahraga per 10.000 penduduk', 1, 0),
(27, 5, 'Jumlah gedung olahraga per 10.000 penduduk', 1, 0),
(28, 6, 'SD/MI', 0, 0),
(29, 6, 'jumlah murid usia 7-12 thn', 1, 28),
(30, 6, 'jumlah penduduk kelompok usia7-12 tahun', 1, 28),
(31, 6, 'APS SD/MI', 1, 28),
(32, 6, 'SMP', 0, 0),
(33, 6, 'jumlah murid usia 13-15 thn', 1, 32),
(34, 6, 'jumlah penduduk kelompok usia13-15 tahun', 1, 32),
(35, 6, 'APS SMP/MTs', 1, 32),
(36, 7, 'SD/MI', 0, 0),
(37, 7, 'Jumlah gedung sekolah', 1, 36),
(38, 7, 'jumlah penduduk kelompok usia7-12 tahun', 1, 36),
(39, 7, 'Rasio', 1, 36),
(40, 7, 'SMP', 0, 0),
(41, 7, 'Jumlah gedung sekolah', 1, 40),
(42, 7, 'jumlah penduduk kelompok usia13-15 tahun', 1, 40),
(43, 7, 'Rasio', 1, 40),
(44, 8, 'SD/MI', 0, 0),
(45, 8, 'Jumlah Guru', 1, 44),
(46, 8, 'Jumlah Murid', 1, 44),
(47, 8, 'Rasio', 1, 44),
(48, 8, 'SMP', 0, 0),
(49, 8, 'Jumlah guru', 1, 48),
(50, 8, 'Jumlah Murid', 1, 48),
(51, 8, 'Rasio', 1, 48),
(52, 9, 'PMDN', 1, 0),
(53, 9, 'PMA', 1, 0),
(54, 10, 'Persetujuan Jumlah Proyek', 1, 0),
(55, 10, 'Realisasi Jumlah Proyek', 1, 0),
(56, 10, 'Persetujuan Nilai Investasi', 1, 0),
(57, 10, 'Realisasi Nilai Investasi', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ref_langkah`
--

DROP TABLE IF EXISTS `ref_langkah`;
CREATE TABLE IF NOT EXISTS `ref_langkah` (
  `id_langkah` int(255) NOT NULL,
  `jenis_dokumen` int(255) NOT NULL,
  `nm_langkah` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_langkah`,`jenis_dokumen`) USING BTREE,
  UNIQUE KEY `idx_ref_step` (`id_langkah`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_langkah`
--

INSERT INTO `ref_langkah` (`id_langkah`, `jenis_dokumen`, `nm_langkah`) VALUES
(1, 1, 'Penyusunan Rancangan Awal RPJMD'),
(2, 7, 'Penyusunan Rancangan Awal Renstra SKPD'),
(3, 1, 'Sinkronisasi Ranwal RPJMD dengan Ranwal Renstra SKPD'),
(4, 2, 'Finalisasi Rancangan RPJMD'),
(5, 3, 'Musrenbang RPJMD'),
(6, 4, 'Penyusunan Rancangan Akhir RPJMD'),
(7, 4, 'Konsultasi Rancangan RPJMD oleh Kementrian/Provinsi'),
(8, 4, 'Finalisasi Rancangan Akhir RPJMD'),
(9, 8, 'Sinkronisasi Rancangan Renstra SKPD dengan Rankhir RPJMD'),
(10, 5, 'Pembahasan RPJMD dengan DPRD'),
(11, 5, 'Finalisasi RPJMD'),
(12, 8, 'Penyusunan Rancangan Akhir Renstra SKPD'),
(13, 9, 'Finalisasi Renstra SKPD'),
(15, 11, 'Rancangan Awal RKPD'),
(16, 12, 'Rancangan RKPD'),
(17, 13, 'Rancangan Akhir RKPD'),
(18, 14, 'RKPD Final'),
(19, 15, 'Rancangan Awal Renja Perangkat Daerah'),
(20, 16, 'Rancangan Renja Perangkat Daerah'),
(21, 17, 'Renja Perangkat Daerah Final'),
(22, 18, 'Musrenbang RKPD Desa/Kelurahan'),
(23, 19, 'Musrenbang RKPD Kecamatan'),
(24, 20, 'Forum Perangkat Daerah'),
(25, 21, 'Musrenbang RKPD Kabupaten Kota');

-- --------------------------------------------------------

--
-- Table structure for table `ref_laporan`
--

DROP TABLE IF EXISTS `ref_laporan`;
CREATE TABLE IF NOT EXISTS `ref_laporan` (
  `id` bigint(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_modul` int(11) NOT NULL DEFAULT '0' COMMENT '0 : Parameter 1 : SSH 2 : ASB 3 : RPJMD 4 : Renstra 5 : RKPD 6 : Renja 7 : Forum 8 : Musrenbang 9 : Pokir 10 : PPAS 11 : RAPBD : 12 APBD ',
  `id_dokumen` int(11) NOT NULL DEFAULT '0',
  `jns_laporan` int(11) NOT NULL DEFAULT '0' COMMENT '0 : Utama 1 : Manajemen',
  `id_laporan` int(11) NOT NULL DEFAULT '1',
  `no_urut` int(11) NOT NULL DEFAULT '1',
  `uraian_laporan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_laporan` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_modul` (`id_modul`,`id_dokumen`,`jns_laporan`,`id_laporan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ref_log_akses`
--

DROP TABLE IF EXISTS `ref_log_akses`;
CREATE TABLE IF NOT EXISTS `ref_log_akses` (
  `id_log` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `fl1` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `fd1` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `fp2` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `fu3` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `fr4` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `id_log_1` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `id_log_2` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_log`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_lokasi`
--

DROP TABLE IF EXISTS `ref_lokasi`;
CREATE TABLE IF NOT EXISTS `ref_lokasi` (
  `id_lokasi` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_lokasi` int(11) NOT NULL COMMENT '0 = Kewilayahan\r\n1 = Ruas Jalan \r\n2 = Saluran Irigasi\r\n3 = Kawasan\r\n99 = Lokasi di Luar Daerah',
  `nama_lokasi` varchar(255) CHARACTER SET latin1 NOT NULL,
  `id_desa` int(11) DEFAULT NULL,
  `id_desa_awal` int(11) DEFAULT NULL,
  `id_desa_akhir` int(11) DEFAULT NULL,
  `koordinat_1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `koordinat_2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `koordinat_3` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `koordinat_4` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `luasan_kawasan` decimal(20,2) DEFAULT '0.00',
  `satuan_luas` int(50) DEFAULT NULL,
  `panjang` decimal(20,2) DEFAULT '0.00',
  `satuan_panjang` int(50) DEFAULT NULL,
  `lebar` decimal(20,2) DEFAULT '0.00',
  `satuan_lebar` int(11) DEFAULT NULL,
  `keterangan_lokasi` longtext CHARACTER SET latin1,
  PRIMARY KEY (`id_lokasi`) USING BTREE,
  UNIQUE KEY `jenis_lokasi` (`jenis_lokasi`,`nama_lokasi`,`id_desa`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_mapping_asb_renstra`
--

DROP TABLE IF EXISTS `ref_mapping_asb_renstra`;
CREATE TABLE IF NOT EXISTS `ref_mapping_asb_renstra` (
  `id_aktivitas_asb` bigint(20) NOT NULL,
  `id_kegiatan_renstra` int(11) NOT NULL,
  KEY `idx_ref_mapping_asb_renstra` (`id_aktivitas_asb`,`id_kegiatan_renstra`) USING BTREE,
  KEY `fk_ref_mapping_asb_renstra1` (`id_kegiatan_renstra`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_menu`
--

DROP TABLE IF EXISTS `ref_menu`;
CREATE TABLE IF NOT EXISTS `ref_menu` (
  `id_menu` bigint(255) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `menu` int(11) NOT NULL,
  `akses` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_menu`) USING BTREE,
  UNIQUE KEY `menu` (`menu`,`group_id`) USING BTREE,
  KEY `akses` (`akses`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_menu`
--

INSERT INTO `ref_menu` (`id_menu`, `group_id`, `menu`, `akses`) VALUES
(1, 1, 9, '11100'),
(2, 2, 9, '11100'),
(3, 7, 9, '11100'),
(5, 7, 20, '11100'),
(7, 7, 30, '11100'),
(8, 2, 101, '11100'),
(9, 7, 101, '11100'),
(10, 2, 102, '11100'),
(11, 7, 102, '11100'),
(12, 2, 103, '11100'),
(13, 7, 103, '11100'),
(14, 2, 105, '11100'),
(15, 7, 105, '11100'),
(16, 2, 106, '11100'),
(17, 7, 106, '11100'),
(18, 2, 107, '11100'),
(19, 7, 107, '11100'),
(20, 2, 108, '11100'),
(21, 7, 108, '11100'),
(22, 2, 109, '11100'),
(23, 7, 109, '11100'),
(24, 1, 110, '11100'),
(25, 2, 111, '11100'),
(26, 7, 111, '11100'),
(27, 2, 401, '11100'),
(28, 7, 401, '11100'),
(29, 2, 402, '11100'),
(30, 7, 402, '11100'),
(31, 2, 403, '11100'),
(32, 7, 403, '11100'),
(33, 2, 404, '11100'),
(34, 7, 404, '11100'),
(35, 2, 405, '11100'),
(36, 7, 405, '11100'),
(37, 2, 406, '11100'),
(38, 7, 406, '11100'),
(39, 2, 407, '11100'),
(40, 7, 407, '11100'),
(41, 2, 408, '11100'),
(42, 7, 408, '11100'),
(43, 2, 501, '11100'),
(44, 7, 501, '11100'),
(45, 2, 502, '11100'),
(46, 7, 502, '11100'),
(47, 2, 503, '11100'),
(48, 7, 503, '11100'),
(50, 7, 504, '11100'),
(51, 2, 601, '11100'),
(52, 7, 601, '11100'),
(53, 2, 603, '11100'),
(54, 7, 603, '11100'),
(55, 2, 604, '11100'),
(56, 7, 604, '11100'),
(57, 2, 605, '11100'),
(58, 7, 605, '11100'),
(59, 2, 606, '11100'),
(60, 7, 606, '11100'),
(61, 2, 607, '11100'),
(62, 7, 607, '11100'),
(63, 2, 608, '11100'),
(64, 7, 608, '11100'),
(65, 2, 609, '11100'),
(66, 7, 609, '11100'),
(67, 2, 701, '11100'),
(68, 7, 701, '11100'),
(69, 2, 702, '11100'),
(70, 7, 702, '11100'),
(71, 2, 801, '11100'),
(72, 7, 801, '11100'),
(73, 2, 802, '11100'),
(74, 7, 802, '11100'),
(75, 2, 803, '11100'),
(76, 7, 803, '11100'),
(77, 2, 805, '11100'),
(78, 7, 805, '11100'),
(79, 2, 806, '11100'),
(80, 7, 806, '11100'),
(81, 3, 20, '11100'),
(82, 3, 30, '11100'),
(85, 3, 501, '11100'),
(86, 3, 502, '11100'),
(87, 3, 503, '11100'),
(88, 3, 606, '11100'),
(89, 3, 607, '11100'),
(94, 2, 104, '11100'),
(97, 11, 503, '11100'),
(98, 10, 604, '11100'),
(99, 10, 605, '11100'),
(100, 9, 603, '11100'),
(101, 8, 601, '11100'),
(103, 2, 409, '11100'),
(104, 2, 611, '11100'),
(105, 2, 610, '11100'),
(106, 2, 703, '11100'),
(107, 2, 704, '11100'),
(108, 2, 710, '11100'),
(109, 2, 711, '11100'),
(110, 2, 712, '11100'),
(111, 2, 713, '11100'),
(112, 2, 910, '11100'),
(113, 2, 911, '11100'),
(114, 2, 920, '11100'),
(115, 2, 921, '11100'),
(116, 2, 930, '11100'),
(117, 2, 931, '11100'),
(118, 2, 932, '11100'),
(119, 2, 933, '11100'),
(120, 2, 934, '11100'),
(121, 2, 940, '11100'),
(122, 2, 941, '11100'),
(123, 2, 942, '11100'),
(124, 2, 950, '11100'),
(125, 3, 101, '11100'),
(126, 3, 102, '11100'),
(127, 3, 103, '11100'),
(128, 3, 105, '11100'),
(129, 3, 106, '11100'),
(130, 3, 107, '11100'),
(131, 3, 108, '11100'),
(132, 3, 111, '11100'),
(133, 3, 104, '11100'),
(134, 3, 109, '11100'),
(135, 3, 801, '11100'),
(136, 3, 802, '11100'),
(137, 3, 803, '11100'),
(138, 3, 805, '11100'),
(139, 3, 806, '11100'),
(140, 3, 901, '11100'),
(141, 3, 401, '11100'),
(142, 3, 402, '11100'),
(143, 3, 403, '11100'),
(144, 3, 404, '11100'),
(145, 3, 405, '11100'),
(146, 3, 406, '11100'),
(147, 3, 407, '11100'),
(148, 3, 408, '11100'),
(149, 3, 610, '11100'),
(150, 3, 601, '11100'),
(151, 3, 603, '11100'),
(152, 3, 604, '11100'),
(153, 3, 605, '11100'),
(154, 3, 608, '11100'),
(155, 3, 609, '11100'),
(156, 3, 611, '11100'),
(157, 3, 409, '11100'),
(158, 3, 701, '11100'),
(159, 3, 702, '11100'),
(160, 3, 703, '11100'),
(161, 3, 704, '11100'),
(162, 3, 710, '11100'),
(163, 3, 711, '11100'),
(164, 3, 712, '11100'),
(165, 3, 713, '11100'),
(166, 3, 910, '11100'),
(167, 3, 911, '11100'),
(168, 3, 920, '11100'),
(169, 3, 921, '11100'),
(170, 3, 930, '11100'),
(171, 3, 931, '11100'),
(172, 3, 932, '11100'),
(173, 3, 933, '11100'),
(174, 3, 934, '11100'),
(175, 3, 940, '11100'),
(176, 3, 941, '11100'),
(177, 3, 942, '11100'),
(178, 3, 950, '11100'),
(179, 2, 804, NULL),
(180, 2, 807, NULL),
(181, 2, 890, NULL),
(182, 2, 891, NULL),
(183, 2, 892, NULL),
(184, 2, 893, NULL),
(185, 2, 201, NULL),
(186, 2, 202, NULL),
(187, 2, 301, NULL),
(188, 2, 302, NULL),
(189, 2, 440, NULL),
(190, 2, 441, NULL),
(191, 2, 442, NULL),
(192, 2, 443, NULL),
(193, 2, 505, NULL),
(194, 2, 542, NULL),
(195, 2, 640, NULL),
(196, 2, 641, NULL),
(197, 2, 642, NULL),
(198, 2, 699, NULL),
(199, 2, 504, NULL),
(200, 2, 643, NULL),
(201, 2, 740, NULL),
(202, 2, 742, NULL),
(203, 2, 935, NULL),
(204, 2, 943, NULL),
(205, 2, 540, NULL),
(206, 2, 541, NULL);

--
-- Triggers `ref_menu`
--
DROP TRIGGER IF EXISTS `trg_ref_menu_c`;
DELIMITER $$
CREATE TRIGGER `trg_ref_menu_c` BEFORE INSERT ON `ref_menu` FOR EACH ROW IF new.group_id = 0 THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'You are not allowed to insert it!!';
END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_ref_menu_d`;
DELIMITER $$
CREATE TRIGGER `trg_ref_menu_d` BEFORE DELETE ON `ref_menu` FOR EACH ROW IF old.group_id = 1 THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'This record is sacred! You are not allowed to remove it!!';
END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_ref_menu_u`;
DELIMITER $$
CREATE TRIGGER `trg_ref_menu_u` BEFORE UPDATE ON `ref_menu` FOR EACH ROW IF old.group_id = 0 THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'This record is sacred! You are not allowed to update it!!';
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ref_pangkat_golongan`
--

DROP TABLE IF EXISTS `ref_pangkat_golongan`;
CREATE TABLE IF NOT EXISTS `ref_pangkat_golongan` (
  `id_pangkat_pns` bigint(255) NOT NULL AUTO_INCREMENT,
  `pangkat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `golongan` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ruang` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pangkat_pns`),
  UNIQUE KEY `pangkat` (`pangkat`,`golongan`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ref_pangkat_golongan`
--

INSERT INTO `ref_pangkat_golongan` (`id_pangkat_pns`, `pangkat`, `golongan`, `ruang`, `created_at`, `updated_at`) VALUES
(1, 'Juru Muda', 'I', 'a', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(2, 'Juru Muda Tingkat I', 'I', 'b', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(3, 'Juru', 'I', 'c', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(4, 'Juru Tingkat I', 'I', 'd', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(5, 'Pengatur Muda', 'II', 'a', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(6, 'Pengatur Muda Tingkat I', 'II', 'b', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(7, 'Pengatur', 'II', 'c', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(8, 'Pengatur Tingkat I', 'II', 'd', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(9, 'Penata Muda', 'III', 'a', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(10, 'Penata Muda Tingkat I', 'III', 'b', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(11, 'Penata', 'III', 'c', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(12, 'Penata Tingkat I', 'III', 'd', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(13, 'Pembina', 'IV', 'a', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(14, 'Pembina Tingkat I', 'IV', 'b', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(15, 'Pembina Utama Muda', 'IV', 'c', '2019-10-01 06:46:52', '2019-10-01 06:46:52'),
(16, 'Pembina Utama Madya', 'IV', 'd', '2019-10-01 06:46:52', '2019-10-01 06:46:59'),
(17, 'Pembina Utama', 'IV', 'e', '2019-10-01 06:46:52', '2019-10-01 06:46:52');

-- --------------------------------------------------------

--
-- Table structure for table `ref_pegawai`
--

DROP TABLE IF EXISTS `ref_pegawai`;
CREATE TABLE IF NOT EXISTS `ref_pegawai` (
  `id_pegawai` int(11) NOT NULL AUTO_INCREMENT,
  `nama_pegawai` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_pegawai` varchar(18) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pegawai` int(11) NOT NULL DEFAULT '0',
  `status_kepegawaian` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pegawai`) USING BTREE,
  UNIQUE KEY `nip_pegawai` (`nip_pegawai`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_pegawai_pangkat`
--

DROP TABLE IF EXISTS `ref_pegawai_pangkat`;
CREATE TABLE IF NOT EXISTS `ref_pegawai_pangkat` (
  `id_pangkat` int(11) NOT NULL AUTO_INCREMENT,
  `id_pegawai` int(255) NOT NULL DEFAULT '0',
  `pangkat_pegawai` int(11) DEFAULT NULL,
  `tmt_pangkat` date DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pangkat`) USING BTREE,
  UNIQUE KEY `id_pegawai` (`id_pegawai`,`pangkat_pegawai`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_pegawai_unit`
--

DROP TABLE IF EXISTS `ref_pegawai_unit`;
CREATE TABLE IF NOT EXISTS `ref_pegawai_unit` (
  `id_unit_pegawai` int(11) NOT NULL AUTO_INCREMENT,
  `id_pegawai` int(255) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `tingkat_eselon` int(11) NOT NULL,
  `id_sotk` int(11) NOT NULL,
  `nama_jabatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tmt_unit` date NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_unit_pegawai`) USING BTREE,
  UNIQUE KEY `id_pegawai` (`id_pegawai`,`id_unit`,`tingkat_eselon`,`id_sotk`) USING BTREE,
  KEY `id_unit` (`id_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_pembatalan`
--

DROP TABLE IF EXISTS `ref_pembatalan`;
CREATE TABLE IF NOT EXISTS `ref_pembatalan` (
  `id_batal` int(255) NOT NULL AUTO_INCREMENT,
  `uraian_batal` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_batal`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_pemda`
--

DROP TABLE IF EXISTS `ref_pemda`;
CREATE TABLE IF NOT EXISTS `ref_pemda` (
  `kd_prov` int(11) NOT NULL,
  `kd_kab` int(11) NOT NULL,
  `id_pemda` int(11) NOT NULL AUTO_INCREMENT,
  `prefix_pemda` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `nm_prov` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `nm_kabkota` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ibu_kota` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `nama_jabatan_kepala_daerah` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `nama_kepala_daerah` varchar(150) COLLATE latin1_general_ci DEFAULT NULL,
  `nama_jabatan_sekretariat_daerah` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `nama_sekretariat_daerah` varchar(150) COLLATE latin1_general_ci DEFAULT NULL,
  `nip_sekretariat_daerah` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `unit_perencanaan` int(11) DEFAULT NULL COMMENT 'id_sub_unit koordinator perencanaan',
  `nama_kepala_bappeda` varchar(150) COLLATE latin1_general_ci DEFAULT NULL,
  `nip_kepala_bappeda` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `unit_keuangan` int(11) DEFAULT NULL COMMENT 'id_sub_unit pengelola keuangan',
  `nama_kepala_bpkad` varchar(150) COLLATE latin1_general_ci DEFAULT NULL,
  `nip_kepala_bpkad` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `logo_pemda` mediumblob,
  `alamat` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `no_telepon` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `no_faksimili` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `checksum` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `checksum2` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_pemda`) USING BTREE,
  UNIQUE KEY `kd_prov` (`kd_prov`,`kd_kab`) USING BTREE,
  UNIQUE KEY `id_pemda` (`id_pemda`) USING BTREE,
  UNIQUE KEY `checksum` (`checksum`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_pengusul`
--

DROP TABLE IF EXISTS `ref_pengusul`;
CREATE TABLE IF NOT EXISTS `ref_pengusul` (
  `id_pengusul` int(255) NOT NULL,
  `nm_pengusul` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keterangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_pengusul`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_pengusul`
--

INSERT INTO `ref_pengusul` (`id_pengusul`, `nm_pengusul`, `keterangan`) VALUES
(1, 'Kepala Daerah', ''),
(2, 'Wakil Kepala Daerah', ''),
(3, 'Pimpinan DPRD Provinsi', ''),
(4, 'Anggota DPRD Provinsi', ''),
(5, 'Pimpinan DPRD Kabupaten/Kota', ''),
(6, 'Anggota DPRD Kabupaten/Kota', ''),
(7, 'Bapedda Provinsi', ''),
(8, 'SKPD Provinsi', ''),
(9, 'Bappeda Kabupaten/Kota', ''),
(10, 'SKPD Kabupaten/Kota', ''),
(11, 'Akademisi', ''),
(12, 'Lembaga Swadaya Masyarakat', ''),
(13, 'Organisasi Masyarakat', ''),
(14, 'Tokoh Masyarakat', ''),
(15, 'Keterwakilan Perempuan', 'Organisasi wanita'),
(16, 'Kelompok Masyarakat Rentan', ''),
(17, 'Kelompok Usaha/Investor', ''),
(18, 'Instansi Pemerintah Pusat', 'Kemeterian/Lembaga');

-- --------------------------------------------------------

--
-- Table structure for table `ref_program`
--

DROP TABLE IF EXISTS `ref_program`;
CREATE TABLE IF NOT EXISTS `ref_program` (
  `id_bidang` int(11) NOT NULL,
  `id_program` int(11) NOT NULL AUTO_INCREMENT,
  `kd_program` int(11) NOT NULL,
  `uraian_program` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_program`) USING BTREE,
  UNIQUE KEY `idx_ref_program` (`id_bidang`,`kd_program`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=484 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_program`
--

INSERT INTO `ref_program` (`id_bidang`, `id_program`, `kd_program`, `uraian_program`) VALUES
(1, 1, 0, 'Non Program'),
(1, 2, 1, 'Program Pelayanan Administrasi Perkantoran'),
(1, 3, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(1, 4, 3, 'Program peningkatan disiplin aparatur'),
(1, 5, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(1, 6, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(1, 7, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(1, 8, 15, 'Program Pendidikan Anak Usia Dini'),
(1, 9, 16, 'Program Wajib Belajar Pendidikan Dasar Sembilan Tahun'),
(1, 10, 17, 'Program Pendidikan Menengah'),
(1, 11, 18, 'Program Pendidikan Non Formal'),
(1, 12, 19, 'Program Pendidikan Luar Biasa'),
(1, 13, 20, 'Program Peningkatan Mutu Pendidik dan Tenaga Kependidikan'),
(1, 14, 21, 'Program Pengembangan Budaya Baca dan Pembinaan Perpustakaan'),
(1, 15, 22, 'Program Manajemen Pelayanan Pendidikan'),
(2, 16, 0, 'Non Program'),
(2, 17, 1, 'Program Pelayanan Administrasi Perkantoran'),
(2, 18, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(2, 19, 3, 'Program peningkatan disiplin aparatur'),
(2, 20, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(2, 21, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(2, 22, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(2, 23, 15, 'Program Obat dan Perbekalan Kesehatan'),
(2, 24, 16, 'Program Upaya Kesehatan Masyarakat'),
(2, 25, 17, 'Program Pengawasan Obat dan Makanan'),
(2, 26, 18, 'Program Pengembangan Obat Asli Indonesia'),
(2, 27, 19, 'Program Promosi Kesehatan dan Pemberdayaan Masyarakat'),
(2, 28, 20, 'Program Perbaikan Gizi Masyarakat'),
(2, 29, 21, 'Program Pengembangan Lingkungan Sehat'),
(2, 30, 22, 'Program Pencegahan dan Penanggulangan Penyakit Menular'),
(2, 31, 23, 'Program Standarisasi Pelayanan Kesehatan'),
(2, 32, 24, 'Program pelayanan kesehatan penduduk miskin'),
(2, 33, 25, 'Program pengadaan, peningkatan dan perbaikan sarana dan prasarana puskesmas/ puskemas pembantu dan jaringannya'),
(2, 34, 26, 'Program pengadaan, peningkatan sarana dan prasarana rumah sakit/ rumah sakit jiwa/ rumah sakit paru-paru/ rumah sakit mata'),
(2, 35, 27, 'Program pemeliharaan sarana dan prasarana rumah sakit/ rumah sakit jiwa/ rumah sakit paru-paru/ rumah sakit mata'),
(2, 36, 28, 'Program kemitraan peningkatan pelayanan kesehatan'),
(2, 37, 29, 'Program peningkatan pelayanan kesehatan anak balita'),
(2, 38, 30, 'Program peningkatan pelayanan kesehatan lansia'),
(2, 39, 31, 'Program pengawasan dan pengendalian kesehatan makanan'),
(2, 40, 32, 'Program peningkatan keselamatan ibu melahirkan dan anak'),
(3, 41, 0, 'Non Program'),
(3, 42, 1, 'Program Pelayanan Administrasi Perkantoran'),
(3, 43, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(3, 44, 3, 'Program peningkatan disiplin aparatur'),
(3, 45, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(3, 46, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(3, 47, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(3, 48, 15, 'Program pembangunan jalan dan jembatan'),
(3, 49, 16, 'Program pembangunan saluran drainase/gorong-gorong'),
(3, 50, 17, 'Program pembangunan turap/talud/bronjong'),
(3, 51, 18, 'Program rehabilitasi/pemeliharaan jalan dan jembatan'),
(3, 52, 19, 'Program rehabilitasi/pemeliharaan talud/bronjong'),
(3, 53, 20, 'Program Inspeksi kondisi jalan dan jembatan'),
(3, 54, 21, 'Program tanggap darurat jalan dan jembatan'),
(3, 55, 22, 'Program pembangunan sistem informasi/data base jalan dan jembatan'),
(3, 56, 23, 'Program peningkatan sarana dan prasarana kebinamargaan'),
(3, 57, 24, 'Program Pengembangan dan Pengelolaan Jaringan Irigasi, Rawa dan Jaringan Pengairan lainnya'),
(3, 58, 25, 'Program Penyediaan dan Pengelolaan Air Baku'),
(3, 59, 26, 'Program Pengembangan, Pengelolaan, dan Konservasi Sungai, Danau dan Sumber Daya Air Lainnya'),
(3, 60, 27, 'Program Pengembangan Kinerja Pengelolaan Air Minum dan Air Limbah'),
(3, 61, 28, 'Program Pengendalian Banjir'),
(3, 62, 29, 'Program Pengembangan Wilayah Strategis dan Cepat Tumbuh'),
(3, 63, 30, 'Program pembangunan infrastruktur perdesaan'),
(3, 64, 31, 'Program Perencanaan Tata Ruang'),
(3, 65, 32, 'Program Pemanfaatan Ruang'),
(3, 66, 33, 'Program Pengendalian Pemanfaatan Ruang'),
(4, 67, 0, 'Non Program'),
(4, 68, 1, 'Program Pelayanan Administrasi Perkantoran'),
(4, 69, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(4, 70, 3, 'Program peningkatan disiplin aparatur'),
(4, 71, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(4, 72, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(4, 73, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(4, 74, 15, 'Program Pengembangan Perumahan'),
(4, 75, 16, 'Program Lingkungan Sehat Perumahan'),
(4, 76, 17, 'Program Pemberdayaan Komunitas Perumahan'),
(4, 77, 18, 'Program perbaikan perumahan akibat bencana alam/sosial'),
(4, 78, 19, 'Program peningkatan kesiagaan dan pencegahan bahaya kebakaran'),
(4, 79, 20, 'Program pengelolaan areal pemakaman'),
(5, 80, 0, 'Non Program'),
(5, 81, 1, 'Program Pelayanan Administrasi Perkantoran'),
(5, 82, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(5, 83, 3, 'Program peningkatan disiplin aparatur'),
(5, 84, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(5, 85, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(5, 86, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(5, 87, 15, 'Program peningkatan keamanan dan kenyamanan lingkungan'),
(5, 88, 16, 'Program pemeliharaan kantrantibmas dan pencegahan tindak kriminal'),
(5, 89, 17, 'Program pengembangan wawasan kebangsaan'),
(5, 90, 18, 'Program kemitraan pengembangan wawasan kebangsaan'),
(5, 91, 19, 'Program pemberdayaan masyarakat untuk menjaga ketertiban dan keamanan'),
(5, 92, 20, 'Program peningkatan pemberantasan penyakit masyarakat (pekat)'),
(5, 93, 21, 'Program pendidikan politik masyarakat'),
(5, 94, 22, 'Program pencegahan dini dan penanggulangan korban bencana alam'),
(6, 95, 0, 'Non Program'),
(6, 96, 1, 'Program Pelayanan Administrasi Perkantoran'),
(6, 97, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(6, 98, 3, 'Program peningkatan disiplin aparatur'),
(6, 99, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(6, 100, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(6, 101, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(6, 102, 15, 'Program Pemberdayaan Fakir Miskin, Komunitas Adat Terpencil (KAT) dan Penyandang Masalah Kesejahteraan Sosial (PMKS) Lainnya'),
(6, 103, 16, 'Program Pelayanan dan Rehabilitasi Kesejahteraan Sosial'),
(6, 104, 17, 'Program pembinaan anak terlantar'),
(6, 105, 18, 'Program pembinaan para penyandang cacat dan trauma'),
(6, 106, 19, 'Program pembinaan panti asuhan /panti jompo'),
(6, 107, 20, 'Program pembinaan eks penyandang penyakit sosial (eks narapidana, PSK, narkoba dan penyakit sosial lainnya)'),
(6, 108, 21, 'Program Pemberdayaan Kelembagaan Kesejahteraan Sosial'),
(7, 109, 0, 'Non Program'),
(7, 110, 1, 'Program Pelayanan Administrasi Perkantoran'),
(7, 111, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(7, 112, 3, 'Program peningkatan disiplin aparatur'),
(7, 113, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(7, 114, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(7, 115, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(7, 116, 15, 'Program Peningkatan Kualitas dan Produktivitas Tenaga Kerja'),
(7, 117, 16, 'Program Peningkatan Kesempatan Kerja'),
(7, 118, 17, 'Program Perlindungan dan Pengembangan Lembaga Ketenagakerjaan'),
(8, 119, 0, 'Non Program'),
(8, 120, 1, 'Program Pelayanan Administrasi Perkantoran'),
(8, 121, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(8, 122, 3, 'Program peningkatan disiplin aparatur'),
(8, 123, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(8, 124, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(8, 125, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(8, 126, 15, 'Program keserasian Kebijakan Peningkatan Kualitas Anak dan Perempuan'),
(8, 127, 16, 'Program Penguatan Kelembagaan Pengarusutamaan Gender dan Anak'),
(8, 128, 17, 'Program Peningkatan Kualitas Hidup dan Perlindungan Perempuan'),
(8, 129, 18, 'Program peningkatan peran serta dan kesetaraan jender dalam pembangunan'),
(8, 130, 19, 'Program penguatan kelembagaan pengarusutamaan gender dan anak'),
(9, 131, 0, 'Non Program'),
(9, 132, 1, 'Program Pelayanan Administrasi Perkantoran'),
(9, 133, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(9, 134, 3, 'Program peningkatan disiplin aparatur'),
(9, 135, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(9, 136, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(9, 137, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(9, 138, 15, 'Program Peningkatan Ketahan Pangan (pertanian/perkebunan)'),
(10, 139, 0, 'Non Program'),
(10, 140, 1, 'Program Pelayanan Administrasi Perkantoran'),
(10, 141, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(10, 142, 3, 'Program peningkatan disiplin aparatur'),
(10, 143, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(10, 144, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(10, 145, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(10, 146, 15, 'Program pembangunan sistem pendaftaran tanah'),
(10, 147, 16, 'Program penataan penguasaan, pemilikan, penggunaan dan pemanfaatan tanah'),
(10, 148, 17, 'Program penyelesaian konflik-konflik pertanahan'),
(10, 149, 18, 'Program pengembangan sistem informasi pertanahan'),
(11, 150, 0, 'Non Program'),
(11, 151, 1, 'Program Pelayanan Administrasi Perkantoran'),
(11, 152, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(11, 153, 3, 'Program peningkatan disiplin aparatur'),
(11, 154, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(11, 155, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(11, 156, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(11, 157, 15, 'Program Pengembangan Kinerja Pengelolaan Persampahan'),
(11, 158, 16, 'Program Pengendalian Pencemaran dan Perusakan Lingkungan Hidup'),
(11, 159, 17, 'Program Perlindungan dan Konservasi Sumber Daya Alam'),
(11, 160, 18, 'Program Rehabilitasi dan Pemulihan Cadangan Sumber Daya Alam'),
(11, 161, 19, 'Program Peningkatan Kualitas dan Akses Informasi Sumber Daya Alam dan Lingkungan Hidup'),
(11, 162, 20, 'Program peningkatan pengendalian polusi'),
(11, 163, 21, 'Program pengembangan ekowisata dan jasa lingkungan dikawsan-kawasan konservasi laut dan hutan'),
(11, 164, 22, 'Program pengendalian kebakaran hutan'),
(11, 165, 23, 'Program pengelolaan dan rehabilitasi ekosistem pesisir dan laut'),
(11, 166, 24, 'Program pengelolaan ruang terbuka hijau (RTH)'),
(12, 167, 0, 'Non Program'),
(12, 168, 1, 'Program Pelayanan Administrasi Perkantoran'),
(12, 169, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(12, 170, 3, 'Program peningkatan disiplin aparatur'),
(12, 171, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(12, 172, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(12, 173, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(12, 174, 15, 'Program Penataan Administrasi Kependudukan'),
(13, 175, 0, 'Non Program'),
(13, 176, 1, 'Program Pelayanan Administrasi Perkantoran'),
(13, 177, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(13, 178, 3, 'Program peningkatan disiplin aparatur'),
(13, 179, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(13, 180, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(13, 181, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(13, 182, 15, 'Program Peningkatan Keberdayaan Masyarakat Perdesaan'),
(13, 183, 16, 'Program pengembangan lembaga ekonomi pedesaan'),
(13, 184, 17, 'Program peningkatan partisipasi masyarakat dalam membangun desa'),
(13, 185, 18, 'Program peningkatan kapasitas aparatur pemerintah desa'),
(13, 186, 19, 'Program peningkatan peran perempuan di perdesaan'),
(14, 187, 0, 'Non Program'),
(14, 188, 1, 'Program Pelayanan Administrasi Perkantoran'),
(14, 189, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(14, 190, 3, 'Program peningkatan disiplin aparatur'),
(14, 191, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(14, 192, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(14, 193, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(14, 194, 15, 'Program Keluarga Berencana'),
(14, 195, 16, 'Program Kesehatan Reproduksi Remaja'),
(14, 196, 17, 'Program pelayanan kontrasepsi'),
(14, 197, 18, 'Program pembinaan peran serta masyarakat dalam pelayanan KB/KR yang mandiri'),
(14, 198, 19, 'Program promosi kesehatan ibu, bayi dan anak melalui kelompok kegiatan dimasyarakat'),
(14, 199, 20, 'Program pengembangan pusat pelayanan informasi dan konseling KRR'),
(14, 200, 21, 'Program peningkatan penanggulangan narkoba, PMS termasuk HIV/AIDS'),
(14, 201, 22, 'Program pengembangan bahan informasi tentang pengasuhan dan pembinaan tumbuh kembang anak'),
(14, 202, 23, 'Program penyiapan tenaga pedamping kelompok bina keluarga'),
(14, 203, 24, 'Program pengembangan model operasional BKB-Posyandu-PADU'),
(15, 204, 0, 'Non Program'),
(15, 205, 1, 'Program Pelayanan Administrasi Perkantoran'),
(15, 206, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(15, 207, 3, 'Program peningkatan disiplin aparatur'),
(15, 208, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(15, 209, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(15, 210, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(15, 211, 15, 'Program Pembangunan Prasarana dan Fasilitas Perhubungan'),
(15, 212, 16, 'Program Rehabilitasi dan Pemeliharaan Prasarana dan Fasilitas LLAJ'),
(15, 213, 17, 'Pogram peningkatan pelayanan angkutan'),
(15, 214, 18, 'Program pembangunan sarana dan prasarana perhubungan'),
(15, 215, 19, 'Program pengendalian dan pengamanan lalu lintas'),
(15, 216, 20, 'Program peningkatan kelaikan pengoperasian kendaraan bermotor'),
(16, 217, 0, 'Non Program'),
(16, 218, 1, 'Program Pelayanan Administrasi Perkantoran'),
(16, 219, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(16, 220, 3, 'Program peningkatan disiplin aparatur'),
(16, 221, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(16, 222, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(16, 223, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(16, 224, 15, 'Program Pengembangan Komunikasi, Informasi dan Media Massa'),
(16, 225, 16, 'Program pengkajian dan penelitian bidang informasi dan komunikasi'),
(16, 226, 17, 'Program fasilitasi Peningkatan SDM bidang komunikasi dan informasi'),
(16, 227, 18, 'Program kerjasama informasi dengan mas media'),
(17, 228, 0, 'Non Program'),
(17, 229, 1, 'Program Pelayanan Administrasi Perkantoran'),
(17, 230, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(17, 231, 3, 'Program peningkatan disiplin aparatur'),
(17, 232, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(17, 233, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(17, 234, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(17, 235, 15, 'Program penciptaan iklim usaha Usaha Kecil Menengah yang konduksif'),
(17, 236, 16, 'Program Pengembangan Kewirausahaan dan Keunggulan Kompetitif Usaha Kecil Menengah'),
(17, 237, 17, 'Program Pengembangan Sistem Pendukung Usaha Bagi Usaha Mikro Kecil Menengah'),
(17, 238, 18, 'Program Peningkatan Kualitas Kelembagaan Koperasi'),
(18, 239, 0, 'Non Program'),
(18, 240, 1, 'Program Pelayanan Administrasi Perkantoran'),
(18, 241, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(18, 242, 3, 'Program peningkatan disiplin aparatur'),
(18, 243, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(18, 244, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(18, 245, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(18, 246, 15, 'Program Peningkatan Promosi dan Kerjasama Investasi'),
(18, 247, 16, 'Program Peningkatan Iklim Investasi dan Realisasi Investasi'),
(18, 248, 17, 'Program penyiapan potensi sumberdaya, sarana, dan prasarana daerah'),
(19, 249, 0, 'Non Program'),
(19, 250, 1, 'Program Pelayanan Administrasi Perkantoran'),
(19, 251, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(19, 252, 3, 'Program peningkatan disiplin aparatur'),
(19, 253, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(19, 254, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(19, 255, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(19, 256, 15, 'Program Pengembangan dan Keserasian Kebijakan Pemuda'),
(19, 257, 16, 'Program peningkatan peran serta kepemudaan'),
(19, 258, 17, 'Program peningkatan upaya penumbuhan kewirausahaan dan kecakapan hidup pemuda'),
(19, 259, 18, 'Program upaya pencegahan penyalahgunaan narkoba'),
(19, 260, 19, 'Program Pengembangan Kebijakan dan Manajemen Olah Raga'),
(19, 261, 20, 'Program Pembinaan dan Pemasyarakatan Olah Raga'),
(19, 262, 21, 'Program Peningkatan Sarana dan Prasarana Olah Raga'),
(20, 263, 0, 'Non Program'),
(20, 264, 1, 'Program Pelayanan Administrasi Perkantoran'),
(20, 265, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(20, 266, 3, 'Program peningkatan disiplin aparatur'),
(20, 267, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(20, 268, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(20, 269, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(20, 270, 15, 'Program pengembangan data/informasi/statistik daerah'),
(21, 271, 0, 'Non Program'),
(21, 272, 1, 'Program Pelayanan Administrasi Perkantoran'),
(21, 273, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(21, 274, 3, 'Program peningkatan disiplin aparatur'),
(21, 275, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(21, 276, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(21, 277, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(22, 278, 0, 'Non Program'),
(22, 279, 1, 'Program Pelayanan Administrasi Perkantoran'),
(22, 280, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(22, 281, 3, 'Program peningkatan disiplin aparatur'),
(22, 282, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(22, 283, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(22, 284, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(22, 285, 15, 'Program Pengembangan Nilai Budaya'),
(22, 286, 16, 'Program Pengelolaan Kekayaan Budaya'),
(22, 287, 17, 'Program Pengelolaan Keragaman Budaya'),
(22, 288, 18, 'Program pengembangan kerjasama pengelolaan kekayaan budaya'),
(23, 289, 0, 'Non Program'),
(23, 290, 1, 'Program Pelayanan Administrasi Perkantoran'),
(23, 291, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(23, 292, 3, 'Program Peningkatan Disiplin Aparatur'),
(23, 293, 4, 'Program Fasilitasi Pindah/Purna Tugas PNS'),
(23, 294, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(23, 295, 6, 'Program Peningkatan Pengembangan Sistem Pelaporan Capaian Kinerja dan Keuangan'),
(23, 296, 15, 'Program Pengembangan Budaya Baca dan Pembinaan Perpustakaan'),
(24, 297, 0, 'Non Program'),
(24, 298, 1, 'Program Pelayanan Administrasi Perkantoran'),
(24, 299, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(24, 300, 3, 'Program peningkatan disiplin aparatur'),
(24, 301, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(24, 302, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(24, 303, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(24, 304, 15, 'Program perbaikan sistem administrasi kearsipan'),
(24, 305, 16, 'Program penyelamatan dan pelestarian dokumen/arsip daerah'),
(24, 306, 17, 'Program pemeliharaan rutin/berkala sarana dan prasarana kearsipan'),
(24, 307, 18, 'Program peningkatan kualitas pelayanan informasi'),
(25, 308, 0, 'Non Program'),
(25, 309, 1, 'Program Pelayanan Administrasi Perkantoran'),
(25, 310, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(25, 311, 3, 'Program peningkatan disiplin aparatur'),
(25, 312, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(25, 313, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(25, 314, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(25, 315, 15, 'Program pemberdayaan ekonomi masyarakat pesisir'),
(25, 316, 16, 'Program pemberdayaan masyarakat dalam pengawasan dan pengendalian sumberdaya kelautan'),
(25, 317, 17, 'Program peningkatan kesadaran dan penegakan hukum dalam pendayagunaan sumberdaya laut'),
(25, 318, 18, 'Program peningkatan mitigasi bencana alam laut dan prakiraan iklim laut'),
(25, 319, 19, 'Program peningkatan kegiatan budaya kelautan dan wawasan maritim kepada masyarakat'),
(25, 320, 20, 'Program pengembangan budidaya perikanan'),
(25, 321, 21, 'Program pengembangan perikanan tangkap'),
(25, 322, 22, 'Program pengembangan sistem penyuluhan perikanan'),
(25, 323, 23, 'Program Optimalisasi pengelolaan dan pemasaran produksi perikanan'),
(25, 324, 24, 'Program pengembangan kawasan budidaya laut, air payau dan air tawar'),
(26, 325, 0, 'Non Program'),
(26, 326, 1, 'Program Pelayanan Administrasi Perkantoran'),
(26, 327, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(26, 328, 3, 'Program peningkatan disiplin aparatur'),
(26, 329, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(26, 330, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(26, 331, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(26, 332, 15, 'Program pengembangan pemasaran pariwisata'),
(26, 333, 16, 'Program pengembangan destinasi pariwisata'),
(26, 334, 17, 'Program pengembangan Kemitraan'),
(27, 335, 0, 'Non Program'),
(27, 336, 1, 'Program Pelayanan Administrasi Perkantoran'),
(27, 337, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(27, 338, 3, 'Program peningkatan disiplin aparatur'),
(27, 339, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(27, 340, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(27, 341, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(27, 342, 15, 'Program Peningkatan Kesejahteraan Petani'),
(27, 343, 16, 'Program peningkatan pemasaran hasil produksi pertanian/perkebunan'),
(27, 344, 17, 'Program peningkatan penerapan teknologi pertanian/perkebunan'),
(27, 345, 18, 'Program peningkatan produksi pertanian/perkebunan'),
(27, 346, 19, 'Program pemberdayaan penyuluh pertanian/perkebunan lapangan'),
(27, 347, 20, 'Program pencegahan dan penanggulangan penyakit ternak'),
(27, 348, 21, 'Program peningkatan produksi hasil peternakan'),
(27, 349, 22, 'Program peningkatan pemasaran hasil produksi peternakan'),
(27, 350, 23, 'Program peningkatan produksi peternakan'),
(28, 351, 0, 'Non Program'),
(28, 352, 1, 'Program Pelayanan Administrasi Perkantoran'),
(28, 353, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(28, 354, 3, 'Program peningkatan disiplin aparatur'),
(28, 355, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(28, 356, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(28, 357, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(28, 358, 15, 'Program pemanfaatan potensi sumber daya hutan'),
(28, 359, 16, 'Program rehabilitasi hutan dan lahan'),
(28, 360, 17, 'Perlindungan dan konservasi sumber daya hutan'),
(28, 361, 18, 'Program pemanfaatan kawasan hutan industri'),
(28, 362, 19, 'Program pembinaan dan penerbitan industri hasil hutan'),
(28, 363, 20, 'Program perencanaan dan pengembangan hutan'),
(29, 364, 0, 'Non Program'),
(29, 365, 1, 'Program Pelayanan Administrasi Perkantoran'),
(29, 366, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(29, 367, 3, 'Program peningkatan disiplin aparatur'),
(29, 368, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(29, 369, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(29, 370, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(29, 371, 15, 'Program pembinaan dan pengawasan bidang pertambangan'),
(29, 372, 16, 'Program pengawasan dan penertiban kegiatan rakyat yang erpotensi merusak lingkungan'),
(29, 373, 17, 'Program pembinaan dan pengembangan bidang ketenagalistrikan'),
(30, 374, 0, 'Non Program'),
(30, 375, 1, 'Program Pelayanan Administrasi Perkantoran'),
(30, 376, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(30, 377, 3, 'Program peningkatan disiplin aparatur'),
(30, 378, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(30, 379, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(30, 380, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(30, 381, 15, 'Program perlindungan konsumen dan pengamanan perdagangan'),
(30, 382, 16, 'Program peningkatan kerjasama perdagangan internasional'),
(30, 383, 17, 'Program peningkatan dan pengembangan ekspor'),
(30, 384, 18, 'Program peningkatan efisiensi perdagangan dalam negeri'),
(30, 385, 19, 'Program pembinaan pedagang kakilima dan asongan'),
(31, 386, 0, 'Non Program'),
(31, 387, 1, 'Program Pelayanan Administrasi Perkantoran'),
(31, 388, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(31, 389, 3, 'Program peningkatan disiplin aparatur'),
(31, 390, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(31, 391, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(31, 392, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(31, 393, 15, 'Program peningkatan kapasitas iptek sistem produksi'),
(31, 394, 16, 'Program pengembangan industri kecil dan menengah'),
(31, 395, 17, 'Program peningkatan kemampuan teknologi industri'),
(31, 396, 18, 'Program penataan struktur industri'),
(31, 397, 19, 'Program pengembangan sentra-sentra industri potensial'),
(32, 398, 0, 'Non Program'),
(32, 399, 1, 'Program Pelayanan Administrasi Perkantoran'),
(32, 400, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(32, 401, 3, 'Program peningkatan disiplin aparatur'),
(32, 402, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(32, 403, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(32, 404, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(32, 405, 15, 'Program pengembangan wilayah transmigrasi'),
(32, 406, 16, 'Program Transmigrasi lokal'),
(32, 407, 17, 'Program transmigrasi regional'),
(33, 408, 0, 'Non Program'),
(33, 409, 1, 'Program Pelayanan Administrasi Perkantoran'),
(33, 410, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(33, 411, 3, 'Program peningkatan disiplin aparatur'),
(33, 412, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(33, 413, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(33, 414, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(33, 415, 15, 'Program Peningkatan Kapasitas Lembaga Perwakilan Rakyat Daerah'),
(33, 416, 16, 'Program Peningkatan Pelayanan Kedinasan Kepala Daerah/Wakil Kepala Daerah'),
(33, 417, 17, 'Program Optimalisasi Pemanfaatan Teknologi Informasi'),
(33, 418, 18, 'Program Mengintensifkan Penanganan Pengaduan Masyarakat'),
(33, 419, 19, 'Program Peningkatan Kerjasama Antar Pemerintah Daerah'),
(33, 420, 20, 'Program Penataan Peraturan Perundang-Undangan'),
(33, 421, 21, 'Program Penataan Daerah Otonomi Baru'),
(34, 422, 0, 'Non Program'),
(34, 423, 1, 'Program Pelayanan Administrasi Perkantoran'),
(34, 424, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(34, 425, 3, 'Program peningkatan disiplin aparatur'),
(34, 426, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(34, 427, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(34, 428, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(34, 429, 15, 'Program Peningkatan Sistem Pengawasan Internal dan Pengendalian Pelaksanaan Kebijakan KDH'),
(34, 430, 16, 'Program Peningkatan Profesionalisme Tenaga Pemeriksa dan Aparatur Pengawasan'),
(34, 431, 17, 'Program Penataan dan Penyempurnaan Kebijakan Sistem dan Prosedur Pengawasan'),
(35, 432, 0, 'Non Program'),
(35, 433, 1, 'Program Pelayanan Administrasi Perkantoran'),
(35, 434, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(35, 435, 3, 'Program peningkatan disiplin aparatur'),
(35, 436, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(35, 437, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(35, 438, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(35, 439, 15, 'Program pengembangan data/informasi'),
(35, 440, 16, 'Program Kerjasama Pembangunan'),
(35, 441, 17, 'Program Pengembangan Wilayah Perbatasan'),
(35, 442, 18, 'Program Perencanaan Pengembangan Wilayah Strategis dan Cepat Tumbuh'),
(35, 443, 19, 'Program perencanaan pengembangan kota-kota menengah dan besar'),
(35, 444, 20, 'Program peningkatan kapasitas kelembagaan perencanaan pembangunan daerah'),
(35, 445, 21, 'Program perencanaan pembangunan daerah'),
(35, 446, 22, 'Program perencanaan pembangunan ekonomi'),
(35, 447, 23, 'Program perencanaan sosial dan budaya'),
(35, 448, 24, 'Program perancanaan prasarana wilayah dan sumber daya alam'),
(35, 449, 25, 'Program perencanaan pembangunan daerah rawan bencana'),
(36, 450, 0, 'Non Program'),
(36, 451, 1, 'Program Pelayanan Administrasi Perkantoran'),
(36, 452, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(36, 453, 3, 'Program peningkatan disiplin aparatur'),
(36, 454, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(36, 455, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(36, 456, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(36, 457, 15, 'Program Peningkatan dan Pengembangan Pengelolaan Keuangan Daerah'),
(36, 458, 16, 'Program Pembinaan dan Fasilitasi Pengelolaan Keuangan Kabupaten/Kota'),
(36, 459, 17, 'Program Pembinaan dan Fasilitasi Pengelolaan Keuangan Desa'),
(37, 460, 0, 'Non Program'),
(37, 461, 1, 'Program Pelayanan Administrasi Perkantoran'),
(37, 462, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(37, 463, 3, 'Program peningkatan disiplin aparatur'),
(37, 464, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(37, 465, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(37, 466, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(37, 467, 15, 'Program pembinaan dan pengembangan aparatur'),
(38, 468, 0, 'Non Program'),
(38, 469, 1, 'Program Pelayanan Administrasi Perkantoran'),
(38, 470, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(38, 471, 3, 'Program peningkatan disiplin aparatur'),
(38, 472, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(38, 473, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(38, 474, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan'),
(38, 475, 15, 'Program Pendidikan Kedinasan'),
(38, 476, 16, 'Program peningkatan kapasitas sumberdaya aparatur'),
(39, 477, 0, 'Non Program'),
(39, 478, 1, 'Program Pelayanan Administrasi Perkantoran'),
(39, 479, 2, 'Program Peningkatan Sarana dan Prasarana Aparatur'),
(39, 480, 3, 'Program peningkatan disiplin aparatur'),
(39, 481, 4, 'Program fasilitasi pindah/purna tugas PNS'),
(39, 482, 5, 'Program Peningkatan Kapasitas Sumber Daya Aparatur'),
(39, 483, 6, 'Program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan');

-- --------------------------------------------------------

--
-- Table structure for table `ref_rek_1`
--

DROP TABLE IF EXISTS `ref_rek_1`;
CREATE TABLE IF NOT EXISTS `ref_rek_1` (
  `kd_rek_1` int(11) NOT NULL,
  `nama_kd_rek_1` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`kd_rek_1`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_rek_1`
--

INSERT INTO `ref_rek_1` (`kd_rek_1`, `nama_kd_rek_1`) VALUES
(1, 'ASET'),
(2, 'KEWAJIBAN'),
(3, 'EKUITAS DANA'),
(4, 'PENDAPATAN'),
(5, 'BELANJA'),
(6, 'PEMBIAYAAN DAERAH'),
(7, 'PERHITUNGAN FIHAK KETIGA (PFK)');

-- --------------------------------------------------------

--
-- Table structure for table `ref_rek_2`
--

DROP TABLE IF EXISTS `ref_rek_2`;
CREATE TABLE IF NOT EXISTS `ref_rek_2` (
  `kd_rek_1` int(11) NOT NULL,
  `kd_rek_2` int(11) NOT NULL,
  `nama_kd_rek_2` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`kd_rek_1`,`kd_rek_2`) USING BTREE,
  UNIQUE KEY `kd_rek_1` (`kd_rek_1`,`kd_rek_2`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_rek_2`
--

INSERT INTO `ref_rek_2` (`kd_rek_1`, `kd_rek_2`, `nama_kd_rek_2`) VALUES
(1, 1, 'ASET LANCAR'),
(1, 2, 'INVESTASI JANGKA PANJANG'),
(1, 3, 'ASET TETAP'),
(1, 4, 'DANA CADANGAN'),
(1, 5, 'ASET LAINNYA'),
(2, 1, 'KEWAJIBAN JANGKA PENDEK'),
(2, 2, 'KEWAJIBAN JANGKA PANJANG'),
(3, 1, 'EKUITAS DANA LANCAR'),
(3, 2, 'EKUITAS DANA INVESTASI'),
(3, 3, 'EKUITAS DANA CADANGAN'),
(4, 1, 'PENDAPATAN ASLI DAERAH'),
(4, 2, 'DANA PERIMBANGAN'),
(4, 3, 'LAIN-LAIN PENDAPATAN DAERAH YANG SAH'),
(5, 1, 'BELANJA TIDAK LANGSUNG'),
(5, 2, 'BELANJA LANGSUNG'),
(6, 1, 'PENERIMAAN PEMBIAYAAN DAERAH'),
(6, 2, 'PENGELUARAN PEMBIAYAAN DAERAH'),
(6, 3, 'PEMBIAYAAN NETTO'),
(6, 4, 'SISA LEBIH/KURANG PEMBIAYAAN TAHUN BERKENAAN'),
(7, 1, 'PENERIMAAN PERHITUNGAN FIHAK KETIGA (PFK)'),
(7, 2, 'PENGELUARAN PERHITUNGAN FIHAK KETIGA (PFK)');

-- --------------------------------------------------------

--
-- Table structure for table `ref_rek_3`
--

DROP TABLE IF EXISTS `ref_rek_3`;
CREATE TABLE IF NOT EXISTS `ref_rek_3` (
  `kd_rek_1` int(11) NOT NULL,
  `kd_rek_2` int(11) NOT NULL,
  `kd_rek_3` int(11) NOT NULL,
  `nama_kd_rek_3` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `saldo_normal` char(1) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`) USING BTREE,
  KEY `kd_rek_1` (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_rek_3`
--

INSERT INTO `ref_rek_3` (`kd_rek_1`, `kd_rek_2`, `kd_rek_3`, `nama_kd_rek_3`, `saldo_normal`) VALUES
(1, 1, 1, 'Kas', 'D'),
(1, 1, 2, 'Investasi Jangka Pendek', 'D'),
(1, 1, 3, 'Piutang', 'D'),
(1, 1, 4, 'Piutang Lain-lain', 'D'),
(1, 1, 5, 'Persediaan', 'D'),
(1, 1, 8, 'R/K SKPD', 'D'),
(1, 2, 1, 'Investasi Non Permanen', 'D'),
(1, 2, 2, 'Investasi Permanen', 'D'),
(1, 3, 1, 'Tanah', 'D'),
(1, 3, 2, 'Peralatan dan Mesin', 'D'),
(1, 3, 3, 'Gedung dan Bangunan', 'D'),
(1, 3, 4, 'Jalan, Jaringan dan Instalasi', 'D'),
(1, 3, 5, 'Aset Tetap Lainnya', 'D'),
(1, 3, 6, 'Konstruksi dalam Pengerjaan', 'D'),
(1, 3, 7, 'Akumulasi Penyusutan', 'D'),
(1, 4, 1, 'Dana Cadangan', 'D'),
(1, 5, 1, 'Tagihan Piutang Penjualan Angsuran', 'D'),
(1, 5, 2, 'Tagihan Tuntutan Ganti Kerugian Daerah', 'D'),
(1, 5, 3, 'Kemitraan dengan Pihak Ketiga', 'D'),
(1, 5, 4, 'Aset Tidak Berwujud', 'D'),
(1, 5, 5, 'Aset Lain-lain', 'D'),
(2, 1, 1, 'Utang Perhitungan Fihak Ketiga (PFK)', 'K'),
(2, 1, 2, 'Utang Bunga', 'K'),
(2, 1, 3, 'Utang Pajak', 'K'),
(2, 1, 4, 'Bagian Lancar Utang Jangka Panjang', 'K'),
(2, 1, 5, 'Pendapatan Diterima Dimuka', 'K'),
(2, 1, 6, 'Utang Jangka Pendek Lainnya', 'K'),
(2, 1, 8, 'R/K Pusat', 'K'),
(2, 2, 1, 'Utang Dalam Negeri', 'K'),
(2, 2, 2, 'Utang Luar Negeri', 'K'),
(3, 1, 1, 'Sisa Lebih Pembiayaan Anggaran (SILPA)', 'K'),
(3, 1, 2, 'Cadangan untuk Piutang', 'K'),
(3, 1, 3, 'Cadangan untuk Persediaan', 'K'),
(3, 1, 4, 'Dana yang harus disediakan untuk pembayaran Utang Jangka Pendek', 'K'),
(3, 1, 5, 'Pendapatan yang Ditangguhkan', 'D'),
(3, 2, 1, 'Diinvestasikan dalam Investasi Jangka Panjang', 'K'),
(3, 2, 2, 'Diinvestasikan dalam Aset Tetap', 'K'),
(3, 2, 3, 'Diinvestasikan dalam Aset Lainnya (Tidak termasuk Dana Cadangan)', 'K'),
(3, 2, 4, 'Dana yang harus disediakan untuk pembayaran hutang Jangka Panjang', 'K'),
(3, 3, 1, 'Diinvestasikan dalam Dana Cadangan', 'K'),
(4, 1, 1, 'Hasil Pajak Daerah', 'K'),
(4, 1, 2, 'Hasil Retribusi Daerah', 'K'),
(4, 1, 3, 'Hasil Pengelolaan Kekayaan Daerah Yang Dipisahkan', 'K'),
(4, 1, 4, 'Lain-lain Pendapatan Asli Daerah Yang Sah', 'K'),
(4, 2, 1, 'Dana Bagi Hasil Pajak/Bagi Hasil Bukan Pajak', 'K'),
(4, 2, 2, 'Dana Alokasi Umum', 'K'),
(4, 2, 3, 'Dana Alokasi Khusus', 'K'),
(4, 3, 1, 'Pendapatan Hibah', 'K'),
(4, 3, 2, 'Dana Darurat', 'K'),
(4, 3, 3, 'Dana Bagi Hasil Pajak dari Provinsi dan Pemerintah Daerah Lainnya', 'K'),
(4, 3, 4, 'Dana Penyesuaian dan Otonomi Khusus', 'K'),
(4, 3, 5, 'Bantuan Keuangan dari Provinsi atau Pemerintah Daerah Lainnya', 'K'),
(5, 1, 1, 'Belanja Pegawai', 'D'),
(5, 1, 2, 'Belanja Bunga', 'D'),
(5, 1, 3, 'Belanja Subsidi', 'D'),
(5, 1, 4, 'Belanja Hibah', 'D'),
(5, 1, 5, 'Belanja Bantuan Sosial', 'D'),
(5, 1, 6, 'Belanja Bagi Hasil Kepada Provinsi/Kabupaten/Kota DanPemerintahan Desa', 'D'),
(5, 1, 7, 'Belanja Bantuan Keuangan Kepada Provinsi/Kabupaten/Kota ,Pemerintahan Desa Dan Partai Politik', 'D'),
(5, 1, 8, 'Belanja Tidak Terduga', 'D'),
(5, 2, 1, 'Belanja Pegawai', 'D'),
(5, 2, 2, 'Belanja Barang Dan Jasa', 'D'),
(5, 2, 3, 'Belanja Modal', 'D'),
(6, 1, 1, 'Sisa Lebih Perhitungan Anggaran Tahun Anggaran Sebelumnya', 'K'),
(6, 1, 2, 'Pencairan Dana Cadangan', 'K'),
(6, 1, 3, 'Hasil Penjualan Kekayaan Daerah yang Dipisahkan', 'K'),
(6, 1, 4, 'Penerimaan Pinjaman Daerah', 'K'),
(6, 1, 5, 'Penerimaan Kembali Pemberian Pinjaman', 'K'),
(6, 1, 6, 'Penerimaan Piutang Daerah', 'K'),
(6, 1, 7, 'Penerimaan kembali investasi dana bergulir', 'K'),
(6, 2, 1, 'Pembentukan Dana Cadangan', 'D'),
(6, 2, 2, 'Penyertaan Modal /Investasi Pemerintah Daerah', 'D'),
(6, 2, 3, 'Pembayaran Pokok Utang', 'D'),
(6, 2, 4, 'Pemberian Pinjaman Daerah', 'D'),
(6, 3, 1, 'Pembiayaan Netto', 'D'),
(6, 4, 1, 'Sisa Lebih/Kurang Pembiayaan Tahun Berkenaan', 'K'),
(7, 1, 1, 'Penerimaan Perhitungan Fihak Ketiga (PFK)', 'K'),
(7, 2, 1, 'Pengeluaran Perhitungan Fihak Ketiga (PFK)', 'D');

-- --------------------------------------------------------

--
-- Table structure for table `ref_rek_4`
--

DROP TABLE IF EXISTS `ref_rek_4`;
CREATE TABLE IF NOT EXISTS `ref_rek_4` (
  `kd_rek_1` int(11) NOT NULL,
  `kd_rek_2` int(11) NOT NULL,
  `kd_rek_3` int(11) NOT NULL,
  `kd_rek_4` int(11) NOT NULL,
  `nama_kd_rek_4` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`,`kd_rek_4`) USING BTREE,
  UNIQUE KEY `kd_rek_1` (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`,`kd_rek_4`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_rek_4`
--

INSERT INTO `ref_rek_4` (`kd_rek_1`, `kd_rek_2`, `kd_rek_3`, `kd_rek_4`, `nama_kd_rek_4`) VALUES
(1, 1, 1, 1, 'Kas di Kas Daerah'),
(1, 1, 1, 2, 'Kas di Bendahara Penerimaan'),
(1, 1, 1, 3, 'Kas di Bendahara Pengeluaran'),
(1, 1, 1, 4, 'Kas Di Badan Layanan Umum Daerah'),
(1, 1, 2, 1, 'Investasi dalam Saham'),
(1, 1, 2, 2, 'Investasi dalam Obligasi'),
(1, 1, 3, 1, 'Piutang Pajak'),
(1, 1, 3, 2, 'Piutang Retribusi'),
(1, 1, 3, 3, 'Piutang Dana Bagi Hasil'),
(1, 1, 3, 4, 'Piutang Dana Alokasi Umum'),
(1, 1, 3, 5, 'Piutang Dana Alokasi Khusus'),
(1, 1, 4, 1, 'Piutang Bagian Lancar Penjualan Angsuran'),
(1, 1, 4, 2, 'Piutang Ganti Rugi atas Kekayaan Daerah'),
(1, 1, 4, 3, 'Piutang Hasil Penjualan Barang Milik Daerah'),
(1, 1, 4, 4, 'Piutang Deviden'),
(1, 1, 4, 5, 'Piutang Bagi Hasil Laba Usaha Perusahaan Daerah'),
(1, 1, 4, 6, 'Piutang Fasilitas Sosial dan Fasilitas Umum'),
(1, 1, 4, 7, 'Piutang Lain-lain - Lainnya'),
(1, 1, 5, 1, 'Persediaan Alat Tulis kantor'),
(1, 1, 5, 2, 'Persediaan Alat Listrik'),
(1, 1, 5, 3, 'Persediaan Material/Bahan'),
(1, 1, 5, 4, 'Persediaan Benda Pos'),
(1, 1, 5, 5, 'Persediaan Bahan Bakar'),
(1, 1, 5, 6, 'Persediaan Bahan Makanan Pokok'),
(1, 1, 8, 1, 'R/K SKPD'),
(1, 2, 1, 1, 'Pinjaman Kepada Perusahaan Negara'),
(1, 2, 1, 2, 'Pinjaman Kepada Perusahaan Daerah'),
(1, 2, 1, 3, 'Pinjaman Kepada Perusahaan Daerah Lainnya'),
(1, 2, 1, 4, 'Investasi dalam Surat Utang Negara'),
(1, 2, 1, 5, 'Investasi Non Permanen Lainnya'),
(1, 2, 2, 1, 'Penyertaan Modal Pemerintah Daerah'),
(1, 2, 2, 2, 'Penyertaan Modal dalam Proyek Pembangunan'),
(1, 2, 2, 3, 'Penyertaan Modal Perusahaan Patungan'),
(1, 2, 2, 4, 'Invertasi Permanen Lainnya'),
(1, 3, 1, 1, 'Tanah Kantor'),
(1, 3, 1, 2, 'Tanah Sarana Kesehatan Rumah Sakit'),
(1, 3, 1, 3, 'Tanah Sarana Kesehatan Puskesmas'),
(1, 3, 1, 4, 'Tanah Sarana Kesehatan Poliklinik'),
(1, 3, 1, 5, 'Tanah Sarana Pendidikan Taman Kanak-kanak'),
(1, 3, 1, 6, 'Tanah Sarana Pendidikan Sekolah Dasar'),
(1, 3, 1, 7, 'Tanah Sarana Pendidikan Menengah Umum dan Kejuruan'),
(1, 3, 1, 8, 'Tanah Sarana Pendidikan Menengah Lanjutan dan Kejuruan'),
(1, 3, 1, 9, 'Tanah Sarana Pendidikan Luar Biasa/Khusus'),
(1, 3, 1, 10, 'Tanah Sarana Pendidikan Pelatihan dan Kursus'),
(1, 3, 1, 11, 'Tanah Sarana Sosial Panti Asuhan'),
(1, 3, 1, 12, 'Tanah Sarana Sosial Panti Jompo'),
(1, 3, 1, 13, 'Tanah Sarana Umum Terminal'),
(1, 3, 1, 14, 'Tanah Sarana Umum Dermaga'),
(1, 3, 1, 15, 'Tanah Sarana Umum Lapangan Terbang Perintis'),
(1, 3, 1, 16, 'Tanah Sarana Umum Rumah Potong Hewan'),
(1, 3, 1, 17, 'Tanah Sarana Umum Tempat Pelelangan Ikan'),
(1, 3, 1, 18, 'Tanah Sarana Umum Pasar'),
(1, 3, 1, 19, 'Tanah Sarana Umum Tempat Pembuangan Akhir Sampah'),
(1, 3, 1, 20, 'Tanah Sarana Umum Taman'),
(1, 3, 1, 21, 'Tanah Sarana Umum Pusat Hiburan Rakyat'),
(1, 3, 1, 22, 'Tanah Sarana Umum Ibadah'),
(1, 3, 1, 23, 'Tanah Sarana Stadion Olahraga'),
(1, 3, 1, 24, 'Tanah Perumahan'),
(1, 3, 1, 25, 'Tanah Petanian'),
(1, 3, 1, 26, 'Tanah Perkebunan'),
(1, 3, 1, 27, 'Tanah Perikanan'),
(1, 3, 1, 28, 'Tanah Peternakan'),
(1, 3, 1, 29, 'Tanah Perkampungan'),
(1, 3, 1, 30, 'Tanah Pergudangan/Tempat Penimbunan Material Bahan Baku'),
(1, 3, 2, 1, 'Alat-alat Besar'),
(1, 3, 2, 2, 'Alat-alat Angkutan Darat Bermotor'),
(1, 3, 2, 3, 'Alat-alat Angkutan Darat Tidak Bermotor'),
(1, 3, 2, 4, 'Alat-alat Angkutan Air Bermotor'),
(1, 3, 2, 5, 'Alat-alat Angkutan Air Tidak Bermotor'),
(1, 3, 2, 6, 'Alat-alat Angkutan Udara'),
(1, 3, 2, 7, 'Alat-alat Bengkel'),
(1, 3, 2, 8, 'Alat-alat Pengolahan Pertanian dan peternakan'),
(1, 3, 2, 9, 'Peralatan Kantor'),
(1, 3, 2, 10, 'Perlengkapan Kantor'),
(1, 3, 2, 11, 'Komputer'),
(1, 3, 2, 12, 'Meubelair'),
(1, 3, 2, 13, 'Peralatan Dapur'),
(1, 3, 2, 14, 'Penghias Ruangan Rumah Tangga'),
(1, 3, 2, 15, 'Alat-alat Studio'),
(1, 3, 2, 16, 'Alat-alat Komunikasi'),
(1, 3, 2, 17, 'Alat-alat Ukur'),
(1, 3, 2, 18, 'Alat-alat Kedokteran'),
(1, 3, 2, 19, 'Alat-alat Laboratorium'),
(1, 3, 2, 20, 'Alat-alat Persenjataan/Keamanan'),
(1, 3, 3, 1, 'Gedung Kantor'),
(1, 3, 3, 2, 'Gedung Rumah Jabatan'),
(1, 3, 3, 3, 'Gedung Rumah Dinas'),
(1, 3, 3, 4, 'Gedung Gudang'),
(1, 3, 3, 5, 'Bangunan Bersejarah'),
(1, 3, 3, 6, 'Bangunan Monumen'),
(1, 3, 3, 7, 'Tugu Peringatan'),
(1, 3, 4, 1, 'Jalan'),
(1, 3, 4, 2, 'Jembatan'),
(1, 3, 4, 3, 'Jaringan Air'),
(1, 3, 4, 4, 'Penerangan Jalan, Taman dan Hutan Kota'),
(1, 3, 4, 5, 'Instalasi Listrik dan Telepon'),
(1, 3, 5, 1, 'Buku dan Kepustakaan'),
(1, 3, 5, 2, 'Barang Bercorak Kesenian, Kebudayaan'),
(1, 3, 5, 3, 'Hewan, Ternak dan Tanaman'),
(1, 3, 6, 1, 'Konstruksi dalam Pengerjaan'),
(1, 3, 7, 1, 'Akumulasi Penyusutan Aset Tetap'),
(1, 4, 1, 1, 'Dana Cadangan'),
(1, 5, 1, 1, 'Tagihan Penjualan Angsuran/Cicilan Kendaraan Bermotor'),
(1, 5, 1, 2, 'Tagihan Penjualan Angsuran/Cicilan Rumah'),
(1, 5, 2, 1, 'Tagihan Tuntutan Ganti Kerugian Daerah'),
(1, 5, 3, 1, 'Bangun guna serah (Build, Operate and Transfer/BOT)'),
(1, 5, 3, 2, 'Bangun serah guna (Build, Transfer and Operate/BTO)'),
(1, 5, 3, 3, 'Kerjasama operasi (KSO)'),
(1, 5, 4, 1, 'Aset Tidak Berwujud'),
(1, 5, 5, 1, 'Aset Lain-lain'),
(2, 1, 1, 1, 'Utang Taspen'),
(2, 1, 1, 2, 'Utang Askes'),
(2, 1, 1, 3, 'Utang PPh Pusat'),
(2, 1, 1, 4, 'Utang PPN Pusat'),
(2, 1, 1, 5, 'Utang Taperum'),
(2, 1, 1, 6, 'Utang Lainnya'),
(2, 1, 1, 7, 'Utang IWP'),
(2, 1, 2, 1, 'Utang Bunga kepada Pemerintah Pusat'),
(2, 1, 2, 2, 'Utang Bunga kepada Daerah Otonom Lainnya'),
(2, 1, 2, 3, 'Utang Bunga kepada BUMN/BUMD'),
(2, 1, 2, 4, 'Utang Bunga kepada Bank/Lembaga Keuangan'),
(2, 1, 2, 5, 'Utang Bunga Dalam Negeri Lainnya'),
(2, 1, 2, 6, 'Utang Bunga Luar Negeri'),
(2, 1, 3, 1, 'Utang Pemotongan Pajak Penghasilan Pasal 21'),
(2, 1, 3, 2, 'Utang Pemotongan Pajak Penghasilan Pasal 22'),
(2, 1, 3, 3, 'Utang Pemungutan Pajak Pertambahan Nilai'),
(2, 1, 4, 1, 'Utang Bank'),
(2, 1, 4, 2, 'Utang Obligasi'),
(2, 1, 4, 3, 'Utang Pemerintah Pusat'),
(2, 1, 4, 4, 'Utang Pemerintah Provinsi'),
(2, 1, 4, 5, 'Utang Pemerintah Kabupaten/Kota'),
(2, 1, 5, 1, 'Setoran Kelebihan Pembayaran kepada Pihak III'),
(2, 1, 5, 2, 'Uang Muka Penjualan Produk Pemda dari Pihak III'),
(2, 1, 5, 3, 'Uang Muka Lelang Penjualan Aset Daerah'),
(2, 1, 6, 1, 'Utang Jangka Pendek Lainnya'),
(2, 1, 8, 1, 'R/K Pusat'),
(2, 2, 1, 1, 'Utang Dalam Negeri-Sektor Perbankan'),
(2, 2, 1, 2, 'Utang Dalam Negeri-Obligasi'),
(2, 2, 1, 3, 'Utang Pemerintah Pusat'),
(2, 2, 1, 4, 'Utang Pemerintah Provinsi'),
(2, 2, 1, 5, 'Utang Pemerintah Kabupaten/Kota'),
(2, 2, 2, 1, 'Utang Luar Negeri-Sektor Perbankan'),
(3, 1, 1, 1, 'Sisa Lebih Pembiayaan Anggaran (SILPA)'),
(3, 1, 2, 1, 'Cadangan untuk Piutang'),
(3, 1, 3, 1, 'Cadangan untuk Persediaan'),
(3, 1, 4, 1, 'Dana yang harus disediakan untuk pembayaran Utang Jangka Pendek'),
(3, 1, 5, 1, 'Pendapatan yang Ditangguhkan'),
(3, 2, 1, 1, 'Diinvestasikan dalam Investasi Jangka Panjang'),
(3, 2, 2, 1, 'Diinvestasikan dalam Aset Tetap'),
(3, 2, 3, 1, 'Diinvestasikan dalam Aset Lainnya (Tidak termasuk Dana Cadangan)'),
(3, 2, 4, 1, 'Dana yang harus disediakan untuk pembayaran Utang Jangka Panjang'),
(3, 3, 1, 1, 'Diinvestasikan dalam Dana Cadangan'),
(4, 1, 1, 1, 'Pajak Hotel'),
(4, 1, 1, 2, 'Pajak Restoran'),
(4, 1, 1, 3, 'Pajak Hiburan'),
(4, 1, 1, 4, 'Pajak Reklame'),
(4, 1, 1, 5, 'Pajak Penerangan Jalan'),
(4, 1, 1, 6, 'Pajak Mineral Bukan Logam dan Batuan'),
(4, 1, 1, 7, 'Pajak Parkir'),
(4, 1, 1, 8, 'Pajak Air Tanah'),
(4, 1, 1, 9, 'Pajak Sarang Burung Walet'),
(4, 1, 1, 10, 'Pajak Lingkungan 4)'),
(4, 1, 1, 11, 'Pajak Bumi dan Bangunan Perdesaan dan Perkotaan'),
(4, 1, 1, 12, 'Bea Perolehan Hak Atas Tanah dan Bangunan'),
(4, 1, 2, 1, 'Retribusi Jasa Umum'),
(4, 1, 2, 2, 'Retribusi Jasa Usaha'),
(4, 1, 2, 3, 'Retribusi Perizinan Tertentu'),
(4, 1, 3, 1, 'Bagian Laba atas Penyertaan Modal pada Perusahaan Milik Daerah/BUMD'),
(4, 1, 3, 2, 'Bagian Laba atas Penyertaan Modal pada Perusahaan Milik Negara/BUMN'),
(4, 1, 3, 3, 'Bagian Laba atas Penyertaan Modal pada Perusahaan Patungan/Milik Swasta'),
(4, 1, 4, 1, 'Hasil Penjualan Aset Daerah Yang Tidak Dipisahkan'),
(4, 1, 4, 2, 'Jasa Giro'),
(4, 1, 4, 3, 'Pendapatan Bunga Deposito'),
(4, 1, 4, 4, 'Tuntutan Ganti Kerugian Daerah'),
(4, 1, 4, 5, 'Komisi, Potongan dan Selisih Nilai Tukar Rupiah'),
(4, 1, 4, 6, 'Pendapatan Denda Atas Keterlambatan Pelaksanaan Pekerjaan'),
(4, 1, 4, 7, 'Pendapatan Denda Pajak'),
(4, 1, 4, 8, 'Pendapatan Denda Retribusi'),
(4, 1, 4, 9, 'Pendapatan Hasil Eksekusi Atas Jaminan'),
(4, 1, 4, 10, 'Pendapatan Dari Pengembalian'),
(4, 1, 4, 11, 'Fasilitas Sosial dan Fasilitas Umum'),
(4, 1, 4, 12, 'Pendapatan dari Penyelenggaraan Pendidikan dan Pelatihan'),
(4, 1, 4, 13, 'Pendapatan dari Angsuran/Cicilan Penjualan'),
(4, 1, 4, 14, 'Hasil dari Pemanfaatan Kekayaan Daerah'),
(4, 1, 4, 15, 'Pendapatan Zakat'),
(4, 1, 4, 16, 'Pendapatan BLUD'),
(4, 1, 4, 17, 'Hasil Pengelolaan Dana Bergulir'),
(4, 1, 4, 18, 'Pendapatan Dana JKN'),
(4, 1, 4, 19, 'Lain-lain PAD yang Sah Lainnya'),
(4, 2, 1, 1, 'Bagi Hasil Pajak'),
(4, 2, 1, 2, 'Bagi Hasil Bukan Pajak/Sumber Daya Alam'),
(4, 2, 2, 1, 'Dana Alokasi Umum'),
(4, 2, 3, 1, 'Dana Alokasi Khusus'),
(4, 3, 1, 1, 'Pendapatan Hibah Dari Pemerintah'),
(4, 3, 1, 2, 'Pendapatan Hibah Dari Pemerintah Daerah Lainnya'),
(4, 3, 1, 3, 'Pendapatan Hibah Dari Badan/Lembaga/Organisasi Swasta Dalam Negeri'),
(4, 3, 1, 4, 'Pendapatan Hibah Dari Kelompok Masyarakat/Perorangan'),
(4, 3, 1, 5, 'Pendapatan Hibah Dari Luar Negeri'),
(4, 3, 2, 1, 'Penanggulangan Korban/Kerusakan Akibat Bencana Alam'),
(4, 3, 3, 1, 'Dana Bagi Hasil Pajak dari Provinsi 2)'),
(4, 3, 3, 2, 'Dana Bagi Hasil Pajak dari Provinsi 3)'),
(4, 3, 3, 3, 'Dana Bagi Hasil Pajak dari Kabupaten 3)'),
(4, 3, 3, 4, 'Dana Bagi Hasil Pajak dari Kota 3)'),
(4, 3, 4, 1, 'Dana Penyesuaian'),
(4, 3, 4, 2, 'Dana Otonomi Khusus'),
(4, 3, 5, 1, 'Bantuan Keuangan Dari Provinsi'),
(4, 3, 5, 2, 'Bantuan Keuangan Dari Kabupaten'),
(4, 3, 5, 3, 'Bantuan Keuangan Dari Kota'),
(5, 1, 1, 1, 'Gaji dan Tunjangan'),
(5, 1, 1, 2, 'Tambahan Penghasilan PNS'),
(5, 1, 1, 3, 'Belanja Penerimaan lainnya Pimpinan dan anggota DPRD serta KDH/WKDH'),
(5, 1, 1, 4, 'Biaya Pemungutan Pajak'),
(5, 1, 1, 5, 'Insentif Pemungutan Pajak Daerah'),
(5, 1, 1, 6, 'Insentif Pemungutan Retribusi Daerah'),
(5, 1, 2, 1, 'Bunga Utang Pinjaman'),
(5, 1, 2, 2, 'Bunga Utang Obligasi'),
(5, 1, 3, 1, 'Belanja Subsidi kepada Perusahaan/Lembaga'),
(5, 1, 4, 1, 'Belanja Hibah kepada Pemerintah Pusat'),
(5, 1, 4, 2, 'Belanja Hibah kepada Pemerintah Daerah lainnya3)'),
(5, 1, 4, 3, 'Belanja Hibah kepada Pemerintahan Desa'),
(5, 1, 4, 4, 'Belanja Hibah kepada Perusahaan Daerah/ BUMD/ BUMN 4)'),
(5, 1, 4, 5, 'Belanja Hibah kepada Badan/Lembaga/Organisasi'),
(5, 1, 4, 6, 'Belanja Hibah kepada Kelompok/Anggota Masyarakat'),
(5, 1, 4, 7, 'Belanja Hibah Dana BOS 6)'),
(5, 1, 5, 1, 'Belanja Bantuan Sosial Kepada Organisasi Sosial Kemasyarakatan'),
(5, 1, 5, 2, 'Belanja Bantuan Sosial kepada Kelompok Masyarakat'),
(5, 1, 5, 3, 'Belanja Bantuan Sosial kepada Anggota Masyarakat'),
(5, 1, 6, 1, 'Belanja Bagi Hasil Pajak Daerah Kepada Provinsi'),
(5, 1, 6, 2, 'Belanja Bagi Hasil Pajak Daerah Kepada Kabupaten/Kota'),
(5, 1, 6, 3, 'Belanja Bagi Hasil Pajak Daerah Kepada Pemerintahan Desa'),
(5, 1, 6, 4, 'Belanja Bagi Hasil Retribusi Daerah Kepada Kabupaten/Kota'),
(5, 1, 6, 5, 'Belanja Bagi Hasil Retribusi Daerah Kepada Pemerintahan Desa'),
(5, 1, 7, 1, 'Belanja Bantuan Keuangan kepada Provinsi'),
(5, 1, 7, 2, 'Belanja Bantuan Keuangan kepada kabupaten/Kota'),
(5, 1, 7, 3, 'Belanja Bantuan Keuangan kepada Desa'),
(5, 1, 7, 4, 'Belanja Bantuan Keuangan kepada Pemerintah Daerah/Pemerintahan Desalainnya'),
(5, 1, 7, 5, 'Belanja Bantuan kepada Partai Politik'),
(5, 1, 8, 1, 'Belanja Tidak Terduga'),
(5, 2, 1, 1, 'Honorarium PNS'),
(5, 2, 1, 2, 'Honorarium Non PNS'),
(5, 2, 1, 3, 'Uang Lembur'),
(5, 2, 1, 4, 'Honorarium Pengelolaan Dana BOS 6)'),
(5, 2, 1, 5, 'Uang untuk diberikan kepada pihak ketiga/masyarakat'),
(5, 2, 2, 1, 'Belanja Bahan Pakai Habis'),
(5, 2, 2, 2, 'Belanja Bahan/Material'),
(5, 2, 2, 3, 'Belanja Jasa Kantor'),
(5, 2, 2, 4, 'Belanja Premi Asuransi'),
(5, 2, 2, 5, 'Belanja Perawatan Kendaraan Bermotor'),
(5, 2, 2, 6, 'Belanja Cetak dan Penggandaan'),
(5, 2, 2, 7, 'Belanja Sewa Rumah/Gedung/Gudang/Parkir'),
(5, 2, 2, 8, 'Belanja Sewa Sarana Mobilitas'),
(5, 2, 2, 9, 'Belanja Sewa Alat Berat'),
(5, 2, 2, 10, 'Belanja Sewa Perlengkapan dan Peralatan Kantor'),
(5, 2, 2, 11, 'Belanja Makanan dan Minuman'),
(5, 2, 2, 12, 'Belanja Pakaian Dinas dan Atributnya'),
(5, 2, 2, 13, 'Belanja Pakaian Kerja'),
(5, 2, 2, 14, 'Belanja Pakaian khusus dan hari-hari tertentu'),
(5, 2, 2, 15, 'Belanja Perjalanan Dinas'),
(5, 2, 2, 16, 'Belanja Beasiswa Pendidikan PNS'),
(5, 2, 2, 17, 'Belanja kursus, pelatihan, sosialisasi dan bimbingan teknis PNS'),
(5, 2, 2, 18, 'Belanja Perjalanan Pindah Tugas'),
(5, 2, 2, 19, 'Belanja Pemulangan Pegawai'),
(5, 2, 2, 20, 'Belanja Pemeliharaan'),
(5, 2, 2, 21, 'Belanja Jasa Konsultansi'),
(5, 2, 2, 22, 'Belanja Barang Dana BOS'),
(5, 2, 2, 23, 'Belanja Barang Yang Akan Diserahkan Kepada Masyarakat/Pihak Ketiga'),
(5, 2, 2, 24, 'Belanja Barang Yang Akan Dijual Kepada Masyarakat/Pihak Ketiga'),
(5, 2, 3, 1, 'Belanja Modal Tanah - Pengadaan Tanah Perkampungan'),
(5, 2, 3, 2, 'Belanja Modal Tanah - Pengadaan Tanah Pertanian'),
(5, 2, 3, 3, 'Belanja Modal Tanah - Pengadaan Tanah Perkebunan'),
(5, 2, 3, 4, 'Belanja Modal Tanah - Pengadaan Kebun Campuran'),
(5, 2, 3, 5, 'Belanja Modal Tanah - Pengadaan Hutan'),
(5, 2, 3, 6, 'Belanja Modal Tanah - Pengadaan Kolam Ikan'),
(5, 2, 3, 7, 'Belanja Modal Tanah - Pengadaan Tanah Danau/Rawa'),
(5, 2, 3, 8, 'Belanja Modal Tanah - Pengadaan Tanah Tandus/Rusak'),
(5, 2, 3, 9, 'Belanja Modal Tanah - Pengadaan Tanah Alang-alang dan Padang Rumput'),
(5, 2, 3, 10, 'Belanja Modal Tanah - Pengadaan Tanah Pengguna Lain'),
(5, 2, 3, 11, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Bangunan Gedung'),
(5, 2, 3, 12, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Pertambangan'),
(5, 2, 3, 13, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Bangunan Bukan Gedung'),
(5, 2, 3, 14, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat-Alat Besar Darat'),
(5, 2, 3, 15, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat-Alat Besar Apung'),
(5, 2, 3, 16, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat-alat Bantu'),
(5, 2, 3, 17, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Angkutan Darat Bermotor'),
(5, 2, 3, 18, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Angkutan Darat Tak Bermotor'),
(5, 2, 3, 19, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Angkut Apung Bermotor'),
(5, 2, 3, 20, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Angkut Apung Tak Bermotor'),
(5, 2, 3, 21, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Angkut Bermotor Udara'),
(5, 2, 3, 22, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Bengkel Bermesin'),
(5, 2, 3, 23, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Bengkel Tak Bermesin'),
(5, 2, 3, 24, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Ukur'),
(5, 2, 3, 25, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Pengolahan'),
(5, 2, 3, 26, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Pemeliharaan Tanaman/Alat Penyimpan'),
(5, 2, 3, 27, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kantor'),
(5, 2, 3, 28, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Rumah Tangga'),
(5, 2, 3, 29, 'Belanja Modal Peralatan dan Mesin - Pengadaan Komputer'),
(5, 2, 3, 30, 'Belanja Modal Peralatan dan Mesin - Pengadaan Meja Dan Kursi Kerja/Rapat Pejabat'),
(5, 2, 3, 31, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Studio'),
(5, 2, 3, 32, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Komunikasi'),
(5, 2, 3, 33, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Pemancar'),
(5, 2, 3, 34, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran'),
(5, 2, 3, 35, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kesehatan'),
(5, 2, 3, 36, 'Belanja Modal Peralatan dan Mesin - Pengadaan Unit-Unit Laboratorium'),
(5, 2, 3, 37, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Peraga/Praktek Sekolah'),
(5, 2, 3, 38, 'Belanja Modal Peralatan dan Mesin - Pengadaan Unit Alat Laboratorium Kimia Nuklir'),
(5, 2, 3, 39, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Fisika Nuklir / Elektronika'),
(5, 2, 3, 40, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Proteksi Radiasi / Proteksi Lingkungan'),
(5, 2, 3, 41, 'Belanja Modal Peralatan dan Mesin - Pengadaan Radiation Aplication and Non Destructive Testing Lab'),
(5, 2, 3, 42, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Lingkungan Hidup'),
(5, 2, 3, 43, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Laboratorium Hidrodinamika'),
(5, 2, 3, 44, 'Belanja Modal Peralatan dan Mesin - Pengadaan Senjata Api'),
(5, 2, 3, 45, 'Belanja Modal Peralatan dan Mesin - Pengadaan Persenjataan Non Senjata Api'),
(5, 2, 3, 46, 'Belanja Modal Peralatan dan Mesin - Pengadaan Amunisi'),
(5, 2, 3, 47, 'Belanja Modal Peralatan dan Mesin -Pengadaan Senjata Sinar'),
(5, 2, 3, 48, 'Belanja Modal Peralatan dan Mesin -Pengadaan Alat Keamanan dan Perlindungan'),
(5, 2, 3, 49, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Tempat Kerja'),
(5, 2, 3, 50, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Tempat Tinggal'),
(5, 2, 3, 51, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Menara'),
(5, 2, 3, 52, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Bersejarah'),
(5, 2, 3, 53, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Tugu Peringatan'),
(5, 2, 3, 54, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Candi'),
(5, 2, 3, 55, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Monumen/Bangunan Bersejarah lainnya'),
(5, 2, 3, 56, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Tugu Titik Kontrol/Pasti'),
(5, 2, 3, 57, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Rambu-Rambu'),
(5, 2, 3, 58, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Rambu-Rambu Lalu Lintas Udara'),
(5, 2, 3, 59, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jalan'),
(5, 2, 3, 60, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jembatan'),
(5, 2, 3, 61, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Air Irigasi'),
(5, 2, 3, 62, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Air Pasang Surut'),
(5, 2, 3, 63, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Air Rawa'),
(5, 2, 3, 64, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengaman Sungai dan Penanggulangan Be'),
(5, 2, 3, 65, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengembangan Sumber Air dan Air Tanah'),
(5, 2, 3, 66, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Air Bersih/Baku'),
(5, 2, 3, 67, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Air Kotor'),
(5, 2, 3, 68, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Air'),
(5, 2, 3, 69, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Air Minum/Air Bersih'),
(5, 2, 3, 70, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Air Kotor'),
(5, 2, 3, 71, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Pengolahan Sampah'),
(5, 2, 3, 72, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Pengolahan Bahan Bangunan'),
(5, 2, 3, 73, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Pembangkit Listrik'),
(5, 2, 3, 74, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Gardu Listrik'),
(5, 2, 3, 75, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Pertahanan'),
(5, 2, 3, 76, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Gas'),
(5, 2, 3, 77, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Pengaman'),
(5, 2, 3, 78, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Air Minum'),
(5, 2, 3, 79, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Listrik'),
(5, 2, 3, 80, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Telepon'),
(5, 2, 3, 81, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Gas'),
(5, 2, 3, 82, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Buku'),
(5, 2, 3, 83, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Terbitan'),
(5, 2, 3, 84, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang-Barang Perpustakaan'),
(5, 2, 3, 85, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang Bercorak Kebudayaan'),
(5, 2, 3, 86, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Alat Olah Raga Lainnya'),
(5, 2, 3, 87, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Hewan'),
(5, 2, 3, 88, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Tanaman'),
(5, 2, 3, 89, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Aset Tetap Renovasi'),
(6, 1, 1, 1, 'Pelampauan penerimaan PAD'),
(6, 1, 1, 2, 'Pelampauan penerimaan Dana Perimbangan'),
(6, 1, 1, 3, 'Pelampauan penerimaan Lain-lain Pendapatan Daerah Yang Sah'),
(6, 1, 1, 4, 'Sisa Penghematan Belanja atau akibat lainnya'),
(6, 1, 1, 5, 'Kewajiban kepada pihak ketiga sampai dengan akhir tahun belum terselesaikan'),
(6, 1, 1, 6, 'Kegiatan lanjutan'),
(6, 1, 2, 1, 'Pencairan Dana Cadangan'),
(6, 1, 3, 1, 'Hasil penjualan perusahaan milik daerah/BUMD'),
(6, 1, 3, 2, 'Hasil penjualan aset milik pemerintah daerah yang dikerjasamakan dengan pihakketiga'),
(6, 1, 4, 1, 'Penerimaan Pinjaman Daerah dari Pemerintah'),
(6, 1, 4, 2, 'Penerimaan Pinjaman Daerah dari pemerintah daerah lain'),
(6, 1, 4, 3, 'Penerimaan Pinjaman Daerah dari lembaga keuangan bank'),
(6, 1, 4, 4, 'Penerimaan Pinjaman Daerah dari lembaga keuangan bukan bank'),
(6, 1, 4, 5, 'Penerimaan hasil penerbitan Obligasi daerah'),
(6, 1, 5, 1, 'Penerimaan Kembali Penerimaan Pinjaman'),
(6, 1, 6, 1, 'Penerimaan piutang daerah dari pendapatan daerah'),
(6, 1, 6, 2, 'Penerimaan piutang daerah dari pemerintah'),
(6, 1, 6, 3, 'Penerimaan piutang daerah dari pemerintah daerah lain'),
(6, 1, 6, 4, 'Penerimaan piutang daerah dari lembaga keuangan bank'),
(6, 1, 6, 5, 'Penerimaan piutang daerah dari lembaga keuangan bukan bank'),
(6, 1, 7, 1, 'Penerimaan kembali investasi dana bergulir'),
(6, 2, 1, 1, 'Pembentukan Dana Cadangan'),
(6, 2, 2, 1, 'Badan usaha milik pemerintah (BUMN)'),
(6, 2, 2, 2, 'Badan usaha milik daerah (BUMD)'),
(6, 2, 2, 3, 'Badan usaha milik swasta'),
(6, 2, 2, 4, 'Dana bergulir'),
(6, 2, 3, 1, 'Pembayaran Pokok Utang yang Jatuh Tempo kepada Pemerintah'),
(6, 2, 3, 2, 'Pembayaran Pokok Utang yang Jatuh Tempo kepada pemerintah daerah lain'),
(6, 2, 3, 3, 'Pembayaran Pokok Utang yang Jatuh Tempo kepada lembaga keuangan bank'),
(6, 2, 3, 4, 'Pembayaran Pokok Utang yang Jatuh Tempo kepada lembaga keuangan bukanbank'),
(6, 2, 3, 5, 'Pembayaran Pokok Utang sebelum Jatuh Tempo kepada Pemerintah'),
(6, 2, 3, 6, 'Pembayaran Pokok Utang sebelum Jatuh Tempo kepada pemerintah daerah lain'),
(6, 2, 3, 7, 'Pembayaran Pokok Utang sebelum Jatuh Tempo kepada lembaga keuanganbank'),
(6, 2, 3, 8, 'Pembayaran Pokok Utang sebelum Jatuh Tempo kepada lembaga keuanganbukan bank'),
(6, 2, 3, 9, 'Pelunasan obligasi daerah pada saat jatuh tempo'),
(6, 2, 3, 10, 'Pembelian kembali obligasi daerah sebelum jatuh tempo'),
(6, 2, 4, 1, 'Pemberian Pinjaman Daerah kepada Pemerintah'),
(6, 2, 4, 2, 'Pemberian Pinjaman Daerah kepada pemerintah daerah lain'),
(6, 3, 1, 1, 'Sisa Lebih Pembiayaan Tahun Berkenaan'),
(6, 4, 1, 1, 'Sisa Lebih/Kurang Pembiayaan Tahun Berkenaan'),
(7, 1, 1, 1, 'Penerimaan PFK - IWP'),
(7, 1, 1, 2, 'Penerimaan PFK - Taspen'),
(7, 1, 1, 3, 'Penerimaan PFK - Askes'),
(7, 1, 1, 4, 'Penerimaan PFK - PPh Pusat'),
(7, 1, 1, 5, 'Penerimaan PFK - PPn Pusat'),
(7, 1, 1, 6, 'Penerimaan PFK - Taperum'),
(7, 1, 1, 7, 'Penerimaan PFK - Lainnya'),
(7, 2, 1, 1, 'Pengeluaran PFK - IWP'),
(7, 2, 1, 2, 'Pengeluaran PFK - Taspen'),
(7, 2, 1, 3, 'Pengeluaran PFK - Askes'),
(7, 2, 1, 4, 'Pengeluaran PFK - PPh Pusat'),
(7, 2, 1, 5, 'Pengeluaran PFK - PPn Pusat'),
(7, 2, 1, 6, 'Pengeluaran PFK - Taperum'),
(7, 2, 1, 7, 'Pengeluaran PFK - Lainnya');

-- --------------------------------------------------------

--
-- Table structure for table `ref_rek_5`
--

DROP TABLE IF EXISTS `ref_rek_5`;
CREATE TABLE IF NOT EXISTS `ref_rek_5` (
  `kd_rek_1` int(11) NOT NULL,
  `kd_rek_2` int(11) NOT NULL,
  `kd_rek_3` int(11) NOT NULL,
  `kd_rek_4` int(11) NOT NULL,
  `kd_rek_5` int(11) NOT NULL,
  `nama_kd_rek_5` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `peraturan` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_rekening` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_rekening`) USING BTREE,
  UNIQUE KEY `kd_rek_1` (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`,`kd_rek_4`,`kd_rek_5`) USING BTREE,
  KEY `id_rekening` (`id_rekening`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1581 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_rek_5`
--

INSERT INTO `ref_rek_5` (`kd_rek_1`, `kd_rek_2`, `kd_rek_3`, `kd_rek_4`, `kd_rek_5`, `nama_kd_rek_5`, `peraturan`, `id_rekening`) VALUES
(1, 1, 1, 1, 1, 'Kas di Kas Daerah', '', 1),
(1, 1, 1, 2, 1, 'Kas di Bendahara Penerimaan', '', 2),
(1, 1, 1, 3, 1, 'Kas di Bendahara Pengeluaran - Bank', '', 3),
(1, 1, 1, 3, 2, 'Kas di Bendahara Pengeluaran - Tunai', '', 4),
(1, 1, 2, 1, 1, 'Investasi dalam Saham …..', '', 5),
(1, 1, 2, 1, 2, 'Dst...................', '', 6),
(1, 1, 2, 2, 1, 'Investasi dalam Obligasi …..', '', 7),
(1, 1, 2, 2, 2, 'Dst...................', '', 8),
(1, 1, 3, 1, 1, 'Piutang Pajak …..', '', 9),
(1, 1, 3, 1, 2, 'Dst...................', '', 10),
(1, 1, 3, 2, 1, 'Piutang Retribusi …..', '', 11),
(1, 1, 3, 2, 2, 'Dst...................', '', 12),
(1, 1, 3, 3, 1, 'Piutang Dana Bagi Hasil Pajak', '', 13),
(1, 1, 3, 3, 2, 'Piutang Dana Bagi Hasil Bukan Pajak …..', '', 14),
(1, 1, 3, 3, 3, 'Dst...................', '', 15),
(1, 1, 3, 4, 1, 'Piutang Dana Alokasi Umum …..', '', 16),
(1, 1, 3, 5, 1, 'Piutang Dana Alokasi Khusus …..', '', 17),
(1, 1, 3, 5, 2, 'Dst...................', '', 18),
(1, 1, 4, 1, 1, 'Piutang Bagian Lancar Penjualan Angsuran Cicilan Kendaraan Bermotor', '', 19),
(1, 1, 4, 1, 2, 'Piutang Bagian Lancar Penjualan Angsuran Cicilan Rumah', '', 20),
(1, 1, 4, 1, 3, 'Dst...................', '', 21),
(1, 1, 4, 2, 1, 'Piutang Ganti Rugi Atas Kekayaan Daerah …..', '', 22),
(1, 1, 4, 2, 2, 'Dst...................', '', 23),
(1, 1, 4, 3, 1, 'Piutang Hasi! Penjualan Barang Milik Daerah …..', '', 24),
(1, 1, 4, 3, 2, 'Dst...................', '', 25),
(1, 1, 4, 4, 1, 'Piutang Dividen…..', '', 26),
(1, 1, 4, 4, 2, 'Dst...................', '', 27),
(1, 1, 4, 5, 1, 'Piutang Bali Hasif Laba Usaha Perusahaan Daerah …..', '', 28),
(1, 1, 4, 5, 2, 'Dst...................', '', 29),
(1, 1, 4, 6, 1, 'Piutang Fasilitas Sosial dan Fasilitas Umum …..', '', 30),
(1, 1, 4, 6, 2, 'Dst...................', '', 31),
(1, 1, 4, 7, 1, 'Panjar Kegiatan', '', 32),
(1, 1, 4, 7, 2, 'Uang Muka Operasional', '', 33),
(1, 1, 5, 1, 1, 'Persediaan Alat Tulis Kantor …..', '', 34),
(1, 1, 5, 1, 2, 'Dst...................', '', 35),
(1, 1, 5, 2, 1, 'Persediaan Alat Listrik …..', '', 36),
(1, 1, 5, 2, 2, 'Dst...................', '', 37),
(1, 1, 5, 3, 1, 'Persediaan Bahan Baku Bangunan', '', 38),
(1, 1, 5, 3, 2, 'Persediaan Suku Cadang Sarana Mobilitas', '', 39),
(1, 1, 5, 3, 3, 'Persediaan Bahan/Bibit Tanaman', '', 40),
(1, 1, 5, 3, 4, 'Persediaan Bibit Ternak', '', 41),
(1, 1, 5, 3, 5, 'Persediaan Obat-obatan', '', 42),
(1, 1, 5, 3, 6, 'Persediaan Bahan Kimia', '', 43),
(1, 1, 5, 3, 7, 'Dst...................', '', 44),
(1, 1, 5, 4, 1, 'Persediaan Perangko', '', 45),
(1, 1, 5, 4, 2, 'Persediaan Materai', '', 46),
(1, 1, 5, 4, 3, 'Persediaan Kertas Segel', '', 47),
(1, 1, 5, 4, 4, 'Dst...................', '', 48),
(1, 1, 5, 5, 1, 'Persediaan Bahan Bakar Minyak', '', 49),
(1, 1, 5, 5, 2, 'Dst...................', '', 50),
(1, 1, 5, 6, 1, 'Persediaan Bahan Makanan Pokok …..', '', 51),
(1, 1, 5, 6, 2, 'Dst...................', '', 52),
(1, 1, 8, 1, 1, 'R/K SKPD', '', 53),
(1, 2, 1, 1, 1, 'Pinjaman kepada Perusahaan Negara …..', '', 54),
(1, 2, 1, 1, 2, 'Dst...................', '', 55),
(1, 2, 1, 2, 1, 'Pinjaman kepada Perusahaan Daerah …..', '', 56),
(1, 2, 1, 2, 2, 'Dst................…', '', 57),
(1, 2, 1, 3, 1, 'Pinjaman kepada Pemerintah Daerah Lainnya …..', '', 58),
(1, 2, 1, 3, 2, 'Dst...................', '', 59),
(1, 2, 1, 4, 1, 'Investasi dalam Surat Utang Negara …..', '', 60),
(1, 2, 1, 4, 2, 'Dst...................', '', 61),
(1, 2, 1, 5, 1, 'Investasi Non Permanen Lainnya ….', '', 62),
(1, 2, 1, 5, 2, 'Dst...................', '', 63),
(1, 2, 2, 1, 1, 'Penyertaan Modal Pemerintah Daerah …..', '', 64),
(1, 2, 2, 1, 2, 'Dst...................', '', 65),
(1, 2, 2, 2, 1, 'Penyertaan Modal dalam Proyek Pembangunan …..', '', 66),
(1, 2, 2, 2, 2, 'Dst...................', '', 67),
(1, 2, 2, 3, 1, 'Penyertaan Modal Perusahaan Patungan…..', '', 68),
(1, 2, 2, 3, 2, 'Dst...................', '', 69),
(1, 2, 2, 4, 1, 'Investasi Permanen Lainnya', '', 70),
(1, 2, 2, 4, 2, 'Dst...................', '', 71),
(1, 3, 1, 1, 1, 'Tanah Kantor …..', '', 72),
(1, 3, 1, 1, 2, 'Dst...................', '', 73),
(1, 3, 1, 2, 1, 'Tanah Sarana Kesehatan Rumah Sakit …..', '', 74),
(1, 3, 1, 2, 2, 'Dst...................', '', 75),
(1, 3, 1, 3, 1, 'Tanah Sarana Kesehatan Puskesmas …..', '', 76),
(1, 3, 1, 3, 2, 'Dst...................', '', 77),
(1, 3, 1, 4, 1, 'Tanah Sarana Kesehatan Poliklinik …..', '', 78),
(1, 3, 1, 4, 2, 'Dst...................', '', 79),
(1, 3, 1, 5, 1, 'Tanah Sarana Pendidikan Taman Kanak-Kanak …..', '', 80),
(1, 3, 1, 5, 2, 'Dst...................', '', 81),
(1, 3, 1, 6, 1, 'Tanah Sarana Pendidikan Sekolah Dasar …..', '', 82),
(1, 3, 1, 6, 2, 'Dst...................', '', 83),
(1, 3, 1, 7, 1, 'Tanah Sarana Pendidikan Menengah Umum dan Kejuruan …..', '', 84),
(1, 3, 1, 7, 2, 'Dst...................', '', 85),
(1, 3, 1, 8, 1, 'Tanah Sarana Pendidikan Menengah Lanjutan dan Kejuruan …..', '', 86),
(1, 3, 1, 8, 2, 'Dst...................', '', 87),
(1, 3, 1, 9, 1, 'Tanah Sarana Pendidikan Luar Biasa', '', 88),
(1, 3, 1, 9, 2, 'Tanah Sarana Pendidikan Luar Khusus …..', '', 89),
(1, 3, 1, 9, 3, 'Dst...................', '', 90),
(1, 3, 1, 10, 1, 'Tanah Sarana Pendidikan Pelatihan', '', 91),
(1, 3, 1, 10, 2, 'Tanah Sarana Pendidikan Kursus …..', '', 92),
(1, 3, 1, 10, 3, 'Dst...................', '', 93),
(1, 3, 1, 11, 1, 'Tanah Sarana Sosial Panti Asuhan …..', '', 94),
(1, 3, 1, 11, 2, 'Dst...................', '', 95),
(1, 3, 1, 12, 1, 'Tanah Sarana Sosial Panti Jompo …..', '', 96),
(1, 3, 1, 12, 2, 'Dst...................', '', 97),
(1, 3, 1, 13, 1, 'Tanah Sarana Urnum Terminal …..', '', 98),
(1, 3, 1, 13, 2, 'Dst...................', '', 99),
(1, 3, 1, 14, 1, 'Tanah Sarana Umum Dermaga …..', '', 100),
(1, 3, 1, 14, 2, 'Dst...................', '', 101),
(1, 3, 1, 15, 1, 'Tanah Sarana Umum Lapangan Terbang Perintis', '', 102),
(1, 3, 1, 15, 2, 'Dst...................', '', 103),
(1, 3, 1, 16, 1, 'Tanah Sarana Umum Rumah Potong Hewan', '', 104),
(1, 3, 1, 16, 2, 'Dst...................', '', 105),
(1, 3, 1, 17, 1, 'Tanah Sarana Umum Tempat Pelelangan Ikan…..', '', 106),
(1, 3, 1, 17, 2, 'Dst...................', '', 107),
(1, 3, 1, 18, 1, 'Tanah Sarana Umum Pasar …..', '', 108),
(1, 3, 1, 18, 2, 'Dst...................', '', 109),
(1, 3, 1, 19, 1, 'Tanah Sarana Umum Tempat Pembuangan Akhir Sampah …..', '', 110),
(1, 3, 1, 19, 2, 'Dst...................', '', 111),
(1, 3, 1, 20, 1, 'Tanah Sarana Umum Taman …..', '', 112),
(1, 3, 1, 20, 2, 'Dst...................', '', 113),
(1, 3, 1, 21, 1, 'Tanah Sarana Umum Pusat Hiburan Rakyat …..', '', 114),
(1, 3, 1, 21, 2, 'Dst...................', '', 115),
(1, 3, 1, 22, 1, 'Tanah Sarana Umum Ibadah …..', '', 116),
(1, 3, 1, 22, 2, 'Dst...................', '', 117),
(1, 3, 1, 23, 1, 'Tanah Sarana Stadion Olahraga…..', '', 118),
(1, 3, 1, 23, 2, 'Dst...................', '', 119),
(1, 3, 1, 24, 1, 'Tanah Perumahan …..', '', 120),
(1, 3, 1, 24, 2, 'Dst...................', '', 121),
(1, 3, 1, 25, 1, 'Tanah Pertanian …..', '', 122),
(1, 3, 1, 25, 2, 'Dst...................', '', 123),
(1, 3, 1, 26, 1, 'Tanah Perkebunan …..', '', 124),
(1, 3, 1, 26, 2, 'Dst...................', '', 125),
(1, 3, 1, 27, 1, 'Tanah Perikanan …..', '', 126),
(1, 3, 1, 27, 2, 'Dst...................', '', 127),
(1, 3, 1, 28, 1, 'Tanah Petemakan …..', '', 128),
(1, 3, 1, 28, 2, 'Dst...................', '', 129),
(1, 3, 1, 29, 1, 'Tanah Perkampungan …..', '', 130),
(1, 3, 1, 29, 2, 'Dst...................', '', 131),
(1, 3, 1, 30, 1, 'Tanah Pergudangan/Tempat Penimbunan Material Bahan Baku …..', '', 132),
(1, 3, 1, 30, 2, 'Dst...................', '', 133),
(1, 3, 2, 1, 1, 'Traktor', '', 134),
(1, 3, 2, 1, 2, 'Buldozer', '', 135),
(1, 3, 2, 1, 3, 'Stoom Wals', '', 136),
(1, 3, 2, 1, 4, 'Eskavator', '', 137),
(1, 3, 2, 1, 5, 'Dump truk', '', 138),
(1, 3, 2, 1, 6, 'Crane', '', 139),
(1, 3, 2, 1, 7, 'Kendaraan penyapu jaian', '', 140),
(1, 3, 2, 1, 8, 'Mesin pengolah semen', '', 141),
(1, 3, 2, 1, 9, 'Mesin pengolah air bersih (reservoir osmosis)', '', 142),
(1, 3, 2, 1, 10, 'Dst...................', '', 143),
(1, 3, 2, 2, 1, 'Alat-alat angkutan darat bermotor sedan', '', 144),
(1, 3, 2, 2, 2, 'Alat-alat angkutan darat bermotor jeep', '', 145),
(1, 3, 2, 2, 3, 'Alat-alat angkutan darat bermotor station wagon', '', 146),
(1, 3, 2, 2, 4, 'Alat-alat angkutan darat bermotor bus', '', 147),
(1, 3, 2, 2, 5, 'Alat-alat angkutan darat bermotor micro bus', '', 148),
(1, 3, 2, 2, 6, 'Alat-alat angkutan darat bermotor truck', '', 149),
(1, 3, 2, 2, 7, 'Alat-alat angkutan darat bermotor tangki (air, minyak, tinja)', '', 150),
(1, 3, 2, 2, 8, 'Alat-alat angkutan darat bermotor boks', '', 151),
(1, 3, 2, 2, 9, 'Alat-alat angkutan dams bermotor pick up', '', 152),
(1, 3, 2, 2, 10, 'Alat-alat angkutan darat bermotor ambulans', '', 153),
(1, 3, 2, 2, 11, 'Alat-alat angkutan darat bermotor pemadam kebakaran', '', 154),
(1, 3, 2, 2, 12, 'Alat-alat angkutan darat bermotor sepeda motor', '', 155),
(1, 3, 2, 2, 13, 'Alat-alat angkutan darat bermotor lift/elevator', '', 156),
(1, 3, 2, 2, 14, 'Alat-alat angkutan darat bermotor tangga berjalan', '', 157),
(1, 3, 2, 2, 15, 'Dst...................', '', 158),
(1, 3, 2, 3, 1, 'Gerobak', '', 159),
(1, 3, 2, 3, 2, 'Pedati/delman/dokar/bendi/cidomo/andong', '', 160),
(1, 3, 2, 3, 3, 'Becak', '', 161),
(1, 3, 2, 3, 4, 'Sepeda', '', 162),
(1, 3, 2, 3, 5, 'Karavan', '', 163),
(1, 3, 2, 3, 6, 'Dst...................', '', 164),
(1, 3, 2, 4, 1, 'Kapal motor', '', 165),
(1, 3, 2, 4, 2, 'Kapal feri', '', 166),
(1, 3, 2, 4, 3, 'Speed boat', '', 167),
(1, 3, 2, 4, 4, 'Motor boat / Motor tempel', '', 168),
(1, 3, 2, 4, 5, 'Hydro foil', '', 169),
(1, 3, 2, 4, 6, 'Jet foil', '', 170),
(1, 3, 2, 4, 7, 'Kapal tug boat', '', 171),
(1, 3, 2, 4, 8, 'Kapal tanker', '', 172),
(1, 3, 2, 4, 9, 'Kapal kargo', '', 173),
(1, 3, 2, 4, 10, 'Dst...................', '', 174),
(1, 3, 2, 5, 1, 'Perahu Nelayan', '', 175),
(1, 3, 2, 5, 2, 'Perahu sampan', '', 176),
(1, 3, 2, 5, 3, 'Perahu Tongkang', '', 177),
(1, 3, 2, 5, 4, 'Perahu karet', '', 178),
(1, 3, 2, 5, 5, 'Perahu rakit', '', 179),
(1, 3, 2, 5, 6, 'Perahu sekoci', '', 180),
(1, 3, 2, 5, 7, 'Dst...................', '', 181),
(1, 3, 2, 6, 1, 'Pesawat kargo', '', 182),
(1, 3, 2, 6, 2, 'Pesawat penumpang', '', 183),
(1, 3, 2, 6, 3, 'Pesawat helikopter', '', 184),
(1, 3, 2, 6, 4, 'Pesawat pemadam kebakaran', '', 185),
(1, 3, 2, 6, 5, 'Pesawat capung', '', 186),
(1, 3, 2, 6, 6, 'Pesawat terbang ampibi', '', 187),
(1, 3, 2, 6, 7, 'Pesawat terbang layang', '', 188),
(1, 3, 2, 6, 8, 'Dst...................', '', 189),
(1, 3, 2, 7, 1, 'Mesin las', '', 190),
(1, 3, 2, 7, 2, 'Mesin bubut', '', 191),
(1, 3, 2, 7, 3, 'Mesin dongkrak', '', 192),
(1, 3, 2, 7, 4, 'Mesin kompresor', '', 193),
(1, 3, 2, 7, 5, 'Dst...................', '', 194),
(1, 3, 2, 8, 1, 'Penggiling hasil pertanian', '', 195),
(1, 3, 2, 8, 2, 'Alat pengering gabah', '', 196),
(1, 3, 2, 8, 3, 'Mesin bajak', '', 197),
(1, 3, 2, 8, 4, 'Alat penetas', '', 198),
(1, 3, 2, 8, 5, 'Dst...................', '', 199),
(1, 3, 2, 9, 1, 'Mesin tik', '', 200),
(1, 3, 2, 9, 2, 'Mesin hitung', '', 201),
(1, 3, 2, 9, 3, 'Mesin stensil', '', 202),
(1, 3, 2, 9, 4, 'Mesin fotocopy', '', 203),
(1, 3, 2, 9, 5, 'Mesin cetak', '', 204),
(1, 3, 2, 9, 6, 'Mesin jilid', '', 205),
(1, 3, 2, 9, 7, 'Mesin potong kertas', '', 206),
(1, 3, 2, 9, 8, 'Mesin penghancur kertas', '', 207),
(1, 3, 2, 9, 9, 'Papan tulis elektronik', '', 208),
(1, 3, 2, 9, 10, 'Papan visual elektronik', '', 209),
(1, 3, 2, 9, 11, 'Tabung pemadam kebakaran', '', 210),
(1, 3, 2, 9, 12, 'Dst...................', '', 211),
(1, 3, 2, 10, 1, 'Meja gambar', '', 212),
(1, 3, 2, 10, 2, 'Almari', '', 213),
(1, 3, 2, 10, 3, 'Brankas', '', 214),
(1, 3, 2, 10, 4, 'Filling kabinet', '', 215),
(1, 3, 2, 10, 5, 'White board', '', 216),
(1, 3, 2, 10, 6, 'Penunjuk waktu', '', 217),
(1, 3, 2, 10, 7, 'Dst...................', '', 218),
(1, 3, 2, 11, 1, 'Komputer mainframe/server', '', 219),
(1, 3, 2, 11, 2, 'Komputer/PC', '', 220),
(1, 3, 2, 11, 3, 'Komputer note book', '', 221),
(1, 3, 2, 11, 4, 'Printer', '', 222),
(1, 3, 2, 11, 5, 'Scaner', '', 223),
(1, 3, 2, 11, 6, 'Monitor/display', '', 224),
(1, 3, 2, 11, 7, 'CPU', '', 225),
(1, 3, 2, 11, 8, 'UPS/Stabilizer', '', 226),
(1, 3, 2, 11, 9, 'Kelengkapan komputer (flash disk, mouse, keyboard, hardisk, speaker)', '', 227),
(1, 3, 2, 11, 10, 'Peralatan jaringan komputer', '', 228),
(1, 3, 2, 11, 11, 'Dst...................', '', 229),
(1, 3, 2, 12, 1, 'Meja kerja', '', 230),
(1, 3, 2, 12, 2, 'Meja rapat', '', 231),
(1, 3, 2, 12, 3, 'Meja makan', '', 232),
(1, 3, 2, 12, 4, 'Kursi kerja', '', 233),
(1, 3, 2, 12, 5, 'Kursi rapat', '', 234),
(1, 3, 2, 12, 6, 'Kursi makan', '', 235),
(1, 3, 2, 12, 7, 'Tempat tidur', '', 236),
(1, 3, 2, 12, 8, 'Sofa', '', 237),
(1, 3, 2, 12, 9, 'Rak buku/tv/kembang', '', 238),
(1, 3, 2, 12, 10, 'Dst...................', '', 239),
(1, 3, 2, 13, 1, 'Tabung gas', '', 240),
(1, 3, 2, 13, 2, 'Kompor gas', '', 241),
(1, 3, 2, 13, 3, 'Lemari makan', '', 242),
(1, 3, 2, 13, 4, 'Dispenser', '', 243),
(1, 3, 2, 13, 5, 'Kulkas', '', 244),
(1, 3, 2, 13, 6, 'Rak piring', '', 245),
(1, 3, 2, 13, 7, 'Piring/gelas/mangkok/cangkir/sendok/garpu/pisau', '', 246),
(1, 3, 2, 13, 8, 'Dst...................', '', 247),
(1, 3, 2, 14, 1, 'Lampu hias', '', 248),
(1, 3, 2, 14, 2, 'Jam dinding/meja', '', 249),
(1, 3, 2, 14, 3, 'Dst...................', '', 250),
(1, 3, 2, 15, 1, 'Kamera', '', 251),
(1, 3, 2, 15, 2, 'Handycam', '', 252),
(1, 3, 2, 15, 3, 'Proyektor', '', 253),
(1, 3, 2, 15, 4, 'Dst...................', '', 254),
(1, 3, 2, 16, 1, 'Telepon', '', 255),
(1, 3, 2, 16, 2, 'Faximili', '', 256),
(1, 3, 2, 16, 3, 'Radio ssb', '', 257),
(1, 3, 2, 16, 4, 'Radio HF/FM (handy talkie)', '', 258),
(1, 3, 2, 16, 5, 'Radio VHF', '', 259),
(1, 3, 2, 16, 6, 'Radio UHF', '', 260),
(1, 3, 2, 16, 7, 'Alat sandi', '', 261),
(1, 3, 2, 16, 8, 'Dst...................', '', 262),
(1, 3, 2, 17, 1, 'Timbangan', '', 263),
(1, 3, 2, 17, 2, 'Teodolite', '', 264),
(1, 3, 2, 17, 3, 'Alat uji emisi', '', 265),
(1, 3, 2, 17, 4, 'Alat GPS', '', 266),
(1, 3, 2, 17, 5, 'Kompas/peralatan navigasi', '', 267),
(1, 3, 2, 17, 6, 'Bejana ukur', '', 268),
(1, 3, 2, 17, 7, 'Baromoter', '', 269),
(1, 3, 2, 17, 8, 'Seismograph', '', 270),
(1, 3, 2, 17, 9, 'Ultrasonograph', '', 271),
(1, 3, 2, 17, 10, 'Dst...................', '', 272),
(1, 3, 2, 18, 1, 'Alat-alat kedokteran umum', '', 273),
(1, 3, 2, 18, 2, 'Alat-alat kedokteran gigi', '', 274),
(1, 3, 2, 18, 3, 'Alat alat kedokteran tht', '', 275),
(1, 3, 2, 18, 4, 'Alat-alat kedokteran mata', '', 276),
(1, 3, 2, 18, 5, 'Alat-slat kedokteran bedah', '', 277),
(1, 3, 2, 18, 6, 'Alat-aiat kedokteran anak', '', 278),
(1, 3, 2, 18, 7, 'Alat-alat kedokteran kebidanan dan penyakit kandungan', '', 279),
(1, 3, 2, 18, 8, 'Alat-alat kedokteran kulit dan kelamin', '', 280),
(1, 3, 2, 18, 9, 'Alat-alat kedokteran kardiologi', '', 281),
(1, 3, 2, 18, 10, 'Alat-alat kedokteran neurologi', '', 282),
(1, 3, 2, 18, 11, 'Alat-alat kedokteran orthopedi', '', 283),
(1, 3, 2, 18, 12, 'Alat-alat kedokteran hewan', '', 284),
(1, 3, 2, 18, 13, 'Alat-alat farmasi', '', 285),
(1, 3, 2, 18, 14, 'Alat-alat penyakit dalam/internis', '', 286),
(1, 3, 2, 18, 15, 'Dst...................', '', 287),
(1, 3, 2, 19, 1, 'Alat-alat laboratorium biologi', '', 288),
(1, 3, 2, 19, 2, 'Alat-alat laboratorium fisika/geologi/geodesi', '', 289),
(1, 3, 2, 19, 3, 'Aiat-slat laboratorium kimia', '', 290),
(1, 3, 2, 19, 4, 'Alat-alat laboratorium pertanian', '', 291),
(1, 3, 2, 19, 5, 'Alat-alat laboratorium peternakan', '', 292),
(1, 3, 2, 19, 6, 'Alat-alat laboratorium perkebunan', '', 293),
(1, 3, 2, 19, 7, 'Alat-alat laboratorium perikanan', '', 294),
(1, 3, 2, 19, 8, 'Alat-alat laboratorium bahasa', '', 295),
(1, 3, 2, 19, 9, 'Alat-alat peraga / praktik sekolah', '', 296),
(1, 3, 2, 19, 10, 'Dst...................', '', 297),
(1, 3, 2, 20, 1, 'Senjata api', '', 298),
(1, 3, 2, 20, 2, 'Mobil water canon', '', 299),
(1, 3, 2, 20, 3, 'Borgol', '', 300),
(1, 3, 2, 20, 4, 'Sangkur/ bayonet', '', 301),
(1, 3, 2, 20, 5, 'Perisai / tameng', '', 302),
(1, 3, 2, 20, 6, 'Detektor logam', '', 303),
(1, 3, 2, 20, 7, 'Rompi anti peluru', '', 304),
(1, 3, 2, 20, 8, 'Pentungan', '', 305),
(1, 3, 2, 20, 9, 'Helm', '', 306),
(1, 3, 2, 20, 10, 'Alarm/sirene', '', 307),
(1, 3, 2, 20, 11, 'Sentolop/senter', '', 308),
(1, 3, 2, 20, 12, 'Dst...................', '', 309),
(1, 3, 3, 1, 1, 'Gedung kantor', '', 310),
(1, 3, 3, 1, 2, 'Dst...................', '', 311),
(1, 3, 3, 2, 1, 'Gedung rumah jabatan', '', 312),
(1, 3, 3, 2, 2, 'Dst...................', '', 313),
(1, 3, 3, 3, 1, 'Gedung rumah dinas', '', 314),
(1, 3, 3, 3, 2, 'Dst...................', '', 315),
(1, 3, 3, 4, 1, 'Gedung gudang', '', 316),
(1, 3, 3, 4, 2, 'Dst...................', '', 317),
(1, 3, 3, 5, 1, 'Bangunan bersejarah', '', 318),
(1, 3, 3, 5, 2, 'Dst...................', '', 319),
(1, 3, 3, 6, 1, 'Bangunan monumen', '', 320),
(1, 3, 3, 6, 2, 'Dst...................', '', 321),
(1, 3, 3, 7, 1, 'Tugu peringatan', '', 322),
(1, 3, 3, 7, 2, 'Dst...................', '', 323),
(1, 3, 4, 1, 1, 'Jalan', '', 324),
(1, 3, 4, 1, 2, 'Jalan fly over', '', 325),
(1, 3, 4, 1, 3, 'Jalan under pass', '', 326),
(1, 3, 4, 1, 4, 'Dst...................', '', 327),
(1, 3, 4, 2, 1, 'Jembatan gantung', '', 328),
(1, 3, 4, 2, 2, 'Jembatan ponton', '', 329),
(1, 3, 4, 2, 3, 'Jembatan penyebrangan orang', '', 330),
(1, 3, 4, 2, 4, 'Jembatan penyebrangan diatas air', '', 331),
(1, 3, 4, 2, 5, 'Dst...................', '', 332),
(1, 3, 4, 3, 1, 'Jaringan irigasi/waduk/bendungan', '', 333),
(1, 3, 4, 3, 2, 'Jaringan air bersih/air minum', '', 334),
(1, 3, 4, 3, 3, 'Reservoir', '', 335),
(1, 3, 4, 3, 4, 'Pintu air', '', 336),
(1, 3, 4, 3, 5, 'Dst...................', '', 337),
(1, 3, 4, 4, 1, 'Lampu hias jalan', '', 338),
(1, 3, 4, 4, 2, 'Lampu hias taman', '', 339),
(1, 3, 4, 4, 3, 'Lampu penerang hutan kota', '', 340),
(1, 3, 4, 4, 4, 'Dst...................', '', 341),
(1, 3, 4, 5, 1, 'Instalasi listrik', '', 342),
(1, 3, 4, 5, 2, 'Jaringan telepon', '', 343),
(1, 3, 4, 5, 3, 'Dst...................', '', 344),
(1, 3, 5, 1, 1, 'Buku matematika', '', 345),
(1, 3, 5, 1, 2, 'Buku fisika', '', 346),
(1, 3, 5, 1, 3, 'Buku kimia', '', 347),
(1, 3, 5, 1, 4, 'Buku biologi', '', 348),
(1, 3, 5, 1, 5, 'Buku biografi', '', 349),
(1, 3, 5, 1, 6, 'Buku geografi', '', 350),
(1, 3, 5, 1, 7, 'Buku astronomi', '', 351),
(1, 3, 5, 1, 8, 'Buku arkeologi', '', 352),
(1, 3, 5, 1, 9, 'Buku bahasa dan sastra', '', 353),
(1, 3, 5, 1, 10, 'Buku keagamaan', '', 354),
(1, 3, 5, 1, 11, 'Buku sejarah', '', 355),
(1, 3, 5, 1, 12, 'Buku seni dan budaya', '', 356),
(1, 3, 5, 1, 13, 'Buku ilmu pengetahuan umum', '', 357),
(1, 3, 5, 1, 14, 'Buku ilmu pengetahuan sosial', '', 358),
(1, 3, 5, 1, 15, 'Buku ilmu politik dan ketatanegaraan', '', 359),
(1, 3, 5, 1, 16, 'Buku ilmu pengetahuan dan teknologi', '', 360),
(1, 3, 5, 1, 17, 'Buku ensiklopedia', '', 361),
(1, 3, 5, 1, 18, 'Buku kamus bahasa', '', 362),
(1, 3, 5, 1, 19, 'Buku ekonomi dan keuangan', '', 363),
(1, 3, 5, 1, 20, 'Buku industri dan perdagangan', '', 364),
(1, 3, 5, 1, 21, 'Buku peraturan perundang-undangan', '', 365),
(1, 3, 5, 1, 22, 'Buku naskah', '', 366),
(1, 3, 5, 1, 23, 'Terbitan berkala (jumal Compact Disk)', '', 367),
(1, 3, 5, 1, 24, 'Mikrofilm', '', 368),
(1, 3, 5, 1, 25, 'Peta/atlas/globe', '', 369),
(1, 3, 5, 1, 26, 'Dst...................', '', 370),
(1, 3, 5, 2, 1, 'Lukisan/foto', '', 371),
(1, 3, 5, 2, 2, 'Patung', '', 372),
(1, 3, 5, 2, 3, 'Ukiran', '', 373),
(1, 3, 5, 2, 4, 'Pahatan', '', 374),
(1, 3, 5, 2, 5, 'Batu alam', '', 375),
(1, 3, 5, 2, 6, 'Maket/miniatur/diorama', '', 376),
(1, 3, 5, 2, 7, 'Dst...................', '', 377),
(1, 3, 5, 3, 1, 'Hewan kebun binatang', '', 378),
(1, 3, 5, 3, 2, 'Temak', '', 379),
(1, 3, 5, 3, 3, 'Tanaman', '', 380),
(1, 3, 5, 3, 4, 'Dst...................', '', 381),
(1, 3, 6, 1, 1, 'Konstruksi Dalam Pengerjaan …..', '', 382),
(1, 3, 6, 1, 2, 'Dst...................', '', 383),
(1, 3, 7, 1, 1, 'Akumulasi Penyusutan Aset Tetap …..', '', 384),
(1, 3, 7, 1, 2, 'Dst...................', '', 385),
(1, 4, 1, 1, 1, 'Dana Cadangan....', '', 386),
(1, 4, 1, 1, 2, 'Dst...................', '', 387),
(1, 5, 1, 1, 1, 'Tagihan Penjualan Angsuran Cicilan Kendaraan Bermotor …..', '', 388),
(1, 5, 1, 1, 2, 'Dst...................', '', 389),
(1, 5, 1, 2, 1, 'Tagihan Penjualan Angsuran Cicilan Rumah', '', 390),
(1, 5, 1, 2, 2, 'Dst...................', '', 391),
(1, 5, 2, 1, 1, 'Tagihan Tuntutan Ganti Kerugian Daerah', '', 392),
(1, 5, 2, 1, 2, 'Dst...................', '', 393),
(1, 5, 3, 1, 1, 'Bangun guna serah (Build, Operate and Transfer/BOT)', '', 394),
(1, 5, 3, 1, 2, 'Dst...................', '', 395),
(1, 5, 3, 2, 1, 'Bangun serah guna (Build, Transfer and Operate/BTO)', '', 396),
(1, 5, 3, 2, 2, 'Dst...................', '', 397),
(1, 5, 3, 3, 1, 'Kerjasama Operasi (KSO)', '', 398),
(1, 5, 3, 3, 2, 'Dst...................', '', 399),
(1, 5, 4, 1, 1, 'Aset Tidak Berwu\'ud', '', 400),
(1, 5, 4, 1, 2, 'Dst...................', '', 401),
(1, 5, 5, 1, 1, 'Aset Lain-lain', '', 402),
(1, 5, 5, 1, 2, 'Dst...................', '', 403),
(2, 1, 1, 1, 1, 'Utang Taspen', '', 404),
(2, 1, 1, 2, 1, 'Utang Askes', '', 405),
(2, 1, 1, 3, 1, 'Utang PPh 21', '', 406),
(2, 1, 1, 3, 2, 'Utang PPh 22', '', 407),
(2, 1, 1, 3, 3, 'Utang PPh 23', '', 408),
(2, 1, 1, 3, 4, 'Utang PPh 25', '', 409),
(2, 1, 1, 4, 1, 'Utang PPN Pusat', '', 410),
(2, 1, 1, 5, 1, 'Utang Taperum', '', 411),
(2, 1, 1, 6, 1, 'Utang Perhitungan Pihak Ketiga Lainnya', '', 412),
(2, 1, 1, 7, 1, 'Utang IWP', '', 413),
(2, 1, 2, 1, 1, 'Utang Bunga kepada Pemerintah Pusat', '', 414),
(2, 1, 2, 2, 1, 'Utang Bunga kepada Daerah Otonom Lainnya', '', 415),
(2, 1, 2, 2, 2, 'Dst.............', '', 416),
(2, 1, 2, 3, 1, 'Utang Bunga kepada BUMN', '', 417),
(2, 1, 2, 3, 2, 'Utang Bunga kepada BUMD', '', 418),
(2, 1, 2, 3, 3, 'Dst ......', '', 419),
(2, 1, 2, 4, 1, 'Utang Bunga kepada Bank ....', '', 420),
(2, 1, 2, 4, 2, 'Utang Bunga kepada Lembaga Keuangan', '', 421),
(2, 1, 2, 4, 3, 'Dst .....', '', 422),
(2, 1, 2, 5, 1, 'Utang Bunga Dalam Negeri Lainnya', '', 423),
(2, 1, 2, 5, 2, 'Dst.............', '', 424),
(2, 1, 2, 6, 1, 'Utang Bunga Luar Negeri', '', 425),
(2, 1, 2, 6, 2, 'Dst.............', '', 426),
(2, 1, 3, 1, 1, 'Utang Pemotongan Pajak Penghasilan Pasal 21', '', 427),
(2, 1, 3, 2, 1, 'Utang Pemotongan Pajak Penghasilan Pasal 22', '', 428),
(2, 1, 3, 3, 1, 'Utang Pemungutan Pajak Pertambahan Nilai', '', 429),
(2, 1, 4, 1, 1, 'Utang Bank', '', 430),
(2, 1, 4, 1, 2, 'Dst.............', '', 431),
(2, 1, 4, 2, 1, 'Utang Obligasi', '', 432),
(2, 1, 4, 2, 2, 'Dst.............', '', 433),
(2, 1, 4, 3, 1, 'Utang Pemerintah Pusat', '', 434),
(2, 1, 4, 4, 1, 'Utang Pemerintah Frovinsi', '', 435),
(2, 1, 4, 4, 2, 'Dst.............', '', 436),
(2, 1, 4, 5, 1, 'Utang Pemerintah Kabupaten …', '', 437),
(2, 1, 4, 5, 2, 'Utang Pemerintah Kota …', '', 438),
(2, 1, 4, 5, 3, 'Dst.............', '', 439),
(2, 1, 5, 1, 1, 'Setoran Kelebihan Pembayaran Kepada Pihak III', '', 440),
(2, 1, 5, 1, 2, 'Dst.............', '', 441),
(2, 1, 5, 2, 1, 'Uang Muka Penjualan Produk Pemda Dari Pihak III', '', 442),
(2, 1, 5, 2, 2, 'Dst.............', '', 443),
(2, 1, 5, 3, 1, 'Uang Muka Lelang Penjualan Aset Daerah', '', 444),
(2, 1, 5, 3, 2, 'Dst.............', '', 445),
(2, 1, 6, 1, 1, 'Utang Jangka Pendek Lainnya', '', 446),
(2, 1, 6, 1, 2, 'Dst.............', '', 447),
(2, 1, 8, 1, 1, 'R/K Pusat', '', 448),
(2, 2, 1, 1, 1, 'Utang Dalam Negeri Sektor Perbankan', '', 449),
(2, 2, 1, 1, 2, 'Dst.............', '', 450),
(2, 2, 1, 2, 1, 'Utang Daiam Negeri - Obligasi', '', 451),
(2, 2, 1, 2, 2, 'Dst.............', '', 452),
(2, 2, 1, 3, 1, 'Utang Pemerintah Pusat', '', 453),
(2, 2, 1, 4, 1, 'Utang Pemerintah Provinsi', '', 454),
(2, 2, 1, 4, 2, 'Dst.............', '', 455),
(2, 2, 1, 5, 1, 'Utang Pemerintah Kabupaten/Kota', '', 456),
(2, 2, 1, 5, 2, 'Dst', '', 457),
(2, 2, 2, 1, 1, 'Utang Luar Negeri - Sektor Perbankan', '', 458),
(2, 2, 2, 1, 2, 'Dst ......', '', 459),
(3, 1, 2, 1, 1, 'Cadangan Piutang', '', 460),
(3, 1, 3, 1, 1, 'Cadangan Persediaan', '', 461),
(3, 1, 4, 1, 1, 'Dana yang Harus Disediakan untuk Pembayaran Utang Jangka Pendek', '', 462),
(3, 1, 5, 1, 1, 'Pendapatan yang Ditangguhkan', '', 463),
(3, 2, 1, 1, 1, 'Diinvestasikan dalam Investasi Jangka Panjang', '', 464),
(3, 2, 2, 1, 1, 'Diinvestasikan dalam Aset Tetap', '', 465),
(3, 2, 3, 1, 1, 'Diinvestasikan dalam Aset Lainnya (tidak termasuk Dana Cadangan)', '', 466),
(3, 2, 4, 1, 1, 'Dana yang Harus disediakan Untuk Pembayaran Utang Jangka Panjang ….', '', 467),
(3, 3, 1, 1, 1, 'Diinvestasikan dalam Dana Cadangan', '', 468),
(4, 1, 1, 1, 1, 'Hotel Bintang Lima Berlian', '', 469),
(4, 1, 1, 1, 2, 'Hotel Bintang Lima', '', 470),
(4, 1, 1, 1, 3, 'Hotel Bintang Empat', '', 471),
(4, 1, 1, 1, 4, 'Hotel Bintang Tiga', '', 472),
(4, 1, 1, 1, 5, 'Hotel Bintang Dua', '', 473),
(4, 1, 1, 1, 6, 'Hotel Bintang Satu', '', 474),
(4, 1, 1, 1, 7, 'Hotel Melati Tiga', '', 475),
(4, 1, 1, 1, 8, 'Hotel Melati Dua', '', 476),
(4, 1, 1, 1, 9, 'Hotel Melati Satu', '', 477),
(4, 1, 1, 1, 10, 'Motel', '', 478),
(4, 1, 1, 1, 11, 'Cottage', '', 479),
(4, 1, 1, 1, 12, 'Losmen/Rumah Penginapan/Pesanggrahan/Rumah Kos', '', 480),
(4, 1, 1, 1, 13, 'Wisma Pariwisata', '', 481),
(4, 1, 1, 1, 14, 'Gubuk Pariwisata', '', 482),
(4, 1, 1, 2, 1, 'Restoran', '', 483),
(4, 1, 1, 2, 2, 'Rumah Makan', '', 484),
(4, 1, 1, 2, 3, 'Kafetaria', '', 485),
(4, 1, 1, 2, 4, 'Kantin', '', 486),
(4, 1, 1, 2, 5, 'Katering', '', 487),
(4, 1, 1, 2, 6, 'Warung', '', 488),
(4, 1, 1, 2, 7, 'Bar', '', 489),
(4, 1, 1, 2, 8, 'Jasa Boga', '', 490),
(4, 1, 1, 3, 1, 'Tontonan Film/Bioskop', '', 491),
(4, 1, 1, 3, 2, 'Pagelaran Kesenian/Musik/Tari/Busana', '', 492),
(4, 1, 1, 3, 3, 'Kontes Kecantikan', '', 493),
(4, 1, 1, 3, 4, 'Kontes Binaraga', '', 494),
(4, 1, 1, 3, 5, 'Pameran', '', 495),
(4, 1, 1, 3, 6, 'Diskotik', '', 496),
(4, 1, 1, 3, 7, 'Karaoke', '', 497),
(4, 1, 1, 3, 8, 'Klab Malam', '', 498),
(4, 1, 1, 3, 9, 'Sirkus/Akrobat/Sulap', '', 499),
(4, 1, 1, 3, 10, 'Permainan Bilyar', '', 500),
(4, 1, 1, 3, 11, 'Permainan Golf', '', 501),
(4, 1, 1, 3, 12, 'Permainan Bowling', '', 502),
(4, 1, 1, 3, 13, 'Pacuan Kuda', '', 503),
(4, 1, 1, 3, 14, 'Balap Kendaraan Bermotor', '', 504),
(4, 1, 1, 3, 15, 'Permainan Ketangkasan', '', 505),
(4, 1, 1, 3, 16, 'Panti Pijat/Refleksi', '', 506),
(4, 1, 1, 3, 17, 'Mandi Uap/Spa', '', 507),
(4, 1, 1, 3, 18, 'Pusat Kebugaran', '', 508),
(4, 1, 1, 3, 19, 'Pertandingan Olahraga', '', 509),
(4, 1, 1, 4, 1, 'Reklame Papan/Billboard/Videotron/Megatron', '', 510),
(4, 1, 1, 4, 2, 'Reklame Kain', '', 511),
(4, 1, 1, 4, 3, 'Reklame Melekat/Stiker', '', 512),
(4, 1, 1, 4, 4, 'Reklame Selebaran', '', 513),
(4, 1, 1, 4, 5, 'Reklame Berjalan', '', 514),
(4, 1, 1, 4, 6, 'Reklame Udara', '', 515),
(4, 1, 1, 4, 7, 'Reklame Apung', '', 516),
(4, 1, 1, 4, 8, 'Reklame Suara', '', 517),
(4, 1, 1, 4, 9, 'Reklame Film/Slide', '', 518),
(4, 1, 1, 4, 10, 'Reklame Peragaan', '', 519),
(4, 1, 1, 5, 1, 'Pajak Penerangan Jalan Dihasilkan Sendiri', '', 520),
(4, 1, 1, 5, 2, 'Pajak Penerangan Jalan Sumber Lain', '', 521),
(4, 1, 1, 6, 1, 'Asbes', '', 522),
(4, 1, 1, 6, 2, 'Batu Tulis', '', 523),
(4, 1, 1, 6, 3, 'Batu Setengah Permata', '', 524),
(4, 1, 1, 6, 4, 'Batu Kapur', '', 525),
(4, 1, 1, 6, 5, 'Batu Apung', '', 526),
(4, 1, 1, 6, 6, 'Batu Pecah', '', 527),
(4, 1, 1, 6, 7, 'Batu Belah', '', 528),
(4, 1, 1, 6, 8, 'Pasir', '', 529),
(4, 1, 1, 6, 9, 'Tanah Timbun/Urug', '', 530),
(4, 1, 1, 6, 10, 'Batu Kerikil', '', 531),
(4, 1, 1, 6, 11, 'Batu Permata', '', 532),
(4, 1, 1, 6, 12, 'Bentonit', '', 533),
(4, 1, 1, 6, 13, 'Dolomit', '', 534),
(4, 1, 1, 6, 14, 'Feldspar', '', 535),
(4, 1, 1, 6, 15, 'Garam Batu (Halite)', '', 536),
(4, 1, 1, 6, 16, 'Grafit', '', 537),
(4, 1, 1, 6, 17, 'Granit/Andesit', '', 538),
(4, 1, 1, 6, 18, 'Gips', '', 539),
(4, 1, 1, 6, 19, 'Kalsit', '', 540),
(4, 1, 1, 6, 20, 'Kaolin', '', 541),
(4, 1, 1, 6, 21, 'Leusit', '', 542),
(4, 1, 1, 6, 22, 'Magnesit', '', 543),
(4, 1, 1, 6, 23, 'Mika', '', 544),
(4, 1, 1, 6, 24, 'Marmer', '', 545),
(4, 1, 1, 6, 25, 'Nitrat', '', 546),
(4, 1, 1, 6, 26, 'Opsidien', '', 547),
(4, 1, 1, 6, 27, 'Oker', '', 548),
(4, 1, 1, 6, 28, 'Pasir Kuarsa', '', 549),
(4, 1, 1, 6, 29, 'Perlit', '', 550),
(4, 1, 1, 6, 30, 'Phospat', '', 551),
(4, 1, 1, 6, 31, 'Talk', '', 552),
(4, 1, 1, 6, 32, 'Tanah Serap (Fullers earth)', '', 553),
(4, 1, 1, 6, 33, 'Tanah Liat', '', 554),
(4, 1, 1, 6, 34, 'Tawas (Alum)', '', 555),
(4, 1, 1, 6, 35, 'Tras', '', 556),
(4, 1, 1, 6, 36, 'Yarosif', '', 557),
(4, 1, 1, 6, 37, 'Zeolit', '', 558),
(4, 1, 1, 6, 38, 'Basal', '', 559),
(4, 1, 1, 6, 39, 'Trakit', '', 560),
(4, 1, 1, 6, 40, 'Mineral Bukan Logam dan Batuan Lainnya', '', 561),
(4, 1, 1, 7, 1, 'Pajak Parkir', '', 562),
(4, 1, 1, 8, 1, 'Pajak Air Tanah', '', 563),
(4, 1, 1, 9, 1, 'Pajak Sarang Burung Walet', '', 564),
(4, 1, 1, 10, 1, 'Pajak Lingkungan 4)', '', 565),
(4, 1, 1, 11, 1, 'Pajak Bumi dan Bangunan Perdesaan dan Perkotaan', 'UU No ....', 566),
(4, 1, 1, 12, 1, 'Bea Perolehan Hak Atas Tanah dan Bangunan', '', 567),
(4, 1, 2, 1, 1, 'Retribusi Pelayanan Kesehatan', '', 568),
(4, 1, 2, 1, 2, 'Retribusi Pelayanan Persampahan/Kebersihan', '', 569),
(4, 1, 2, 1, 3, 'Retribusi Penggantian Biaya Kartu Tanda Penduduk dan Akta Catatan Sipil', '', 570),
(4, 1, 2, 1, 4, 'Retribusi Pelayanan Pemakaman dan Pengabuan Mayat', '', 571),
(4, 1, 2, 1, 5, 'Retribusi Pelayanan Parkir di Tepi Jalan Umum', '', 572),
(4, 1, 2, 1, 6, 'Retribusi Pelayanan Pasar', '', 573),
(4, 1, 2, 1, 7, 'Retribusi Pengujian Kendaraan Bermotor', '', 574),
(4, 1, 2, 1, 8, 'Retribusi Pemeriksaan Alat Pemadam Kebakaran', '', 575),
(4, 1, 2, 1, 9, 'Retribusi Penggantian Biaya Cetak Peta', '', 576),
(4, 1, 2, 1, 10, 'Retribusi Pelayanan Pendidikan', '', 577),
(4, 1, 2, 1, 11, 'Retribusi Penyediaan dan/atau Penyedotan Kakus', '', 578),
(4, 1, 2, 1, 12, 'Retribusi Pengelolaan Limbah Cair', '', 579),
(4, 1, 2, 1, 13, 'Retribusi Pengendalian Menara Telekomunikasi', '', 580),
(4, 1, 2, 1, 14, 'Retribusi Pelayanan Tera/Tera Ulang', '', 581),
(4, 1, 2, 2, 1, 'Retribusi Pemakaian Kekayaan Daerah', '', 582),
(4, 1, 2, 2, 2, 'Retribusi Pasar Grosir/Pertokoan', '', 583),
(4, 1, 2, 2, 3, 'Retribusi Tempat Pelelangan', '', 584),
(4, 1, 2, 2, 4, 'Retribusi Terminal', '', 585),
(4, 1, 2, 2, 5, 'Retribusi Tempat Khusus Parkir', '', 586),
(4, 1, 2, 2, 6, 'Retribusi Tempat Penginapan/Pesanggrahan/Villa', '', 587),
(4, 1, 2, 2, 7, 'Retribusi Penyediaan dan/atau Penyedotan Kakus', '', 588),
(4, 1, 2, 2, 8, 'Retribusi Rumah Potong Hewan', '', 589),
(4, 1, 2, 2, 9, 'Retribusi Pelayanan Kepelabuhan', '', 590),
(4, 1, 2, 2, 10, 'Retribusi Tempat Rekreasi dan Olahraga', '', 591),
(4, 1, 2, 2, 11, 'Retribusi Penyeberangan di Air', '', 592),
(4, 1, 2, 2, 12, 'Retribusi Pengelolaan Limbah Cair 4)', '', 593),
(4, 1, 2, 2, 13, 'Retribusi Penjualan Produksi Usaha Daerah', '', 594),
(4, 1, 2, 3, 1, 'Retribusi Izin Mendirikan Bangunan', '', 595),
(4, 1, 2, 3, 2, 'Retribusi Izin Tempat Penjualan Minuman Beralkohol', '', 596),
(4, 1, 2, 3, 3, 'Retribusi Izin Gangguan', '', 597),
(4, 1, 2, 3, 4, 'Retribusi Izin Trayek', '', 598),
(4, 1, 2, 3, 5, 'Retribusi Izin Usaha Perikanan', '', 599),
(4, 1, 3, 1, 1, 'Perusahaan Daerah', '', 600),
(4, 1, 3, 1, 2, 'BUMD ..............', '', 601),
(4, 1, 3, 2, 1, 'BUMN ..............', '', 602),
(4, 1, 3, 3, 1, 'Perusahaan Patungan', '', 603),
(4, 1, 4, 1, 1, 'Pelepasan Hak Atas Tanah', '', 604),
(4, 1, 4, 1, 2, 'Penjualan Peralatan/Perlengkapan Kantor Tidak Terpakai', '', 605),
(4, 1, 4, 1, 3, 'Penjualan Mesin/Alat-Alat Berat Tidak Terpakai', '', 606),
(4, 1, 4, 1, 4, 'Penjualan Rumah Jabatan/Rumah Dinas', '', 607),
(4, 1, 4, 1, 5, 'Penjualan Kendaraan Dinas Roda Dua', '', 608),
(4, 1, 4, 1, 6, 'Penjualan Kendaraan Dinas Roda Empat', '', 609),
(4, 1, 4, 1, 7, 'Penjualan Drum Bekas', '', 610),
(4, 1, 4, 1, 8, 'Penjualan Hasil Penebangan Pohon', '', 611),
(4, 1, 4, 1, 9, 'Penjualan Lampu Hias Bekas', '', 612),
(4, 1, 4, 1, 10, 'Penjualan Bahan-Bahan Bekas Bangunan', '', 613),
(4, 1, 4, 1, 11, 'Penjualan Perlengkapan Lalu Lintas', '', 614),
(4, 1, 4, 1, 12, 'Penjualan Obat-Obatan dan Hasil Farmasi', '', 615),
(4, 1, 4, 1, 13, 'Penjualan Hasil Pertanian', '', 616),
(4, 1, 4, 1, 14, 'Penjualan Hasil Kehutanan', '', 617),
(4, 1, 4, 1, 15, 'Penjualan Hasil Perkebunan', '', 618),
(4, 1, 4, 1, 16, 'Penjualan Hasil Peternakan', '', 619),
(4, 1, 4, 1, 17, 'Penjualan Hasil Perikanan', '', 620),
(4, 1, 4, 1, 18, 'Penjualan Hasil Sitaan', '', 621),
(4, 1, 4, 2, 1, 'Jasa Giro Kas Daerah', '', 622),
(4, 1, 4, 2, 2, 'Jasa Giro Pemegang Kas', '', 623),
(4, 1, 4, 2, 3, 'Jasa Giro Dana Cadangan', '', 624),
(4, 1, 4, 3, 1, 'Rekening Deposito Pada Bank ..............', '', 625),
(4, 1, 4, 4, 1, 'Kerugian Uang Daerah', '', 626),
(4, 1, 4, 4, 2, 'Kerugian Barang Daerah', '', 627),
(4, 1, 4, 5, 1, 'Penerimaan Komisi dari Penempatan Kas Daerah', '', 628),
(4, 1, 4, 5, 2, 'Penerimaan Potongan dari ..............', '', 629),
(4, 1, 4, 5, 3, 'Penerimaan Keuntungan Selisih Nilai Tukar Rupiah dari ..............', '', 630),
(4, 1, 4, 6, 1, 'Bidang Pendidikan', '', 631),
(4, 1, 4, 6, 2, 'Bidang Kesehatan', '', 632),
(4, 1, 4, 6, 3, 'Bidang Pekerjaan Umum dan Penataan Ruang', '', 633),
(4, 1, 4, 6, 4, 'Bidang Perumahan Rakyat dan Kawasan Pemukiman', '', 634),
(4, 1, 4, 6, 5, 'Bidang Ketentraman dan Ketertiban Umum serta Perlindungan Masyarakat', '', 635),
(4, 1, 4, 6, 6, 'Bidang Sosial', '', 636),
(4, 1, 4, 6, 7, 'Bidang Tenaga Kerja', '', 637),
(4, 1, 4, 6, 8, 'Bidang Pemberdayaan Perempuan dan Perlindungan Anak', '', 638),
(4, 1, 4, 6, 9, 'Bidang Pangan', '', 639),
(4, 1, 4, 6, 10, 'Bidang Pertanahan', '', 640),
(4, 1, 4, 6, 11, 'Bidang Lingkungan Hidup', '', 641),
(4, 1, 4, 6, 12, 'Bidang Administrasi Kependudukan dan Capil', '', 642),
(4, 1, 4, 6, 13, 'Bidang Pemberdayaan Masyarakat Desa', '', 643),
(4, 1, 4, 6, 14, 'Bidang Pengendalian Penduduk dan Keluarga Berencana', '', 644),
(4, 1, 4, 6, 15, 'Bidang Perhubungan', '', 645),
(4, 1, 4, 6, 16, 'Bidang Komunikasi dan Informatika', '', 646),
(4, 1, 4, 6, 17, 'Bidang Koperasi, Usaha Kecil dan Menengah', '', 647),
(4, 1, 4, 6, 18, 'Bidang Penanaman Modal', '', 648),
(4, 1, 4, 6, 19, 'Bidang Kepemudaan dan Olah Raga', '', 649),
(4, 1, 4, 6, 20, 'Bidang Statistik', '', 650),
(4, 1, 4, 6, 21, 'Bidang Persandian', '', 651),
(4, 1, 4, 6, 22, 'Bidang Kebudayaan', '', 652),
(4, 1, 4, 6, 23, 'Bidang Perpustakaan', '', 653),
(4, 1, 4, 6, 24, 'Bidang Kearsipan', '', 654),
(4, 1, 4, 6, 25, 'Bidang Kelautan dan Perikanan', '', 655),
(4, 1, 4, 6, 26, 'Bidang Pariwisata', '', 656),
(4, 1, 4, 6, 27, 'Bidang Pertanian', '', 657),
(4, 1, 4, 6, 28, 'Bidang Kehutanan', '', 658),
(4, 1, 4, 6, 29, 'Bidang Energi dan Sumberdaya Mineral', '', 659),
(4, 1, 4, 6, 30, 'Bidang Perdagangan', '', 660),
(4, 1, 4, 6, 31, 'Bidang Perindustrian', '', 661),
(4, 1, 4, 6, 32, 'Bidang Transmigrasi', '', 662),
(4, 1, 4, 6, 33, 'Urusan Penunjang', '', 663),
(4, 1, 4, 7, 1, 'Pendapatan Denda Pajak Hotel', '', 664),
(4, 1, 4, 7, 2, 'Pendapatan Denda Pajak Restoran', '', 665),
(4, 1, 4, 7, 3, 'Pendapatan Denda Pajak Hiburan', '', 666),
(4, 1, 4, 7, 4, 'Pendapatan Denda Pajak Reklame', '', 667),
(4, 1, 4, 7, 5, 'Pendapatan Denda Pajak Penerangan Jalan', '', 668),
(4, 1, 4, 7, 6, 'Pendapatan Denda Pajak Mineral Bukan Logam dan Batuan', '', 669),
(4, 1, 4, 7, 7, 'Pendapatan Denda Pajak Parkir', '', 670),
(4, 1, 4, 7, 8, 'Pendapatan Denda Pajak Air Tanah', '', 671),
(4, 1, 4, 7, 9, 'Pendapatan Denda Pajak Sarang Burung Walet', '', 672),
(4, 1, 4, 7, 10, 'Pendapatan Denda Pajak Lingkungan', '', 673),
(4, 1, 4, 7, 11, 'Pendapatan Denda Pajak Bumi dan Bangunan Perdesaan dan Perkotaan', '', 674),
(4, 1, 4, 7, 12, 'Pendapatan Denda Bea Perolehan Hak Atas Tanah dan Bangunan', '', 675),
(4, 1, 4, 8, 1, 'Pendapatan Denda Retribusi Jasa Umum', '', 676),
(4, 1, 4, 8, 2, 'Pendapatan Denda Retribusi Jasa Usaha', '', 677),
(4, 1, 4, 8, 3, 'Pendapatan Denda Retribusi Perizinan Tertentu', '', 678),
(4, 1, 4, 9, 1, 'Hasil Eksekusi Atas Jaminan atas Pelaksanaan Pekerjaan', '', 679),
(4, 1, 4, 9, 2, 'Hasil Eksekusi Atas Jaminan atas Pembongkaran Reklame', '', 680),
(4, 1, 4, 9, 3, 'Hasil Eksekusi Atas Jaminan atas KTP Musiman', '', 681),
(4, 1, 4, 10, 1, 'Pendapatan Dari Pengembalian Pajak Penghasilan Pasal 21', '', 682),
(4, 1, 4, 10, 2, 'Pendapatan Dari Pengembalian Kelebihan Pembayaran Asuransi Kesehatan', '', 683),
(4, 1, 4, 10, 3, 'Pendapatan Dari Pengembalian Kelebihan Pembayaran Gaji dan Tunjangan', '', 684),
(4, 1, 4, 10, 4, 'Pendapatan Dari Pengembalian Kelebihan Pembayaran Perjalanan Dinas', '', 685),
(4, 1, 4, 10, 5, 'Pendapatan Dari Pengembalian Uang Muka', '', 686),
(4, 1, 4, 10, 6, 'Pendapatan Dari Pengembalian dari Pihak Ketiga', '', 687),
(4, 1, 4, 11, 1, 'Fasilitas Sosial', '', 688),
(4, 1, 4, 11, 2, 'Fasilitas Umum', '', 689),
(4, 1, 4, 12, 1, 'Uang Pendaftaran/Ujian Masuk', '', 690),
(4, 1, 4, 12, 2, 'Uang Sekolah/Pendidikan dan Pelatihan', '', 691),
(4, 1, 4, 12, 3, 'Uang Ujian Kenaikan Tingkat/Kelas', '', 692),
(4, 1, 4, 13, 1, 'Angsuran/Cicilan Penjualan Rumah Dinas Daerah Golongan III', '', 693),
(4, 1, 4, 13, 2, 'Angsuran/Cicilan Penjualan Kendaraan Perorangan Dinas', '', 694),
(4, 1, 4, 13, 3, 'Angsuran/Cicilan Ganti Kerugian Barang Milik Daerah', '', 695),
(4, 1, 4, 14, 1, 'Hasil dari Pemanfaatan Kekayaan Daerah Sewa', '', 696),
(4, 1, 4, 14, 2, 'Hasil dari Pemanfaatan Kekayaan Daerah Kerjasama Pemanfaatan', '', 697),
(4, 1, 4, 14, 3, 'Hasil dari Pemanfaatan Kekayaan Daerah Bangun Guna Serah', '', 698),
(4, 1, 4, 14, 4, 'Hasil dari Pemanfaatan Kekayaan Daerah Bangun Serah Guna', '', 699),
(4, 1, 4, 15, 1, 'Pendapatan Zakat', '', 700),
(4, 1, 4, 16, 1, 'Pendapatan Jasa Layanan Umum BLUD', '', 701),
(4, 1, 4, 16, 2, 'Pendapatan Hibah BLUD', '', 702),
(4, 1, 4, 16, 3, 'Pendapatan Hasil Kerjasama BLUD', '', 703),
(4, 1, 4, 17, 1, 'Hasil Pengelolaan Dana Bergulir dari Kelompok Masyarakat', '', 704),
(4, 1, 4, 18, 1, 'Pendapatan Dana JKN', '', 705),
(4, 1, 4, 19, 1, 'Lain-lain PAD yang Sah Lainnya', '', 706),
(4, 2, 1, 1, 1, 'Bagi Hasil dari Pajak Bumi dan Bangunan sektor Pertambangan', '', 707),
(4, 2, 1, 1, 2, 'Bagi Hasil dari Pajak Bumi dan Bangunan sektor Perkebunan', '', 708),
(4, 2, 1, 1, 3, 'Bagi Hasil dari Pajak Bumi dan Bangunan sektor Perhutanan', '', 709),
(4, 2, 1, 1, 4, 'Bagi Hasil dari Pajak Penghasilan (PPh) Pasal 25 dan Pasal 29 Wajib Pajak Orang Pribadi Dalam Negeri dan PPh Pasal 21', '', 710),
(4, 2, 1, 1, 5, 'Bagi Hasil Cukai Hasil Tembakau', '', 711),
(4, 2, 1, 2, 1, 'Bagi Hasil dari Iuran Hak Pengusahaan Hutan', '', 712),
(4, 2, 1, 2, 2, 'Bagi Hasil dari Provisi Sumber Daya Hutan', '', 713),
(4, 2, 1, 2, 3, 'Bagi Hasil dari Dana Reboisasi', '', 714),
(4, 2, 1, 2, 4, 'Bagi Hasil dari Iuran Tetap (Land-Rent)', '', 715),
(4, 2, 1, 2, 5, 'Bagi Hasil dari Iuran Eksplorasi dan Iuran Eksploitasi (Royalti)', '', 716),
(4, 2, 1, 2, 6, 'Bagi Hasil dari Pungutan Pengusahaan Perikanan', '', 717),
(4, 2, 1, 2, 7, 'Bagi Hasil dari Pungutan Hasil Perikanan', '', 718),
(4, 2, 1, 2, 8, 'Bagi Hasil dari Pertambangan Minyak Bumi', '', 719),
(4, 2, 1, 2, 9, 'Bagi Hasil dari Pertambangan Gas Bumi', '', 720),
(4, 2, 1, 2, 10, 'Bagi Hasil dari Pertambangan Panas Bumi', '', 721),
(4, 2, 2, 1, 1, 'Dana Alokasi Umum', '', 722),
(4, 2, 3, 1, 1, 'DAK Bidang Infrastruktur Jalan', '', 723),
(4, 2, 3, 1, 2, 'DAK Bidang Infrastruktur Irigasi', '', 724),
(4, 2, 3, 1, 3, 'DAK Bidang Infrastruktur Air Minum', '', 725),
(4, 2, 3, 1, 4, 'DAK Bidang Infrastruktur Sanitasi', '', 726),
(4, 2, 3, 1, 5, 'DAK Bidang Keluarga Berencana', '', 727),
(4, 2, 3, 1, 6, 'DAK Bidang Keluarga', '', 728),
(4, 2, 3, 1, 7, 'DAK Bidang Kehutanan', '', 729),
(4, 2, 3, 1, 8, 'DAK Bidang Perumahan dan Kawasan Pemukiman', '', 730),
(4, 2, 3, 1, 9, 'DAK Bidang Kesehatan', '', 731),
(4, 2, 3, 1, 10, 'DAK Bidang Kelautan dan Perikanan', '', 732),
(4, 2, 3, 1, 11, 'DAK Bidang Prasarana Pemerintahan', '', 733),
(4, 2, 3, 1, 12, 'DAK Bidang Transportasi Perdesaan', '', 734),
(4, 2, 3, 1, 13, 'DAK Bidang Perdagangan', '', 735),
(4, 2, 3, 1, 14, 'DAK Bidang Lingkungan Hidup', '', 736),
(4, 2, 3, 1, 15, 'DAK Bidang Sarana dan Prasarana Daerah Tertinggal (SPDT)', '', 737),
(4, 2, 3, 1, 16, 'DAK Bidang Pertanian', '', 738),
(4, 2, 3, 1, 17, 'DAK Bidang Energi Pedesaan', '', 739),
(4, 2, 3, 1, 18, 'DAK Bidang Sarana dan Prasarana Kawasan Perbatasan', '', 740),
(4, 2, 3, 1, 19, 'DAK Bidang Pendidikan', '', 741),
(4, 2, 3, 1, 20, 'DAK Bidang Keselamatan Transportasi Darat', '', 742),
(4, 3, 1, 1, 1, 'Pemerintah', '', 743),
(4, 3, 1, 2, 1, 'Pemerintah Daerah ..............', '', 744),
(4, 3, 1, 3, 1, 'Badan/Lembaga/Organisasi Swasta ..............', '', 745),
(4, 3, 1, 4, 1, 'Kelompok Masyarakat/Perorangan', '', 746),
(4, 3, 1, 5, 1, 'Pendapatan Hibah Dari Bilateral', '', 747),
(4, 3, 1, 5, 2, 'Pendapatan Hibah Dari Multilateral', '', 748),
(4, 3, 1, 5, 3, 'Pendapatan Hibah Dari Donor Lainnya', '', 749),
(4, 3, 2, 1, 1, 'Korban/Kerusakan Akibat Bencana Alam ..............', '', 750),
(4, 3, 3, 1, 1, 'Bagi Hasil dari Pajak Kendaraan Bermotor', '', 751),
(4, 3, 3, 1, 2, 'Bagi Hasil dari Pajak Kendaraan Di atas Air 4)', '', 752),
(4, 3, 3, 1, 3, 'Bagi Hasil dari Bea Balik Nama Kendaraan Bermotor', '', 753),
(4, 3, 3, 1, 4, 'Bagi Hasil dari Pajak Bea Balik Nama Kendaraan Di atas Air 4)', '', 754),
(4, 3, 3, 1, 5, 'Bagi Hasil dari Pajak Bahan Bakar Kendaraan Bermotor', '', 755),
(4, 3, 3, 1, 6, 'Bagi Hasil dari Pajak Pengambilan dan Pemanfaatan Air Bawah Tanah 4)', '', 756),
(4, 3, 3, 1, 7, 'Bagi Hasil dari Pajak Air Permukaan', '', 757),
(4, 3, 3, 1, 8, 'Bagi Hasil dari Pajak Rokok', '', 758),
(4, 3, 3, 2, 1, 'Dana Bagi Hasil Pajak dari Provinsi ..............', '', 759),
(4, 3, 3, 3, 1, 'Dana Bagi Hasil Pajak dari Kabupaten ..............', '', 760),
(4, 3, 3, 4, 1, 'Dana Bagi Hasil Pajak dari Kota ..............', '', 761),
(4, 3, 4, 1, 1, 'Dana BOS', '', 762),
(4, 3, 4, 2, 1, 'Dana Otonomi Khusus', '', 763),
(4, 3, 5, 1, 1, 'Bantuan Keuangan Dari Provinsi ..............', '', 764),
(4, 3, 5, 2, 1, 'Bantuan Keuangan Dari Kabupaten ..............', '', 765),
(4, 3, 5, 3, 1, 'Bantuan Keuangan Dari Kota ..............', '', 766),
(5, 1, 1, 1, 1, 'Gaji Pokok PNS/Uang Representasi1)', '', 767),
(5, 1, 1, 1, 2, 'Tunjangan Keluarga', '', 768),
(5, 1, 1, 1, 3, 'Tunjangan Jabatan 1)', '', 769),
(5, 1, 1, 1, 4, 'Tunjangan Fungsional', '', 770),
(5, 1, 1, 1, 5, 'Tunjangan Fungsional Umum', '', 771),
(5, 1, 1, 1, 6, 'Tunjangan Beras 1)', '', 772),
(5, 1, 1, 1, 7, 'Tunjangan PPh/Tunjangan Khusus', '', 773),
(5, 1, 1, 1, 8, 'Pembulatan Gaji', '', 774),
(5, 1, 1, 1, 9, 'Iuran Asuransi Kesehatan', '', 775),
(5, 1, 1, 1, 10, 'Uang Paket 2)', '', 776),
(5, 1, 1, 1, 11, 'Tunjangan Badan Musyawarah 2)', '', 777),
(5, 1, 1, 1, 12, 'Tunjangan Komisi 2)', '', 778),
(5, 1, 1, 1, 13, 'Tunjangan Badan Anggaran 2)', '', 779),
(5, 1, 1, 1, 14, 'Tunjangan Badan Kehormatan 2)', '', 780),
(5, 1, 1, 1, 15, 'Tunjangan Alat Kelengkapan Lainnya 2)', '', 781),
(5, 1, 1, 1, 16, 'Tunjangan Perumahan 2)', '', 782),
(5, 1, 1, 1, 17, 'Uang Duka Wafat/Tewas 1)', '', 783),
(5, 1, 1, 1, 18, 'Uang Jasa Pengabdian 2)', '', 784),
(5, 1, 1, 1, 19, 'Belanja Penunjang Operasional Pimpinan DPRD', '', 785),
(5, 1, 1, 1, 20, 'Tunjangan Kesehatan DPRD', '', 786),
(5, 1, 1, 2, 1, 'Tambahan Penghasilan berdasarkan beban kerja', '', 787),
(5, 1, 1, 2, 2, 'Tambahan Penghasilan berdasarkan tempat bertugas', '', 788),
(5, 1, 1, 2, 3, 'Tambahan Penghasilan berdasarkan kondisi kerja', '', 789),
(5, 1, 1, 2, 4, 'Tambahan Penghasilan berdasarkan kelangkaan profesi', '', 790),
(5, 1, 1, 3, 1, 'Tunjangan Komunikasi Intensif Pimpinan dan Anggota DPRD', '', 791),
(5, 1, 1, 3, 2, 'Belanja Penunjang Operasional KDH/WKDH', '', 792),
(5, 1, 1, 4, 1, 'Biaya Pemungutan PBB', '', 793),
(5, 1, 1, 5, 1, 'Insentif Pemungutan Pajak Daerah', '', 794),
(5, 1, 1, 6, 1, 'Insentif Pemungutan Retribusi Daerah', '', 795),
(5, 1, 2, 1, 1, 'Bunga Utang Pinjaman kepada Pemerintah', '', 796),
(5, 1, 2, 1, 2, 'Bunga Utang Pinjaman kepada Pemerintah Daerah lainnya', '', 797),
(5, 1, 2, 1, 3, 'Bunga Utang Pinjaman kepada Lembaga Keuangan Bank', '', 798),
(5, 1, 2, 1, 4, 'Bunga Utang Pinjaman kepada Lembaga Keuangan Bukan Bank', '', 799),
(5, 1, 2, 2, 1, 'Bunga Utang Obligasi ………', '', 800),
(5, 1, 3, 1, 1, 'Belanja Subsidi kepada Perusahaan ….', '', 801),
(5, 1, 3, 1, 2, 'Belanja Subsidi kepada Lembaga ….', '', 802),
(5, 1, 4, 1, 1, 'Hibah kepada Pemerintah Pusat', '', 803),
(5, 1, 4, 2, 1, 'Pemerintah Provinsi ……….', '', 804),
(5, 1, 4, 2, 2, 'Pemerintah Kabupaten/Kota ..........', '', 805),
(5, 1, 4, 3, 1, 'Pemerintahan Desa ….......', '', 806),
(5, 1, 4, 4, 1, 'Perusahaan Daerah/ BUMD/ BUMN …...........', '', 807),
(5, 1, 4, 5, 1, 'Belanja Hibah kepada Badan/Lembaga/Organisasi …...........', '', 808),
(5, 1, 4, 6, 1, 'Belanja Hibah kepada Kelompok/anggota masyarakat ……..', '', 809),
(5, 1, 4, 7, 1, 'Belanja Hibah Dana BOS ke SD Swasta', '', 810),
(5, 1, 4, 7, 2, 'Belanja Hibah Dana BOS ke SMP Swasta', '', 811),
(5, 1, 5, 1, 1, 'Belanja Bantuan Sosial kepada Organisasi Sosial Kemasyarakatan ....', '', 812),
(5, 1, 5, 2, 1, 'Belanja Bantuan Sosial kepada Kelompok Masyarakat .................', '', 813),
(5, 1, 5, 3, 1, 'Belanja Bantuan Sosial kepada ……………………', '', 814),
(5, 1, 6, 1, 1, 'Belanja Bagi Hasil Pajak Daerah Kepada Provinsi ...', '', 815),
(5, 1, 6, 2, 1, 'Belanja Bagi Hasil Pajak Daerah Kepada Kabupaten/Kota …', '', 816),
(5, 1, 6, 3, 1, 'Belanja Bagi Hasil Pajak Daerah Kepada Pemerintahan Desa …', '', 817),
(5, 1, 6, 4, 1, 'Belanja Bagi Hasil Retribusi Daerah Kepada Kabupaten/Kota ….', '', 818),
(5, 1, 6, 5, 1, 'Belanja Bagi Hasil Retribusi Daerah Kepada Pemerintahan Desa ….', '', 819),
(5, 1, 7, 1, 1, 'Belanja Bantuan Keuangan Kepada Provinsi …...', '', 820),
(5, 1, 7, 2, 1, 'Belanja Bantuan Keuangan kepada Kabupaten/Kota …...', '', 821),
(5, 1, 7, 3, 1, 'Belanja Bantuan Keuangan kepada Desa ……', '', 822),
(5, 1, 7, 4, 1, 'Belanja Bantuan Keuangan kepada Provinsi ...', '', 823),
(5, 1, 7, 4, 2, 'Belanja Bantuan Keuangan kepada Kabupaten/Kota …', '', 824),
(5, 1, 7, 4, 3, 'Belanja Bantuan Keuangan kepada Pemerintahan Desa ...', '', 825),
(5, 1, 7, 5, 1, 'Belanja Bantuan kepada Partai Politik ................', '', 826),
(5, 1, 8, 1, 1, 'Belanja Tidak Terduga', '', 827),
(5, 2, 1, 1, 1, 'Honorarium Panitia Pelaksana Kegiatan', '', 828),
(5, 2, 1, 1, 2, 'Honorarium Tim Pengadaan Barang dan Jasa', '', 829),
(5, 2, 1, 2, 1, 'Honorarium Tenaga Ahli/Instruktur/Narasumber', '', 830),
(5, 2, 1, 2, 2, 'Honorarium Pegawai Honorer/tidak tetap', '', 831),
(5, 2, 1, 3, 1, 'Uang Lembur PNS', '', 832),
(5, 2, 1, 3, 2, 'Uang Lembur Non PNS', '', 833),
(5, 2, 1, 4, 1, 'Honorarium Pengelolaan Dana BOS', '', 834),
(5, 2, 1, 5, 1, 'Uang untuk diberikan kepada pihak ketiga', '', 835),
(5, 2, 1, 5, 2, 'Uang untuk diberikan kepada masyarakat', '', 836),
(5, 2, 2, 1, 1, 'Belanja alat tulis kantor', '', 837),
(5, 2, 2, 1, 2, 'Belanja dokumen/administrasi tender', '', 838),
(5, 2, 2, 1, 3, 'Belanja alat listrik dan elektronik ( lampu pijar, battery kering)', '', 839),
(5, 2, 2, 1, 4, 'Belanja perangko, materai dan benda pos lainnya', '', 840),
(5, 2, 2, 1, 5, 'Belanja peralatan kebersihan dan bahan pembersih', '', 841),
(5, 2, 2, 1, 6, 'Belanja Bahan Bakar Minyak/Gas sarana mobilitas', '', 842),
(5, 2, 2, 1, 7, 'Belanja pengisian tabung pemadam kebakaran', '', 843),
(5, 2, 2, 1, 8, 'Belanja pengisian tabung gas', '', 844),
(5, 2, 2, 2, 1, 'Belanja bahan baku bangunan', '', 845),
(5, 2, 2, 2, 2, 'Belanja bahan/bibit tanaman', '', 846),
(5, 2, 2, 2, 3, 'Belanja bibit ternak', '', 847),
(5, 2, 2, 2, 4, 'Belanja bahan obat-obatan', '', 848),
(5, 2, 2, 2, 5, 'Belanja bahan kimia', '', 849),
(5, 2, 2, 2, 6, 'Belanja Persediaan Bahan Makanan Pokok', '', 850),
(5, 2, 2, 3, 1, 'Belanja telepon', '', 851),
(5, 2, 2, 3, 2, 'Belanja air', '', 852),
(5, 2, 2, 3, 3, 'Belanja listrik', '', 853),
(5, 2, 2, 3, 4, 'Belanja Jasa pengumuman lelang/ pemenang lelang', '', 854),
(5, 2, 2, 3, 5, 'Belanja surat kabar/majalah', '', 855),
(5, 2, 2, 3, 6, 'Belanja kawat/faksimili/internet', '', 856),
(5, 2, 2, 3, 7, 'Belanja paket/pengiriman', '', 857),
(5, 2, 2, 3, 8, 'Belanja Sertifikasi', '', 858),
(5, 2, 2, 3, 9, 'Belanja Jasa Transaksi Keuangan', '', 859),
(5, 2, 2, 3, 10, 'Belanja jasa administrasi pungutan Pajak Penerangan Jalan Umum', '', 860),
(5, 2, 2, 3, 11, 'Belanja jasa administrasi pungutan Pajak Bahan Bakar Kendaraan Bermotor', '', 861),
(5, 2, 2, 4, 1, 'Belanja Premi Asuransi Kesehatan 2)', '', 862),
(5, 2, 2, 4, 2, 'Belanja Premi Asuransi Barang Milik Daerah', '', 863),
(5, 2, 2, 5, 1, 'Belanja Jasa Service', '', 864),
(5, 2, 2, 5, 2, 'Belanja Penggantian Suku Cadang', '', 865),
(5, 2, 2, 5, 3, 'Belanja Bahan Bakar Minyak/Gas dan pelumas', '', 866),
(5, 2, 2, 5, 4, 'Belanja Jasa KIR', '', 867),
(5, 2, 2, 5, 5, 'Belanja Pajak Kendaraan Bermotor', '', 868),
(5, 2, 2, 5, 6, 'Belanja Bea Balik Nama Kendaraan Bermotor', '', 869),
(5, 2, 2, 6, 1, 'Belanja cetak', '', 870),
(5, 2, 2, 6, 2, 'Belanja Penggandaan', '', 871),
(5, 2, 2, 7, 1, 'Belanja sewa rumah jabatan/rumah dinas', '', 872),
(5, 2, 2, 7, 2, 'Belanja sewa gedung/ kantor/tempat', '', 873),
(5, 2, 2, 7, 3, 'Belanja sewa ruang rapat/pertemuan', '', 874),
(5, 2, 2, 7, 4, 'Belanja sewa tempat parkir/uang tambat/hanggar sarana mobilitas', '', 875),
(5, 2, 2, 8, 1, 'Belanja sewa Sarana Mobilitas Darat', '', 876),
(5, 2, 2, 8, 2, 'Belanja sewa Sarana Mobilitas Air', '', 877),
(5, 2, 2, 8, 3, 'Belanja sewa Sarana Mobilitas Udara', '', 878),
(5, 2, 2, 9, 1, 'Belanja sewa Eskavator', '', 879),
(5, 2, 2, 9, 2, 'Belanja sewa Buldoser', '', 880),
(5, 2, 2, 10, 1, 'Belanja sewa meja kursi', '', 881),
(5, 2, 2, 10, 2, 'Belanja sewa komputer dan printer', '', 882),
(5, 2, 2, 10, 3, 'Belanja sewa proyektor', '', 883),
(5, 2, 2, 10, 4, 'Belanja sewa generator', '', 884),
(5, 2, 2, 10, 5, 'Belanja sewa tenda', '', 885),
(5, 2, 2, 10, 6, 'Belanja sewa pakaian adat/tradisional', '', 886),
(5, 2, 2, 11, 1, 'Belanja makanan dan minuman harian pegawai', '', 887),
(5, 2, 2, 11, 2, 'Belanja makanan dan minuman rapat', '', 888),
(5, 2, 2, 11, 3, 'Belanja makanan dan minuman tamu', '', 889),
(5, 2, 2, 11, 4, 'Belanja makanan dan minuman pelatihan', '', 890),
(5, 2, 2, 12, 1, 'Belanja pakaian Dinas KDH dan WKDH', '', 891),
(5, 2, 2, 12, 2, 'Belanja Pakaian Sipil Harian (PSH)', '', 892),
(5, 2, 2, 12, 3, 'Belanja Pakaian Sipil Lengkap (PSL)', '', 893),
(5, 2, 2, 12, 4, 'Belanja Pakaian Dinas Harian (PDH)', '', 894),
(5, 2, 2, 12, 5, 'Belanja Pakaian Dinas Upacara (PDU)', '', 895),
(5, 2, 2, 13, 1, 'Belanja pakaian kerja lapangan', '', 896),
(5, 2, 2, 14, 1, 'Belanja pakaian KORPRI', '', 897),
(5, 2, 2, 14, 2, 'Belanja pakaian adat daerah', '', 898),
(5, 2, 2, 14, 3, 'Belanja pakaian batik tradisional', '', 899),
(5, 2, 2, 14, 4, 'Belanja pakaian olahraga', '', 900),
(5, 2, 2, 15, 1, 'Belanja perjalanan dinas dalam daerah', '', 901),
(5, 2, 2, 15, 2, 'Belanja perjalanan dinas luar daerah', '', 902),
(5, 2, 2, 15, 3, 'Belanja perjalanan dinas luar negeri', '', 903),
(5, 2, 2, 16, 1, 'Belanja beasiswa tugas belajar D3', '', 904),
(5, 2, 2, 16, 2, 'Belanja beasiswa tugas belajar S1', '', 905),
(5, 2, 2, 16, 3, 'Belanja beasiswa tugas belajar S2', '', 906),
(5, 2, 2, 16, 4, 'Belanja beasiswa tugas belajar S3', '', 907),
(5, 2, 2, 17, 1, 'Belanja kursus-kursus singkat/ pelatihan', '', 908);
INSERT INTO `ref_rek_5` (`kd_rek_1`, `kd_rek_2`, `kd_rek_3`, `kd_rek_4`, `kd_rek_5`, `nama_kd_rek_5`, `peraturan`, `id_rekening`) VALUES
(5, 2, 2, 17, 2, 'Belanja sosialisasi', '', 909),
(5, 2, 2, 17, 3, 'Belanja Bimbingan Teknis', '', 910),
(5, 2, 2, 18, 1, 'Belanja perjalanan pindah tugas dalam daerah', '', 911),
(5, 2, 2, 18, 2, 'Belanja perjalanan pindah tugas luar daerah', '', 912),
(5, 2, 2, 19, 1, 'Belanja pemulangan pegawai yang pensiun dalam daerah', '', 913),
(5, 2, 2, 19, 2, 'Belanja pemulangan pegawai yang pensiun luar daerah', '', 914),
(5, 2, 2, 19, 3, 'Belanja pemulangan pegawai yang tewas dalam melaksanakan tugas', '', 915),
(5, 2, 2, 20, 1, 'Belanja Pemeliharan Tanah', '', 916),
(5, 2, 2, 20, 2, 'Belanja Pemeliharan Peralatan dan Mesin', '', 917),
(5, 2, 2, 20, 3, 'Belanja Pemeliharan Gedung dan Bangunan', '', 918),
(5, 2, 2, 20, 4, 'Belanja Pemeliharan Jalan', '', 919),
(5, 2, 2, 20, 5, 'Belanja Pemeliharan Jembatan', '', 920),
(5, 2, 2, 20, 6, 'Belanja Pemeliharan Aset Tetap Lainnya', '', 921),
(5, 2, 2, 21, 1, 'Belanja Jasa Konsultansi Penelitian', '', 922),
(5, 2, 2, 21, 2, 'Belanja Jasa Konsultansi Perencanaan', '', 923),
(5, 2, 2, 21, 3, 'Belanja Jasa Konsultansi Pengawasan', '', 924),
(5, 2, 2, 22, 1, 'Belanja Barang Dana BOS', '', 925),
(5, 2, 2, 23, 1, 'Belanja Barang Yang Akan Diserahkan Kepada Masyarakat', '', 926),
(5, 2, 2, 23, 2, 'Belanja Barang Yang Akan Diserahkan Kepada Pihak Ketiga', '', 927),
(5, 2, 2, 24, 1, 'Belanja Barang Yang Akan Dijual Kepada Masyarakat', '', 928),
(5, 2, 2, 24, 2, 'Belanja Barang Yang Akan Dijual Kepada Pihak Ketiga', '', 929),
(5, 2, 3, 1, 1, 'Belanja Modal Tanah - Pengadaan Tanah Kampung', '', 930),
(5, 2, 3, 1, 2, 'Belanja Modal Tanah - Pengadaan Tanah Emplasmen', '', 931),
(5, 2, 3, 1, 3, 'Belanja Modal Tanah - Pengadaan Tanah Kuburan', '', 932),
(5, 2, 3, 2, 1, 'Belanja Modal Tanah - Pengadaan Tanah Sawah Satu Tahun Ditanami', '', 933),
(5, 2, 3, 2, 2, 'Belanja Modal Tanah - Pengadaan Tanah Tegalan', '', 934),
(5, 2, 3, 2, 3, 'Belanja Modal Tanah - Pengadaan Tanah Ladang', '', 935),
(5, 2, 3, 3, 1, 'Belanja Modal Tanah - Pengadaan Tanah Perkebunan', '', 936),
(5, 2, 3, 4, 1, 'Belanja Modal Tanah - Pengadaan Bidang Tanah Kebun Yang Tidak Ada Jaringan Pengairan', '', 937),
(5, 2, 3, 4, 2, 'Belanja Modal Tanah - Pengadaan Kebun Tumbuh Liar Bercampur Jenis Lain', '', 938),
(5, 2, 3, 5, 1, 'Belanja Modal Tanah - Pengadaan Hutan Lebat', '', 939),
(5, 2, 3, 5, 2, 'Belanja Modal Tanah - Pengadaan Hutan Belukar', '', 940),
(5, 2, 3, 5, 3, 'Belanja Modal Tanah - Pengadaan Hutan Tanaman Jenis', '', 941),
(5, 2, 3, 5, 4, 'Belanja Modal Tanah - Pengadaan Hutan Alam Sejenis/Hutan Rawa', '', 942),
(5, 2, 3, 5, 5, 'Belanja Modal Tanah - Pengadaan Hutan Untuk Penggunaan Khusus', '', 943),
(5, 2, 3, 6, 1, 'Belanja Modal Tanah - Pengadaan Kolam Ikan Tambak', '', 944),
(5, 2, 3, 6, 2, 'Belanja Modal Tanah - Pengadaan Kolam Ikan Air Tawar', '', 945),
(5, 2, 3, 7, 1, 'Belanja Modal Tanah - Pengadaan Tanah Rawa', '', 946),
(5, 2, 3, 7, 2, 'Belanja Modal Tanah - Pengadaan Tanah Danau', '', 947),
(5, 2, 3, 8, 1, 'Belanja Modal Tanah - Pengadaan Tanah Tandus', '', 948),
(5, 2, 3, 8, 2, 'Belanja Modal Tanah - Pengadaan Tanah Rusak', '', 949),
(5, 2, 3, 9, 1, 'Belanja Modal Tanah - Pengadaan Tanah Alang-alang', '', 950),
(5, 2, 3, 9, 2, 'Belanja Modal Tanah - Pengadaan Tanah Padang Rumput', '', 951),
(5, 2, 3, 10, 1, 'Belanja Modal Tanah - Pengadaan Tanah Penggalian', '', 952),
(5, 2, 3, 11, 1, 'Belanja Modal Tanah - Pengadaan Tanah Bangunan Perumahan/G. Tempat Tinggal', '', 953),
(5, 2, 3, 11, 2, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Bangunan Gedung Perdagangan/Perusahaan', '', 954),
(5, 2, 3, 11, 3, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Bangunan Industri', '', 955),
(5, 2, 3, 11, 4, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Bangunan Tempat Kerja/Jasa', '', 956),
(5, 2, 3, 11, 5, 'Belanja Modal Tanah - Pengadaan Tanah Kosong', '', 957),
(5, 2, 3, 11, 6, 'Belanja Modal Tanah - Pengadaan Tanah Peternakan', '', 958),
(5, 2, 3, 11, 7, 'Belanja Modal Tanah - Pengadaan Tanah Bangunan Pengairan', '', 959),
(5, 2, 3, 11, 8, 'Belanja Modal Tanah - Pengadaan Tanah Bangunan Jalan dan Jembatan', '', 960),
(5, 2, 3, 11, 9, 'Belanja Modal Tanah - Pengadaan Tanah Lembiran/Bantaran/Lepe-lepe/Setren dst', '', 961),
(5, 2, 3, 12, 1, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Pertambangan', '', 962),
(5, 2, 3, 13, 1, 'Belanja Modal Tanah - Pengadaan Tanah Lapangan Olah Raga', '', 963),
(5, 2, 3, 13, 2, 'Belanja Modal Tanah - Pengadaan Tanah Lapangan Parkir', '', 964),
(5, 2, 3, 13, 3, 'Belanja Modal Tanah - Pengadaan Tanah Lapangan Penimbun Barang', '', 965),
(5, 2, 3, 13, 4, 'Belanja Modal Tanah - Pengadaan Tanah Lapangan Pemancar dan Studio Alam', '', 966),
(5, 2, 3, 13, 5, 'Belanja Modal Tanah - Pengadaan Tanah Lapangan Pengujian/Pengolahan', '', 967),
(5, 2, 3, 13, 6, 'Belanja Modal Tanah - Pengadaan Tanah Lapangan Terbang', '', 968),
(5, 2, 3, 13, 7, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Bangunan Jalan', '', 969),
(5, 2, 3, 13, 8, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Bangunan Air', '', 970),
(5, 2, 3, 13, 9, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Bangunan Instalasi', '', 971),
(5, 2, 3, 13, 10, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Bangunan Jaringan', '', 972),
(5, 2, 3, 13, 11, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Bangunan Bersejarah', '', 973),
(5, 2, 3, 13, 12, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Bangunan Gedung Olah Raga', '', 974),
(5, 2, 3, 13, 13, 'Belanja Modal Tanah - Pengadaan Tanah Untuk Bangunan Tempat Ibadah', '', 975),
(5, 2, 3, 14, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Tractor', '', 976),
(5, 2, 3, 14, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Grader', '', 977),
(5, 2, 3, 14, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Excavator', '', 978),
(5, 2, 3, 14, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Pile Driver', '', 979),
(5, 2, 3, 14, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Hauler', '', 980),
(5, 2, 3, 14, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Asphal Equipment', '', 981),
(5, 2, 3, 14, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Compacting Equipment', '', 982),
(5, 2, 3, 14, 8, 'Belanja Modal Peralatan dan Mesin - Pengadaan Aggregate & Concrete Equipment', '', 983),
(5, 2, 3, 14, 9, 'Belanja Modal Peralatan dan Mesin - Pengadaan Loader', '', 984),
(5, 2, 3, 14, 10, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Pengangkat', '', 985),
(5, 2, 3, 14, 11, 'Belanja Modal Peralatan dan Mesin - Pengadaan Mesin Proses', '', 986),
(5, 2, 3, 15, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Dredger', '', 987),
(5, 2, 3, 15, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Floating Excavator', '', 988),
(5, 2, 3, 15, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Amphibi Dredger', '', 989),
(5, 2, 3, 15, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kapal Tarik', '', 990),
(5, 2, 3, 15, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Mesin Proses Agung', '', 991),
(5, 2, 3, 16, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Penarik', '', 992),
(5, 2, 3, 16, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Feeder', '', 993),
(5, 2, 3, 16, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Compressor', '', 994),
(5, 2, 3, 16, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Electric Generating Set', '', 995),
(5, 2, 3, 16, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Pompa', '', 996),
(5, 2, 3, 16, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Mesin Bor', '', 997),
(5, 2, 3, 16, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Unit Pemeliharaan Lapangan', '', 998),
(5, 2, 3, 16, 8, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Pengolahan Air Kotor', '', 999),
(5, 2, 3, 16, 9, 'Belanja Modal Peralatan dan Mesin - Pengadaan Pembangkit Uap Air Panas/Sistem Generator', '', 1000),
(5, 2, 3, 17, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kendaraan Dinas Bermotor Perorangan', '', 1001),
(5, 2, 3, 17, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kendaraan Bermotor Penumpang', '', 1002),
(5, 2, 3, 17, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kendaraan Bermotor Angkutan Barang', '', 1003),
(5, 2, 3, 17, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kendaraan Bermotor Khusus', '', 1004),
(5, 2, 3, 17, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kendaraan Bermotor Beroda Dua', '', 1005),
(5, 2, 3, 17, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kendaraan Bermotor Beroda Tiga', '', 1006),
(5, 2, 3, 18, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kendaraan Bermotor Angkutan Barang', '', 1007),
(5, 2, 3, 18, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kendaraan Tak Bermotor Berpenumpang', '', 1008),
(5, 2, 3, 19, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Angkut Apung Bermotor Barang', '', 1009),
(5, 2, 3, 19, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Angkut Apung Bermotor Penumpang', '', 1010),
(5, 2, 3, 19, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Angkut Apung Bermotor Khusus', '', 1011),
(5, 2, 3, 20, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Angkut Apung Tak Bermotor Untuk Barang', '', 1012),
(5, 2, 3, 20, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Angkut Apung Tak Bermotor Penumpang', '', 1013),
(5, 2, 3, 20, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Angkut Apung Tak Bermotor Khusus', '', 1014),
(5, 2, 3, 21, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kapal Terbang', '', 1015),
(5, 2, 3, 22, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Konstruksi Logam Terpasang pada Pondasi', '', 1016),
(5, 2, 3, 22, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Konstruksi Logam yang Berpindah', '', 1017),
(5, 2, 3, 22, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Bengkel Listrik', '', 1018),
(5, 2, 3, 22, 4, 'Belanja Modal Peralatan dan Mesin - Perkakas Bengkel Service', '', 1019),
(5, 2, 3, 22, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Pengangkat Bermesin', '', 1020),
(5, 2, 3, 22, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Bengkel Kayu', '', 1021),
(5, 2, 3, 22, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Bengkel Khusus', '', 1022),
(5, 2, 3, 22, 8, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Las', '', 1023),
(5, 2, 3, 22, 9, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Pabrik Es', '', 1024),
(5, 2, 3, 23, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Bengkel Konstruksi Logam', '', 1025),
(5, 2, 3, 23, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Bengkel Listrik', '', 1026),
(5, 2, 3, 23, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Bengkel Service', '', 1027),
(5, 2, 3, 23, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Pengangkat', '', 1028),
(5, 2, 3, 23, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Standar (Standart Tool)', '', 1029),
(5, 2, 3, 23, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Khusus (Special Tool)', '', 1030),
(5, 2, 3, 23, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Perkakas Bengkel Kerja', '', 1031),
(5, 2, 3, 23, 8, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Tukang-tukang Besi', '', 1032),
(5, 2, 3, 23, 9, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Tukang Kayu', '', 1033),
(5, 2, 3, 23, 10, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Tukang Kulit', '', 1034),
(5, 2, 3, 23, 11, 'Belanja Modal Peralatan dan Mesin - PengadaanPeralatan Ukur, Gip & Feting', '', 1035),
(5, 2, 3, 24, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Ukur Universal', '', 1036),
(5, 2, 3, 24, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Ukur/Test Intelegensia', '', 1037),
(5, 2, 3, 24, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Ukur/Test Alat Kepribadian', '', 1038),
(5, 2, 3, 24, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Ukur /Test Klinis Lain', '', 1039),
(5, 2, 3, 24, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kalibrasi', '', 1040),
(5, 2, 3, 24, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Oscilloscope', '', 1041),
(5, 2, 3, 24, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Universal Tester', '', 1042),
(5, 2, 3, 24, 8, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Ukur/Pembanding', '', 1043),
(5, 2, 3, 24, 9, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Ukur Lainnya', '', 1044),
(5, 2, 3, 24, 10, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Timbangan/Blora', '', 1045),
(5, 2, 3, 24, 11, 'Belanja Modal Peralatan dan Mesin - Pengadaan Anak Timbangan/Biasa', '', 1046),
(5, 2, 3, 24, 12, 'Belanja Modal Peralatan dan Mesin - Pengadaan Takaran Kering', '', 1047),
(5, 2, 3, 24, 13, 'Belanja Modal Peralatan dan Mesin - Pengadaan Takaran Bahan Bangunan 2 HL', '', 1048),
(5, 2, 3, 24, 14, 'Belanja Modal Peralatan dan Mesin - Pengadaan Takaran Latex/Getah Susu', '', 1049),
(5, 2, 3, 24, 15, 'Belanja Modal Peralatan dan Mesin - Pengadaan Gelas Takar Berbagai Kapasitas', '', 1050),
(5, 2, 3, 25, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Pengolahan Tanah dan Tanaman', '', 1051),
(5, 2, 3, 25, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Panen/Pengolahan', '', 1052),
(5, 2, 3, 25, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat-Alat Peternakan', '', 1053),
(5, 2, 3, 25, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Penyimpanan Hasil Percobaan Pertanian', '', 1054),
(5, 2, 3, 25, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Pertanian', '', 1055),
(5, 2, 3, 25, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Procesing', '', 1056),
(5, 2, 3, 25, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Pasca Panen', '', 1057),
(5, 2, 3, 25, 8, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Pengolahan Produksi Perikanan', '', 1058),
(5, 2, 3, 26, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Pemeliharaan Tanaman', '', 1059),
(5, 2, 3, 26, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Panen', '', 1060),
(5, 2, 3, 26, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Penyimpanan', '', 1061),
(5, 2, 3, 26, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium', '', 1062),
(5, 2, 3, 26, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Penangkap Ikan', '', 1063),
(5, 2, 3, 27, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Mesin Ketik', '', 1064),
(5, 2, 3, 27, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Mesin Hitung/Jumlah', '', 1065),
(5, 2, 3, 27, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Reproduksi (Pengganda)', '', 1066),
(5, 2, 3, 27, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Penyimpanan Perlengkapan Kantor', '', 1067),
(5, 2, 3, 27, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kantor Lainnya', '', 1068),
(5, 2, 3, 28, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Meubelair', '', 1069),
(5, 2, 3, 28, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Pengukur Waktu', '', 1070),
(5, 2, 3, 28, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Pembersih', '', 1071),
(5, 2, 3, 28, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Pendingin', '', 1072),
(5, 2, 3, 28, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Dapur', '', 1073),
(5, 2, 3, 28, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Rumah Tangga Lainnya (Home Use)', '', 1074),
(5, 2, 3, 28, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Pemadam Kebakaran', '', 1075),
(5, 2, 3, 29, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Komputer Unit Jaringan', '', 1076),
(5, 2, 3, 29, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Personal Komputer', '', 1077),
(5, 2, 3, 29, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Komputer Mainframe', '', 1078),
(5, 2, 3, 29, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Mini Komputer', '', 1079),
(5, 2, 3, 29, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Personal Komputer', '', 1080),
(5, 2, 3, 29, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Jaringan', '', 1081),
(5, 2, 3, 30, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Meja Kerja Pejabat', '', 1082),
(5, 2, 3, 30, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Meja Rapat Pejabat', '', 1083),
(5, 2, 3, 30, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kursi Kerja Pejabat', '', 1084),
(5, 2, 3, 30, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kursi Rapat Pejabat', '', 1085),
(5, 2, 3, 30, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kursi Hadap Depan Meja Kerja Pejabat', '', 1086),
(5, 2, 3, 30, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Kursi Tamu di Ruangan Pejabat', '', 1087),
(5, 2, 3, 30, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Lemari dan Arsip Pejabat', '', 1088),
(5, 2, 3, 31, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Studio Visual', '', 1089),
(5, 2, 3, 31, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Studio Video dan Film', '', 1090),
(5, 2, 3, 31, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Studio Video dan Film A', '', 1091),
(5, 2, 3, 31, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Cetak', '', 1092),
(5, 2, 3, 31, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Computing', '', 1093),
(5, 2, 3, 31, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Pemetaan Ukur', '', 1094),
(5, 2, 3, 32, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Komunikasi Telephone', '', 1095),
(5, 2, 3, 32, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Komunikasi Radio SSB', '', 1096),
(5, 2, 3, 32, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Komunikasi Radio HF/FM', '', 1097),
(5, 2, 3, 32, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Komunikasi Radio VHF', '', 1098),
(5, 2, 3, 32, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Komunikasi Radio UHF', '', 1099),
(5, 2, 3, 32, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Komunikasi Sosial', '', 1100),
(5, 2, 3, 32, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat-alat Sandi', '', 1101),
(5, 2, 3, 33, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Pemancar MF/MW', '', 1102),
(5, 2, 3, 33, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Pemancar HF/SW', '', 1103),
(5, 2, 3, 33, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Pemancar VHF/FM', '', 1104),
(5, 2, 3, 33, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Pemancar UHF', '', 1105),
(5, 2, 3, 33, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Pemancar SHF', '', 1106),
(5, 2, 3, 33, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Antena MF/MW', '', 1107),
(5, 2, 3, 33, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Antena HF/SW', '', 1108),
(5, 2, 3, 33, 8, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Antena VHF/FM', '', 1109),
(5, 2, 3, 33, 9, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Antena UHF', '', 1110),
(5, 2, 3, 33, 10, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Antena SHF/Parabola', '', 1111),
(5, 2, 3, 33, 11, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Translator VHF/VHF', '', 1112),
(5, 2, 3, 33, 12, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Translator UHF/UHF', '', 1113),
(5, 2, 3, 33, 13, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Translator VHF/UHF', '', 1114),
(5, 2, 3, 33, 14, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Translator UHF/VHF', '', 1115),
(5, 2, 3, 33, 15, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Microvawe FPU', '', 1116),
(5, 2, 3, 33, 16, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Microvawe Terestrial', '', 1117),
(5, 2, 3, 33, 17, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Microvawe TVRO', '', 1118),
(5, 2, 3, 33, 18, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Dummy Load', '', 1119),
(5, 2, 3, 33, 19, 'Belanja Modal Peralatan dan Mesin - Pengadaan Switcher Antena', '', 1120),
(5, 2, 3, 33, 20, 'Belanja Modal Peralatan dan Mesin - Pengadaan Switcher/Menara Antena', '', 1121),
(5, 2, 3, 33, 21, 'Belanja Modal Peralatan dan Mesin - Pengadaan Feeder', '', 1122),
(5, 2, 3, 33, 22, 'Belanja Modal Peralatan dan Mesin - Pengadaan Humitity Control', '', 1123),
(5, 2, 3, 33, 23, 'Belanja Modal Peralatan dan Mesin - Pengadaan Program Input Equipment', '', 1124),
(5, 2, 3, 33, 24, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Antena Penerima VHF', '', 1125),
(5, 2, 3, 34, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Umum', '', 1126),
(5, 2, 3, 34, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Gigi', '', 1127),
(5, 2, 3, 34, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Keluarga Berencana', '', 1128),
(5, 2, 3, 34, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Mata', '', 1129),
(5, 2, 3, 34, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran T.H.T', '', 1130),
(5, 2, 3, 34, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Rotgen', '', 1131),
(5, 2, 3, 34, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Farmasi', '', 1132),
(5, 2, 3, 34, 8, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat-Alat Kedokteran Bedah', '', 1133),
(5, 2, 3, 34, 9, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kesehatan Kebidanan dan Penyakit Kandungan', '', 1134),
(5, 2, 3, 34, 10, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Bagian penyakit Dalam', '', 1135),
(5, 2, 3, 34, 11, 'Belanja Modal Peralatan dan Mesin - Pengadaan Mortuary', '', 1136),
(5, 2, 3, 34, 12, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kesehatan Anak', '', 1137),
(5, 2, 3, 34, 13, 'Belanja Modal Peralatan dan Mesin - Pengadaan Poliklinik Set', '', 1138),
(5, 2, 3, 34, 14, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Penderita Cacat Tubuh', '', 1139),
(5, 2, 3, 34, 15, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Neurologi (syaraf)', '', 1140),
(5, 2, 3, 34, 16, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Jantung', '', 1141),
(5, 2, 3, 34, 17, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Nuklir', '', 1142),
(5, 2, 3, 34, 18, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Radiologi', '', 1143),
(5, 2, 3, 34, 19, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Kulit dan Kelamin', '', 1144),
(5, 2, 3, 34, 20, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Gawat Darurat', '', 1145),
(5, 2, 3, 34, 21, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Jiwa', '', 1146),
(5, 2, 3, 34, 22, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kedokteran Hewan', '', 1147),
(5, 2, 3, 35, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kesehatan Perawatan', '', 1148),
(5, 2, 3, 35, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kesehatan Rehabilitasi Medis', '', 1149),
(5, 2, 3, 35, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kesehatan Matra Laut', '', 1150),
(5, 2, 3, 35, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kesehatan Matra Udara', '', 1151),
(5, 2, 3, 35, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kesehatan Kedokteran Kepolisian', '', 1152),
(5, 2, 3, 35, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kesehatan Olahraga', '', 1153),
(5, 2, 3, 36, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Kimia Air', '', 1154),
(5, 2, 3, 36, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Microbiologi', '', 1155),
(5, 2, 3, 36, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Hidro Kimia', '', 1156),
(5, 2, 3, 36, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Model/Hidrolika', '', 1157),
(5, 2, 3, 36, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat laboratorium Buatan/Geologi', '', 1158),
(5, 2, 3, 36, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Bahan Bangunan Konstruksi', '', 1159),
(5, 2, 3, 36, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Aspal Cat & Kimia', '', 1160),
(5, 2, 3, 36, 8, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat laboratorium Mekanik Tanah dan Batuan', '', 1161),
(5, 2, 3, 36, 9, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Cocok Tanam', '', 1162),
(5, 2, 3, 36, 10, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Logam, Mesin, Listrik', '', 1163),
(5, 2, 3, 36, 11, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Logam, Mesin Listrik A', '', 1164),
(5, 2, 3, 36, 12, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Umum', '', 1165),
(5, 2, 3, 36, 13, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Umum A', '', 1166),
(5, 2, 3, 36, 14, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Kedokteran', '', 1167),
(5, 2, 3, 36, 15, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Microbiologi', '', 1168),
(5, 2, 3, 36, 16, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Kimia', '', 1169),
(5, 2, 3, 36, 17, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Microbiologi A', '', 1170),
(5, 2, 3, 36, 18, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Patologi', '', 1171),
(5, 2, 3, 36, 19, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Immunologi', '', 1172),
(5, 2, 3, 36, 20, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Hematologi', '', 1173),
(5, 2, 3, 36, 21, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Film', '', 1174),
(5, 2, 3, 36, 22, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Makanan', '', 1175),
(5, 2, 3, 36, 23, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Standarisasi, Kalibrasi dan Instrumentasi', '', 1176),
(5, 2, 3, 36, 24, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Farmasi', '', 1177),
(5, 2, 3, 36, 25, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Fisika', '', 1178),
(5, 2, 3, 36, 26, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Hidrodinamika', '', 1179),
(5, 2, 3, 36, 27, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Klimatologi', '', 1180),
(5, 2, 3, 36, 28, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Proses Peleburan', '', 1181),
(5, 2, 3, 36, 29, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Pasir', '', 1182),
(5, 2, 3, 36, 30, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Proses Pembuatan Cetakan', '', 1183),
(5, 2, 3, 36, 31, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Proses Pembuatan Pola', '', 1184),
(5, 2, 3, 36, 32, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Metalography', '', 1185),
(5, 2, 3, 36, 33, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Proses Pengelasan', '', 1186),
(5, 2, 3, 36, 34, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Uji Proses Pengelasan', '', 1187),
(5, 2, 3, 36, 35, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Proses Pembuatan Logam', '', 1188),
(5, 2, 3, 36, 36, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Matrologie', '', 1189),
(5, 2, 3, 36, 37, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Proses Pelapisan Logam', '', 1190),
(5, 2, 3, 36, 38, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Proses Pengolahan Panas', '', 1191),
(5, 2, 3, 36, 39, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Proses Teknologi Textil', '', 1192),
(5, 2, 3, 36, 40, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Uji Tekstel', '', 1193),
(5, 2, 3, 36, 41, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Proses Teknologi Keramik', '', 1194),
(5, 2, 3, 36, 42, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Proses Teknologi Kulit Karet', '', 1195),
(5, 2, 3, 36, 43, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Uji Kulit, Karet dan Plastik', '', 1196),
(5, 2, 3, 36, 44, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Uji Keramik', '', 1197),
(5, 2, 3, 36, 45, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Proses Teknologi Selulosa', '', 1198),
(5, 2, 3, 36, 46, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Pertanian', '', 1199),
(5, 2, 3, 36, 47, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Pertanian A', '', 1200),
(5, 2, 3, 36, 48, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Pertanian B', '', 1201),
(5, 2, 3, 36, 49, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Elektronika dan Daya', '', 1202),
(5, 2, 3, 36, 50, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium energi Surya', '', 1203),
(5, 2, 3, 36, 51, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Konversi Batubara dan Biomas', '', 1204),
(5, 2, 3, 36, 52, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Oceanografi', '', 1205),
(5, 2, 3, 36, 53, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Lingkungan Perairan', '', 1206),
(5, 2, 3, 36, 54, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Biologi Peralatan', '', 1207),
(5, 2, 3, 36, 55, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Biologi', '', 1208),
(5, 2, 3, 36, 56, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Geofisika', '', 1209),
(5, 2, 3, 36, 57, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Tambang', '', 1210),
(5, 2, 3, 36, 58, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Proses/Teknik Kimia', '', 1211),
(5, 2, 3, 36, 59, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Proses Industri', '', 1212),
(5, 2, 3, 36, 60, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Kesehatan Kerja', '', 1213),
(5, 2, 3, 36, 61, 'Belanja Modal Peralatan dan Mesin - Pengadaan Laboratorium Kearsipan', '', 1214),
(5, 2, 3, 36, 62, 'Belanja Modal Peralatan dan Mesin - Pengadaan Laboratorium Hematologi & Urinalisis', '', 1215),
(5, 2, 3, 36, 63, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Lainnya', '', 1216),
(5, 2, 3, 36, 64, 'Belanja Modal Peralatan dan Mesin - Pengadaan Laboratorium Hematologi & Urinalisis A', '', 1217),
(5, 2, 3, 37, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Bidang Studi : Bahasa Indonesia', '', 1218),
(5, 2, 3, 37, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Bidang Studi : Matematika', '', 1219),
(5, 2, 3, 37, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Bidang Studi : IPA Dasar', '', 1220),
(5, 2, 3, 37, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Bidang Studi : IPA Lanjutan', '', 1221),
(5, 2, 3, 37, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Bidang Studi : IPA Menengah', '', 1222),
(5, 2, 3, 37, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Bidang Studi : IPA Atas', '', 1223),
(5, 2, 3, 37, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Bidang Studi : IPS', '', 1224),
(5, 2, 3, 37, 8, 'Belanja Modal Peralatan dan Mesin - Pengadaan Bidang Studi : Agama Islam', '', 1225),
(5, 2, 3, 37, 9, 'Belanja Modal Peralatan dan Mesin - Pengadaan Bidang Studi : Ketrampilan', '', 1226),
(5, 2, 3, 37, 10, 'Belanja Modal Peralatan dan Mesin - Pengadaan Bidang Studi : Kesenian', '', 1227),
(5, 2, 3, 37, 11, 'Belanja Modal Peralatan dan Mesin - Pengadaan Bidang Studi : Olah Raga', '', 1228),
(5, 2, 3, 37, 12, 'Belanja Modal Peralatan dan Mesin - Pengadaan Bidang Studi : PMP', '', 1229),
(5, 2, 3, 37, 13, 'Belanja Modal Peralatan dan Mesin - Pengadaan Bidang Pendidikan/Ketrampilan Lain-lain', '', 1230),
(5, 2, 3, 38, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Analytical instrument', '', 1231),
(5, 2, 3, 38, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Instrument Probe/Sensor', '', 1232),
(5, 2, 3, 38, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan General Laboratory Tool', '', 1233),
(5, 2, 3, 38, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Instrument Probe/Sensor A', '', 1234),
(5, 2, 3, 38, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Glassware Plastic/Utensils', '', 1235),
(5, 2, 3, 38, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Laboratory Safety Equipment', '', 1236),
(5, 2, 3, 39, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Radiation Detector', '', 1237),
(5, 2, 3, 39, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Modular Counting and Scentific', '', 1238),
(5, 2, 3, 39, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Assembly/Accounting System', '', 1239),
(5, 2, 3, 39, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Recorder Display', '', 1240),
(5, 2, 3, 39, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan System/Power Supply', '', 1241),
(5, 2, 3, 39, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Measuring / Testing Device', '', 1242),
(5, 2, 3, 39, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Opto Electronics', '', 1243),
(5, 2, 3, 39, 8, 'Belanja Modal Peralatan dan Mesin - Pengadaan Accelator', '', 1244),
(5, 2, 3, 39, 9, 'Belanja Modal Peralatan dan Mesin - Pengadaan Reactor Expermental System', '', 1245),
(5, 2, 3, 40, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Ukur Fisika Kesehatan', '', 1246),
(5, 2, 3, 40, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Kesehatan Kerja', '', 1247),
(5, 2, 3, 40, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Proteksi Lingkungan', '', 1248),
(5, 2, 3, 40, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Meteorological Equipment', '', 1249),
(5, 2, 3, 40, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Sumber Radiasi', '', 1250),
(5, 2, 3, 41, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Radiation Application Equipment', '', 1251),
(5, 2, 3, 41, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Non Destructive Test (NDT) Device', '', 1252),
(5, 2, 3, 41, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Umum Kedoteran /Klinik Nuklir', '', 1253),
(5, 2, 3, 41, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Hidrologi', '', 1254),
(5, 2, 3, 42, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat laboratorium Kualitas Air dan tanah', '', 1255),
(5, 2, 3, 42, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Kualitas Udara', '', 1256),
(5, 2, 3, 42, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Kebisingan dan Getaran', '', 1257),
(5, 2, 3, 42, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Laboratorium Lingkungan', '', 1258),
(5, 2, 3, 42, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Laboratorium Penunjang', '', 1259),
(5, 2, 3, 43, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Laboratorium Hidrodinamika Towing Carriage', '', 1260),
(5, 2, 3, 43, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Laboratorium Hidrodinamika Wave Generator and Absorber', '', 1261),
(5, 2, 3, 43, 3, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan Laboratorium Hidrodinamika Data Accquistion and Analyzing System', '', 1262),
(5, 2, 3, 43, 4, 'Belanja Modal Peralatan dan Mesin - Pengadaan Cavitation Tunnel', '', 1263),
(5, 2, 3, 43, 5, 'Belanja Modal Peralatan dan Mesin - Pengadaan Overhead Cranes', '', 1264),
(5, 2, 3, 43, 6, 'Belanja Modal Peralatan dan Mesin - Pengadaan Peralatan umum', '', 1265),
(5, 2, 3, 43, 7, 'Belanja Modal Peralatan dan Mesin - Pengadaan Pemesinan : Model Ship Workshop', '', 1266),
(5, 2, 3, 43, 8, 'Belanja Modal Peralatan dan Mesin - Pengadaan Pemesinan : Propeller Model Workshop', '', 1267),
(5, 2, 3, 43, 9, 'Belanja Modal Peralatan dan Mesin - Pengadaan Pemesinan : Mechanical Workshop', '', 1268),
(5, 2, 3, 43, 10, 'Belanja Modal Peralatan dan Mesin - Pengadaan Pemesinan : Precision Mechanical Workshop', '', 1269),
(5, 2, 3, 43, 11, 'Belanja Modal Peralatan dan Mesin - Pengadaan Pemesinan Painting Shop', '', 1270),
(5, 2, 3, 43, 12, 'Belanja Modal Peralatan dan Mesin - Pengadaan Pemesinan : Ship Model Preparation Shop', '', 1271),
(5, 2, 3, 43, 13, 'Belanja Modal Peralatan dan Mesin - Pengadaan Pemesinan : Electrical Workshop', '', 1272),
(5, 2, 3, 43, 14, 'Belanja Modal Peralatan dan Mesin - Pengadaan MOB', '', 1273),
(5, 2, 3, 43, 15, 'Belanja Modal Peralatan dan Mesin - Pengadaan Photo and Film Equipment', '', 1274),
(5, 2, 3, 44, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Senjata Genggam', '', 1275),
(5, 2, 3, 44, 2, 'Belanja Modal Peralatan dan Mesin - Senjata Pinggang', '', 1276),
(5, 2, 3, 44, 3, 'Belanja Modal Peralatan dan Mesin - Senjata Bahu/Senjata Laras Panjang', '', 1277),
(5, 2, 3, 44, 4, 'Belanja Modal Peralatan dan Mesin - Senapan Mesin', '', 1278),
(5, 2, 3, 44, 5, 'Belanja Modal Peralatan dan Mesin - Mortir', '', 1279),
(5, 2, 3, 44, 6, 'Belanja Modal Peralatan dan Mesin - Anti Lapis Baja', '', 1280),
(5, 2, 3, 44, 7, 'Belanja Modal Peralatan dan Mesin -Artileri Medan (Armed)', '', 1281),
(5, 2, 3, 44, 8, 'Belanja Modal Peralatan dan Mesin -Artileri Pertahanan Udara (Arhanud)', '', 1282),
(5, 2, 3, 44, 9, 'Belanja Modal Peralatan dan Mesin -Peluru Kendali/Rudal', '', 1283),
(5, 2, 3, 44, 10, 'Belanja Modal Peralatan dan Mesin -Kavaleri', '', 1284),
(5, 2, 3, 44, 11, 'Belanja Modal Peralatan dan Mesin -Senjata Lain-lain', '', 1285),
(5, 2, 3, 45, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Alat Keamanan', '', 1286),
(5, 2, 3, 45, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Non Senjata Api', '', 1287),
(5, 2, 3, 46, 1, 'Belanja Modal Peralatan dan Mesin - Pengadaan Amunisi Umum', '', 1288),
(5, 2, 3, 46, 2, 'Belanja Modal Peralatan dan Mesin - Pengadaan Amunisi Darat', '', 1289),
(5, 2, 3, 47, 1, 'Belanja Modal Peralatan dan Mesin -Pengadaan Laser', '', 1290),
(5, 2, 3, 48, 1, 'Belanja Modal Peralatan dan Mesin -Pengadaan Alat Bantu Kemanan', '', 1291),
(5, 2, 3, 48, 2, 'Belanja Modal Peralatan dan Mesin -Pengadaan Alat Perlindungan', '', 1292),
(5, 2, 3, 49, 1, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Kantor', '', 1293),
(5, 2, 3, 49, 2, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gudang', '', 1294),
(5, 2, 3, 49, 3, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gudang Untuk Bengkel', '', 1295),
(5, 2, 3, 49, 4, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Instalasi', '', 1296),
(5, 2, 3, 49, 5, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Laboratorium', '', 1297),
(5, 2, 3, 49, 6, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Kesehatan', '', 1298),
(5, 2, 3, 49, 7, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Oceanarium/Opservatorium', '', 1299),
(5, 2, 3, 49, 8, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Tempat Ibadah', '', 1300),
(5, 2, 3, 49, 9, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Tempat Pertemuan', '', 1301),
(5, 2, 3, 49, 10, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Tempat Pendidikan', '', 1302),
(5, 2, 3, 49, 11, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Tempat Olah Raga', '', 1303),
(5, 2, 3, 49, 12, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Pertokoan/Koperasi/Pasar', '', 1304),
(5, 2, 3, 49, 13, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Untuk Pos Jaga', '', 1305),
(5, 2, 3, 49, 14, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Garasi/Pool', '', 1306),
(5, 2, 3, 49, 15, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Pemotongan Hewan', '', 1307),
(5, 2, 3, 49, 16, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Pabrik', '', 1308),
(5, 2, 3, 49, 17, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Stasiun Bus', '', 1309),
(5, 2, 3, 49, 18, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Kandang Hewan/Ternak', '', 1310),
(5, 2, 3, 49, 19, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Perpustakaan', '', 1311),
(5, 2, 3, 49, 20, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Museum', '', 1312),
(5, 2, 3, 49, 21, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Terminal/Pelabuhan/Bandar', '', 1313),
(5, 2, 3, 49, 22, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Pengujian Kelaikan', '', 1314),
(5, 2, 3, 49, 23, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Lembaga Pemasyarakatan', '', 1315),
(5, 2, 3, 49, 24, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Rumah Tahanan', '', 1316),
(5, 2, 3, 49, 25, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Kramatorium', '', 1317),
(5, 2, 3, 49, 26, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Pembakaran Bangkai Hewan', '', 1318),
(5, 2, 3, 49, 27, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Gedung Tempat Kerja Lainnya', '', 1319),
(5, 2, 3, 50, 1, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Rumah Negara Golongan I', '', 1320),
(5, 2, 3, 50, 2, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Rumah Negara Golongan II', '', 1321),
(5, 2, 3, 50, 3, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Rumah Negara Goloongan III', '', 1322),
(5, 2, 3, 50, 4, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Mess/Wisma/Bungalow/Tempat Peristirahatan', '', 1323),
(5, 2, 3, 50, 5, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Asrama', '', 1324),
(5, 2, 3, 50, 6, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Hotel', '', 1325),
(5, 2, 3, 50, 7, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Motel', '', 1326),
(5, 2, 3, 50, 8, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Flat/Rumah Susun', '', 1327),
(5, 2, 3, 51, 1, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Menara Perambuan Penerang Pantai', '', 1328),
(5, 2, 3, 51, 2, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Perambut Penerangan Pantai Tidak Bermenara', '', 1329),
(5, 2, 3, 51, 3, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Menara Telekomunikasi', '', 1330),
(5, 2, 3, 52, 1, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Istana Peringatan', '', 1331),
(5, 2, 3, 52, 2, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Rumah Adat', '', 1332),
(5, 2, 3, 52, 3, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Rumah Peningggalan Sejarah', '', 1333),
(5, 2, 3, 52, 4, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Makam Sejarah', '', 1334),
(5, 2, 3, 52, 5, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Tempat Ibadah Bersejarah', '', 1335),
(5, 2, 3, 53, 1, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Tugu Kemerdekaan', '', 1336),
(5, 2, 3, 53, 2, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Tugu Pembangunan', '', 1337),
(5, 2, 3, 53, 3, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Tugu Peringatan Lainnya', '', 1338),
(5, 2, 3, 54, 1, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Candi Hindhu', '', 1339),
(5, 2, 3, 54, 2, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Candi Budha', '', 1340),
(5, 2, 3, 54, 3, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Candi Lainnya', '', 1341),
(5, 2, 3, 55, 1, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Bersejarah', '', 1342),
(5, 2, 3, 56, 1, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Tugu/Tanda Batas', '', 1343),
(5, 2, 3, 57, 1, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Rambu Bersuar Lalu Lintas Darat', '', 1344),
(5, 2, 3, 57, 2, 'Belanja Modal Gedung dan Bangunan - Pengadaan Bangunan Rambu Tidak Bersuar', '', 1345),
(5, 2, 3, 58, 1, 'Belanja Modal Gedung dan Bangunan - Pengadaan Runway/Threshold Light', '', 1346),
(5, 2, 3, 58, 2, 'Belanja Modal Gedung dan Bangunan - Pengadaan Visual Approach Slope Indicator (VASI)', '', 1347),
(5, 2, 3, 58, 3, 'Belanja Modal Gedung dan Bangunan - Pengadaan Approach Light', '', 1348),
(5, 2, 3, 58, 4, 'Belanja Modal Gedung dan Bangunan - Pengadaan Runway Identification Light(Rells)', '', 1349),
(5, 2, 3, 58, 5, 'Belanja Modal Gedung dan Bangunan - Pengadaan Signal', '', 1350),
(5, 2, 3, 58, 6, 'Belanja Modal Gedung dan Bangunan - Pengadaan Flood Light', '', 1351),
(5, 2, 3, 59, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jalan Negara/Nasional', '', 1352),
(5, 2, 3, 59, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jalan Propinsi', '', 1353),
(5, 2, 3, 59, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jalan Kabupaten/Kota', '', 1354),
(5, 2, 3, 59, 4, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jalan Desa', '', 1355),
(5, 2, 3, 59, 5, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jalan Khusus', '', 1356),
(5, 2, 3, 59, 6, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jalan Tol', '', 1357),
(5, 2, 3, 59, 7, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jalan Kereta', '', 1358),
(5, 2, 3, 59, 8, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Landasan Pacu Pesawat Terbang', '', 1359),
(5, 2, 3, 60, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jembatan Negara/Nasional', '', 1360),
(5, 2, 3, 60, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jembatan Propinsi', '', 1361),
(5, 2, 3, 60, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jembatan Kabupaten/Kota', '', 1362),
(5, 2, 3, 60, 4, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jembatan Desa', '', 1363),
(5, 2, 3, 60, 5, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jembatan Khusus', '', 1364),
(5, 2, 3, 60, 6, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jembatan Pada Jalan Tol', '', 1365),
(5, 2, 3, 60, 7, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jembatan Pada Jalan Kereta Api', '', 1366),
(5, 2, 3, 60, 8, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jembatan Pada Landasan Pacu Pesawat Terbang', '', 1367),
(5, 2, 3, 60, 9, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jembatan Penyeberangan', '', 1368),
(5, 2, 3, 61, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Waduk Irigasi', '', 1369),
(5, 2, 3, 61, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengambilan Irigasi', '', 1370),
(5, 2, 3, 61, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembawa Irigasi', '', 1371),
(5, 2, 3, 61, 4, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembuang Irigasi', '', 1372),
(5, 2, 3, 61, 5, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengaman Irigasi', '', 1373),
(5, 2, 3, 61, 6, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pelengkap Irigasi', '', 1374),
(5, 2, 3, 61, 7, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan/Jaringan Irigasi', '', 1375),
(5, 2, 3, 62, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Waduk Pasang Surut', '', 1376),
(5, 2, 3, 62, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengambilan Pasang Surut', '', 1377),
(5, 2, 3, 62, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembawa Pasang Surut', '', 1378),
(5, 2, 3, 62, 4, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembuang Pasang Surut', '', 1379),
(5, 2, 3, 62, 5, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengaman Pasang Surut', '', 1380),
(5, 2, 3, 62, 6, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pelengkap Pasang Surut', '', 1381),
(5, 2, 3, 62, 7, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Sawah Pasang Surut', '', 1382),
(5, 2, 3, 63, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Air Pengembang Rawa dan Poder', '', 1383),
(5, 2, 3, 63, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengembalian Pasang Rawa', '', 1384),
(5, 2, 3, 63, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembawa Pasang Rawa', '', 1385),
(5, 2, 3, 63, 4, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembuang Pasang Rawa', '', 1386),
(5, 2, 3, 63, 5, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengamanan Pasang Surut', '', 1387),
(5, 2, 3, 63, 6, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pelengkap Pasang Rawa', '', 1388),
(5, 2, 3, 63, 7, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Sawah Pengembangan Rawa', '', 1389),
(5, 2, 3, 64, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Waduk Penanggulangan Sungai', '', 1390),
(5, 2, 3, 64, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengambilan Pengamanan Sungai', '', 1391),
(5, 2, 3, 64, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembuang Pengaman', '', 1392),
(5, 2, 3, 64, 4, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembuang Pengaman Sungai', '', 1393),
(5, 2, 3, 64, 5, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengaman Pengamanan Sungai', '', 1394),
(5, 2, 3, 64, 6, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pelengkap Pengamanan Sungai', '', 1395),
(5, 2, 3, 65, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Waduk Pengembangan Sumber Air', '', 1396),
(5, 2, 3, 65, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengambilan Pengembangan Sumber Air', '', 1397),
(5, 2, 3, 65, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembawa Pengembangan Sumber Air', '', 1398),
(5, 2, 3, 65, 4, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembuang Pengembangan Sumber Air', '', 1399),
(5, 2, 3, 65, 5, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengamanan Pengembangan Sumber Air', '', 1400),
(5, 2, 3, 65, 6, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pelengkap Pengembangan Sumber Air', '', 1401),
(5, 2, 3, 66, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Waduk Air Bersih/Air Baku', '', 1402),
(5, 2, 3, 66, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengambilan Air Bersih/Baku', '', 1403),
(5, 2, 3, 66, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembawa Air Bersih', '', 1404),
(5, 2, 3, 66, 4, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembuang Air Bersih/Air Baku', '', 1405),
(5, 2, 3, 66, 5, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pelengkap Air Bersih/Air Baku', '', 1406),
(5, 2, 3, 67, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembawa Air Kotor', '', 1407);
INSERT INTO `ref_rek_5` (`kd_rek_1`, `kd_rek_2`, `kd_rek_3`, `kd_rek_4`, `kd_rek_5`, `nama_kd_rek_5`, `peraturan`, `id_rekening`) VALUES
(5, 2, 3, 67, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Waduk Air Kotor', '', 1408),
(5, 2, 3, 67, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pembuangan Air Kotor', '', 1409),
(5, 2, 3, 67, 4, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pengaman Air Kotor', '', 1410),
(5, 2, 3, 67, 5, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Pelengkap Air Kotor', '', 1411),
(5, 2, 3, 68, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Air Laut', '', 1412),
(5, 2, 3, 68, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Bangunan Air Tawar', '', 1413),
(5, 2, 3, 69, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Air Muka Tanah', '', 1414),
(5, 2, 3, 69, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Air Sumber /Mata Air', '', 1415),
(5, 2, 3, 69, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Air Tanah Dalam', '', 1416),
(5, 2, 3, 69, 4, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Air Tanah Dangkal', '', 1417),
(5, 2, 3, 69, 5, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Air Bersih/Air Baku Lainnya', '', 1418),
(5, 2, 3, 70, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Air Kotor', '', 1419),
(5, 2, 3, 70, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Air Buangan Industri', '', 1420),
(5, 2, 3, 70, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Air Buangan Pertanian', '', 1421),
(5, 2, 3, 71, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Pengolahan Sampah Organik', '', 1422),
(5, 2, 3, 71, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Pengolahan Sampah Non Organik', '', 1423),
(5, 2, 3, 72, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Pengolahan Bahan Bangunan', '', 1424),
(5, 2, 3, 73, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Pembangkit Listrik Tenaga Air', '', 1425),
(5, 2, 3, 73, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Pembangkit Listrik Tenaga Diesel', '', 1426),
(5, 2, 3, 73, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Pembangkit Liatrik Tenaga Mikro (Hidro)', '', 1427),
(5, 2, 3, 73, 4, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Pembangkit Listrik Tenaga Angin (PLTAN)', '', 1428),
(5, 2, 3, 73, 5, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Pembangkit Listrik Tenaga Uap (PLTU)', '', 1429),
(5, 2, 3, 73, 6, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Pembangkit Listrik Tenaga Nuklir (PLTN)', '', 1430),
(5, 2, 3, 73, 7, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Pembangkit Listrik Tenaga Gas (PLTG)', '', 1431),
(5, 2, 3, 73, 8, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Pembangkit Listrik Tenaga Panas Bumi (PLTP)', '', 1432),
(5, 2, 3, 73, 9, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Pembangkit Listrik Tenaga Tenaga Surya (PLTS)', '', 1433),
(5, 2, 3, 73, 10, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Pembangkit Listrik Tenaga Biogas (PLTB)', '', 1434),
(5, 2, 3, 73, 11, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Pembangkit Listrik Tenaga Samudera/Gelombang Samudera (PLTSm)', '', 1435),
(5, 2, 3, 74, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Gardu Listrik Induk', '', 1436),
(5, 2, 3, 74, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - PengadaanInstalasi Gardu Listrik Distribusi', '', 1437),
(5, 2, 3, 74, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Pusat Pengatur Listrik', '', 1438),
(5, 2, 3, 75, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Pertahanan Di Darat', '', 1439),
(5, 2, 3, 76, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Gardu Gas', '', 1440),
(5, 2, 3, 76, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Jaringan Pipa Gas', '', 1441),
(5, 2, 3, 77, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Instalasi Pengaman Penangkal Petir', '', 1442),
(5, 2, 3, 78, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Pembawa', '', 1443),
(5, 2, 3, 78, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Induk Distribusi', '', 1444),
(5, 2, 3, 78, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Cabang Distribusi', '', 1445),
(5, 2, 3, 78, 4, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Air Minum Jaringan Sambungan Kerumah', '', 1446),
(5, 2, 3, 79, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Transmisi', '', 1447),
(5, 2, 3, 79, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Distribusi', '', 1448),
(5, 2, 3, 80, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Telepon Di atas Tanah', '', 1449),
(5, 2, 3, 80, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Telepon Di bawah Tanah', '', 1450),
(5, 2, 3, 80, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Telepon Didalam Air', '', 1451),
(5, 2, 3, 81, 1, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Pipa Gas Transmisi', '', 1452),
(5, 2, 3, 81, 2, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Pipa Distribusi', '', 1453),
(5, 2, 3, 81, 3, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan Pipa Dinas', '', 1454),
(5, 2, 3, 81, 4, 'Belanja Modal Jalan, Irigasi dan Jaringan - Pengadaan Jaringan BBM', '', 1455),
(5, 2, 3, 82, 1, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Buku Ilmu Pengetahuan Umum', '', 1456),
(5, 2, 3, 82, 2, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Buku Filsafat', '', 1457),
(5, 2, 3, 82, 3, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Buku Keagamaan', '', 1458),
(5, 2, 3, 82, 4, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Buku Ilmu Sosial', '', 1459),
(5, 2, 3, 82, 5, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Buku Ilmu Bahasa', '', 1460),
(5, 2, 3, 82, 6, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Buku Matematika & Pengetahuan alam', '', 1461),
(5, 2, 3, 82, 7, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Buku Ilmu Pengetahuan Praktis', '', 1462),
(5, 2, 3, 82, 8, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Buku Arsitektur, Kesenian, Olah raga', '', 1463),
(5, 2, 3, 82, 9, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Buku Geografi, Biografi, Sejarah', '', 1464),
(5, 2, 3, 83, 1, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Terbitan Berkala', '', 1465),
(5, 2, 3, 83, 2, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Buku Laporan', '', 1466),
(5, 2, 3, 84, 1, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang-Barang Perpustakaan Peta', '', 1467),
(5, 2, 3, 84, 2, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang-Barang Perpustakaan Naskah (Manuskrip)', '', 1468),
(5, 2, 3, 84, 3, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang-Barang Perpustakaan Musik', '', 1469),
(5, 2, 3, 84, 4, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang-Barang Perpustakaan Karya Grafika (Graphic Material)', '', 1470),
(5, 2, 3, 84, 5, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang-Barang Perpustakaan Three Dimensional Artetacs and Realita', '', 1471),
(5, 2, 3, 84, 6, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang-Barang Perpustakaan Bentuk Micro (Microform)', '', 1472),
(5, 2, 3, 84, 7, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang-Barang Perpustakaan Rekaman Suara', '', 1473),
(5, 2, 3, 84, 8, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang-Barang Perpustakaan Berkas Komputer (Computer Files)', '', 1474),
(5, 2, 3, 84, 9, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang-Barang Perpustakaan Film Bergerak dan Rekaman Video', '', 1475),
(5, 2, 3, 84, 10, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang-Barang Perpustakaan Tarscalt', '', 1476),
(5, 2, 3, 85, 1, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang Bercorak Kebudayaan Pahatan', '', 1477),
(5, 2, 3, 85, 2, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang Bercorak Kebudayaan Lukisan', '', 1478),
(5, 2, 3, 85, 3, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang Bercorak Kebudayaan Alat Kesenian', '', 1479),
(5, 2, 3, 85, 4, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang Bercorak Kebudayaan Alat Olah Raga', '', 1480),
(5, 2, 3, 85, 5, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang Bercorak Kebudayaan Tanda Penghargaan', '', 1481),
(5, 2, 3, 85, 6, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang Bercorak Kebudayaan Maket dan Foto Dokumen', '', 1482),
(5, 2, 3, 85, 7, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang Bercorak Kebudayaan Benda-benda Bersejarah', '', 1483),
(5, 2, 3, 85, 8, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Barang Bercorak Kebudayaan Barang Kerajinan', '', 1484),
(5, 2, 3, 86, 1, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Alat Olah Raga Senam', '', 1485),
(5, 2, 3, 86, 2, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Alat Olah Raga Air', '', 1486),
(5, 2, 3, 86, 3, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Alat Olah Raga Udara', '', 1487),
(5, 2, 3, 86, 4, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Alat Olah Raga Lainnya', '', 1488),
(5, 2, 3, 87, 1, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Binatang Ternak', '', 1489),
(5, 2, 3, 87, 2, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Binatang Unggas', '', 1490),
(5, 2, 3, 87, 3, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Binatang Melata', '', 1491),
(5, 2, 3, 87, 4, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Binatang Ikan', '', 1492),
(5, 2, 3, 87, 5, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Hewan Kebun Binatang', '', 1493),
(5, 2, 3, 87, 6, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Hewan Pengamanan', '', 1494),
(5, 2, 3, 88, 1, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Tanaman Perkebunan', '', 1495),
(5, 2, 3, 88, 2, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Tanaman Holtikultura', '', 1496),
(5, 2, 3, 88, 3, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Tanaman Kehutanan', '', 1497),
(5, 2, 3, 88, 4, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Tanaman Hias', '', 1498),
(5, 2, 3, 88, 5, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Tanaman Obat dan Kosmetika', '', 1499),
(5, 2, 3, 89, 1, 'Belanja Modal Aset Tetap Lainnya - Pengadaan Aset Tetap Renovasi', '', 1500),
(6, 1, 1, 1, 1, 'Pajak Daerah', '', 1501),
(6, 1, 1, 1, 2, 'Retribusi Daerah', '', 1502),
(6, 1, 1, 1, 3, 'Hasil Pengelolaan Kekayaan Daerah yang Dipisahkan', '', 1503),
(6, 1, 1, 1, 4, 'Lain-Lain PAD yang sah', '', 1504),
(6, 1, 1, 2, 1, 'Bagi Hasil Pajak', '', 1505),
(6, 1, 1, 2, 2, 'Bagi Hasil Bukan Pajak/Sumber Daya Alam', '', 1506),
(6, 1, 1, 4, 1, 'Belanja Pegawai dari Belanja Tidak langsung', '', 1507),
(6, 1, 1, 4, 2, 'Belanja Pegawai dari Belanja langsung', '', 1508),
(6, 1, 1, 4, 3, 'Belanja Barang dan Jasa', '', 1509),
(6, 1, 1, 4, 4, 'Belanja Modal', '', 1510),
(6, 1, 1, 4, 5, 'Belanja Bunga', '', 1511),
(6, 1, 1, 4, 6, 'Belanja Subsidi', '', 1512),
(6, 1, 1, 4, 7, 'Belanja Hibah', '', 1513),
(6, 1, 1, 4, 8, 'Belanja Bantuan Sosial', '', 1514),
(6, 1, 1, 4, 9, 'Belanja Belanja Bagi Hasil', '', 1515),
(6, 1, 1, 4, 10, 'Belanja Bantuan Keuangan', '', 1516),
(6, 1, 1, 4, 11, 'Belanja Tidak Terduga', '', 1517),
(6, 1, 1, 5, 1, 'Uang jaminan ……', '', 1518),
(6, 1, 1, 5, 2, 'Potongan Taspen', '', 1519),
(6, 1, 1, 5, 3, 'Potongan Beras', '', 1520),
(6, 1, 1, 5, 4, 'Askes', '', 1521),
(6, 1, 1, 6, 1, 'Kegiatan lanjutan ......', '', 1522),
(6, 1, 2, 1, 1, 'Pencairan Dana Cadangan nomor ……', '', 1523),
(6, 1, 3, 1, 1, 'BUMD ....', '', 1524),
(6, 1, 4, 1, 1, 'Penerusan pinjaman…..', '', 1525),
(6, 1, 4, 2, 1, 'Pemerintah daerah ……', '', 1526),
(6, 1, 4, 3, 1, 'Bank …..', '', 1527),
(6, 1, 4, 4, 1, 'Lembaga keuangan bukan bank ……', '', 1528),
(6, 1, 4, 5, 1, 'Obligasi atas nama ….', '', 1529),
(6, 1, 4, 5, 2, 'Obligasi nomor ….', '', 1530),
(6, 1, 5, 1, 1, 'Penerimaan Kembali Penerimaan Pinjaman ….', '', 1531),
(6, 1, 6, 1, 1, 'Penerimaan piutang daerah dari pendapatan pajak daerah', '', 1532),
(6, 1, 6, 1, 2, 'Penerimaan piutang daerah dari pendapatan retribusi daerah', '', 1533),
(6, 1, 6, 1, 3, 'Penerimaan piutang daerah dari lain-lain pendapatan yang sah', '', 1534),
(6, 1, 6, 2, 1, 'Penerimaan piutang daerah dari pemerintah', '', 1535),
(6, 1, 6, 3, 1, 'Pemerintah daerah …………….', '', 1536),
(6, 1, 6, 4, 1, 'Bank ………………..', '', 1537),
(6, 1, 6, 5, 1, 'Lembaga keuangan bukan bank …………………….', '', 1538),
(6, 1, 7, 1, 1, 'Penerimaan kembali dana bergulir dari kelompok masyarakat', '', 1539),
(6, 2, 1, 1, 1, 'Pembentukan Dana Cadangan nomor ……', '', 1540),
(6, 2, 2, 1, 1, 'BUMN …….', '', 1541),
(6, 2, 2, 2, 1, 'BUMD ……….', '', 1542),
(6, 2, 2, 3, 1, 'Badan …………..', '', 1543),
(6, 2, 2, 4, 1, 'Dana bergulir kepada kelompok masyarakat', '', 1544),
(6, 2, 3, 1, 1, 'Penerusan pinjaman…..', '', 1545),
(6, 2, 3, 2, 1, 'Pemerintah daerah ……', '', 1546),
(6, 2, 3, 3, 1, 'Bank …..', '', 1547),
(6, 2, 3, 4, 1, 'Lembaga keuangan bukan bank ……', '', 1548),
(6, 2, 3, 5, 1, 'Penerusan pinjaman…..', '', 1549),
(6, 2, 3, 6, 1, 'Pemerintah daerah ……', '', 1550),
(6, 2, 3, 7, 1, 'Bank …..', '', 1551),
(6, 2, 3, 8, 1, 'Lembaga keuangan bukan bank ……', '', 1552),
(6, 2, 3, 9, 1, 'Obligasi atas nama …………', '', 1553),
(6, 2, 3, 9, 2, 'Obligasi nomor …………', '', 1554),
(6, 2, 3, 10, 1, 'Obligasi atas nama …………', '', 1555),
(6, 2, 3, 10, 2, 'Obligasi nomor …………', '', 1556),
(6, 2, 4, 1, 1, 'Pemerintah', '', 1557),
(6, 2, 4, 2, 1, 'Pemerintah daerah ……', '', 1558),
(6, 3, 1, 1, 1, 'Sisa Lebih Pembiayaan Anggaran Tahun Berkenaan', '', 1559),
(6, 4, 1, 1, 1, 'Sisa Lebih/Kurang Pembiayaan Tahun Berkenaan', '', 1560),
(7, 1, 1, 1, 1, 'Penerimaan PFK - IWP', '', 1561),
(7, 1, 1, 2, 1, 'Penerimaan PFK - Taspen', '', 1562),
(7, 1, 1, 3, 1, 'Penerimaan PFK - Askes', '', 1563),
(7, 1, 1, 4, 1, 'Penerimaan PFK - PPh Ps. 21', '', 1564),
(7, 1, 1, 4, 2, 'Penerimaan PFK - PPh Ps. 22', '', 1565),
(7, 1, 1, 4, 3, 'Penerimaan PFK - PPh Ps. 23', '', 1566),
(7, 1, 1, 4, 4, 'Penerimaan PFK - PPh Ps. 25', '', 1567),
(7, 1, 1, 5, 1, 'Penerimaan PFK - PPn Pusat', '', 1568),
(7, 1, 1, 6, 1, 'Penerimaan PFK - Taperum', '', 1569),
(7, 1, 1, 7, 1, 'Penerimaan PFK - Lainnya', '', 1570),
(7, 2, 1, 1, 1, 'Pengeluaran PFK - IWP', '', 1571),
(7, 2, 1, 2, 1, 'Pengeluaran PFK - Taspen', '', 1572),
(7, 2, 1, 3, 1, 'Pengeluaran PFK- Askes', '', 1573),
(7, 2, 1, 4, 1, 'Pengeluaran PFK - PPh Ps. 21', '', 1574),
(7, 2, 1, 4, 2, 'Pengeluaran PFK - PPh Ps. 22', '', 1575),
(7, 2, 1, 4, 3, 'Pengeluaran PFK - PPh Ps. 23', '', 1576),
(7, 2, 1, 4, 4, 'Pengeluaran PFK - PPh Ps. 25', '', 1577),
(7, 2, 1, 5, 1, 'Pengeluaran PFK - PPn Pusat', '', 1578),
(7, 2, 1, 6, 1, 'Pengeluaran PFK - Taperum', '', 1579),
(7, 2, 1, 7, 1, 'Pengeluaran PFK - Lainnya', '', 1580);

-- --------------------------------------------------------

--
-- Table structure for table `ref_revisi`
--

DROP TABLE IF EXISTS `ref_revisi`;
CREATE TABLE IF NOT EXISTS `ref_revisi` (
  `id_revisi` int(255) NOT NULL,
  `uraian_revisi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_revisi`) USING BTREE,
  UNIQUE KEY `idx_ref_revisi` (`id_revisi`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_satuan`
--

DROP TABLE IF EXISTS `ref_satuan`;
CREATE TABLE IF NOT EXISTS `ref_satuan` (
  `id_satuan` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_satuan` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `singkatan_satuan` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scope_pemakaian` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_satuan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_setting`
--

DROP TABLE IF EXISTS `ref_setting`;
CREATE TABLE IF NOT EXISTS `ref_setting` (
  `tahun_rencana` int(11) NOT NULL COMMENT 'tahun_perencanaan',
  `jenis_rw` int(11) NOT NULL DEFAULT '0' COMMENT 'jenis_pembatasan_rw, 0 tidak dibatasi, 1 jml_usulan, 2 jml_pagu',
  `jml_rw` int(11) NOT NULL DEFAULT '0' COMMENT 'batas usulan rw, 0 tidak dibatasi',
  `pagu_rw` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jenis_desa` int(11) NOT NULL DEFAULT '0' COMMENT 'jenis_pembatasan_rw, 0 tidak dibatasi, 1 jml_usulan, 2 jml_pagu',
  `jml_desa` int(11) NOT NULL DEFAULT '0' COMMENT 'batas usulan rw, 0 tidak dibatasi',
  `pagu_desa` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jenis_kecamatan` int(11) NOT NULL DEFAULT '0' COMMENT 'jenis_pembatasan_rw, 0 tidak dibatasi, 1 jml_usulan, 2 jml_pagu',
  `jml_kecamatan` int(11) NOT NULL DEFAULT '0' COMMENT 'batas usulan rw, 0 tidak dibatasi',
  `pagu_kecamatan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `deviasi_pagu` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_setting` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  PRIMARY KEY (`tahun_rencana`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_setting`
--

INSERT INTO `ref_setting` (`tahun_rencana`, `jenis_rw`, `jml_rw`, `pagu_rw`, `jenis_desa`, `jml_desa`, `pagu_desa`, `jenis_kecamatan`, `jml_kecamatan`, `pagu_kecamatan`, `deviasi_pagu`, `status_setting`) VALUES
(2019, 0, 0, '0.00', 0, 0, '0.00', 0, 0, '0.00', '20.00', 0),
(2020, 0, 0, '0.00', 0, 0, '0.00', 0, 0, '0.00', '5.00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ref_sotk_level_1`
--

DROP TABLE IF EXISTS `ref_sotk_level_1`;
CREATE TABLE IF NOT EXISTS `ref_sotk_level_1` (
  `id_sotk_es2` int(11) NOT NULL AUTO_INCREMENT,
  `id_unit` int(11) NOT NULL,
  `nama_eselon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tingkat_eselon` int(11) NOT NULL COMMENT '1/2/3',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_sotk_es2`) USING BTREE,
  KEY `id_unit` (`id_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_sotk_level_2`
--

DROP TABLE IF EXISTS `ref_sotk_level_2`;
CREATE TABLE IF NOT EXISTS `ref_sotk_level_2` (
  `id_sotk_es3` int(11) NOT NULL AUTO_INCREMENT,
  `id_sotk_es2` int(11) NOT NULL,
  `nama_eselon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tingkat_eselon` int(11) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_sotk_es3`) USING BTREE,
  KEY `id_sotk_es2` (`id_sotk_es2`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_sotk_level_3`
--

DROP TABLE IF EXISTS `ref_sotk_level_3`;
CREATE TABLE IF NOT EXISTS `ref_sotk_level_3` (
  `id_sotk_es4` int(11) NOT NULL AUTO_INCREMENT,
  `id_sotk_es3` int(11) NOT NULL,
  `nama_eselon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tingkat_eselon` int(11) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_sotk_es4`) USING BTREE,
  KEY `id_sotk_es2` (`id_sotk_es3`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_golongan`
--

DROP TABLE IF EXISTS `ref_ssh_golongan`;
CREATE TABLE IF NOT EXISTS `ref_ssh_golongan` (
  `id_golongan_ssh` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_ssh` int(11) NOT NULL DEFAULT '0' COMMENT '0 = BL 1=BTL 2=Pendapatan 3=Pembiayaan ',
  `no_urut` int(11) NOT NULL,
  `uraian_golongan_ssh` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_golongan_ssh`) USING BTREE,
  UNIQUE KEY `idx_ref_ssh_golongan` (`id_golongan_ssh`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_kelompok`
--

DROP TABLE IF EXISTS `ref_ssh_kelompok`;
CREATE TABLE IF NOT EXISTS `ref_ssh_kelompok` (
  `id_kelompok_ssh` int(11) NOT NULL AUTO_INCREMENT,
  `id_golongan_ssh` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `uraian_kelompok_ssh` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kelompok_ssh`) USING BTREE,
  KEY `fk_ssh_kelompok` (`id_golongan_ssh`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_perkada`
--

DROP TABLE IF EXISTS `ref_ssh_perkada`;
CREATE TABLE IF NOT EXISTS `ref_ssh_perkada` (
  `id_perkada` int(11) NOT NULL AUTO_INCREMENT,
  `nomor_perkada` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_perkada` date NOT NULL,
  `tahun_berlaku` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `id_perkada_induk` int(11) NOT NULL DEFAULT '0',
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `uraian_perkada` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_perkada`) USING BTREE,
  UNIQUE KEY `idx_ref_ssh_perkada_2` (`id_perkada`,`id_perkada_induk`,`id_perubahan`) USING BTREE,
  KEY `idx_ref_ssh_perkada_1` (`id_perkada`,`created_at`,`updated_at`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_perkada_tarif`
--

DROP TABLE IF EXISTS `ref_ssh_perkada_tarif`;
CREATE TABLE IF NOT EXISTS `ref_ssh_perkada_tarif` (
  `id_tarif_perkada` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_tarif_old` bigint(11) NOT NULL DEFAULT '0',
  `no_urut` bigint(11) NOT NULL,
  `id_tarif_ssh` bigint(11) NOT NULL,
  `id_rekening` int(11) DEFAULT NULL,
  `id_zona_perkada` int(11) NOT NULL,
  `jml_rupiah` decimal(20,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tarif_perkada`) USING BTREE,
  UNIQUE KEY `ref_ssh_perkada_tarif_unik` (`id_tarif_ssh`,`id_zona_perkada`) USING BTREE,
  KEY `fk_ref_tarif_jumlah_1` (`id_zona_perkada`) USING BTREE,
  KEY `idx_ref_ssh_tarif_jumlah` (`id_tarif_ssh`,`id_zona_perkada`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1596 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_perkada_zona`
--

DROP TABLE IF EXISTS `ref_ssh_perkada_zona`;
CREATE TABLE IF NOT EXISTS `ref_ssh_perkada_zona` (
  `id_zona_perkada` int(11) NOT NULL AUTO_INCREMENT,
  `no_urut` int(11) NOT NULL,
  `id_perkada` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `id_zona` int(11) NOT NULL,
  `nama_zona` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_zona_perkada`) USING BTREE,
  UNIQUE KEY `idx_ref_ssh_tarif_jumlah` (`id_perkada`,`id_zona`,`id_perubahan`) USING BTREE,
  KEY `fk_ref_tarif_jumlah_1` (`id_zona_perkada`,`no_urut`,`id_perkada`,`id_zona`) USING BTREE,
  KEY `ref_ssh_perkada_zona_fk` (`id_zona`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_rekening`
--

DROP TABLE IF EXISTS `ref_ssh_rekening`;
CREATE TABLE IF NOT EXISTS `ref_ssh_rekening` (
  `id_rekening_ssh` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_tarif_ssh` bigint(20) NOT NULL,
  `id_rekening` int(11) NOT NULL,
  `uraian_tarif_ssh` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_rekening_ssh`) USING BTREE,
  UNIQUE KEY `fk_ref_ssh_rekening` (`id_tarif_ssh`,`id_rekening`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_sub_kelompok`
--

DROP TABLE IF EXISTS `ref_ssh_sub_kelompok`;
CREATE TABLE IF NOT EXISTS `ref_ssh_sub_kelompok` (
  `id_sub_kelompok_ssh` int(11) NOT NULL AUTO_INCREMENT,
  `id_kelompok_ssh` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `uraian_sub_kelompok_ssh` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_sub_kelompok_ssh`) USING BTREE,
  KEY `fk_ref_ssh_sub_kelompok` (`id_kelompok_ssh`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_tarif`
--

DROP TABLE IF EXISTS `ref_ssh_tarif`;
CREATE TABLE IF NOT EXISTS `ref_ssh_tarif` (
  `id_tarif_ssh` bigint(11) NOT NULL AUTO_INCREMENT,
  `no_urut` int(11) NOT NULL,
  `id_sub_kelompok_ssh` int(11) NOT NULL,
  `uraian_tarif_ssh` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keterangan_tarif_ssh` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_satuan` int(11) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = aktif, 1 = non aktif',
  PRIMARY KEY (`id_tarif_ssh`) USING BTREE,
  UNIQUE KEY `id_ref_ssh_tarif_1` (`id_tarif_ssh`,`no_urut`,`id_sub_kelompok_ssh`) USING BTREE,
  KEY `id_ref_ssh_tarif` (`id_sub_kelompok_ssh`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=491 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_zona`
--

DROP TABLE IF EXISTS `ref_ssh_zona`;
CREATE TABLE IF NOT EXISTS `ref_ssh_zona` (
  `id_zona` int(11) NOT NULL AUTO_INCREMENT,
  `keterangan_zona` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diskripsi_zona` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_zona`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_ssh_zona`
--

INSERT INTO `ref_ssh_zona` (`id_zona`, `keterangan_zona`, `diskripsi_zona`) VALUES
(1, 'Semua Wilayah', 'Semua wilayah tanpa ada perbedaan lokasi, kecuali ditetapkan lain di tarif Zona Terluar'),
(2, 'Zona Terluar', 'Tarif SSH untuk zona terluar meliputi radius 50km dari pusat kota');

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_zona_lokasi`
--

DROP TABLE IF EXISTS `ref_ssh_zona_lokasi`;
CREATE TABLE IF NOT EXISTS `ref_ssh_zona_lokasi` (
  `id_zona_lokasi` int(11) NOT NULL AUTO_INCREMENT,
  `id_zona` int(11) NOT NULL,
  `id_lokasi` int(11) NOT NULL,
  `id_desa` int(11) DEFAULT NULL,
  `diskripsi_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_zona_lokasi`) USING BTREE,
  KEY `fk_zona_lokasi` (`id_zona`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_status_usul`
--

DROP TABLE IF EXISTS `ref_status_usul`;
CREATE TABLE IF NOT EXISTS `ref_status_usul` (
  `id_status_usul` int(11) NOT NULL,
  `uraian_status_usul` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_status_usul`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_sub_unit`
--

DROP TABLE IF EXISTS `ref_sub_unit`;
CREATE TABLE IF NOT EXISTS `ref_sub_unit` (
  `id_sub_unit` int(255) NOT NULL AUTO_INCREMENT,
  `id_unit` int(11) NOT NULL,
  `kd_sub` int(255) NOT NULL,
  `nm_sub` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_sub_unit`) USING BTREE,
  UNIQUE KEY `idx_ref_sub_unit` (`id_unit`,`kd_sub`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_sumber_dana`
--

DROP TABLE IF EXISTS `ref_sumber_dana`;
CREATE TABLE IF NOT EXISTS `ref_sumber_dana` (
  `id_sumber_dana` int(11) NOT NULL,
  `uraian_sumber_dana` longtext CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id_sumber_dana`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_sumber_dana`
--

INSERT INTO `ref_sumber_dana` (`id_sumber_dana`, `uraian_sumber_dana`) VALUES
(1, 'Pendapatan Asli Daerah'),
(2, 'Dana Alokasi Umum'),
(3, 'Dana Alokasi Khusus'),
(4, 'Lain-Lain Pendapatan Yang Sah'),
(5, 'Dana Insentif Daerah'),
(6, 'BK Provinsi');

-- --------------------------------------------------------

--
-- Table structure for table `ref_tabel_dasar`
--

DROP TABLE IF EXISTS `ref_tabel_dasar`;
CREATE TABLE IF NOT EXISTS `ref_tabel_dasar` (
  `id_tabel_dasar` int(11) NOT NULL,
  `nama_tabel` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_tabel_dasar`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `ref_tabel_dasar`
--

INSERT INTO `ref_tabel_dasar` (`id_tabel_dasar`, `nama_tabel`) VALUES
(1, 'Nilai dan Kontribusi Sektor dalam PDRB'),
(2, 'Nilai dan Kontribusi Sektor dalam PDRB HB'),
(3, 'Angka Melek Huruf'),
(4, 'Rata-Rata Lama Sekolah Tahun'),
(5, 'Perkembangan Seni, Budaya dan Olahraga'),
(6, 'Angka Partisipasi Sekolah'),
(7, 'Ketersediaan Sekolah dan Penduduk Usia Sekolah'),
(8, 'Jumlah Guru dan Murid Jenjang Pendidikan Dasar'),
(9, 'Jumlah Investor PMDN/PMA'),
(10, 'Jumlah Investasi PMDN/PMA');

-- --------------------------------------------------------

--
-- Table structure for table `ref_tahun`
--

DROP TABLE IF EXISTS `ref_tahun`;
CREATE TABLE IF NOT EXISTS `ref_tahun` (
  `id_tahun` int(11) NOT NULL AUTO_INCREMENT,
  `id_pemda` int(11) NOT NULL,
  `id_rpjmd` int(11) NOT NULL,
  `tahun_0` int(255) NOT NULL,
  `tahun_1` int(255) NOT NULL,
  `tahun_2` int(255) NOT NULL,
  `tahun_3` int(255) NOT NULL,
  `tahun_4` int(255) NOT NULL,
  `tahun_5` int(255) NOT NULL,
  PRIMARY KEY (`id_tahun`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_unit`
--

DROP TABLE IF EXISTS `ref_unit`;
CREATE TABLE IF NOT EXISTS `ref_unit` (
  `id_unit` int(11) NOT NULL AUTO_INCREMENT,
  `id_bidang` int(11) NOT NULL,
  `kd_unit` int(255) NOT NULL,
  `nm_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_unit`) USING BTREE,
  UNIQUE KEY `idx_ref_unit` (`id_bidang`,`kd_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_urusan`
--

DROP TABLE IF EXISTS `ref_urusan`;
CREATE TABLE IF NOT EXISTS `ref_urusan` (
  `kd_urusan` int(255) NOT NULL,
  `nm_urusan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`kd_urusan`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ref_urusan`
--

INSERT INTO `ref_urusan` (`kd_urusan`, `nm_urusan`) VALUES
(1, 'Urusan Wajib Pelayanan Dasar'),
(2, 'Urusan Wajib Bukan Pelayanan Dasar'),
(3, 'Urusan Pilihan'),
(4, 'Urusan Pemerintahan Fungsi Penunjang');

-- --------------------------------------------------------

--
-- Table structure for table `ref_user_role`
--

DROP TABLE IF EXISTS `ref_user_role`;
CREATE TABLE IF NOT EXISTS `ref_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_peran` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tambah` int(11) NOT NULL DEFAULT '0',
  `edit` int(11) NOT NULL DEFAULT '0',
  `hapus` int(11) NOT NULL DEFAULT '0',
  `lihat` int(11) NOT NULL DEFAULT '0',
  `reviu` int(11) NOT NULL DEFAULT '0',
  `posting` int(11) NOT NULL DEFAULT '0',
  `status_role` int(11) NOT NULL DEFAULT '0' COMMENT '0 aktif 1 non aktif',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `temp_table_info`
--

DROP TABLE IF EXISTS `temp_table_info`;
CREATE TABLE IF NOT EXISTS `temp_table_info` (
  `TBL_INDEX` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TABLE_SCHEMA` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TABLE_NAME` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `COLUMN_NAME` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `COLUMN_TYPE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IS_NULLABLE` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `COLUMN_KEY` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `COLUMN_DEFAULT` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `EXTRA` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `INDEX_NAME` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `SEQ_IN_INDEX` int(11) DEFAULT NULL,
  `NON_UNIQUE` int(11) DEFAULT NULL,
  `FLAG` int(11) DEFAULT NULL,
  KEY `TBL_INDEX` (`TBL_INDEX`,`TABLE_NAME`,`COLUMN_NAME`,`IS_NULLABLE`,`COLUMN_KEY`,`INDEX_NAME`,`FLAG`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_aktivitas_pd`
--

DROP TABLE IF EXISTS `trx_anggaran_aktivitas_pd`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_aktivitas_pd` (
  `id_aktivitas_pd` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_pelaksana_pd` bigint(20) NOT NULL,
  `id_aktivitas_rkpd_final` int(11) DEFAULT '0',
  `tahun_anggaran` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `id_aktivitas_asb` int(11) DEFAULT '0',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `uraian_aktivitas_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_aktivitas_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_rkpd_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_aktivitas_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_rkpd_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_satuan_publik` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `pagu_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_anggaran` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal',
  `keterangan_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_keu` int(11) NOT NULL DEFAULT '0' COMMENT '0 = detail 1 = grouping',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = rkpd 1 tambahan baru',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `checksum` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_aktivitas_pd`) USING BTREE,
  UNIQUE KEY `id_pelaksana_pd` (`id_pelaksana_pd`,`id_aktivitas_rkpd_final`,`tahun_anggaran`,`sumber_aktivitas`,`sumber_dana`,`id_perubahan`,`id_aktivitas_asb`,`sumber_data`) USING BTREE,
  KEY `FK_trx_forum_skpd_aktivitas_trx_forum_skpd` (`id_pelaksana_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=248 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_belanja_pd`
--

DROP TABLE IF EXISTS `trx_anggaran_belanja_pd`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_belanja_pd` (
  `id_belanja_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_belanja_rkpd_final` int(11) NOT NULL DEFAULT '0',
  `tahun_anggaran` int(11) NOT NULL DEFAULT '0',
  `no_urut` int(11) NOT NULL DEFAULT '0',
  `id_zona_ssh` int(11) NOT NULL DEFAULT '0',
  `sumber_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 asb 1 ssh',
  `id_aktivitas_asb` int(11) NOT NULL DEFAULT '0',
  `id_item_ssh` bigint(20) NOT NULL DEFAULT '0',
  `id_rekening_ssh` int(11) NOT NULL DEFAULT '0',
  `uraian_belanja` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `koefisien` decimal(20,2) NOT NULL DEFAULT '1.00',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_1_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `koefisien_rkpd` decimal(20,2) NOT NULL DEFAULT '1.00',
  `harga_satuan_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `checksum` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_jumlah` decimal(20,2) DEFAULT NULL,
  PRIMARY KEY (`id_belanja_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_skpd_belanja` (`tahun_anggaran`,`no_urut`,`id_belanja_pd`,`id_aktivitas_pd`) USING BTREE,
  KEY `fk_trx_forum_skpd_belanja` (`id_aktivitas_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_dokumen`
--

DROP TABLE IF EXISTS `trx_anggaran_dokumen`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_dokumen` (
  `id_dokumen_keu` int(11) NOT NULL AUTO_INCREMENT,
  `jns_dokumen_keu` int(11) NOT NULL DEFAULT '0' COMMENT '0 ppas 1 apbd',
  `kd_dokumen_keu` int(11) NOT NULL DEFAULT '0' COMMENT '0 murni 1 pergeseran_1 2 perubahan 3 pergeseran_2',
  `id_perubahan` int(11) NOT NULL DEFAULT '0' COMMENT '0 awal',
  `id_dokumen_ref` int(11) NOT NULL DEFAULT '0',
  `tahun_anggaran` int(11) NOT NULL COMMENT 'tahun perencanaan',
  `nomor_keu` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_keu` date NOT NULL,
  `uraian_perkada` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_unit_ppkd` int(11) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sinkronisasi` int(11) NOT NULL DEFAULT '0',
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_dokumen_keu`) USING BTREE,
  UNIQUE KEY `tahun_ranwal` (`jns_dokumen_keu`,`kd_dokumen_keu`,`id_perubahan`,`tahun_anggaran`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_indikator`
--

DROP TABLE IF EXISTS `trx_anggaran_indikator`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_indikator` (
  `id_indikator_program_rkpd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_anggaran_pemda` int(11) NOT NULL,
  `id_indikator_rkpd_final` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_rkpd` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_keuangan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_output` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 data rpjmd 1 data baru',
  PRIMARY KEY (`id_indikator_program_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_indikator` (`tahun_rkpd`,`id_anggaran_pemda`,`kd_indikator`,`no_urut`,`id_indikator_rkpd_final`) USING BTREE,
  KEY `id_anggaran_pemda` (`id_anggaran_pemda`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_kegiatan_pd`
--

DROP TABLE IF EXISTS `trx_anggaran_kegiatan_pd`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_kegiatan_pd` (
  `id_kegiatan_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_program_pd` bigint(20) NOT NULL,
  `id_kegiatan_pd_rkpd_final` int(11) DEFAULT NULL,
  `id_unit` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `tahun_anggaran` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja` int(11) DEFAULT '0',
  `id_rkpd_renstra` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `id_kegiatan_renstra` int(11) DEFAULT '0',
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_forum` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun_kegiatan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_kegiatan_renstra` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_status` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 =  musrenbang',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal dilaksanakan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari renja 1 baru tambahan',
  `kelompok_sasaran` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `checksum` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kegiatan_pd`) USING BTREE,
  UNIQUE KEY `id_unit_id_renja_id_kegiatan_ref` (`id_unit`,`id_kegiatan_ref`,`id_program_pd`,`tahun_anggaran`,`id_kegiatan_pd_rkpd_final`,`id_perubahan`) USING BTREE,
  KEY `FK_trx_forum_skpd_trx_forum_skpd_program` (`id_program_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_keg_indikator_pd`
--

DROP TABLE IF EXISTS `trx_anggaran_keg_indikator_pd`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_keg_indikator_pd` (
  `id_indikator_kegiatan` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_indikator_rkpd_final` int(11) DEFAULT NULL,
  `tahun_anggaran` int(11) NOT NULL,
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_output` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_kegiatan`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_anggaran`,`id_indikator_rkpd_final`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_kegiatan_pd`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_indikator_rkpd_final`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_kegiatan_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_lokasi_pd`
--

DROP TABLE IF EXISTS `trx_anggaran_lokasi_pd`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_lokasi_pd` (
  `id_lokasi_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_lokasi_rkpd_final` int(11) NOT NULL DEFAULT '0' COMMENT '0',
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `tahun_anggaran` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `jenis_lokasi` int(11) NOT NULL DEFAULT '0',
  `id_lokasi` int(11) NOT NULL,
  `id_lokasi_teknis` int(11) DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_desa` int(11) DEFAULT '0',
  `id_kecamatan` int(11) DEFAULT '0',
  `rt` int(11) DEFAULT '0',
  `rw` int(11) DEFAULT '0',
  `uraian_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lat` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rkpd 1 anggaran',
  PRIMARY KEY (`id_lokasi_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_lokasi` (`id_aktivitas_pd`,`tahun_anggaran`,`no_urut`,`id_lokasi_pd`,`jenis_lokasi`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_pelaksana`
--

DROP TABLE IF EXISTS `trx_anggaran_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_pelaksana` (
  `id_pelaksana_anggaran` int(11) NOT NULL AUTO_INCREMENT,
  `id_anggaran_pemda` int(11) NOT NULL,
  `tahun_anggaran` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_urusan_anggaran` int(11) NOT NULL,
  `id_pelaksana_rkpd_final` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `pagu_rkpd_final` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_anggaran` decimal(20,2) NOT NULL DEFAULT '0.00',
  `hak_akses` int(11) NOT NULL DEFAULT '0' COMMENT '0 tidak dapat menambah data 1 dapat menambah data',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 dibatalkan',
  `ket_pelaksanaan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  PRIMARY KEY (`id_pelaksana_anggaran`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_anggaran`,`id_anggaran_pemda`,`id_unit`,`id_urusan_anggaran`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_anggaran_pemda`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_urusan_anggaran`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_2` (`id_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_pelaksana_pd`
--

DROP TABLE IF EXISTS `trx_anggaran_pelaksana_pd`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_pelaksana_pd` (
  `id_pelaksana_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_rkpd_final` int(11) DEFAULT NULL,
  `tahun_anggaran` int(11) NOT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) DEFAULT '0',
  `id_lokasi` int(11) DEFAULT '0' COMMENT 'lokasi penyelenggaraan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan',
  `ket_pelaksana` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal 2 baru',
  `status_data` int(11) NOT NULL COMMENT '0 draft 1 final',
  `hak_akses` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_pelaksana_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_pelaksana` (`id_kegiatan_pd`,`tahun_anggaran`,`no_urut`,`id_pelaksana_pd`,`id_sub_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_program`
--

DROP TABLE IF EXISTS `trx_anggaran_program`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_program` (
  `id_anggaran_pemda` int(11) NOT NULL AUTO_INCREMENT,
  `id_dokumen_keu` int(11) NOT NULL DEFAULT '0',
  `id_rkpd_ranwal` int(11) NOT NULL COMMENT '0 baru',
  `id_rkpd_final` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru',
  `no_urut` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL 3 Pembiayaan',
  `tahun_anggaran` int(11) NOT NULL,
  `id_rkpd_rpjmd` int(11) DEFAULT NULL,
  `thn_id_rpjmd` int(11) DEFAULT NULL,
  `id_visi_rpjmd` int(11) DEFAULT NULL,
  `id_misi_rpjmd` int(11) DEFAULT NULL,
  `id_tujuan_rpjmd` int(11) DEFAULT NULL,
  `id_sasaran_rpjmd` int(11) DEFAULT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `uraian_program_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_keuangan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_program` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL COMMENT '0 = data tepat waktu sesuai renstra/rpjmd\\r\\n1 = data pergeseran waktu renstra/rpjmd\\r\\n2 = data baru yang belum ada di renstra/rpjmd\\r\\n9 = dibatalkan pelaksanaanya\\r\\n8 = ditunda dilaksanakan\\r\\n',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Draft 1 = Posting',
  `ket_usulan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RKPD 1 = Baru',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_anggaran_pemda`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_ranwal` (`tahun_anggaran`,`thn_id_rpjmd`,`id_visi_rpjmd`,`id_misi_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_program_rpjmd`,`no_urut`,`id_rkpd_final`,`id_rkpd_ranwal`,`id_dokumen_keu`) USING BTREE,
  KEY `id_dokumen_keu` (`id_dokumen_keu`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_program_pd`
--

DROP TABLE IF EXISTS `trx_anggaran_program_pd`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_program_pd` (
  `id_program_pd` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_pelaksana_anggaran` int(11) NOT NULL,
  `kd_dokumen_keu` int(11) NOT NULL DEFAULT '0' COMMENT '0 murni 1 pergeseran_1 2 perubahan 3 pergeseran_2',
  `jns_dokumen_keu` int(11) NOT NULL DEFAULT '0' COMMENT '0 ppas 1 apbd',
  `id_perubahan` int(11) NOT NULL DEFAULT '0' COMMENT '0 awal',
  `id_dokumen_keu` int(11) NOT NULL DEFAULT '0',
  `tahun_anggaran` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pdt 2 BTL 3 Penerimaan',
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_program_pd_rkpd_final` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT '0',
  `uraian_program_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_rkpd_final` decimal(20,2) DEFAULT '0.00',
  `pagu_anggaran` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RKPD 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `checksum` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_program_pd`) USING BTREE,
  UNIQUE KEY `id_unit_id_renja_program_id_program_ref` (`id_unit`,`tahun_anggaran`,`kd_dokumen_keu`,`jns_dokumen_keu`,`id_perubahan`,`id_pelaksana_anggaran`,`id_program_ref`,`id_program_pd_rkpd_final`,`id_dokumen_keu`) USING BTREE,
  KEY `FK_trx_forum_skpd_program_trx_forum_skpd_program_ranwal` (`id_pelaksana_anggaran`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_prog_indikator_pd`
--

DROP TABLE IF EXISTS `trx_anggaran_prog_indikator_pd`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_prog_indikator_pd` (
  `id_indikator_program` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_program_pd` bigint(11) NOT NULL,
  `id_indikator_rkpd_final` int(11) NOT NULL DEFAULT '0',
  `tahun_anggaran` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_output` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_program`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_anggaran`,`id_indikator_rkpd_final`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_program_pd`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_program_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_tapd`
--

DROP TABLE IF EXISTS `trx_anggaran_tapd`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_tapd` (
  `id_tapd` bigint(255) NOT NULL AUTO_INCREMENT,
  `id_dokumen_keu` int(11) NOT NULL,
  `id_pegawai` int(11) NOT NULL,
  `id_unit_pegawai` int(11) NOT NULL,
  `peran_tim` varchar(255) NOT NULL,
  `status_tim` int(255) NOT NULL DEFAULT '0',
  `tmt_tim` date DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tapd`),
  UNIQUE KEY `id_dokumen_keu` (`id_dokumen_keu`,`id_pegawai`,`id_unit_pegawai`,`status_tim`),
  KEY `id_pegawai` (`id_pegawai`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_tapd_unit`
--

DROP TABLE IF EXISTS `trx_anggaran_tapd_unit`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_tapd_unit` (
  `id_unit_tapd` bigint(255) NOT NULL AUTO_INCREMENT,
  `id_tapd` bigint(255) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `status_unit` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_unit_tapd`),
  UNIQUE KEY `id_tapd` (`id_tapd`,`id_unit`,`status_unit`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_unit_kpa`
--

DROP TABLE IF EXISTS `trx_anggaran_unit_kpa`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_unit_kpa` (
  `id_kpa` bigint(255) NOT NULL AUTO_INCREMENT,
  `id_pa` bigint(11) NOT NULL,
  `id_pegawai` int(11) NOT NULL,
  `id_unit_pegawai` int(11) NOT NULL,
  `id_program` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_kpa`) USING BTREE,
  UNIQUE KEY `id_pa` (`id_pa`,`id_program`,`id_pegawai`),
  KEY `id_pegawai` (`id_pegawai`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_unit_pa`
--

DROP TABLE IF EXISTS `trx_anggaran_unit_pa`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_unit_pa` (
  `id_pa` bigint(255) NOT NULL AUTO_INCREMENT,
  `id_dokumen_keu` int(11) NOT NULL,
  `no_dokumen` varchar(255) DEFAULT NULL,
  `tgl_dokumen` date DEFAULT NULL,
  `id_unit` int(11) DEFAULT NULL,
  `id_pegawai` int(11) NOT NULL,
  `id_unit_pegawai` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pa`),
  UNIQUE KEY `id_dokumen_keu` (`id_dokumen_keu`,`id_unit`),
  KEY `id_pegawai` (`id_pegawai`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_anggaran_urusan`
--

DROP TABLE IF EXISTS `trx_anggaran_urusan`;
CREATE TABLE IF NOT EXISTS `trx_anggaran_urusan` (
  `id_urusan_anggaran` int(11) NOT NULL AUTO_INCREMENT,
  `id_anggaran_pemda` int(11) NOT NULL,
  `tahun_anggaran` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `id_bidang` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rkpd 1 baru',
  `id_urusan_rkpd_final` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_urusan_anggaran`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_anggaran`,`id_anggaran_pemda`,`id_bidang`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_anggaran_pemda`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_bidang`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_aktivitas`
--

DROP TABLE IF EXISTS `trx_asb_aktivitas`;
CREATE TABLE IF NOT EXISTS `trx_asb_aktivitas` (
  `id_aktivitas_asb` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_asb_sub_sub_kelompok` int(11) NOT NULL,
  `nm_aktivitas_asb` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `satuan_aktivitas` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diskripsi_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_1` decimal(20,2) DEFAULT '0.00',
  `id_satuan_1` int(11) DEFAULT NULL COMMENT 'cost driver',
  `sat_derivatif_1` int(11) DEFAULT NULL,
  `volume_2` decimal(20,2) DEFAULT '0.00',
  `id_satuan_2` int(11) DEFAULT NULL COMMENT 'cost driver',
  `sat_derivatif_2` int(11) DEFAULT NULL,
  `range_max` decimal(20,2) NOT NULL DEFAULT '0.00',
  `kapasitas_max` decimal(20,2) NOT NULL DEFAULT '0.00',
  `range_max1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `kapasitas_max1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `temp_id` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_aktivitas_asb`) USING BTREE,
  KEY `fk_trx_aktivitas_asb` (`id_asb_sub_sub_kelompok`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_kelompok`
--

DROP TABLE IF EXISTS `trx_asb_kelompok`;
CREATE TABLE IF NOT EXISTS `trx_asb_kelompok` (
  `id_asb_kelompok` int(11) NOT NULL AUTO_INCREMENT,
  `id_asb_perkada` int(11) NOT NULL,
  `uraian_kelompok_asb` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `temp_id` float DEFAULT NULL,
  PRIMARY KEY (`id_asb_kelompok`) USING BTREE,
  KEY `FK_trx_asb_cluster_trx_asb_perkada` (`id_asb_perkada`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_komponen`
--

DROP TABLE IF EXISTS `trx_asb_komponen`;
CREATE TABLE IF NOT EXISTS `trx_asb_komponen` (
  `id_aktivitas_asb` bigint(20) NOT NULL,
  `id_komponen_asb` bigint(20) NOT NULL AUTO_INCREMENT,
  `nm_komponen_asb` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_rekening` int(11) NOT NULL,
  `temp_id` float DEFAULT NULL,
  PRIMARY KEY (`id_komponen_asb`) USING BTREE,
  KEY `FK_trx_asb_komponen_trx_asb_aktivitas` (`id_aktivitas_asb`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=819 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_komponen_rinci`
--

DROP TABLE IF EXISTS `trx_asb_komponen_rinci`;
CREATE TABLE IF NOT EXISTS `trx_asb_komponen_rinci` (
  `id_komponen_asb_rinci` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_komponen_asb` bigint(20) NOT NULL,
  `jenis_biaya` int(11) NOT NULL DEFAULT '1' COMMENT '1 fix 2 dependent variabel 3 independen variable',
  `id_tarif_ssh` bigint(11) NOT NULL,
  `koefisien1` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `id_satuan1` int(11) DEFAULT NULL,
  `sat_derivatif1` int(11) DEFAULT NULL,
  `koefisien2` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `id_satuan2` int(11) DEFAULT NULL,
  `sat_derivatif2` int(11) DEFAULT NULL,
  `koefisien3` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `id_satuan3` int(11) DEFAULT NULL,
  `satuan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ket_group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hub_driver` int(11) DEFAULT '0' COMMENT '1 driver1 2 driver2 3 driver12 0 N/A',
  PRIMARY KEY (`id_komponen_asb_rinci`) USING BTREE,
  KEY `fk_ref_komponen_asb_rinc` (`id_tarif_ssh`) USING BTREE,
  KEY `idx_ref_komponen_asb_rinci` (`id_komponen_asb`) USING BTREE,
  KEY `FK_trx_asb_komponen_rinci_ref_satuan` (`id_satuan1`) USING BTREE,
  KEY `FK_trx_asb_komponen_rinci_ref_satuan_2` (`id_satuan2`) USING BTREE,
  KEY `FK_trx_asb_komponen_rinci_ref_satuan_3` (`id_satuan3`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3479732 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_perhitungan`
--

DROP TABLE IF EXISTS `trx_asb_perhitungan`;
CREATE TABLE IF NOT EXISTS `trx_asb_perhitungan` (
  `tahun_perhitungan` int(11) NOT NULL,
  `id_perhitungan` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_perkada` int(11) NOT NULL,
  `flag_aktif` int(11) NOT NULL DEFAULT '0' COMMENT '0 aktif 1 non aktif',
  PRIMARY KEY (`id_perhitungan`) USING BTREE,
  UNIQUE KEY `idx_trx_perhitungan_asb` (`tahun_perhitungan`,`id_perkada`,`flag_aktif`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_perhitungan_rinci`
--

DROP TABLE IF EXISTS `trx_asb_perhitungan_rinci`;
CREATE TABLE IF NOT EXISTS `trx_asb_perhitungan_rinci` (
  `id_perhitungan_rinci` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_perhitungan` bigint(20) NOT NULL,
  `id_asb_kelompok` bigint(20) NOT NULL,
  `id_asb_sub_kelompok` bigint(20) NOT NULL,
  `id_asb_sub_sub_kelompok` bigint(20) NOT NULL,
  `id_aktivitas_asb` bigint(20) NOT NULL,
  `id_komponen_asb` bigint(20) NOT NULL,
  `id_komponen_asb_rinci` bigint(20) NOT NULL,
  `id_tarif_ssh` bigint(20) NOT NULL,
  `id_zona` int(11) NOT NULL,
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_pagu` decimal(20,2) DEFAULT '0.00',
  `kfix` decimal(20,4) DEFAULT '0.0000',
  `kmax` decimal(20,4) DEFAULT '0.0000',
  `kdv1` decimal(20,4) DEFAULT '0.0000',
  `kr1` decimal(20,4) DEFAULT '0.0000',
  `kdv2` decimal(20,4) DEFAULT '0.0000',
  `kr2` decimal(20,4) DEFAULT '0.0000',
  `kiv1` decimal(20,4) DEFAULT '0.0000',
  `kiv2` decimal(20,4) DEFAULT '0.0000',
  `kiv3` decimal(20,4) DEFAULT '0.0000',
  PRIMARY KEY (`id_perhitungan_rinci`) USING BTREE,
  UNIQUE KEY `id_trx_perhitungan_aktivitas` (`id_perhitungan`,`id_asb_kelompok`,`id_asb_sub_kelompok`,`id_aktivitas_asb`,`id_komponen_asb`,`id_komponen_asb_rinci`,`id_zona`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=729 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_perkada`
--

DROP TABLE IF EXISTS `trx_asb_perkada`;
CREATE TABLE IF NOT EXISTS `trx_asb_perkada` (
  `id_asb_perkada` int(11) NOT NULL AUTO_INCREMENT,
  `nomor_perkada` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_perkada` date NOT NULL,
  `tahun_berlaku` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `uraian_perkada` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  PRIMARY KEY (`id_asb_perkada`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_sub_kelompok`
--

DROP TABLE IF EXISTS `trx_asb_sub_kelompok`;
CREATE TABLE IF NOT EXISTS `trx_asb_sub_kelompok` (
  `id_asb_sub_kelompok` int(11) NOT NULL AUTO_INCREMENT,
  `id_asb_kelompok` int(11) NOT NULL,
  `uraian_sub_kelompok_asb` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `temp_id` float DEFAULT NULL,
  PRIMARY KEY (`id_asb_sub_kelompok`) USING BTREE,
  KEY `FK_trx_asb_cluster_trx_asb_perkada` (`id_asb_kelompok`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_sub_sub_kelompok`
--

DROP TABLE IF EXISTS `trx_asb_sub_sub_kelompok`;
CREATE TABLE IF NOT EXISTS `trx_asb_sub_sub_kelompok` (
  `id_asb_sub_sub_kelompok` int(11) NOT NULL AUTO_INCREMENT,
  `id_asb_sub_kelompok` int(11) NOT NULL,
  `uraian_sub_sub_kelompok_asb` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `temp_id` float DEFAULT NULL,
  PRIMARY KEY (`id_asb_sub_sub_kelompok`) USING BTREE,
  KEY `FK_trx_asb_cluster_trx_asb_perkada` (`id_asb_sub_kelompok`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd`
--

DROP TABLE IF EXISTS `trx_forum_skpd`;
CREATE TABLE IF NOT EXISTS `trx_forum_skpd` (
  `id_forum_skpd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_forum_program` bigint(20) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja` int(11) DEFAULT '0',
  `id_rkpd_renstra` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `id_kegiatan_renstra` int(11) DEFAULT '0',
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_forum` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun_kegiatan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_kegiatan_renstra` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_status` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 =  musrenbang',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal dilaksanakan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari renja 1 baru tambahan',
  `kelompok_sasaran` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_forum_skpd`) USING BTREE,
  UNIQUE KEY `id_unit_id_renja_id_kegiatan_ref` (`id_unit`,`id_kegiatan_ref`,`id_forum_program`) USING BTREE,
  KEY `FK_trx_forum_skpd_trx_forum_skpd_program` (`id_forum_program`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_aktivitas`
--

DROP TABLE IF EXISTS `trx_forum_skpd_aktivitas`;
CREATE TABLE IF NOT EXISTS `trx_forum_skpd_aktivitas` (
  `id_aktivitas_forum` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_forum_skpd` bigint(20) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT '0',
  `id_aktivitas_renja` int(11) DEFAULT '0',
  `uraian_aktivitas_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_aktivitas_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_aktivitas_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_aktivitas_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal',
  `keterangan_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja 1 tambahan baru',
  `id_satuan_publik` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_aktivitas_forum`) USING BTREE,
  KEY `FK_trx_forum_skpd_aktivitas_trx_forum_skpd` (`id_forum_skpd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_belanja`
--

DROP TABLE IF EXISTS `trx_forum_skpd_belanja`;
CREATE TABLE IF NOT EXISTS `trx_forum_skpd_belanja` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_forum` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_lokasi_forum` bigint(20) NOT NULL,
  `id_zona_ssh` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL DEFAULT '0',
  `sumber_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 asb 1 ssh',
  `id_aktivitas_asb` int(11) NOT NULL,
  `id_item_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL,
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '1',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1_forum` int(11) NOT NULL,
  `volume_2_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2_forum` int(11) NOT NULL DEFAULT '1',
  `harga_satuan_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL,
  PRIMARY KEY (`id_belanja_forum`) USING BTREE,
  UNIQUE KEY `id_trx_forum_skpd_belanja` (`tahun_forum`,`no_urut`,`id_belanja_forum`,`id_lokasi_forum`) USING BTREE,
  KEY `fk_trx_forum_skpd_belanja` (`id_lokasi_forum`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1390 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_dokumen`
--

DROP TABLE IF EXISTS `trx_forum_skpd_dokumen`;
CREATE TABLE IF NOT EXISTS `trx_forum_skpd_dokumen` (
  `id_dokumen_ranwal` int(11) NOT NULL AUTO_INCREMENT,
  `id_unit_renja` int(255) NOT NULL,
  `nomor_ranwal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_ranwal` date NOT NULL,
  `tahun_ranwal` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `uraian_perkada` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  PRIMARY KEY (`id_dokumen_ranwal`) USING BTREE,
  UNIQUE KEY `id_unit_renja` (`id_unit_renja`,`tahun_ranwal`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_kebijakan`
--

DROP TABLE IF EXISTS `trx_forum_skpd_kebijakan`;
CREATE TABLE IF NOT EXISTS `trx_forum_skpd_kebijakan` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_renja` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_kebijakan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kebijakan_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_renja`,`id_unit`,`no_urut`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_kegiatan_indikator`
--

DROP TABLE IF EXISTS `trx_forum_skpd_kegiatan_indikator`;
CREATE TABLE IF NOT EXISTS `trx_forum_skpd_kegiatan_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_forum_skpd` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_kegiatan` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_kegiatan`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_forum_skpd`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_forum_skpd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_lokasi`
--

DROP TABLE IF EXISTS `trx_forum_skpd_lokasi`;
CREATE TABLE IF NOT EXISTS `trx_forum_skpd_lokasi` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_forum` bigint(20) NOT NULL,
  `id_lokasi_forum` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_lokasi` int(11) NOT NULL,
  `id_lokasi_renja` int(11) DEFAULT '0',
  `id_lokasi_teknis` int(11) DEFAULT NULL,
  `jenis_lokasi` int(11) NOT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_desa` int(11) DEFAULT '0',
  `id_kecamatan` int(11) DEFAULT '0',
  `rt` int(11) DEFAULT '0',
  `rw` int(11) DEFAULT '0',
  `uraian_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lat` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan 2 musrenbang 3 pokir',
  PRIMARY KEY (`id_lokasi_forum`) USING BTREE,
  UNIQUE KEY `id_trx_forum_lokasi` (`id_pelaksana_forum`,`tahun_forum`,`no_urut`,`id_lokasi_forum`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_pelaksana`
--

DROP TABLE IF EXISTS `trx_forum_skpd_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_forum_skpd_pelaksana` (
  `id_pelaksana_forum` bigint(20) NOT NULL AUTO_INCREMENT,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_forum` bigint(11) NOT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) DEFAULT '0',
  `id_lokasi` int(11) DEFAULT '0' COMMENT 'lokasi penyelenggaraan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan',
  `ket_pelaksana` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal 2 baru',
  `status_data` int(11) NOT NULL COMMENT '0 draft 1 final',
  PRIMARY KEY (`id_pelaksana_forum`) USING BTREE,
  UNIQUE KEY `id_trx_forum_pelaksana` (`id_aktivitas_forum`,`tahun_forum`,`no_urut`,`id_pelaksana_forum`,`id_sub_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_program`
--

DROP TABLE IF EXISTS `trx_forum_skpd_program`;
CREATE TABLE IF NOT EXISTS `trx_forum_skpd_program` (
  `id_forum_program` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_forum_rkpdprog` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pdt 2 BTL',
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_renja_program` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `uraian_program_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_forum` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) DEFAULT NULL,
  PRIMARY KEY (`id_forum_program`) USING BTREE,
  UNIQUE KEY `id_unit_id_renja_program_id_program_ref` (`id_unit`,`id_renja_program`,`id_program_ref`) USING BTREE,
  KEY `FK_trx_forum_skpd_program_trx_forum_skpd_program_ranwal` (`id_forum_rkpdprog`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_program_indikator`
--

DROP TABLE IF EXISTS `trx_forum_skpd_program_indikator`;
CREATE TABLE IF NOT EXISTS `trx_forum_skpd_program_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_forum_program` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_program`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_forum_program`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_forum_program`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_program_ranwal`
--

DROP TABLE IF EXISTS `trx_forum_skpd_program_ranwal`;
CREATE TABLE IF NOT EXISTS `trx_forum_skpd_program_ranwal` (
  `id_forum_rkpdprog` int(11) NOT NULL AUTO_INCREMENT,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pdt 2 BTL',
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `id_bidang` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL DEFAULT '0',
  `uraian_program_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_ranwal` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_program` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Draft 1 = Posting Renja 2 = Posting Musren',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RPJMD 1 = Baru 2 = Luncuran tahun sebelumnya',
  PRIMARY KEY (`id_forum_rkpdprog`) USING BTREE,
  UNIQUE KEY `id_rkpd_ranwal_id_bidang_id_unit` (`id_rkpd_ranwal`,`id_bidang`,`id_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_usulan`
--

DROP TABLE IF EXISTS `trx_forum_skpd_usulan`;
CREATE TABLE IF NOT EXISTS `trx_forum_skpd_usulan` (
  `id_sumber_usulan` bigint(20) NOT NULL AUTO_INCREMENT,
  `sumber_usulan` int(11) DEFAULT '0' COMMENT '0 renja 1 musrendes 2 musrencam 3 pokir 4 forum_skpd',
  `id_lokasi_forum` bigint(20) NOT NULL,
  `id_ref_usulan` int(11) DEFAULT NULL,
  `volume_1_usulan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2_usulan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 tanpa 1 dengan 2 digabung 3 ditolak',
  `uraian_usulan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ket_usulan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_sumber_usulan`) USING BTREE,
  KEY `id_trx_forum_skpd_usulan` (`id_ref_usulan`,`id_sumber_usulan`,`id_lokasi_forum`) USING BTREE,
  KEY `FK_trx_forum_skpd_usulan_trx_forum_skpd_lokasi` (`id_lokasi_forum`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_group_menu`
--

DROP TABLE IF EXISTS `trx_group_menu`;
CREATE TABLE IF NOT EXISTS `trx_group_menu` (
  `menu` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  UNIQUE KEY `menu` (`menu`,`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Triggers `trx_group_menu`
--
DROP TRIGGER IF EXISTS `trg_agroup_menu`;
DELIMITER $$
CREATE TRIGGER `trg_agroup_menu` BEFORE INSERT ON `trx_group_menu` FOR EACH ROW IF new.group_id = 1 THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'You are not allowed to insert it!!';
END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_egroup_menu`;
DELIMITER $$
CREATE TRIGGER `trg_egroup_menu` BEFORE UPDATE ON `trx_group_menu` FOR EACH ROW IF old.group_id = 1 THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'This record is sacred! You are not allowed to update it!!';
END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_group_menu`;
DELIMITER $$
CREATE TRIGGER `trg_group_menu` BEFORE DELETE ON `trx_group_menu` FOR EACH ROW IF old.group_id = 1 THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'This record is sacred! You are not allowed to remove it!!';
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `trx_isian_data_dasar`
--

DROP TABLE IF EXISTS `trx_isian_data_dasar`;
CREATE TABLE IF NOT EXISTS `trx_isian_data_dasar` (
  `id_isian_tabel_dasar` int(11) NOT NULL AUTO_INCREMENT,
  `id_kolom_tabel_dasar` int(11) DEFAULT NULL,
  `id_kecamatan` int(11) DEFAULT NULL,
  `nmin1` decimal(20,2) DEFAULT '0.00',
  `nmin2` decimal(20,2) DEFAULT '0.00',
  `nmin3` decimal(20,2) DEFAULT '0.00',
  `nmin4` decimal(20,2) DEFAULT '0.00',
  `nmin5` decimal(20,2) DEFAULT '0.00',
  `tahun` int(4) DEFAULT NULL,
  `nmin1_persen` decimal(20,2) DEFAULT '0.00',
  `nmin2_persen` decimal(20,2) DEFAULT '0.00',
  `nmin3_persen` decimal(20,2) DEFAULT '0.00',
  `nmin4_persen` decimal(20,2) DEFAULT '0.00',
  `nmin5_persen` decimal(20,2) DEFAULT '0.00',
  PRIMARY KEY (`id_isian_tabel_dasar`) USING BTREE,
  KEY `id_kolom_tabel_dasar` (`id_kolom_tabel_dasar`) USING BTREE,
  KEY `id_kecamatan` (`id_kecamatan`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_log_api`
--

DROP TABLE IF EXISTS `trx_log_api`;
CREATE TABLE IF NOT EXISTS `trx_log_api` (
  `id_log` int(11) NOT NULL AUTO_INCREMENT,
  `tahun` int(11) NOT NULL,
  `id_app` int(11) NOT NULL,
  `id_unit` int(11) DEFAULT NULL,
  `tgl_kirim` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status_kirim` int(11) NOT NULL,
  `log_kirim` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trx_log_events`
--

DROP TABLE IF EXISTS `trx_log_events`;
CREATE TABLE IF NOT EXISTS `trx_log_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_events` int(11) NOT NULL DEFAULT '0',
  `discription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `operate` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrencam`
--

DROP TABLE IF EXISTS `trx_musrencam`;
CREATE TABLE IF NOT EXISTS `trx_musrencam` (
  `tahun_musren` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrencam` int(11) NOT NULL AUTO_INCREMENT,
  `id_renja` int(11) NOT NULL,
  `id_kecamatan` int(11) NOT NULL,
  `id_kegiatan` int(11) NOT NULL,
  `id_asb_aktivitas` int(11) NOT NULL,
  `uraian_aktivitas_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_kondisi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tolak_ukur_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_output_aktivitas` decimal(20,2) DEFAULT '0.00',
  `id_satuan` int(11) DEFAULT NULL,
  `id_satuan_desa` int(11) DEFAULT NULL,
  `volume` decimal(20,2) DEFAULT '0.00',
  `volume_desa` decimal(20,2) DEFAULT '0.00',
  `harga_satuan` decimal(20,2) DEFAULT '0.00',
  `harga_satuan_desa` decimal(20,2) DEFAULT '0.00',
  `jml_pagu` decimal(20,2) DEFAULT '0.00',
  `jml_pagu_desa` decimal(20,2) DEFAULT '0.00',
  `id_usulan_desa` bigint(255) DEFAULT NULL,
  `pagu_aktivitas` decimal(20,2) DEFAULT '0.00',
  `sumber_usulan` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Ranwal/Renja 1 = Desa 2 = Musrencam',
  `status_usulan` int(11) NOT NULL COMMENT '0 = Proses Usulan 1 = Kirim_Forum',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0= Diterima\r\n1= Diterima dengan perubahan\r\n2= Digabungkan dengan usulan lain\r\n3= Ditolak',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_musrencam`) USING BTREE,
  UNIQUE KEY `idx_trx_musrendes` (`id_renja`,`tahun_musren`,`no_urut`,`id_musrencam`,`id_kecamatan`,`id_usulan_desa`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrencam_lokasi`
--

DROP TABLE IF EXISTS `trx_musrencam_lokasi`;
CREATE TABLE IF NOT EXISTS `trx_musrencam_lokasi` (
  `tahun_musren` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrencam` int(11) NOT NULL,
  `id_lokasi_musrencam` int(11) NOT NULL AUTO_INCREMENT,
  `id_lokasi` int(11) NOT NULL COMMENT 'difilter hanya id lokasi yang jenis lokasinya kewilayahan',
  `id_desa` int(11) DEFAULT NULL,
  `rt` int(11) DEFAULT NULL,
  `rw` int(11) DEFAULT NULL,
  `uraian_kondisi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_foto` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lat` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_musrendes` int(11) DEFAULT NULL,
  `id_lokasi_musrendes` int(255) DEFAULT NULL,
  `sumber_data` int(11) DEFAULT NULL COMMENT '0 = desa 1 = kecamatan',
  `volume_desa` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume` decimal(20,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_lokasi_musrencam`) USING BTREE,
  UNIQUE KEY `idx_trx_musrendes_lokasi` (`id_musrencam`,`tahun_musren`,`no_urut`,`id_lokasi_musrencam`,`id_desa`,`rt`,`rw`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrendes`
--

DROP TABLE IF EXISTS `trx_musrendes`;
CREATE TABLE IF NOT EXISTS `trx_musrendes` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrendes` int(11) NOT NULL AUTO_INCREMENT,
  `id_renja` int(11) NOT NULL,
  `id_desa` int(11) NOT NULL,
  `id_kegiatan` int(11) NOT NULL,
  `id_asb_aktivitas` int(11) NOT NULL,
  `uraian_aktivitas_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_kondisi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tolak_ukur_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_output_aktivitas` decimal(20,2) DEFAULT '0.00',
  `id_satuan` int(11) DEFAULT NULL,
  `id_satuan_rw` int(11) DEFAULT NULL,
  `volume` decimal(20,2) DEFAULT '0.00',
  `volume_rw` decimal(20,2) DEFAULT '0.00',
  `harga_satuan` decimal(20,2) DEFAULT '0.00',
  `harga_satuan_rw` decimal(20,2) DEFAULT '0.00',
  `jml_pagu` decimal(20,2) DEFAULT '0.00',
  `jml_pagu_rw` decimal(20,2) DEFAULT '0.00',
  `id_usulan_rw` bigint(255) DEFAULT NULL,
  `pagu_aktivitas` decimal(20,2) DEFAULT '0.00',
  `sumber_usulan` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Ranwal/Renja 1 = RW 2 = Musrendes',
  `status_usulan` int(11) NOT NULL COMMENT '0 = Proses Usulan 1 = Kirim_Musrencam',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0= Diterima\r\n1= Diterima dengan perubahan\r\n2= Digabungkan dengan usulan lain\r\n3= Ditolak',
  PRIMARY KEY (`id_musrendes`) USING BTREE,
  UNIQUE KEY `idx_trx_musrendes` (`id_renja`,`tahun_renja`,`no_urut`,`id_musrendes`,`id_desa`,`id_usulan_rw`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrendes_lokasi`
--

DROP TABLE IF EXISTS `trx_musrendes_lokasi`;
CREATE TABLE IF NOT EXISTS `trx_musrendes_lokasi` (
  `tahun_musren` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrendes` int(11) NOT NULL,
  `id_lokasi_musrendes` int(11) NOT NULL AUTO_INCREMENT,
  `id_lokasi` int(11) NOT NULL COMMENT 'difilter hanya id lokasi yang jenis lokasinya kewilayahan',
  `id_desa` int(11) DEFAULT NULL,
  `rt` int(11) DEFAULT NULL,
  `rw` int(11) DEFAULT NULL,
  `uraian_kondisi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_foto` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lat` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) DEFAULT NULL COMMENT '0 = RW 1 = Desa',
  `volume_rw` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_desa` decimal(20,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_lokasi_musrendes`) USING BTREE,
  UNIQUE KEY `idx_trx_musrendes_lokasi` (`id_musrendes`,`tahun_musren`,`no_urut`,`id_lokasi_musrendes`,`id_desa`,`rt`,`rw`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrendes_rw`
--

DROP TABLE IF EXISTS `trx_musrendes_rw`;
CREATE TABLE IF NOT EXISTS `trx_musrendes_rw` (
  `tahun_musren` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrendes_rw` int(11) NOT NULL AUTO_INCREMENT,
  `id_renja` int(11) NOT NULL,
  `id_desa` int(11) NOT NULL,
  `id_kegiatan` int(11) NOT NULL,
  `id_asb_aktivitas` int(11) NOT NULL,
  `uraian_aktivitas_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_kondisi` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_satuan` int(11) NOT NULL DEFAULT '0',
  `volume` decimal(20,2) NOT NULL DEFAULT '0.00',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_pagu` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_usulan` int(11) NOT NULL COMMENT '0 = Proses Usulan 1 = Kirim_Musrencam',
  `rt` int(11) DEFAULT NULL,
  `rw` int(11) DEFAULT NULL,
  `lat` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_musrendes_rw`) USING BTREE,
  UNIQUE KEY `tahun_musren` (`tahun_musren`,`no_urut`,`id_renja`,`id_desa`,`id_kegiatan`,`id_asb_aktivitas`,`rt`,`rw`) USING BTREE,
  KEY `id_renja` (`id_renja`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrendes_rw_lokasi`
--

DROP TABLE IF EXISTS `trx_musrendes_rw_lokasi`;
CREATE TABLE IF NOT EXISTS `trx_musrendes_rw_lokasi` (
  `no_urut` int(11) NOT NULL,
  `id_musrendes_rw` int(11) NOT NULL,
  `id_musrendes_lokasi` int(11) NOT NULL AUTO_INCREMENT,
  `file_foto` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_kondisi` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lat` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_usulan` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Proses Usulan 1 = Kirim_Musrencam',
  PRIMARY KEY (`id_musrendes_lokasi`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab`
--

DROP TABLE IF EXISTS `trx_musrenkab`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab` (
  `id_musrenkab` int(11) NOT NULL AUTO_INCREMENT,
  `id_rkpd_ranwal` int(11) NOT NULL COMMENT '0 baru',
  `id_rkpd_rancangan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru',
  `no_urut` int(11) NOT NULL,
  `tahun_rkpd` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_rkpd_rpjmd` int(11) DEFAULT NULL,
  `thn_id_rpjmd` int(11) DEFAULT NULL,
  `id_visi_rpjmd` int(11) DEFAULT NULL,
  `id_misi_rpjmd` int(11) DEFAULT NULL,
  `id_tujuan_rpjmd` int(11) DEFAULT NULL,
  `id_sasaran_rpjmd` int(11) DEFAULT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `uraian_program_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_ranwal` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_program` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL COMMENT '0 = data tepat waktu sesuai renstra/rpjmd\\r\\n1 = data pergeseran waktu renstra/rpjmd\\r\\n2 = data baru yang belum ada di renstra/rpjmd\\r\\n9 = dibatalkan pelaksanaanya\\r\\n8 = ditunda dilaksanakan\\r\\n',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Draft 1 = Posting Renja 2 = Posting Musren',
  `ket_usulan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RPJMD 1 = Baru 2 = Luncuran tahun sebelumnya',
  `id_dokumen` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_musrenkab`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_ranwal` (`id_program_rpjmd`,`id_visi_rpjmd`,`id_sasaran_rpjmd`,`thn_id_rpjmd`,`id_rkpd_rancangan`,`id_tujuan_rpjmd`,`tahun_rkpd`,`no_urut`,`id_misi_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_aktivitas_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_aktivitas_pd`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_aktivitas_pd` (
  `id_aktivitas_pd` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_pelaksana_pd` bigint(20) NOT NULL,
  `id_aktivitas_forum` int(11) NOT NULL DEFAULT '0',
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT '0',
  `id_aktivitas_renja` int(11) DEFAULT '0',
  `uraian_aktivitas_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_aktivitas_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_aktivitas_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_aktivitas_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal',
  `keterangan_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja 1 tambahan baru',
  `id_satuan_publik` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_aktivitas_pd`) USING BTREE,
  KEY `FK_trx_forum_skpd_aktivitas_trx_forum_skpd` (`id_pelaksana_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_belanja_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_belanja_pd`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_belanja_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_belanja_forum` int(11) NOT NULL DEFAULT '0',
  `id_zona_ssh` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL DEFAULT '0',
  `sumber_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 asb 1 ssh',
  `id_aktivitas_asb` int(11) NOT NULL,
  `id_item_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL,
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '1',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1_forum` int(11) NOT NULL,
  `volume_2_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2_forum` int(11) NOT NULL DEFAULT '1',
  `harga_satuan_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL,
  PRIMARY KEY (`id_belanja_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_skpd_belanja` (`tahun_forum`,`no_urut`,`id_belanja_pd`,`id_aktivitas_pd`) USING BTREE,
  KEY `fk_trx_forum_skpd_belanja` (`id_aktivitas_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=737 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_dokumen`
--

DROP TABLE IF EXISTS `trx_musrenkab_dokumen`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_dokumen` (
  `id_dokumen_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `nomor_rkpd` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_rkpd` date NOT NULL,
  `tahun_rkpd` int(11) NOT NULL COMMENT 'tahun perencanaan',
  `uraian_perkada` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_unit_perencana` int(11) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  PRIMARY KEY (`id_dokumen_rkpd`) USING BTREE,
  UNIQUE KEY `tahun_ranwal` (`tahun_rkpd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_indikator`
--

DROP TABLE IF EXISTS `trx_musrenkab_indikator`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrenkab` int(11) NOT NULL,
  `id_indikator_program_rkpd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_indikator_rkpd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_rkpd` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 data rpjmd 1 data baru',
  PRIMARY KEY (`id_indikator_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_indikator` (`tahun_rkpd`,`id_musrenkab`,`kd_indikator`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_indikator` (`id_musrenkab`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_kebijakan`
--

DROP TABLE IF EXISTS `trx_musrenkab_kebijakan`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_kebijakan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrenkab` int(11) NOT NULL,
  `id_kebijakan_rancangan` int(11) NOT NULL,
  `id_kebijakan_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_kebijakan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kebijakan_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_ranwal_kebijakan` (`tahun_rkpd`,`id_musrenkab`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_kebijakan` (`id_musrenkab`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_kebijakan_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_kebijakan_pd`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_kebijakan_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_pd` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_kebijakan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kebijakan_pd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_renja`,`id_unit`,`no_urut`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_kegiatan_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_kegiatan_pd`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_kegiatan_pd` (
  `id_kegiatan_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_program_pd` bigint(20) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_forum_skpd` int(11) DEFAULT NULL,
  `id_renja` int(11) DEFAULT '0',
  `id_rkpd_renstra` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `id_kegiatan_renstra` int(11) DEFAULT '0',
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_forum` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun_kegiatan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_kegiatan_renstra` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_status` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 =  musrenbang',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal dilaksanakan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari renja 1 baru tambahan',
  `kelompok_sasaran` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kegiatan_pd`) USING BTREE,
  UNIQUE KEY `id_unit_id_renja_id_kegiatan_ref` (`id_unit`,`id_kegiatan_ref`,`id_program_pd`) USING BTREE,
  KEY `FK_trx_forum_skpd_trx_forum_skpd_program` (`id_program_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_keg_indikator_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_keg_indikator_pd`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_keg_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_kegiatan` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_kegiatan`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_kegiatan_pd`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_kegiatan_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_lokasi_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_lokasi_pd`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_lokasi_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_lokasi_forum` int(11) NOT NULL DEFAULT '0' COMMENT '0',
  `id_lokasi_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_lokasi` int(11) NOT NULL,
  `id_lokasi_renja` int(11) DEFAULT '0',
  `id_lokasi_teknis` int(11) DEFAULT NULL,
  `jenis_lokasi` int(11) NOT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_desa` int(11) DEFAULT '0',
  `id_kecamatan` int(11) DEFAULT '0',
  `rt` int(11) DEFAULT '0',
  `rw` int(11) DEFAULT '0',
  `uraian_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lat` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan 2 musrenbang 3 pokir',
  PRIMARY KEY (`id_lokasi_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_lokasi` (`id_aktivitas_pd`,`tahun_forum`,`no_urut`,`id_lokasi_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_pelaksana`
--

DROP TABLE IF EXISTS `trx_musrenkab_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `id_musrenkab` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `hak_akses` int(11) NOT NULL DEFAULT '0' COMMENT '0 tidak dapat menambah data 1 dapat menambah data',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 dibatalkan',
  `ket_pelaksanaan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  PRIMARY KEY (`id_pelaksana_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_musrenkab`,`id_unit`,`id_urusan_rkpd`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_musrenkab`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_urusan_rkpd`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_2` (`id_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_pelaksana_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_pelaksana_pd`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_pelaksana_pd` (
  `id_pelaksana_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_pelaksana_forum` int(11) DEFAULT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) DEFAULT '0',
  `id_lokasi` int(11) DEFAULT '0' COMMENT 'lokasi penyelenggaraan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan',
  `ket_pelaksana` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal 2 baru',
  `status_data` int(11) NOT NULL COMMENT '0 draft 1 final',
  PRIMARY KEY (`id_pelaksana_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_pelaksana` (`id_kegiatan_pd`,`tahun_forum`,`no_urut`,`id_pelaksana_pd`,`id_sub_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_program_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_program_pd`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_program_pd` (
  `id_program_pd` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_pelaksana_rkpd` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pdt 2 BTL',
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) DEFAULT NULL,
  `id_renja_program` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `uraian_program_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_forum` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) DEFAULT NULL,
  PRIMARY KEY (`id_program_pd`) USING BTREE,
  KEY `FK_trx_forum_skpd_program_trx_forum_skpd_program_ranwal` (`id_pelaksana_rkpd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_prog_indikator_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_prog_indikator_pd`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_prog_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_pd` bigint(11) NOT NULL,
  `id_program_forum` int(11) NOT NULL DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_program`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_program_pd`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_program_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_urusan`
--

DROP TABLE IF EXISTS `trx_musrenkab_urusan`;
CREATE TABLE IF NOT EXISTS `trx_musrenkab_urusan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `id_musrenkab` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `id_bidang` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  PRIMARY KEY (`id_urusan_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_musrenkab`,`id_bidang`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_musrenkab`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_bidang`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_pokir`
--

DROP TABLE IF EXISTS `trx_pokir`;
CREATE TABLE IF NOT EXISTS `trx_pokir` (
  `id_tahun` int(11) NOT NULL,
  `id_pokir` int(11) NOT NULL AUTO_INCREMENT,
  `tanggal_pengusul` date NOT NULL,
  `asal_pengusul` int(11) NOT NULL DEFAULT '0' COMMENT '0 Fraksi\r\n1 Pempinan\r\n2 Badan Musyawarah\r\n3 Komisi\r\n4 Badan Legislasi Daerah\r\n5 Badan Anggaran\r\n6 Badan Kehormatan\r\n9 Badan Lainnya',
  `jabatan_pengusul` int(11) NOT NULL DEFAULT '4' COMMENT '0 ketua 1 wakil ketua 2 sekretaris 3 bendahara 4 anggota',
  `nama_pengusul` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nomor_anggota` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `daerah_pemilihan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media_pokir` int(11) DEFAULT '0' COMMENT '1 surat 2 email 3 telepon 4 lisan 9 lainnya',
  `bukti_dokumen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `entried_at` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_pokir`) USING BTREE,
  UNIQUE KEY `id_tahun` (`id_tahun`,`tanggal_pengusul`,`asal_pengusul`,`jabatan_pengusul`,`nomor_anggota`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_pokir_lokasi`
--

DROP TABLE IF EXISTS `trx_pokir_lokasi`;
CREATE TABLE IF NOT EXISTS `trx_pokir_lokasi` (
  `id_pokir_usulan` int(11) NOT NULL,
  `id_pokir_lokasi` int(11) NOT NULL AUTO_INCREMENT,
  `id_kecamatan` int(11) NOT NULL,
  `id_desa` int(11) DEFAULT NULL,
  `rw` int(11) DEFAULT NULL,
  `rt` int(11) DEFAULT NULL,
  `diskripsi_lokasi` blob,
  PRIMARY KEY (`id_pokir_lokasi`) USING BTREE,
  UNIQUE KEY `id_pokir_usulan` (`id_pokir_usulan`,`id_kecamatan`,`id_desa`,`rw`,`rt`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_pokir_tl`
--

DROP TABLE IF EXISTS `trx_pokir_tl`;
CREATE TABLE IF NOT EXISTS `trx_pokir_tl` (
  `id_pokir_tl` int(11) NOT NULL AUTO_INCREMENT,
  `id_pokir` int(11) NOT NULL,
  `id_pokir_usulan` int(11) NOT NULL,
  `id_pokir_lokasi` int(11) NOT NULL,
  `unit_tl` int(11) DEFAULT NULL,
  `status_tl` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Belum TL, 1 = Disposisi Ke Unit, 2 = Dipending, 3 = Perlu Dibahas kembali  4 = tidak diakomodir',
  `keterangan_status` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_pokir_tl`) USING BTREE,
  UNIQUE KEY `id_pokir_usulan` (`id_pokir`,`id_pokir_usulan`,`id_pokir_lokasi`) USING BTREE,
  KEY `trx_pokir_tl_ibfk_1` (`id_pokir_usulan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_pokir_tl_unit`
--

DROP TABLE IF EXISTS `trx_pokir_tl_unit`;
CREATE TABLE IF NOT EXISTS `trx_pokir_tl_unit` (
  `id_pokir_unit` int(11) NOT NULL AUTO_INCREMENT,
  `unit_tl` int(11) DEFAULT NULL,
  `id_pokir_tl` int(11) NOT NULL,
  `id_pokir` int(11) NOT NULL,
  `id_pokir_usulan` int(11) NOT NULL,
  `id_pokir_lokasi` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL DEFAULT '0',
  `id_lokasi_renja` int(11) NOT NULL DEFAULT '0',
  `id_aktivitas_forum` int(11) NOT NULL DEFAULT '0',
  `id_lokasi_forum` int(11) NOT NULL DEFAULT '0',
  `volume_tl` decimal(20,2) DEFAULT '0.00',
  `pagu_tl` decimal(20,2) DEFAULT '0.00',
  `status_tl` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Belum TL, 1 = Diakomodir Renja, 2 = Diakomodir Forum, 3 = Tidak diakomodir',
  `keterangan_status` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_pokir_unit`) USING BTREE,
  UNIQUE KEY `id_pokir_usulan` (`id_pokir`,`id_pokir_usulan`,`id_pokir_lokasi`) USING BTREE,
  KEY `trx_pokir_tl_ibfk_1` (`id_pokir_usulan`) USING BTREE,
  KEY `trx_pokir_tl_unit_ibfk_1` (`id_pokir_tl`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_pokir_usulan`
--

DROP TABLE IF EXISTS `trx_pokir_usulan`;
CREATE TABLE IF NOT EXISTS `trx_pokir_usulan` (
  `id_pokir` int(11) NOT NULL,
  `id_pokir_usulan` int(11) NOT NULL AUTO_INCREMENT,
  `no_urut` int(11) NOT NULL DEFAULT '1',
  `id_judul_usulan` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diskripsi_usulan` blob,
  `id_unit` int(11) DEFAULT NULL,
  `volume` decimal(20,2) DEFAULT '0.00',
  `id_satuan` int(11) DEFAULT NULL,
  `jml_anggaran` decimal(20,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `entried_at` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_pokir_usulan`) USING BTREE,
  UNIQUE KEY `id_pokir` (`id_pokir`,`no_urut`) USING BTREE,
  KEY `id_unit` (`id_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_prioritas_nasional`
--

DROP TABLE IF EXISTS `trx_prioritas_nasional`;
CREATE TABLE IF NOT EXISTS `trx_prioritas_nasional` (
  `tahun` int(11) NOT NULL,
  `id_prioritas` int(11) NOT NULL AUTO_INCREMENT,
  `nama_prioritas` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_prioritas`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_prioritas_pemda`
--

DROP TABLE IF EXISTS `trx_prioritas_pemda`;
CREATE TABLE IF NOT EXISTS `trx_prioritas_pemda` (
  `id_tema_rkpd` int(11) NOT NULL,
  `id_prioritas` int(11) NOT NULL AUTO_INCREMENT,
  `nama_prioritas` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_prioritas`) USING BTREE,
  KEY `id_tema_rkpd` (`id_tema_rkpd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_prioritas_pemda_tema`
--

DROP TABLE IF EXISTS `trx_prioritas_pemda_tema`;
CREATE TABLE IF NOT EXISTS `trx_prioritas_pemda_tema` (
  `tahun` int(11) NOT NULL,
  `id_tema_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_tema` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_tema_rkpd`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_prioritas_provinsi`
--

DROP TABLE IF EXISTS `trx_prioritas_provinsi`;
CREATE TABLE IF NOT EXISTS `trx_prioritas_provinsi` (
  `tahun` int(11) NOT NULL,
  `id_prioritas` int(11) NOT NULL AUTO_INCREMENT,
  `nama_prioritas` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_prioritas`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_program_nasional`
--

DROP TABLE IF EXISTS `trx_program_nasional`;
CREATE TABLE IF NOT EXISTS `trx_program_nasional` (
  `id_prioritas` int(11) NOT NULL,
  `id_prognas` int(11) NOT NULL,
  `uraian_program_nasional` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_prognas`) USING BTREE,
  KEY `id_prioritas` (`id_prioritas`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_program_nasional_detail`
--

DROP TABLE IF EXISTS `trx_program_nasional_detail`;
CREATE TABLE IF NOT EXISTS `trx_program_nasional_detail` (
  `id_prognas_unit` int(11) NOT NULL,
  `id_prognas_item` bigint(11) NOT NULL,
  `id_kegiatan_pd` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_prognas_item`) USING BTREE,
  UNIQUE KEY `id_prognas_unit` (`id_prognas_unit`,`id_kegiatan_pd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_program_nasional_unit`
--

DROP TABLE IF EXISTS `trx_program_nasional_unit`;
CREATE TABLE IF NOT EXISTS `trx_program_nasional_unit` (
  `id_prognas` int(11) NOT NULL,
  `id_prognas_unit` int(11) NOT NULL,
  `id_unit` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_prognas_unit`) USING BTREE,
  UNIQUE KEY `id_prognas` (`id_prognas`,`id_unit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_program_provinsi`
--

DROP TABLE IF EXISTS `trx_program_provinsi`;
CREATE TABLE IF NOT EXISTS `trx_program_provinsi` (
  `id_prioritas` int(11) NOT NULL,
  `id_progprov` int(11) NOT NULL,
  `uraian_program_provinsi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_progprov`) USING BTREE,
  KEY `id_prioritas` (`id_prioritas`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_program_provinsi_detail`
--

DROP TABLE IF EXISTS `trx_program_provinsi_detail`;
CREATE TABLE IF NOT EXISTS `trx_program_provinsi_detail` (
  `id_progprov_unit` int(11) NOT NULL,
  `id_progprov_item` bigint(11) NOT NULL,
  `id_kegiatan_pd` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_progprov_item`) USING BTREE,
  UNIQUE KEY `id_progprov_unit` (`id_progprov_unit`,`id_kegiatan_pd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_program_provinsi_unit`
--

DROP TABLE IF EXISTS `trx_program_provinsi_unit`;
CREATE TABLE IF NOT EXISTS `trx_program_provinsi_unit` (
  `id_progprov` int(11) NOT NULL,
  `id_progprov_unit` int(11) NOT NULL,
  `id_unit` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id_progprov_unit`) USING BTREE,
  UNIQUE KEY `id_progprov` (`id_progprov`,`id_unit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_aktivitas`
--

DROP TABLE IF EXISTS `trx_renja_aktivitas`;
CREATE TABLE IF NOT EXISTS `trx_renja_aktivitas` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL AUTO_INCREMENT,
  `id_renja` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT NULL,
  `id_satuan_publik` int(11) DEFAULT NULL,
  `uraian_aktivitas_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tolak_ukur_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_output_aktivitas` decimal(20,2) DEFAULT '0.00',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rata2` decimal(20,2) DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(255) DEFAULT NULL,
  `id_satuan_2` int(255) DEFAULT NULL,
  PRIMARY KEY (`id_aktivitas_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_rancangan_renja_pelaksana` (`id_renja`,`tahun_renja`,`no_urut`,`id_aktivitas_renja`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_belanja`
--

DROP TABLE IF EXISTS `trx_renja_belanja`;
CREATE TABLE IF NOT EXISTS `trx_renja_belanja` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL AUTO_INCREMENT,
  `id_lokasi_renja` int(11) NOT NULL,
  `id_zona_ssh` int(11) NOT NULL DEFAULT '0',
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '1 ssh 0 asb',
  `id_aktivitas_asb` bigint(20) DEFAULT NULL,
  `id_tarif_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_belanja_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_belanja` (`id_lokasi_renja`,`tahun_renja`,`no_urut`,`id_belanja_renja`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_dokumen`
--

DROP TABLE IF EXISTS `trx_renja_dokumen`;
CREATE TABLE IF NOT EXISTS `trx_renja_dokumen` (
  `id_dokumen_ranwal` int(11) NOT NULL AUTO_INCREMENT,
  `id_unit_renja` int(255) NOT NULL,
  `nomor_ranwal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_ranwal` date NOT NULL,
  `tahun_ranwal` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `uraian_perkada` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  `jns_dokumen` int(255) NOT NULL,
  `id_dokumen_ref` int(255) NOT NULL DEFAULT '0',
  `id_perubahan` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_dokumen_ranwal`) USING BTREE,
  UNIQUE KEY `id_unit_renja` (`id_unit_renja`,`tahun_ranwal`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_kebijakan`
--

DROP TABLE IF EXISTS `trx_renja_kebijakan`;
CREATE TABLE IF NOT EXISTS `trx_renja_kebijakan` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_renja` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_kebijakan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_kebijakan_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_kebijakan` (`tahun_renja`,`id_unit`,`no_urut`,`id_sasaran_renstra`,`id_kebijakan_renja`,`id_renja`) USING BTREE,
  KEY `fk_trx_renja_rancangan_kebijakan` (`id_sasaran_renstra`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_kegiatan`
--

DROP TABLE IF EXISTS `trx_renja_kegiatan`;
CREATE TABLE IF NOT EXISTS `trx_renja_kegiatan` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL COMMENT 'juga menunjukkan prioritas',
  `id_renja` int(11) NOT NULL AUTO_INCREMENT,
  `id_renja_program` bigint(11) NOT NULL,
  `id_rkpd_renstra` int(11) DEFAULT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) DEFAULT NULL,
  `id_misi_renstra` int(11) DEFAULT NULL,
  `id_tujuan_renstra` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `uraian_program_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_kegiatan` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_selanjutnya` decimal(20,2) DEFAULT '0.00',
  `status_pelaksanaan_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 = tepat 1 = dimajukan 2 = ditunda 3 dibatalkan 4 baru',
  `pagu_musrenbang` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja skpd 1 =  tambahan baru',
  `ket_usulan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 Final',
  `status_rancangan` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum selesai 1 siap kirim ke forum',
  `kelompok_sasaran` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_rancangan_renja` (`id_rkpd_renstra`,`tahun_renja`,`no_urut`,`id_renja`) USING BTREE,
  KEY `idx_trx_rancangan_renja_1` (`id_rkpd_ranwal`) USING BTREE,
  KEY `id_program_renstra` (`id_program_renstra`) USING BTREE,
  KEY `id_sasaran_renstra` (`id_sasaran_renstra`) USING BTREE,
  KEY `FK_trx_renja_rancangan_trx_renja_rancangan_program` (`id_renja_program`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_kegiatan_indikator`
--

DROP TABLE IF EXISTS `trx_renja_kegiatan_indikator`;
CREATE TABLE IF NOT EXISTS `trx_renja_kegiatan_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_indikator_kegiatan_renja` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan_renja` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `angka_tahun` decimal(20,2) DEFAULT '0.00',
  `angka_renstra` decimal(20,2) DEFAULT '0.00',
  `id_satuan_output` int(255) DEFAULT NULL,
  `status_data` int(11) DEFAULT '0' COMMENT '0 draft 1 final',
  `sumber_data` int(11) DEFAULT '0' COMMENT '0 renstra 1 tambahan',
  PRIMARY KEY (`id_indikator_kegiatan_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_renja`) USING BTREE,
  KEY `FK_trx_renja_rancangan_indikator_trx_renja_rancangan` (`id_renja`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_lokasi`
--

DROP TABLE IF EXISTS `trx_renja_lokasi`;
CREATE TABLE IF NOT EXISTS `trx_renja_lokasi` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) NOT NULL,
  `id_lokasi_renja` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_lokasi` int(11) NOT NULL COMMENT '0 kewilayah 1 teknis',
  `id_lokasi` int(11) NOT NULL,
  `id_kecamatan` int(11) DEFAULT NULL,
  `id_desa` int(11) DEFAULT NULL,
  `rt` int(11) DEFAULT NULL,
  `rw` int(11) DEFAULT NULL,
  `uraian_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lat` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_lokasi_renja`) USING BTREE,
  UNIQUE KEY `idx_rancangan_renja_lokasi` (`id_pelaksana_renja`,`tahun_renja`,`no_urut`,`id_lokasi_renja`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_pelaksana`
--

DROP TABLE IF EXISTS `trx_renja_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_renja_pelaksana` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) NOT NULL AUTO_INCREMENT,
  `id_renja` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) DEFAULT '0',
  `ket_usul` int(11) DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `id_lokasi` int(11) NOT NULL DEFAULT '0' COMMENT 'Lokasi Penyelenggaraan Kegiatan',
  PRIMARY KEY (`id_pelaksana_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_rancangan_renja_pelaksana` (`id_renja`,`tahun_renja`,`no_urut`,`id_pelaksana_renja`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_program`
--

DROP TABLE IF EXISTS `trx_renja_program`;
CREATE TABLE IF NOT EXISTS `trx_renja_program` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL AUTO_INCREMENT,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_renja_ranwal` int(11) NOT NULL DEFAULT '0',
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `id_bidang` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) DEFAULT NULL,
  `id_misi_renstra` int(11) DEFAULT NULL,
  `id_tujuan_renstra` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `uraian_program_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_ranwal` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `status_program_rkpd` int(11) DEFAULT NULL COMMENT 'status pelaksanaan unit di rkpd',
  `sumber_data_rkpd` int(11) DEFAULT NULL COMMENT 'sumber usulan pelaksana unit di rkpd',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_renja_program`) USING BTREE,
  UNIQUE KEY `idx_trx_rancangan_renja` (`tahun_renja`,`no_urut`,`id_rkpd_ranwal`,`id_program_rpjmd`,`id_unit`,`id_bidang`,`id_renja_ranwal`) USING BTREE,
  KEY `idx_trx_rancangan_renja_1` (`id_rkpd_ranwal`) USING BTREE,
  KEY `id_program_renstra` (`id_program_renstra`) USING BTREE,
  KEY `id_sasaran_renstra` (`id_sasaran_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_ibfk_2` (`id_renja_ranwal`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_program_indikator`
--

DROP TABLE IF EXISTS `trx_renja_program_indikator`;
CREATE TABLE IF NOT EXISTS `trx_renja_program_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program_renja` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_renja` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_program_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_renja_program`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_renja_program`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_program_rkpd`
--

DROP TABLE IF EXISTS `trx_renja_program_rkpd`;
CREATE TABLE IF NOT EXISTS `trx_renja_program_rkpd` (
  `tahun_renja` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_renja_ranwal` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `uraian_program_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `jml_data` int(11) NOT NULL DEFAULT '0',
  `jml_baru` int(11) NOT NULL DEFAULT '0',
  `jml_lama` int(11) NOT NULL DEFAULT '0',
  `jml_tepat` int(11) NOT NULL DEFAULT '0',
  `jml_maju` int(11) NOT NULL DEFAULT '0',
  `jml_tunda` int(11) NOT NULL DEFAULT '0',
  `jml_batal` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_renja_ranwal`) USING BTREE,
  UNIQUE KEY `tahun_renja_id_rkpd_ranwal_id_unit` (`tahun_renja`,`id_rkpd_ranwal`,`id_unit`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan`
--

DROP TABLE IF EXISTS `trx_renja_rancangan`;
CREATE TABLE IF NOT EXISTS `trx_renja_rancangan` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL COMMENT 'juga menunjukkan prioritas',
  `id_renja` int(11) NOT NULL AUTO_INCREMENT,
  `id_renja_program` bigint(11) NOT NULL,
  `id_rkpd_renstra` int(11) DEFAULT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) DEFAULT NULL,
  `id_misi_renstra` int(11) DEFAULT NULL,
  `id_tujuan_renstra` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `uraian_program_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_kegiatan` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_selanjutnya` decimal(20,2) DEFAULT '0.00',
  `status_pelaksanaan_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 = tepat 1 = dimajukan 2 = ditunda 3 dibatalkan 4 baru',
  `pagu_musrenbang` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja skpd 1 =  tambahan baru',
  `ket_usulan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 Final',
  `status_rancangan` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum selesai 1 siap kirim ke forum',
  `kelompok_sasaran` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_rancangan_renja` (`id_rkpd_renstra`,`tahun_renja`,`no_urut`,`id_renja`) USING BTREE,
  KEY `idx_trx_rancangan_renja_1` (`id_rkpd_ranwal`) USING BTREE,
  KEY `id_program_renstra` (`id_program_renstra`) USING BTREE,
  KEY `id_sasaran_renstra` (`id_sasaran_renstra`) USING BTREE,
  KEY `FK_trx_renja_rancangan_trx_renja_rancangan_program` (`id_renja_program`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_aktivitas`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_aktivitas`;
CREATE TABLE IF NOT EXISTS `trx_renja_rancangan_aktivitas` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL AUTO_INCREMENT,
  `id_renja` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT NULL,
  `id_satuan_publik` int(11) DEFAULT NULL,
  `uraian_aktivitas_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tolak_ukur_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_output_aktivitas` decimal(20,2) DEFAULT '0.00',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rata2` decimal(20,2) DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(255) DEFAULT NULL,
  `id_satuan_2` int(255) DEFAULT NULL,
  PRIMARY KEY (`id_aktivitas_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_rancangan_renja_pelaksana` (`id_renja`,`tahun_renja`,`no_urut`,`id_aktivitas_renja`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_belanja`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_belanja`;
CREATE TABLE IF NOT EXISTS `trx_renja_rancangan_belanja` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL AUTO_INCREMENT,
  `id_lokasi_renja` int(11) NOT NULL,
  `id_zona_ssh` int(11) NOT NULL DEFAULT '0',
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '1 ssh 0 asb',
  `id_aktivitas_asb` bigint(20) DEFAULT NULL,
  `id_tarif_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_belanja_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_belanja` (`id_lokasi_renja`,`tahun_renja`,`no_urut`,`id_belanja_renja`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=358 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_dokumen`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_dokumen`;
CREATE TABLE IF NOT EXISTS `trx_renja_rancangan_dokumen` (
  `id_dokumen_ranwal` int(11) NOT NULL AUTO_INCREMENT,
  `id_unit_renja` int(255) NOT NULL,
  `nomor_ranwal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_ranwal` date NOT NULL,
  `tahun_ranwal` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `uraian_perkada` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  PRIMARY KEY (`id_dokumen_ranwal`) USING BTREE,
  UNIQUE KEY `id_unit_renja` (`id_unit_renja`,`tahun_ranwal`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_indikator`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_indikator`;
CREATE TABLE IF NOT EXISTS `trx_renja_rancangan_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_indikator_kegiatan_renja` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan_renja` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `angka_tahun` decimal(20,2) DEFAULT '0.00',
  `angka_renstra` decimal(20,2) DEFAULT '0.00',
  `id_satuan_output` int(255) DEFAULT NULL,
  `status_data` int(11) DEFAULT '0' COMMENT '0 draft 1 final',
  `sumber_data` int(11) DEFAULT '0' COMMENT '0 renstra 1 tambahan',
  PRIMARY KEY (`id_indikator_kegiatan_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_renja`) USING BTREE,
  KEY `FK_trx_renja_rancangan_indikator_trx_renja_rancangan` (`id_renja`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_kebijakan`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_kebijakan`;
CREATE TABLE IF NOT EXISTS `trx_renja_rancangan_kebijakan` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_renja` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_kebijakan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_kebijakan_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_kebijakan` (`tahun_renja`,`id_unit`,`no_urut`,`id_sasaran_renstra`,`id_kebijakan_renja`,`id_renja`) USING BTREE,
  KEY `fk_trx_renja_rancangan_kebijakan` (`id_sasaran_renstra`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_lokasi`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_lokasi`;
CREATE TABLE IF NOT EXISTS `trx_renja_rancangan_lokasi` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) NOT NULL,
  `id_lokasi_renja` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_lokasi` int(11) NOT NULL COMMENT '0 kewilayah 1 teknis',
  `id_lokasi` int(11) NOT NULL,
  `id_kecamatan` int(11) DEFAULT NULL,
  `id_desa` int(11) DEFAULT NULL,
  `rt` int(11) DEFAULT NULL,
  `rw` int(11) DEFAULT NULL,
  `uraian_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lat` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_lokasi_renja`) USING BTREE,
  UNIQUE KEY `idx_rancangan_renja_lokasi` (`id_pelaksana_renja`,`tahun_renja`,`no_urut`,`id_lokasi_renja`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_pelaksana`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_renja_rancangan_pelaksana` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) NOT NULL AUTO_INCREMENT,
  `id_renja` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) DEFAULT '0',
  `ket_usul` int(11) DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `id_lokasi` int(11) NOT NULL DEFAULT '0' COMMENT 'Lokasi Penyelenggaraan Kegiatan',
  PRIMARY KEY (`id_pelaksana_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_rancangan_renja_pelaksana` (`id_renja`,`tahun_renja`,`no_urut`,`id_pelaksana_renja`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_program`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_program`;
CREATE TABLE IF NOT EXISTS `trx_renja_rancangan_program` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL AUTO_INCREMENT,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_renja_ranwal` int(11) NOT NULL DEFAULT '0',
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `id_bidang` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) DEFAULT NULL,
  `id_misi_renstra` int(11) DEFAULT NULL,
  `id_tujuan_renstra` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `uraian_program_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_ranwal` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `status_program_rkpd` int(11) DEFAULT NULL COMMENT 'status pelaksanaan unit di rkpd',
  `sumber_data_rkpd` int(11) DEFAULT NULL COMMENT 'sumber usulan pelaksana unit di rkpd',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_renja_program`) USING BTREE,
  UNIQUE KEY `idx_trx_rancangan_renja` (`tahun_renja`,`no_urut`,`id_rkpd_ranwal`,`id_program_rpjmd`,`id_unit`,`id_bidang`,`id_renja_ranwal`) USING BTREE,
  KEY `idx_trx_rancangan_renja_1` (`id_rkpd_ranwal`) USING BTREE,
  KEY `id_program_renstra` (`id_program_renstra`) USING BTREE,
  KEY `id_sasaran_renstra` (`id_sasaran_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_ibfk_2` (`id_renja_ranwal`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_program_indikator`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_program_indikator`;
CREATE TABLE IF NOT EXISTS `trx_renja_rancangan_program_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program_renja` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_renja` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_output` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_program_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_renja_program`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_renja_program`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_program_ranwal`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_program_ranwal`;
CREATE TABLE IF NOT EXISTS `trx_renja_rancangan_program_ranwal` (
  `tahun_renja` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_renja_ranwal` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `uraian_program_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `jml_data` int(11) NOT NULL DEFAULT '0',
  `jml_baru` int(11) NOT NULL DEFAULT '0',
  `jml_lama` int(11) NOT NULL DEFAULT '0',
  `jml_tepat` int(11) NOT NULL DEFAULT '0',
  `jml_maju` int(11) NOT NULL DEFAULT '0',
  `jml_tunda` int(11) NOT NULL DEFAULT '0',
  `jml_batal` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_renja_ranwal`) USING BTREE,
  UNIQUE KEY `tahun_renja_id_rkpd_ranwal_id_unit` (`tahun_renja`,`id_rkpd_ranwal`,`id_unit`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_ref_pokir`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_ref_pokir`;
CREATE TABLE IF NOT EXISTS `trx_renja_rancangan_ref_pokir` (
  `id_aktivitas_renja` int(11) NOT NULL,
  `id_pokir_usulan` int(11) NOT NULL,
  `id_ref_pokir_renja` int(11) NOT NULL,
  PRIMARY KEY (`id_ref_pokir_renja`) USING BTREE,
  UNIQUE KEY `id_aktivitas_renja` (`id_aktivitas_renja`,`id_pokir_usulan`) USING BTREE,
  KEY `id_pokir_usulan` (`id_pokir_usulan`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_aktivitas`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_aktivitas`;
CREATE TABLE IF NOT EXISTS `trx_renja_ranwal_aktivitas` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL AUTO_INCREMENT,
  `id_renja` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT NULL,
  `id_satuan_publik` int(11) DEFAULT NULL,
  `uraian_aktivitas_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tolak_ukur_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_output_aktivitas` decimal(20,2) DEFAULT '0.00',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rata2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(255) DEFAULT NULL,
  `id_satuan_2` int(255) DEFAULT NULL,
  PRIMARY KEY (`id_aktivitas_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_rancangan_renja_pelaksana` (`id_renja`,`tahun_renja`,`no_urut`,`id_aktivitas_renja`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_dokumen`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_dokumen`;
CREATE TABLE IF NOT EXISTS `trx_renja_ranwal_dokumen` (
  `id_dokumen_ranwal` int(11) NOT NULL AUTO_INCREMENT,
  `id_unit_renja` int(255) NOT NULL,
  `nomor_ranwal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_ranwal` date NOT NULL,
  `tahun_ranwal` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `uraian_perkada` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  PRIMARY KEY (`id_dokumen_ranwal`) USING BTREE,
  UNIQUE KEY `id_unit_renja` (`id_unit_renja`,`tahun_ranwal`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_kegiatan`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_kegiatan`;
CREATE TABLE IF NOT EXISTS `trx_renja_ranwal_kegiatan` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL COMMENT 'juga menunjukkan prioritas',
  `id_renja` int(11) NOT NULL AUTO_INCREMENT,
  `id_renja_program` bigint(11) NOT NULL,
  `id_rkpd_renstra` int(11) DEFAULT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) DEFAULT NULL,
  `id_misi_renstra` int(11) DEFAULT NULL,
  `id_tujuan_renstra` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `uraian_program_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_kegiatan` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_selanjutnya` decimal(20,2) DEFAULT '0.00',
  `status_pelaksanaan_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 = tepat 1 = dimajukan 2 = ditunda 3 dibatalkan 4 baru',
  `pagu_musrenbang` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja skpd 1 =  tambahan baru',
  `ket_usulan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 Final',
  `status_rancangan` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum selesai 1 siap kirim ke forum',
  `kelompok_sasaran` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_rancangan_renja` (`id_rkpd_renstra`,`tahun_renja`,`no_urut`,`id_renja`) USING BTREE,
  KEY `idx_trx_rancangan_renja_1` (`id_rkpd_ranwal`) USING BTREE,
  KEY `id_program_renstra` (`id_program_renstra`) USING BTREE,
  KEY `id_sasaran_renstra` (`id_sasaran_renstra`) USING BTREE,
  KEY `FK_trx_renja_rancangan_trx_renja_rancangan_program` (`id_renja_program`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_kegiatan_indikator`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_kegiatan_indikator`;
CREATE TABLE IF NOT EXISTS `trx_renja_ranwal_kegiatan_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_indikator_kegiatan_renja` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan_renja` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `angka_tahun` decimal(20,2) DEFAULT '0.00',
  `angka_renstra` decimal(20,2) DEFAULT '0.00',
  `id_satuan_output` int(255) DEFAULT NULL,
  `status_data` int(11) DEFAULT '0' COMMENT '0 draft 1 final',
  `sumber_data` int(11) DEFAULT '0' COMMENT '0 renstra 1 tambahan',
  PRIMARY KEY (`id_indikator_kegiatan_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_renja`) USING BTREE,
  KEY `FK_trx_renja_rancangan_indikator_trx_renja_rancangan` (`id_renja`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_pelaksana`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_renja_ranwal_pelaksana` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) NOT NULL AUTO_INCREMENT,
  `id_renja` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL DEFAULT '0',
  `id_sub_unit` int(11) NOT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) DEFAULT '0',
  `ket_usul` int(11) DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `id_lokasi` int(11) NOT NULL DEFAULT '0' COMMENT 'Lokasi Penyelenggaraan Kegiatan',
  PRIMARY KEY (`id_pelaksana_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_rancangan_renja_pelaksana` (`id_renja`,`tahun_renja`,`no_urut`,`id_pelaksana_renja`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_program`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_program`;
CREATE TABLE IF NOT EXISTS `trx_renja_ranwal_program` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL AUTO_INCREMENT,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_renja_ranwal` int(11) NOT NULL DEFAULT '0',
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `id_bidang` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) DEFAULT NULL,
  `id_misi_renstra` int(11) DEFAULT NULL,
  `id_tujuan_renstra` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `uraian_program_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_ranwal` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `status_program_rkpd` int(11) DEFAULT NULL COMMENT 'status pelaksanaan unit di rkpd',
  `sumber_data_rkpd` int(11) DEFAULT NULL COMMENT 'sumber usulan pelaksana unit di rkpd',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_dokumen` int(255) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  PRIMARY KEY (`id_renja_program`) USING BTREE,
  UNIQUE KEY `idx_trx_rancangan_renja` (`tahun_renja`,`no_urut`,`id_rkpd_ranwal`,`id_program_rpjmd`,`id_unit`,`id_bidang`,`id_renja_ranwal`) USING BTREE,
  KEY `idx_trx_rancangan_renja_1` (`id_rkpd_ranwal`) USING BTREE,
  KEY `id_program_renstra` (`id_program_renstra`) USING BTREE,
  KEY `id_sasaran_renstra` (`id_sasaran_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_ibfk_2` (`id_renja_ranwal`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_program_indikator`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_program_indikator`;
CREATE TABLE IF NOT EXISTS `trx_renja_ranwal_program_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program_renja` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_renja` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_output` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_program_renja`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_renja_program`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_ranwal_program_indikator_ibfk_1` (`id_renja_program`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_program_rkpd`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_program_rkpd`;
CREATE TABLE IF NOT EXISTS `trx_renja_ranwal_program_rkpd` (
  `tahun_renja` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_renja_ranwal` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `uraian_program_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `jml_data` int(11) NOT NULL DEFAULT '0',
  `jml_baru` int(11) NOT NULL DEFAULT '0',
  `jml_lama` int(11) NOT NULL DEFAULT '0',
  `jml_tepat` int(11) NOT NULL DEFAULT '0',
  `jml_maju` int(11) NOT NULL DEFAULT '0',
  `jml_tunda` int(11) NOT NULL DEFAULT '0',
  `jml_batal` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_renja_ranwal`) USING BTREE,
  UNIQUE KEY `tahun_renja_id_rkpd_ranwal_id_unit` (`tahun_renja`,`id_rkpd_ranwal`,`id_unit`) USING BTREE,
  KEY `id_rkpd_ranwal` (`id_rkpd_ranwal`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_dokumen`
--

DROP TABLE IF EXISTS `trx_renstra_dokumen`;
CREATE TABLE IF NOT EXISTS `trx_renstra_dokumen` (
  `id_rpjmd` int(11) NOT NULL,
  `id_renstra` int(11) NOT NULL AUTO_INCREMENT,
  `id_renstra_old` int(11) NOT NULL,
  `id_renstra_ref` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `nomor_renstra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_renstra` date DEFAULT NULL,
  `uraian_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nm_pimpinan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_pimpinan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jabatan_pimpinan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jns_dokumen` int(11) NOT NULL DEFAULT '9',
  `id_revisi` int(11) NOT NULL DEFAULT '0',
  `id_status_dokumen` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_renstra`) USING BTREE,
  UNIQUE KEY `idx_trx_renstra_dokumen` (`id_rpjmd`,`id_unit`) USING BTREE,
  KEY `fk_trx_renstra_dokumen_1` (`id_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_kebijakan`
--

DROP TABLE IF EXISTS `trx_renstra_kebijakan`;
CREATE TABLE IF NOT EXISTS `trx_renstra_kebijakan` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `uraian_kebijakan_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_kebijakan_renstra`) USING BTREE,
  UNIQUE KEY `idx_trx_renstra_kebijakan` (`thn_id`,`id_sasaran_renstra`,`id_kebijakan_renstra`,`id_perubahan`,`no_urut`) USING BTREE,
  KEY `fk_trx_renstra_kebijakan` (`id_sasaran_renstra`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_kegiatan`
--

DROP TABLE IF EXISTS `trx_renstra_kegiatan`;
CREATE TABLE IF NOT EXISTS `trx_renstra_kegiatan` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_renstra` int(11) NOT NULL,
  `id_kegiatan_renstra` int(11) NOT NULL AUTO_INCREMENT,
  `id_kegiatan_ref` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `uraian_kegiatan_renstra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_sasaran_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun1` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun2` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun3` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun4` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun5` decimal(20,2) DEFAULT '0.00',
  `total_pagu` decimal(20,2) DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_kegiatan_renstra`) USING BTREE,
  UNIQUE KEY `idx_trx_renstra_kegiatan` (`thn_id`,`id_program_renstra`,`id_kegiatan_renstra`,`id_perubahan`,`no_urut`) USING BTREE,
  KEY `fk_trx_renstra_kegiatan` (`id_program_renstra`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_kegiatan_indikator`
--

DROP TABLE IF EXISTS `trx_renstra_kegiatan_indikator`;
CREATE TABLE IF NOT EXISTS `trx_renstra_kegiatan_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_renstra` int(11) NOT NULL,
  `id_indikator_kegiatan_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan_renstra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tolok_ukur_indikator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_indikator_kegiatan_renstra`) USING BTREE,
  UNIQUE KEY `idx_trx_renstra_kegiatan_indikator` (`thn_id`,`id_kegiatan_renstra`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  KEY `fk_trx_renstra_kegiatan_indikator` (`id_kegiatan_renstra`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_kegiatan_pelaksana`
--

DROP TABLE IF EXISTS `trx_renstra_kegiatan_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_renstra_kegiatan_pelaksana` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_renstra_pelaksana` int(11) NOT NULL AUTO_INCREMENT,
  `id_kegiatan_renstra` int(255) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_kegiatan_renstra_pelaksana`) USING BTREE,
  UNIQUE KEY `idx_trx_renstra_kegiatan_pelaksana` (`thn_id`,`id_kegiatan_renstra`,`id_perubahan`,`id_sub_unit`,`no_urut`) USING BTREE,
  KEY `fk_trx_renstra_kegiatan_pelaksana` (`id_kegiatan_renstra`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_misi`
--

DROP TABLE IF EXISTS `trx_renstra_misi`;
CREATE TABLE IF NOT EXISTS `trx_renstra_misi` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_visi_renstra` int(11) NOT NULL,
  `id_misi_renstra` int(11) NOT NULL AUTO_INCREMENT,
  `id_perubahan` int(11) NOT NULL,
  `uraian_misi_renstra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_misi_renstra`) USING BTREE,
  UNIQUE KEY `idx_trx_renstra_misi` (`id_visi_renstra`,`thn_id`,`no_urut`,`id_misi_renstra`,`id_perubahan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_program`
--

DROP TABLE IF EXISTS `trx_renstra_program`;
CREATE TABLE IF NOT EXISTS `trx_renstra_program` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_program_renstra` int(11) NOT NULL AUTO_INCREMENT,
  `id_program_rpjmd` int(11) NOT NULL,
  `id_program_ref` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `jns_program` int(11) NOT NULL DEFAULT '0',
  `uraian_program_renstra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_sasaran_program` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun1` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun2` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun3` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun4` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun5` decimal(20,2) DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_program_renstra`) USING BTREE,
  UNIQUE KEY `idx_renstra_program` (`thn_id`,`id_sasaran_renstra`,`id_program_renstra`,`id_perubahan`,`no_urut`) USING BTREE,
  KEY `fk_trx_renstra_program` (`id_sasaran_renstra`) USING BTREE,
  KEY `fk_trx_renstra_program_1` (`id_program_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_program_indikator`
--

DROP TABLE IF EXISTS `trx_renstra_program_indikator`;
CREATE TABLE IF NOT EXISTS `trx_renstra_program_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_renstra` int(11) NOT NULL,
  `id_indikator_sasaran_renstra` int(11) NOT NULL DEFAULT '0',
  `id_indikator_program_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `id_aspek_pembangunan` int(11) NOT NULL DEFAULT '0',
  `uraian_indikator_program_renstra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tolok_ukur_indikator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_indikator_program_renstra`) USING BTREE,
  UNIQUE KEY `idx_trx_renstra_program_indikator` (`thn_id`,`id_program_renstra`,`id_indikator_program_renstra`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  KEY `fk_trx_renstra_program_indikator` (`id_program_renstra`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_sasaran`
--

DROP TABLE IF EXISTS `trx_renstra_sasaran`;
CREATE TABLE IF NOT EXISTS `trx_renstra_sasaran` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_tujuan_renstra` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL DEFAULT '0',
  `id_sasaran_renstra` int(11) NOT NULL AUTO_INCREMENT,
  `id_perubahan` int(11) NOT NULL,
  `uraian_sasaran_renstra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_sasaran_renstra`) USING BTREE,
  UNIQUE KEY `idx_trx_renstra_sasaran` (`thn_id`,`id_tujuan_renstra`,`id_sasaran_renstra`,`id_perubahan`,`no_urut`) USING BTREE,
  KEY `fk_trx_renstra_sasaran` (`id_tujuan_renstra`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_sasaran_indikator`
--

DROP TABLE IF EXISTS `trx_renstra_sasaran_indikator`;
CREATE TABLE IF NOT EXISTS `trx_renstra_sasaran_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_indikator_sasaran_rpjmd` int(11) NOT NULL DEFAULT '0',
  `id_indikator_sasaran_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_sasaran_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tolok_ukur_indikator` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_indikator_sasaran_renstra`) USING BTREE,
  UNIQUE KEY `idx_trx_rpjmd_sasaran_indikator` (`thn_id`,`id_sasaran_renstra`,`id_indikator_sasaran_renstra`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  KEY `fk_trx_renstra_sasaran_indikator` (`id_sasaran_renstra`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_strategi`
--

DROP TABLE IF EXISTS `trx_renstra_strategi`;
CREATE TABLE IF NOT EXISTS `trx_renstra_strategi` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_strategi_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `uraian_strategi_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_strategi_renstra`) USING BTREE,
  UNIQUE KEY `idx_trx_renstra_kebijakan` (`thn_id`,`id_sasaran_renstra`,`id_perubahan`,`id_strategi_renstra`,`no_urut`) USING BTREE,
  KEY `fk_trx_renstra_strategi` (`id_sasaran_renstra`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_tujuan`
--

DROP TABLE IF EXISTS `trx_renstra_tujuan`;
CREATE TABLE IF NOT EXISTS `trx_renstra_tujuan` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_misi_renstra` int(11) NOT NULL,
  `id_tujuan_renstra` int(11) NOT NULL AUTO_INCREMENT,
  `id_perubahan` int(11) NOT NULL,
  `uraian_tujuan_renstra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tujuan_renstra`) USING BTREE,
  UNIQUE KEY `idx_trx_renstra_tujuan` (`thn_id`,`id_misi_renstra`,`id_tujuan_renstra`,`id_perubahan`,`no_urut`) USING BTREE,
  KEY `fk_trx_renstra_tujuan` (`id_misi_renstra`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_tujuan_indikator`
--

DROP TABLE IF EXISTS `trx_renstra_tujuan_indikator`;
CREATE TABLE IF NOT EXISTS `trx_renstra_tujuan_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_tujuan_renstra` int(11) NOT NULL,
  `id_indikator_tujuan_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_sasaran_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tolok_ukur_indikator` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_indikator_tujuan_renstra`) USING BTREE,
  UNIQUE KEY `idx_trx_rpjmd_sasaran_indikator` (`thn_id`,`id_tujuan_renstra`,`id_indikator_tujuan_renstra`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  KEY `fk_trx_renstra_sasaran_indikator` (`id_tujuan_renstra`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_visi`
--

DROP TABLE IF EXISTS `trx_renstra_visi`;
CREATE TABLE IF NOT EXISTS `trx_renstra_visi` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renstra` int(11) NOT NULL DEFAULT '1',
  `id_visi_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'berisi id khusus untuk setiap visi pada periode yang sama',
  `id_unit` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `thn_awal_renstra` int(11) NOT NULL,
  `thn_akhir_renstra` int(11) NOT NULL,
  `uraian_visi_renstra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_status_dokumen` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_visi_renstra`) USING BTREE,
  UNIQUE KEY `idx_ta_visi_rpjmd` (`thn_id`,`id_visi_renstra`,`thn_awal_renstra`,`thn_akhir_renstra`,`id_perubahan`,`id_unit`,`no_urut`) USING BTREE,
  KEY `FK_trx_renstra_visi_ref_unit` (`id_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final`
--

DROP TABLE IF EXISTS `trx_rkpd_final`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final` (
  `id_rkpd_rancangan` int(11) NOT NULL AUTO_INCREMENT,
  `id_rkpd_ranwal` int(11) NOT NULL COMMENT '0 baru',
  `id_forum_rkpdprog` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru',
  `no_urut` int(11) NOT NULL,
  `tahun_rkpd` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_rkpd_rpjmd` int(11) DEFAULT NULL,
  `thn_id_rpjmd` int(11) DEFAULT NULL,
  `id_visi_rpjmd` int(11) DEFAULT NULL,
  `id_misi_rpjmd` int(11) DEFAULT NULL,
  `id_tujuan_rpjmd` int(11) DEFAULT NULL,
  `id_sasaran_rpjmd` int(11) DEFAULT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `uraian_program_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_ranwal` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_program` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL COMMENT '0 = data tepat waktu sesuai renstra/rpjmd\\r\\n1 = data pergeseran waktu renstra/rpjmd\\r\\n2 = data baru yang belum ada di renstra/rpjmd\\r\\n9 = dibatalkan pelaksanaanya\\r\\n8 = ditunda dilaksanakan\\r\\n',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Draft 1 = Posting Renja 2 = Posting Musren',
  `ket_usulan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RPJMD 1 = Baru 2 = Luncuran tahun sebelumnya',
  `id_dokumen` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_rkpd_rancangan`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_ranwal` (`thn_id_rpjmd`,`id_misi_rpjmd`,`id_sasaran_rpjmd`,`no_urut`,`tahun_rkpd`,`id_visi_rpjmd`,`id_tujuan_rpjmd`,`id_program_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_aktivitas_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_aktivitas_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_aktivitas_pd` (
  `id_aktivitas_pd` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_pelaksana_pd` bigint(20) NOT NULL,
  `id_aktivitas_forum` int(11) NOT NULL DEFAULT '0',
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT '0',
  `id_aktivitas_renja` int(11) DEFAULT '0',
  `uraian_aktivitas_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_aktivitas_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_aktivitas_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_aktivitas_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal',
  `keterangan_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja 1 tambahan baru',
  `id_satuan_publik` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_aktivitas_pd`) USING BTREE,
  KEY `FK_trx_forum_skpd_aktivitas_trx_forum_skpd` (`id_pelaksana_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_belanja_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_belanja_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_belanja_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_belanja_forum` int(11) NOT NULL DEFAULT '0',
  `id_zona_ssh` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL DEFAULT '0',
  `sumber_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 asb 1 ssh',
  `id_aktivitas_asb` int(11) NOT NULL,
  `id_item_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL,
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '1',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1_forum` int(11) NOT NULL,
  `volume_2_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2_forum` int(11) NOT NULL DEFAULT '1',
  `harga_satuan_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL,
  PRIMARY KEY (`id_belanja_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_skpd_belanja` (`tahun_forum`,`no_urut`,`id_belanja_pd`,`id_aktivitas_pd`) USING BTREE,
  KEY `fk_trx_forum_skpd_belanja` (`id_aktivitas_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=736 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_dokumen`
--

DROP TABLE IF EXISTS `trx_rkpd_final_dokumen`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_dokumen` (
  `id_dokumen_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `nomor_rkpd` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_rkpd` date NOT NULL,
  `tahun_rkpd` int(11) NOT NULL COMMENT 'tahun perencanaan',
  `uraian_perkada` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_unit_perencana` int(11) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  PRIMARY KEY (`id_dokumen_rkpd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_indikator`
--

DROP TABLE IF EXISTS `trx_rkpd_final_indikator`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_indikator_program_rkpd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_indikator_rkpd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_rkpd` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 data rpjmd 1 data baru',
  PRIMARY KEY (`id_indikator_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_indikator` (`tahun_rkpd`,`id_rkpd_rancangan`,`kd_indikator`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_indikator` (`id_rkpd_rancangan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_kebijakan`
--

DROP TABLE IF EXISTS `trx_rkpd_final_kebijakan`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_kebijakan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_kebijakan_rancangan` int(11) NOT NULL,
  `id_kebijakan_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_kebijakan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kebijakan_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_ranwal_kebijakan` (`tahun_rkpd`,`id_rkpd_rancangan`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_kebijakan` (`id_rkpd_rancangan`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_kebijakan_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_kebijakan_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_kebijakan_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_pd` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_kebijakan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kebijakan_pd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_renja`,`id_unit`,`no_urut`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_kegiatan_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_kegiatan_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_kegiatan_pd` (
  `id_kegiatan_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_program_pd` bigint(20) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_forum_skpd` int(11) DEFAULT NULL,
  `id_renja` int(11) DEFAULT '0',
  `id_rkpd_renstra` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `id_kegiatan_renstra` int(11) DEFAULT '0',
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_forum` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun_kegiatan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_kegiatan_renstra` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_status` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 =  musrenbang',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal dilaksanakan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari renja 1 baru tambahan',
  `kelompok_sasaran` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kegiatan_pd`) USING BTREE,
  UNIQUE KEY `id_unit_id_renja_id_kegiatan_ref` (`id_unit`,`id_kegiatan_ref`,`id_program_pd`) USING BTREE,
  KEY `FK_trx_forum_skpd_trx_forum_skpd_program` (`id_program_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_keg_indikator_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_keg_indikator_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_keg_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_kegiatan` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_kegiatan`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_kegiatan_pd`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_kegiatan_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_lokasi_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_lokasi_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_lokasi_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_lokasi_forum` int(11) NOT NULL DEFAULT '0' COMMENT '0',
  `id_lokasi_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_lokasi` int(11) NOT NULL,
  `id_lokasi_renja` int(11) DEFAULT '0',
  `id_lokasi_teknis` int(11) DEFAULT NULL,
  `jenis_lokasi` int(11) NOT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_desa` int(11) DEFAULT '0',
  `id_kecamatan` int(11) DEFAULT '0',
  `rt` int(11) DEFAULT '0',
  `rw` int(11) DEFAULT '0',
  `uraian_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lat` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan 2 musrenbang 3 pokir',
  PRIMARY KEY (`id_lokasi_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_lokasi` (`id_aktivitas_pd`,`tahun_forum`,`no_urut`,`id_lokasi_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_pelaksana`
--

DROP TABLE IF EXISTS `trx_rkpd_final_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `hak_akses` int(11) NOT NULL DEFAULT '0' COMMENT '0 tidak dapat menambah data 1 dapat menambah data',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 dibatalkan',
  `ket_pelaksanaan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  PRIMARY KEY (`id_pelaksana_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rancangan`,`id_unit`,`id_urusan_rkpd`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_rancangan`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_urusan_rkpd`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_2` (`id_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_pelaksana_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_pelaksana_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_pelaksana_pd` (
  `id_pelaksana_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_pelaksana_forum` int(11) DEFAULT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) DEFAULT '0',
  `id_lokasi` int(11) DEFAULT '0' COMMENT 'lokasi penyelenggaraan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan',
  `ket_pelaksana` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal 2 baru',
  `status_data` int(11) NOT NULL COMMENT '0 draft 1 final',
  PRIMARY KEY (`id_pelaksana_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_pelaksana` (`id_kegiatan_pd`,`tahun_forum`,`no_urut`,`id_pelaksana_pd`,`id_sub_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_program_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_program_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_program_pd` (
  `id_program_pd` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pdt 2 BTL',
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_forum_program` int(11) DEFAULT NULL,
  `id_renja_program` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `uraian_program_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_forum` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) NOT NULL DEFAULT '0',
  `checksum` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_program_pd`) USING BTREE,
  UNIQUE KEY `id_unit_id_renja_program_id_program_ref` (`id_unit`,`id_renja_program`,`id_program_ref`,`id_forum_program`) USING BTREE,
  KEY `FK_trx_forum_skpd_program_trx_forum_skpd_program_ranwal` (`id_rkpd_rancangan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_prog_indikator_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_prog_indikator_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_prog_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_pd` bigint(11) NOT NULL,
  `id_program_forum` int(11) NOT NULL DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_program`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_program_pd`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_program_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_urusan`
--

DROP TABLE IF EXISTS `trx_rkpd_final_urusan`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_final_urusan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `id_bidang` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  PRIMARY KEY (`id_urusan_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rancangan`,`id_bidang`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_rancangan`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_bidang`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_identifikasi_masalah`
--

DROP TABLE IF EXISTS `trx_rkpd_identifikasi_masalah`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_identifikasi_masalah` (
  `id_masalah` bigint(255) NOT NULL AUTO_INCREMENT,
  `tahun_perencanaan` int(11) DEFAULT NULL,
  `id_indikator` bigint(255) NOT NULL,
  `interpretasi` int(11) NOT NULL COMMENT '0 = belum tercapai, 1= sesuai, 2= melampaui',
  `angka_target` decimal(20,2) DEFAULT NULL,
  `angka_capaian` decimal(20,2) DEFAULT NULL,
  `uraian_target` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_capaian` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_masalah` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_keberhasilan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_masalah`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan` (
  `id_rkpd_rancangan` int(11) NOT NULL AUTO_INCREMENT,
  `id_rkpd_ranwal` int(11) NOT NULL COMMENT '0 baru',
  `id_forum_rkpdprog` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru',
  `no_urut` int(11) NOT NULL,
  `tahun_rkpd` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_rkpd_rpjmd` int(11) DEFAULT NULL,
  `thn_id_rpjmd` int(11) DEFAULT NULL,
  `id_visi_rpjmd` int(11) DEFAULT NULL,
  `id_misi_rpjmd` int(11) DEFAULT NULL,
  `id_tujuan_rpjmd` int(11) DEFAULT NULL,
  `id_sasaran_rpjmd` int(11) DEFAULT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `uraian_program_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_ranwal` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_program` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL COMMENT '0 = data tepat waktu sesuai renstra/rpjmd\\r\\n1 = data pergeseran waktu renstra/rpjmd\\r\\n2 = data baru yang belum ada di renstra/rpjmd\\r\\n9 = dibatalkan pelaksanaanya\\r\\n8 = ditunda dilaksanakan\\r\\n',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Draft 1 = Posting Renja 2 = Posting Musren',
  `ket_usulan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RPJMD 1 = Baru 2 = Luncuran tahun sebelumnya',
  `id_dokumen` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_rkpd_rancangan`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_ranwal` (`tahun_rkpd`,`thn_id_rpjmd`,`id_visi_rpjmd`,`id_misi_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_program_rpjmd`,`no_urut`,`id_forum_rkpdprog`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_aktivitas_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_aktivitas_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_aktivitas_pd` (
  `id_aktivitas_pd` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_pelaksana_pd` bigint(20) NOT NULL,
  `id_aktivitas_forum` int(11) NOT NULL DEFAULT '0',
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT '0',
  `id_aktivitas_renja` int(11) DEFAULT '0',
  `uraian_aktivitas_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_aktivitas_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_aktivitas_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_aktivitas_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal',
  `keterangan_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja 1 tambahan baru',
  `id_satuan_publik` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_aktivitas_pd`) USING BTREE,
  KEY `FK_trx_forum_skpd_aktivitas_trx_forum_skpd` (`id_pelaksana_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_belanja_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_belanja_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_belanja_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_belanja_forum` int(11) NOT NULL DEFAULT '0',
  `id_zona_ssh` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL DEFAULT '0',
  `sumber_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 asb 1 ssh',
  `id_aktivitas_asb` int(11) NOT NULL,
  `id_item_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL,
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '1',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1_forum` int(11) NOT NULL,
  `volume_2_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2_forum` int(11) NOT NULL DEFAULT '1',
  `harga_satuan_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL,
  PRIMARY KEY (`id_belanja_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_skpd_belanja` (`tahun_forum`,`no_urut`,`id_belanja_pd`,`id_aktivitas_pd`) USING BTREE,
  KEY `fk_trx_forum_skpd_belanja` (`id_aktivitas_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_dokumen`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_dokumen`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_dokumen` (
  `id_dokumen_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `nomor_rkpd` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_rkpd` date NOT NULL,
  `tahun_rkpd` int(11) NOT NULL COMMENT 'tahun perencanaan',
  `uraian_perkada` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_unit_perencana` int(11) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  PRIMARY KEY (`id_dokumen_rkpd`) USING BTREE,
  UNIQUE KEY `tahun_ranwal` (`tahun_rkpd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_indikator`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_indikator`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_indikator_program_rkpd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_indikator_rkpd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_rkpd` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 data rpjmd 1 data baru',
  PRIMARY KEY (`id_indikator_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_indikator` (`tahun_rkpd`,`id_rkpd_rancangan`,`kd_indikator`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_indikator` (`id_rkpd_rancangan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_kebijakan`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_kebijakan`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_kebijakan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_kebijakan_rancangan` int(11) NOT NULL,
  `id_kebijakan_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_kebijakan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kebijakan_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_ranwal_kebijakan` (`tahun_rkpd`,`id_rkpd_rancangan`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_kebijakan` (`id_rkpd_rancangan`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_kebijakan_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_kebijakan_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_kebijakan_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_pd` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_kebijakan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kebijakan_pd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_renja`,`id_unit`,`no_urut`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_kegiatan_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_kegiatan_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_kegiatan_pd` (
  `id_kegiatan_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_program_pd` bigint(20) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_forum_skpd` int(11) DEFAULT NULL,
  `id_renja` int(11) DEFAULT '0',
  `id_rkpd_renstra` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `id_kegiatan_renstra` int(11) DEFAULT '0',
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_forum` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun_kegiatan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_kegiatan_renstra` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_status` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 =  musrenbang',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal dilaksanakan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari renja 1 baru tambahan',
  `kelompok_sasaran` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kegiatan_pd`) USING BTREE,
  UNIQUE KEY `id_unit_id_renja_id_kegiatan_ref` (`id_unit`,`id_kegiatan_ref`,`id_program_pd`) USING BTREE,
  KEY `FK_trx_forum_skpd_trx_forum_skpd_program` (`id_program_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_keg_indikator_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_keg_indikator_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_keg_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_kegiatan` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_kegiatan`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_kegiatan_pd`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_kegiatan_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_lokasi_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_lokasi_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_lokasi_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_lokasi_forum` int(11) NOT NULL DEFAULT '0' COMMENT '0',
  `id_lokasi_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_lokasi` int(11) NOT NULL,
  `id_lokasi_renja` int(11) DEFAULT '0',
  `id_lokasi_teknis` int(11) DEFAULT NULL,
  `jenis_lokasi` int(11) NOT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_desa` int(11) DEFAULT '0',
  `id_kecamatan` int(11) DEFAULT '0',
  `rt` int(11) DEFAULT '0',
  `rw` int(11) DEFAULT '0',
  `uraian_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lat` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan 2 musrenbang 3 pokir',
  PRIMARY KEY (`id_lokasi_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_lokasi` (`id_aktivitas_pd`,`tahun_forum`,`no_urut`,`id_lokasi_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_pelaksana`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `hak_akses` int(11) NOT NULL DEFAULT '0' COMMENT '0 tidak dapat menambah data 1 dapat menambah data',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 dibatalkan',
  `ket_pelaksanaan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  PRIMARY KEY (`id_pelaksana_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rancangan`,`id_unit`,`id_urusan_rkpd`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_rancangan`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_urusan_rkpd`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_2` (`id_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_pelaksana_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_pelaksana_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_pelaksana_pd` (
  `id_pelaksana_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_pelaksana_forum` int(11) DEFAULT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) DEFAULT '0',
  `id_lokasi` int(11) DEFAULT '0' COMMENT 'lokasi penyelenggaraan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan',
  `ket_pelaksana` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal 2 baru',
  `status_data` int(11) NOT NULL COMMENT '0 draft 1 final',
  PRIMARY KEY (`id_pelaksana_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_pelaksana` (`id_kegiatan_pd`,`tahun_forum`,`no_urut`,`id_pelaksana_pd`,`id_sub_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_program_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_program_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_program_pd` (
  `id_program_pd` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pdt 2 BTL',
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_forum_program` int(11) DEFAULT NULL,
  `id_renja_program` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `uraian_program_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_forum` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) DEFAULT NULL,
  PRIMARY KEY (`id_program_pd`) USING BTREE,
  UNIQUE KEY `id_unit_id_renja_program_id_program_ref` (`id_forum_program`) USING BTREE,
  KEY `FK_trx_forum_skpd_program_trx_forum_skpd_program_ranwal` (`id_rkpd_rancangan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_prog_indikator_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_prog_indikator_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_prog_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_pd` bigint(11) NOT NULL,
  `id_program_forum` int(11) NOT NULL DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_program`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_program_pd`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_program_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_urusan`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_urusan`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rancangan_urusan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `id_bidang` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  PRIMARY KEY (`id_urusan_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rancangan`,`id_bidang`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_rancangan`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_bidang`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir` (
  `id_rkpd_rancangan` int(11) NOT NULL AUTO_INCREMENT,
  `id_rkpd_ranwal` int(11) NOT NULL COMMENT '0 baru',
  `id_forum_rkpdprog` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru',
  `no_urut` int(11) NOT NULL,
  `tahun_rkpd` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_rkpd_rpjmd` int(11) DEFAULT NULL,
  `thn_id_rpjmd` int(11) DEFAULT NULL,
  `id_visi_rpjmd` int(11) DEFAULT NULL,
  `id_misi_rpjmd` int(11) DEFAULT NULL,
  `id_tujuan_rpjmd` int(11) DEFAULT NULL,
  `id_sasaran_rpjmd` int(11) DEFAULT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `uraian_program_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_ranwal` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_program` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL COMMENT '0 = data tepat waktu sesuai renstra/rpjmd\\r\\n1 = data pergeseran waktu renstra/rpjmd\\r\\n2 = data baru yang belum ada di renstra/rpjmd\\r\\n9 = dibatalkan pelaksanaanya\\r\\n8 = ditunda dilaksanakan\\r\\n',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Draft 1 = Posting Renja 2 = Posting Musren',
  `ket_usulan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RPJMD 1 = Baru 2 = Luncuran tahun sebelumnya',
  `id_dokumen` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_rkpd_rancangan`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_ranwal` (`tahun_rkpd`,`thn_id_rpjmd`,`id_visi_rpjmd`,`id_misi_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_program_rpjmd`,`no_urut`,`id_forum_rkpdprog`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_aktivitas_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_aktivitas_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_aktivitas_pd` (
  `id_aktivitas_pd` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_pelaksana_pd` bigint(20) NOT NULL,
  `id_aktivitas_forum` int(11) NOT NULL DEFAULT '0',
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT '0',
  `id_aktivitas_renja` int(11) DEFAULT '0',
  `uraian_aktivitas_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_aktivitas_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_aktivitas_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_aktivitas_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal',
  `keterangan_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja 1 tambahan baru',
  `id_satuan_publik` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_aktivitas_pd`) USING BTREE,
  KEY `FK_trx_forum_skpd_aktivitas_trx_forum_skpd` (`id_pelaksana_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_belanja_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_belanja_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_belanja_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_belanja_forum` int(11) NOT NULL DEFAULT '0',
  `id_zona_ssh` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL DEFAULT '0',
  `sumber_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 asb 1 ssh',
  `id_aktivitas_asb` int(11) NOT NULL,
  `id_item_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL,
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '1',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1_forum` int(11) NOT NULL,
  `volume_2_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2_forum` int(11) NOT NULL DEFAULT '1',
  `harga_satuan_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL,
  PRIMARY KEY (`id_belanja_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_skpd_belanja` (`tahun_forum`,`no_urut`,`id_belanja_pd`,`id_aktivitas_pd`) USING BTREE,
  KEY `fk_trx_forum_skpd_belanja` (`id_aktivitas_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=737 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_dokumen`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_dokumen`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_dokumen` (
  `id_dokumen_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `nomor_rkpd` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_rkpd` date NOT NULL,
  `tahun_rkpd` int(11) NOT NULL COMMENT 'tahun perencanaan',
  `uraian_perkada` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_unit_perencana` int(11) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  PRIMARY KEY (`id_dokumen_rkpd`) USING BTREE,
  UNIQUE KEY `tahun_ranwal` (`tahun_rkpd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_indikator`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_indikator`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_indikator_program_rkpd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_indikator_rkpd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_rkpd` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 data rpjmd 1 data baru',
  PRIMARY KEY (`id_indikator_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_indikator` (`tahun_rkpd`,`id_rkpd_rancangan`,`kd_indikator`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_indikator` (`id_rkpd_rancangan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_kebijakan`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_kebijakan`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_kebijakan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_kebijakan_rancangan` int(11) NOT NULL,
  `id_kebijakan_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_kebijakan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kebijakan_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_ranwal_kebijakan` (`tahun_rkpd`,`id_rkpd_rancangan`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_kebijakan` (`id_rkpd_rancangan`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_kebijakan_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_kebijakan_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_kebijakan_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_pd` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_kebijakan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kebijakan_pd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_renja`,`id_unit`,`no_urut`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_kegiatan_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_kegiatan_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_kegiatan_pd` (
  `id_kegiatan_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_program_pd` bigint(20) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_forum_skpd` int(11) DEFAULT NULL,
  `id_renja` int(11) DEFAULT '0',
  `id_rkpd_renstra` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `id_kegiatan_renstra` int(11) DEFAULT '0',
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_forum` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun_kegiatan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_kegiatan_renstra` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_status` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 =  musrenbang',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal dilaksanakan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari renja 1 baru tambahan',
  `kelompok_sasaran` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kegiatan_pd`) USING BTREE,
  UNIQUE KEY `id_unit_id_renja_id_kegiatan_ref` (`id_unit`,`id_kegiatan_ref`,`id_program_pd`) USING BTREE,
  KEY `FK_trx_forum_skpd_trx_forum_skpd_program` (`id_program_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_keg_indikator_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_keg_indikator_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_keg_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_kegiatan` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_kegiatan`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_kegiatan_pd`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_kegiatan_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_lokasi_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_lokasi_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_lokasi_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_lokasi_forum` int(11) NOT NULL DEFAULT '0' COMMENT '0',
  `id_lokasi_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_lokasi` int(11) NOT NULL,
  `id_lokasi_renja` int(11) DEFAULT '0',
  `id_lokasi_teknis` int(11) DEFAULT NULL,
  `jenis_lokasi` int(11) NOT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_desa` int(11) DEFAULT '0',
  `id_kecamatan` int(11) DEFAULT '0',
  `rt` int(11) DEFAULT '0',
  `rw` int(11) DEFAULT '0',
  `uraian_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lat` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan 2 musrenbang 3 pokir',
  PRIMARY KEY (`id_lokasi_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_lokasi` (`id_aktivitas_pd`,`tahun_forum`,`no_urut`,`id_lokasi_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_pelaksana`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `hak_akses` int(11) NOT NULL DEFAULT '0' COMMENT '0 tidak dapat menambah data 1 dapat menambah data',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 dibatalkan',
  `ket_pelaksanaan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  PRIMARY KEY (`id_pelaksana_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rancangan`,`id_unit`,`id_urusan_rkpd`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_rancangan`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_urusan_rkpd`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_2` (`id_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_pelaksana_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_pelaksana_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_pelaksana_pd` (
  `id_pelaksana_pd` bigint(20) NOT NULL AUTO_INCREMENT,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_pelaksana_forum` int(11) DEFAULT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) DEFAULT '0',
  `id_lokasi` int(11) DEFAULT '0' COMMENT 'lokasi penyelenggaraan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan',
  `ket_pelaksana` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal 2 baru',
  `status_data` int(11) NOT NULL COMMENT '0 draft 1 final',
  PRIMARY KEY (`id_pelaksana_pd`) USING BTREE,
  UNIQUE KEY `id_trx_forum_pelaksana` (`id_kegiatan_pd`,`tahun_forum`,`no_urut`,`id_pelaksana_pd`,`id_sub_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_program_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_program_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_program_pd` (
  `id_program_pd` bigint(11) NOT NULL AUTO_INCREMENT,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pdt 2 BTL',
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_forum_program` int(11) DEFAULT NULL,
  `id_renja_program` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `uraian_program_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_forum` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) DEFAULT NULL,
  PRIMARY KEY (`id_program_pd`) USING BTREE,
  UNIQUE KEY `id_unit_id_renja_program_id_program_ref` (`id_unit`,`id_renja_program`,`id_program_ref`,`id_forum_program`) USING BTREE,
  KEY `FK_trx_forum_skpd_program_trx_forum_skpd_program_ranwal` (`id_rkpd_rancangan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_prog_indikator_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_prog_indikator_pd`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_prog_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_pd` bigint(11) NOT NULL,
  `id_program_forum` int(11) NOT NULL DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru',
  PRIMARY KEY (`id_indikator_program`) USING BTREE,
  UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_program_pd`) USING BTREE,
  KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_program_pd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_urusan`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_urusan`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranhir_urusan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `id_bidang` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  PRIMARY KEY (`id_urusan_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rancangan`,`id_bidang`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_rancangan`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_bidang`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranwal`
--

DROP TABLE IF EXISTS `trx_rkpd_ranwal`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranwal` (
  `id_rkpd_ranwal` int(11) NOT NULL AUTO_INCREMENT,
  `no_urut` int(11) NOT NULL,
  `tahun_rkpd` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_rkpd_rpjmd` int(11) DEFAULT NULL,
  `thn_id_rpjmd` int(11) DEFAULT NULL,
  `id_visi_rpjmd` int(11) DEFAULT NULL,
  `id_misi_rpjmd` int(11) DEFAULT NULL,
  `id_tujuan_rpjmd` int(11) DEFAULT NULL,
  `id_sasaran_rpjmd` int(11) DEFAULT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `uraian_program_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_ranwal` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_program` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL COMMENT '0 = data tepat waktu sesuai renstra/rpjmd\\r\\n1 = data pergeseran waktu renstra/rpjmd\\r\\n2 = data baru yang belum ada di renstra/rpjmd\\r\\n9 = dibatalkan pelaksanaanya\\r\\n8 = ditunda dilaksanakan\\r\\n',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Draft 1 = Posting Renja 2 = Posting Musren',
  `ket_usulan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RPJMD 1 = Baru 2 = Luncuran tahun sebelumnya',
  `id_dokumen` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_rkpd_ranwal`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_ranwal` (`tahun_rkpd`,`thn_id_rpjmd`,`id_visi_rpjmd`,`id_misi_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_program_rpjmd`,`no_urut`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranwal_dokumen`
--

DROP TABLE IF EXISTS `trx_rkpd_ranwal_dokumen`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranwal_dokumen` (
  `id_dokumen_ranwal` int(11) NOT NULL AUTO_INCREMENT,
  `nomor_ranwal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_ranwal` date NOT NULL,
  `tahun_ranwal` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `uraian_perkada` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_unit_perencana` int(11) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nip_tandatangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  PRIMARY KEY (`id_dokumen_ranwal`) USING BTREE,
  UNIQUE KEY `tahun_ranwal` (`tahun_ranwal`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranwal_indikator`
--

DROP TABLE IF EXISTS `trx_rkpd_ranwal_indikator`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranwal_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_indikator_program_rkpd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_rkpd` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `target_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `indikator_input` text CHARACTER SET latin1,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `indikator_output` text CHARACTER SET latin1,
  `id_satuan_output` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 data rpjmd 1 data baru',
  PRIMARY KEY (`id_indikator_program_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_indikator` (`tahun_rkpd`,`id_rkpd_ranwal`,`kd_indikator`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_indikator` (`id_rkpd_ranwal`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranwal_kebijakan`
--

DROP TABLE IF EXISTS `trx_rkpd_ranwal_kebijakan`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranwal_kebijakan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_kebijakan_ranwal` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_kebijakan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kebijakan_ranwal`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_ranwal_kebijakan` (`tahun_rkpd`,`id_rkpd_ranwal`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_kebijakan` (`id_rkpd_ranwal`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranwal_pelaksana`
--

DROP TABLE IF EXISTS `trx_rkpd_ranwal_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranwal_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL AUTO_INCREMENT,
  `id_unit` int(11) NOT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `hak_akses` int(11) NOT NULL DEFAULT '0' COMMENT '0 tidak dapat menambah data 1 dapat menambah data',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 dibatalkan',
  `ket_pelaksanaan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  PRIMARY KEY (`id_pelaksana_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_ranwal`,`id_unit`,`id_urusan_rkpd`,`no_urut`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_ranwal`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_urusan_rkpd`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_2` (`id_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranwal_urusan`
--

DROP TABLE IF EXISTS `trx_rkpd_ranwal_urusan`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_ranwal_urusan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL AUTO_INCREMENT,
  `id_bidang` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  PRIMARY KEY (`id_urusan_rkpd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_ranwal`,`id_bidang`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_ranwal`) USING BTREE,
  KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_bidang`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_renstra`
--

DROP TABLE IF EXISTS `trx_rkpd_renstra`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_renstra` (
  `tahun_rkpd` int(11) NOT NULL,
  `id_rkpd_renstra` int(11) NOT NULL AUTO_INCREMENT,
  `id_rkpd_rpjmd` int(11) NOT NULL,
  `id_program_rpjmd` int(11) NOT NULL,
  `pagu_tahun_rpjmd` decimal(20,2) DEFAULT '0.00',
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) NOT NULL,
  `uraian_visi_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_misi_renstra` int(11) NOT NULL,
  `uraian_misi_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_tujuan_renstra` int(11) NOT NULL,
  `uraian_tujuan_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `uraian_sasaran_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_program_renstra` int(11) NOT NULL,
  `uraian_program_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun_program` decimal(20,2) DEFAULT '0.00',
  `id_kegiatan_renstra` int(11) NOT NULL,
  `uraian_kegiatan_renstra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun_kegiatan` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = insidentil',
  PRIMARY KEY (`id_rkpd_renstra`) USING BTREE,
  KEY `idx_trx_rkpd_renstra` (`id_rkpd_rpjmd`,`tahun_rkpd`,`id_rkpd_renstra`,`id_program_rpjmd`,`id_unit`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_renstra_indikator`
--

DROP TABLE IF EXISTS `trx_rkpd_renstra_indikator`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_renstra_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `id_rkpd_renstra` int(11) NOT NULL,
  `id_indikator_renstra` int(11) NOT NULL AUTO_INCREMENT,
  `kd_indikator` int(11) DEFAULT NULL,
  `uraian_indikator_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tolokukur_kegiatan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_output` decimal(20,2) DEFAULT '0.00',
  PRIMARY KEY (`id_indikator_renstra`) USING BTREE,
  KEY `fk_trx_rkpd_renstra_pelaksana` (`id_rkpd_renstra`) USING BTREE,
  KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_renstra`,`kd_indikator`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_renstra_pelaksana`
--

DROP TABLE IF EXISTS `trx_rkpd_renstra_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_renstra_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `id_rkpd_renstra` int(11) NOT NULL,
  `id_pelaksana_renstra` int(11) NOT NULL AUTO_INCREMENT,
  `id_sub_unit` int(11) NOT NULL,
  `pagu_tahun` decimal(20,2) DEFAULT '0.00',
  PRIMARY KEY (`id_pelaksana_renstra`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_renstra`,`id_sub_unit`) USING BTREE,
  KEY `fk_trx_rkpd_renstra_pelaksana` (`id_rkpd_renstra`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rpjmd_kebijakan`
--

DROP TABLE IF EXISTS `trx_rkpd_rpjmd_kebijakan`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rpjmd_kebijakan` (
  `tahun_rkpd` int(11) NOT NULL,
  `id_rkpd_rpjmd` int(11) NOT NULL,
  `id_kebijakan_rpjmd` int(11) NOT NULL AUTO_INCREMENT,
  `uraian_kebijakan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_kebijakan_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rpjmd`) USING BTREE,
  KEY `fk_trx_rkpd_rpjmd_kebijakan` (`id_rkpd_rpjmd`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rpjmd_program_indikator`
--

DROP TABLE IF EXISTS `trx_rkpd_rpjmd_program_indikator`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rpjmd_program_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `id_rkpd_rpjmd` int(11) NOT NULL,
  `id_indikator_program_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_rpjmd` text CHARACTER SET latin1,
  `tolok_ukur_indikator` text CHARACTER SET latin1,
  `angka_tahun` decimal(20,2) DEFAULT '0.00',
  PRIMARY KEY (`id_indikator_program_rpjmd`) USING BTREE,
  KEY `fk_rkpd_rpjmd_indikator` (`id_rkpd_rpjmd`) USING BTREE,
  KEY `idx_trx_rkpd_rpjmd_program_indikator` (`tahun_rkpd`,`id_rkpd_rpjmd`,`kd_indikator`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rpjmd_program_pelaksana`
--

DROP TABLE IF EXISTS `trx_rkpd_rpjmd_program_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rpjmd_program_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL AUTO_INCREMENT,
  `id_rkpd_rpjmd` int(11) NOT NULL,
  `id_urbid_rpjmd` int(11) NOT NULL,
  `id_bidang` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `pagu_tahun` decimal(20,2) DEFAULT '0.00',
  PRIMARY KEY (`id_pelaksana_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rpjmd`,`id_urbid_rpjmd`,`id_unit`) USING BTREE,
  KEY `fk_rkpd_rpjmd_pelaksana` (`id_rkpd_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rpjmd_ranwal`
--

DROP TABLE IF EXISTS `trx_rkpd_rpjmd_ranwal`;
CREATE TABLE IF NOT EXISTS `trx_rkpd_rpjmd_ranwal` (
  `id_rkpd_rpjmd` int(11) NOT NULL AUTO_INCREMENT,
  `tahun_rkpd` int(11) NOT NULL,
  `thn_id_rpjmd` int(11) NOT NULL,
  `id_visi_rpjmd` int(11) NOT NULL,
  `uraian_visi_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_misi_rpjmd` int(11) NOT NULL,
  `uraian_misi_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_tujuan_rpjmd` int(11) NOT NULL,
  `uraian_tujuan_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `uraian_sasaran_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_program_rpjmd` int(11) NOT NULL,
  `uraian_program_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_program_rpjmd` decimal(20,2) DEFAULT '0.00',
  `status_data` int(11) NOT NULL COMMENT '0 = data tepat waktu sesuai renstra/rpjmd\\r\\n1 = data pergeseran waktu renstra/rpjmd\\r\\n2 = data baru yang belum ada di renstra/rpjmd',
  PRIMARY KEY (`id_rkpd_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_rkpd_rpjmd_ranwal` (`id_rkpd_rpjmd`,`tahun_rkpd`,`thn_id_rpjmd`,`id_visi_rpjmd`,`id_misi_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_program_rpjmd`) USING BTREE,
  KEY `FK_trx_rkpd_rpjmd_ranwal_trx_rpjmd_visi` (`id_visi_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_analisa_ikk`
--

DROP TABLE IF EXISTS `trx_rpjmd_analisa_ikk`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_analisa_ikk` (
  `id_capaian_rpjmd` int(11) NOT NULL AUTO_INCREMENT,
  `id_pemda` int(11) NOT NULL,
  `id_indikator` int(11) NOT NULL,
  `capaian_min1` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `capaian_min2` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `capaian_min3` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `capaian_min4` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `capaian_min5` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `capaian_standard` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `interpretasi` int(11) NOT NULL DEFAULT '0' COMMENT '0 = belum tercapai, 1= sesuai, 2= melampaui',
  `keterangan_capaian` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_capaian_rpjmd`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_dokumen`
--

DROP TABLE IF EXISTS `trx_rpjmd_dokumen`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_dokumen` (
  `id_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'berisi id khusus untuk setiap visi pada periode yang sama',
  `id_pemda` int(11) NOT NULL DEFAULT '1',
  `id_rpjmd_old` int(11) NOT NULL DEFAULT '1',
  `id_rpjmd_ref` int(11) NOT NULL DEFAULT '-1',
  `thn_dasar` int(11) NOT NULL,
  `tahun_1` int(11) NOT NULL,
  `tahun_2` int(11) NOT NULL,
  `tahun_3` int(11) NOT NULL,
  `tahun_4` int(11) NOT NULL,
  `tahun_5` int(11) NOT NULL,
  `no_perda` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tgl_perda` date DEFAULT NULL,
  `keterangan_dokumen` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jns_dokumen` int(11) NOT NULL DEFAULT '5',
  `id_revisi` int(11) NOT NULL DEFAULT '0',
  `id_status_dokumen` int(11) NOT NULL DEFAULT '1' COMMENT '0 = draft , 1 = aktif  2 = direvisi',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_rpjmd`) USING BTREE,
  KEY `id_rpjmd_old` (`id_rpjmd_old`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_identifikasi_masalah`
--

DROP TABLE IF EXISTS `trx_rpjmd_identifikasi_masalah`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_identifikasi_masalah` (
  `id_masalah` bigint(255) NOT NULL AUTO_INCREMENT,
  `id_pemda` int(11) DEFAULT NULL,
  `id_indikator` bigint(255) NOT NULL,
  `interpretasi` int(11) NOT NULL COMMENT '0 = belum tercapai, 1= sesuai, 2= melampaui',
  `angka_target` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `angka_capaian` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `uraian_masalah` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_keberhasilan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_masalah`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_kebijakan`
--

DROP TABLE IF EXISTS `trx_rpjmd_kebijakan`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_kebijakan` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `id_sasaran_old` int(11) NOT NULL DEFAULT '0',
  `id_kebijakan_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_kebijakan_old` int(11) NOT NULL DEFAULT '0',
  `id_perubahan` int(11) NOT NULL,
  `uraian_kebijakan_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_kebijakan` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_kebijakan_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rpjmd_kebijakan` (`thn_id`,`id_sasaran_rpjmd`,`id_kebijakan_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  KEY `fk_trx_rpjmd_kebijakan` (`id_sasaran_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_misi`
--

DROP TABLE IF EXISTS `trx_rpjmd_misi`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_misi` (
  `thn_id_rpjmd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_visi_rpjmd` int(11) NOT NULL,
  `id_visi_old` int(11) NOT NULL DEFAULT '0',
  `id_misi_rpjmd` int(11) NOT NULL AUTO_INCREMENT,
  `id_misi_old` int(11) NOT NULL DEFAULT '0',
  `id_perubahan` int(11) NOT NULL,
  `uraian_misi_rpjmd` varchar(550) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_misi_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_ta_misi_rpjmd` (`thn_id_rpjmd`,`id_visi_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  KEY `fk_trx_rpjmd_misi` (`id_visi_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_prioritas`
--

DROP TABLE IF EXISTS `trx_rpjmd_prioritas`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_prioritas` (
  `id_masalah` int(11) NOT NULL AUTO_INCREMENT,
  `id_pemda` int(11) NOT NULL DEFAULT '1',
  `uraian_masalah` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `faktor_keberhasilan` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tingkatan_masalah` int(11) NOT NULL DEFAULT '4' COMMENT '1=Internasional, 2=Nasional, 3=Provinsi, 4=Kab/Kota',
  `skor_prioritas` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `urutan_prioritas` int(11) NOT NULL DEFAULT '1',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_masalah`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_program`
--

DROP TABLE IF EXISTS `trx_rpjmd_program`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_program` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `id_sasaran_old` int(11) NOT NULL DEFAULT '0',
  `id_program_rpjmd` int(11) NOT NULL AUTO_INCREMENT,
  `id_program_old` int(11) NOT NULL DEFAULT '0',
  `id_perubahan` int(11) DEFAULT NULL,
  `jns_program` int(11) NOT NULL DEFAULT '0',
  `uraian_program_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagu_tahun1` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun2` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun3` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun4` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun5` decimal(20,2) DEFAULT '0.00',
  `total_pagu` decimal(20,2) DEFAULT '0.00',
  `status_program` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_program_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rpjmd_program` (`thn_id`,`id_sasaran_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  KEY `fk_trx_rpjmd_program` (`id_sasaran_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_program_indikator`
--

DROP TABLE IF EXISTS `trx_rpjmd_program_indikator`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_program_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_rpjmd` int(11) NOT NULL,
  `id_program_old` int(11) NOT NULL DEFAULT '0',
  `id_indikator_program_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_indikator_rpjmd_old` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `id_indikator` int(11) NOT NULL,
  `id_indikator_old` int(11) NOT NULL,
  `id_indikator_sasaran_rpjmd` int(11) NOT NULL DEFAULT '0',
  `id_indikator_sasaran_old` int(11) NOT NULL DEFAULT '0',
  `uraian_indikator_program_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tolok_ukur_indikator` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `status_indikator` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_indikator_program_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rpjmd_program_indikator` (`thn_id`,`id_program_rpjmd`,`id_indikator`,`no_urut`) USING BTREE,
  KEY `fk_trx_rpjmd_program_indikator` (`id_program_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_program_pelaksana`
--

DROP TABLE IF EXISTS `trx_rpjmd_program_pelaksana`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_program_pelaksana` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_urbid_rpjmd` int(11) NOT NULL,
  `id_urbid_old` int(11) NOT NULL DEFAULT '0',
  `id_pelaksana_rpjmd` int(11) NOT NULL AUTO_INCREMENT,
  `id_pelaksana_old` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `id_unit_old` int(11) NOT NULL DEFAULT '0',
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `pagu_tahun1` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun2` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun3` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun4` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun5` decimal(20,2) DEFAULT '0.00',
  `status_pelaksana` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pelaksana_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rpjmd_program_pelaksana` (`thn_id`,`id_urbid_rpjmd`,`id_unit`,`no_urut`) USING BTREE,
  KEY `fk_trx_rpjmd_program_pelaksana` (`id_urbid_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_program_urusan`
--

DROP TABLE IF EXISTS `trx_rpjmd_program_urusan`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_program_urusan` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_urbid_rpjmd` int(11) NOT NULL AUTO_INCREMENT,
  `id_urbid_old` int(11) NOT NULL DEFAULT '0',
  `id_program_rpjmd` int(11) NOT NULL,
  `id_program_old` int(11) NOT NULL DEFAULT '0',
  `id_bidang` int(11) NOT NULL,
  `id_bidang_old` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_urbid_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rpjmd_program_pelaksana` (`thn_id`,`id_program_rpjmd`,`id_bidang`,`no_urut`) USING BTREE,
  KEY `fk_trx_rpjmd_program_urusan` (`id_program_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_sasaran`
--

DROP TABLE IF EXISTS `trx_rpjmd_sasaran`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_sasaran` (
  `thn_id_rpjmd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_tujuan_rpjmd` int(11) NOT NULL,
  `id_tujuan_old` int(11) NOT NULL DEFAULT '0',
  `id_sasaran_rpjmd` int(11) NOT NULL AUTO_INCREMENT,
  `id_sasaran_old` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `uraian_sasaran_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_sasaran` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_sasaran_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rpjmd_sasaran` (`thn_id_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  KEY `fk_trx_rpjmd_sasaran` (`id_tujuan_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_sasaran_indikator`
--

DROP TABLE IF EXISTS `trx_rpjmd_sasaran_indikator`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_sasaran_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `id_sasaran_old` int(11) NOT NULL DEFAULT '0',
  `id_indikator_sasaran_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_indikator_rpjmd_old` int(11) NOT NULL DEFAULT '0',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `kd_indikator_old` int(11) NOT NULL DEFAULT '0',
  `uraian_indikator_sasaran_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tolok_ukur_indikator` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `status_indikator` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_indikator_sasaran_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rpjmd_sasaran_indikator` (`thn_id`,`id_sasaran_rpjmd`,`id_indikator_sasaran_rpjmd`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  KEY `fk_trx_rpjmd_sasaran_indikator` (`id_sasaran_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_strategi`
--

DROP TABLE IF EXISTS `trx_rpjmd_strategi`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_strategi` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `id_sasaran_old` int(11) NOT NULL DEFAULT '0',
  `id_strategi_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_strategi_old` int(11) NOT NULL DEFAULT '0',
  `id_perubahan` int(11) NOT NULL,
  `uraian_strategi_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_strategi` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_strategi_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rpjmd_strategi` (`thn_id`,`id_sasaran_rpjmd`,`id_strategi_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  KEY `fk_trx_rpjmd_strategi` (`id_sasaran_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_tujuan`
--

DROP TABLE IF EXISTS `trx_rpjmd_tujuan`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_tujuan` (
  `thn_id_rpjmd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_misi_rpjmd` int(11) NOT NULL,
  `id_misi_old` int(11) NOT NULL DEFAULT '0',
  `id_tujuan_rpjmd` int(11) NOT NULL AUTO_INCREMENT,
  `id_tujuan_old` int(11) NOT NULL DEFAULT '0',
  `id_perubahan` int(11) NOT NULL,
  `uraian_tujuan_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_tujuan` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tujuan_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rpjmd_tujuan` (`thn_id_rpjmd`,`id_misi_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  KEY `fk_trx_rpjmd_tujuan` (`id_misi_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_tujuan_indikator`
--

DROP TABLE IF EXISTS `trx_rpjmd_tujuan_indikator`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_tujuan_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_tujuan_rpjmd` int(11) NOT NULL,
  `id_tujuan_old` int(11) NOT NULL DEFAULT '0',
  `id_indikator_tujuan_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran',
  `id_indikator_rpjmd_old` int(11) NOT NULL DEFAULT '0',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `kd_indikator_old` int(11) NOT NULL DEFAULT '0',
  `uraian_indikator_sasaran_rpjmd` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tolok_ukur_indikator` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `status_indikator` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_indikator_tujuan_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rpjmd_tujuan_indikator` (`thn_id`,`id_tujuan_rpjmd`,`id_indikator_tujuan_rpjmd`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  KEY `fk_trx_rpjmd_tujuan_indikator` (`id_tujuan_rpjmd`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_visi`
--

DROP TABLE IF EXISTS `trx_rpjmd_visi`;
CREATE TABLE IF NOT EXISTS `trx_rpjmd_visi` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rpjmd` int(11) NOT NULL,
  `id_visi_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'berisi id khusus untuk setiap visi pada periode yang sama',
  `id_visi_old` int(11) NOT NULL DEFAULT '0',
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `uraian_visi_rpjmd` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_visi_rpjmd`) USING BTREE,
  UNIQUE KEY `idx_trx_rpjmd_visi` (`id_rpjmd`,`no_urut`,`thn_id`,`id_visi_rpjmd`,`id_perubahan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_usulan_kab`
--

DROP TABLE IF EXISTS `trx_usulan_kab`;
CREATE TABLE IF NOT EXISTS `trx_usulan_kab` (
  `id_usulan_kab` int(11) NOT NULL AUTO_INCREMENT,
  `id_tahun` int(11) NOT NULL,
  `id_kab` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL DEFAULT '0',
  `sumber_usulan` int(11) NOT NULL DEFAULT '0',
  `judul_usulan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uraian_usulan` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan` int(11) DEFAULT NULL,
  `pagu` decimal(20,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `entry_by` int(255) NOT NULL,
  PRIMARY KEY (`id_usulan_kab`) USING BTREE,
  UNIQUE KEY `id_tahun` (`id_tahun`,`id_kab`,`id_unit`,`no_urut`) USING BTREE,
  KEY `id_kab` (`id_kab`) USING BTREE,
  KEY `id_unit` (`id_unit`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_usulan_kab_lokasi`
--

DROP TABLE IF EXISTS `trx_usulan_kab_lokasi`;
CREATE TABLE IF NOT EXISTS `trx_usulan_kab_lokasi` (
  `id_usulan_kab` int(11) NOT NULL,
  `id_usulan_kab_lokasi` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL DEFAULT '1',
  `id_lokasi` int(11) NOT NULL,
  `volume` decimal(20,2) DEFAULT '0.00',
  `id_satuan` int(11) DEFAULT NULL,
  `uraian_lokasi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_usulan_kab_lokasi`) USING BTREE,
  UNIQUE KEY `id_usulan_kab` (`id_usulan_kab`,`no_urut`,`id_lokasi`) USING BTREE,
  KEY `id_lokasi` (`id_lokasi`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_usulan_rw`
--

DROP TABLE IF EXISTS `trx_usulan_rw`;
CREATE TABLE IF NOT EXISTS `trx_usulan_rw` (
  `id_usulan_rw` bigint(20) NOT NULL AUTO_INCREMENT,
  `no_urut` int(11) NOT NULL,
  `id_desa` int(11) NOT NULL,
  `id_rw` int(11) NOT NULL,
  `id_renja` bigint(20) NOT NULL,
  `id_asb_aktivitas` bigint(20) NOT NULL,
  `uraian_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_aktivitas` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_aktivitas` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_aktivitas` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_usulan` int(11) NOT NULL COMMENT '0 = draft 1 = musrendes 2 = setuju musrendes',
  PRIMARY KEY (`id_usulan_rw`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `id_unit` int(11) DEFAULT NULL COMMENT 'Diisi dengan kode unit asal operator',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_user` int(11) NOT NULL DEFAULT '1' COMMENT '0 non aktif 1 aktif',
  `status_waktu` int(11) NOT NULL DEFAULT '0' COMMENT '0 unlimited 1 limited',
  `tgl_mulai` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_akhir` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `email` (`email`),
  KEY `group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `group_id`, `name`, `email`, `id_unit`, `password`, `remember_token`, `status_user`, `status_waktu`, `tgl_mulai`, `tgl_akhir`, `created_at`, `updated_at`) VALUES
(1, 2, 'administrator', 'admin@bpkp.go.id', NULL, '$2y$10$jR4xkjKFcnS9RSwkKz0odef0Qu7wsqb4YYnx16ElnCC72eXcLvRYy', 'Q0s7dAswvJo2pyI7O4euZ2OO6yByLlYHMNlMRGRDYYGk8tQlFsucwpvSu6iM', 1, 0, '0000-00-00 00:00:00', '2019-10-01 11:04:44', '2017-04-06 23:30:42', '2019-10-19 10:32:50'),
(2, 1, 'superAdmin@simcan.dev', 'super@simcan.dev', NULL, '$2y$10$tZIfh.n2Fw9bO.0dMvA/nOr6oNA7gdmg8aU9gHylOS79z2RfCc10W', 'sCTrCPgJLNDSaEqeSGcH4jm3Fplvov9dp7aGnwauqnRTkM9tWNzMOX5fyFbB', 1, 0, '0000-00-00 00:00:00', '2019-10-01 11:04:44', '2017-10-08 18:02:03', '2019-10-19 10:30:47');

--
-- Triggers `users`
--
DROP TRIGGER IF EXISTS `trg_user`;
DELIMITER $$
CREATE TRIGGER `trg_user` BEFORE DELETE ON `users` FOR EACH ROW IF old.email = 'super@simcan.dev' THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'This record is sacred! You are not allowed to remove it!!';
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_app`
--

DROP TABLE IF EXISTS `user_app`;
CREATE TABLE IF NOT EXISTS `user_app` (
  `id_app_user` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NOT NULL,
  `group_id` int(11) UNSIGNED NOT NULL,
  `app_id` int(11) NOT NULL COMMENT '0',
  `status_app` int(11) NOT NULL COMMENT '1',
  `status_waktu` int(11) NOT NULL DEFAULT '0',
  `tgl_mulai` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_akhir` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_app_user`) USING BTREE,
  UNIQUE KEY `user_id` (`user_id`,`group_id`,`app_id`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `user_desa`
--

DROP TABLE IF EXISTS `user_desa`;
CREATE TABLE IF NOT EXISTS `user_desa` (
  `id_user_wil` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NOT NULL,
  `kd_kecamatan` int(11) NOT NULL COMMENT 'prov',
  `kd_desa` int(11) NOT NULL COMMENT 'kab/kota',
  `rw` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_wil` int(11) NOT NULL DEFAULT '0',
  `status_waktu` int(11) NOT NULL DEFAULT '0',
  `tgl_mulai` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_akhir` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user_wil`) USING BTREE,
  UNIQUE KEY `user_id` (`user_id`,`kd_kecamatan`,`kd_desa`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `user_level_sakip`
--

DROP TABLE IF EXISTS `user_level_sakip`;
CREATE TABLE IF NOT EXISTS `user_level_sakip` (
  `id_user_level` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NOT NULL,
  `id_sotk_level_1` int(11) NOT NULL,
  `id_sotk_level_2` int(11) DEFAULT NULL,
  `id_sotk_level_3` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_user_level`) USING BTREE,
  UNIQUE KEY `kd_unit` (`user_id`,`id_sotk_level_1`,`id_sotk_level_2`,`id_sotk_level_3`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `user_sub_unit`
--

DROP TABLE IF EXISTS `user_sub_unit`;
CREATE TABLE IF NOT EXISTS `user_sub_unit` (
  `id_user_unit` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NOT NULL,
  `kd_unit` int(11) NOT NULL,
  `kd_sub` int(11) DEFAULT NULL,
  `status_unit` int(11) NOT NULL DEFAULT '0',
  `status_waktu` int(11) NOT NULL DEFAULT '0',
  `tgl_mulai` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_akhir` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user_unit`) USING BTREE,
  UNIQUE KEY `kd_unit` (`user_id`,`kd_unit`,`kd_sub`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ref_indikator`
--
ALTER TABLE `ref_indikator` ADD FULLTEXT KEY `nm_indikator` (`nm_indikator`);

--
-- Indexes for table `ref_ssh_tarif`
--
ALTER TABLE `ref_ssh_tarif` ADD FULLTEXT KEY `uraian_tarif_ssh` (`uraian_tarif_ssh`);

--
-- Indexes for table `trx_asb_komponen_rinci`
--
ALTER TABLE `trx_asb_komponen_rinci` ADD FULLTEXT KEY `ket_group` (`ket_group`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kin_trx_cascading_indikator_kegiatan_pd`
--
ALTER TABLE `kin_trx_cascading_indikator_kegiatan_pd`
  ADD CONSTRAINT `FK_kin_trx_cascading_indikator_kegiatan_pd_kin_1` FOREIGN KEY (`id_hasil_kegiatan`) REFERENCES `kin_trx_cascading_kegiatan_opd` (`id_hasil_kegiatan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_cascading_indikator_program_pd`
--
ALTER TABLE `kin_trx_cascading_indikator_program_pd`
  ADD CONSTRAINT `FK_kin_trx_cascading_indikator_program_pd_1` FOREIGN KEY (`id_hasil_program`) REFERENCES `kin_trx_cascading_program_opd` (`id_hasil_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_cascading_kegiatan_opd`
--
ALTER TABLE `kin_trx_cascading_kegiatan_opd`
  ADD CONSTRAINT `FK_kin_trx_cascading_kegiatan_opd_kin_trx_cascading_program_opd` FOREIGN KEY (`id_hasil_program`) REFERENCES `kin_trx_cascading_program_opd` (`id_hasil_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_iku_opd_kegiatan`
--
ALTER TABLE `kin_trx_iku_opd_kegiatan`
  ADD CONSTRAINT `kin_trx_iku_opd_kegiatan_ibfk_1` FOREIGN KEY (`id_iku_opd_program`) REFERENCES `kin_trx_iku_opd_program` (`id_iku_opd_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_iku_opd_program`
--
ALTER TABLE `kin_trx_iku_opd_program`
  ADD CONSTRAINT `kin_trx_iku_opd_program_ibfk_1` FOREIGN KEY (`id_iku_opd_sasaran`) REFERENCES `kin_trx_iku_opd_sasaran` (`id_iku_opd_sasaran`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_iku_opd_sasaran`
--
ALTER TABLE `kin_trx_iku_opd_sasaran`
  ADD CONSTRAINT `kin_trx_iku_opd_sasaran_ibfk_1` FOREIGN KEY (`id_dokumen`) REFERENCES `kin_trx_iku_opd_dok` (`id_dokumen`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_iku_pemda_rinci`
--
ALTER TABLE `kin_trx_iku_pemda_rinci`
  ADD CONSTRAINT `kin_trx_iku_pemda_rinci_ibfk_1` FOREIGN KEY (`id_dokumen`) REFERENCES `kin_trx_iku_pemda_dok` (`id_dokumen`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_es3_kegiatan`
--
ALTER TABLE `kin_trx_perkin_es3_kegiatan`
  ADD CONSTRAINT `kin_trx_perkin_es3_kegiatan_ibfk_1` FOREIGN KEY (`id_perkin_program`) REFERENCES `kin_trx_perkin_es3_program` (`id_perkin_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_es3_program`
--
ALTER TABLE `kin_trx_perkin_es3_program`
  ADD CONSTRAINT `kin_trx_perkin_es3_program_ibfk_1` FOREIGN KEY (`id_dokumen_perkin`) REFERENCES `kin_trx_perkin_es3_dok` (`id_dokumen_perkin`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kin_trx_perkin_es3_program_ibfk_2` FOREIGN KEY (`id_perkin_program_opd`) REFERENCES `kin_trx_perkin_opd_program` (`id_perkin_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_es3_program_indikator`
--
ALTER TABLE `kin_trx_perkin_es3_program_indikator`
  ADD CONSTRAINT `kin_trx_perkin_es3_program_indikator_ibfk_1` FOREIGN KEY (`id_perkin_program`) REFERENCES `kin_trx_perkin_es3_program` (`id_perkin_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_es4_kegiatan`
--
ALTER TABLE `kin_trx_perkin_es4_kegiatan`
  ADD CONSTRAINT `kin_trx_perkin_es4_kegiatan_ibfk_1` FOREIGN KEY (`id_perkin_kegiatan_es3`) REFERENCES `kin_trx_perkin_es3_kegiatan` (`id_perkin_kegiatan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kin_trx_perkin_es4_kegiatan_ibfk_2` FOREIGN KEY (`id_dokumen_perkin`) REFERENCES `kin_trx_perkin_es4_dok` (`id_dokumen_perkin`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_es4_kegiatan_indikator`
--
ALTER TABLE `kin_trx_perkin_es4_kegiatan_indikator`
  ADD CONSTRAINT `kin_trx_perkin_es4_kegiatan_indikator_ibfk_1` FOREIGN KEY (`id_perkin_kegiatan`) REFERENCES `kin_trx_perkin_es4_kegiatan` (`id_perkin_kegiatan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_opd_program`
--
ALTER TABLE `kin_trx_perkin_opd_program`
  ADD CONSTRAINT `kin_trx_perkin_opd_program_ibfk_1` FOREIGN KEY (`id_perkin_sasaran`) REFERENCES `kin_trx_perkin_opd_sasaran` (`id_perkin_sasaran`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_opd_sasaran`
--
ALTER TABLE `kin_trx_perkin_opd_sasaran`
  ADD CONSTRAINT `kin_trx_perkin_opd_sasaran_ibfk_1` FOREIGN KEY (`id_dokumen_perkin`) REFERENCES `kin_trx_perkin_opd_dok` (`id_dokumen_perkin`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_opd_sasaran_indikator`
--
ALTER TABLE `kin_trx_perkin_opd_sasaran_indikator`
  ADD CONSTRAINT `kin_trx_perkin_opd_sasaran_indikator_ibfk_1` FOREIGN KEY (`id_perkin_sasaran`) REFERENCES `kin_trx_perkin_opd_sasaran` (`id_perkin_sasaran`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_real_es2_dok`
--
ALTER TABLE `kin_trx_real_es2_dok`
  ADD CONSTRAINT `kin_trx_real_es2_dok_ibfk_1` FOREIGN KEY (`id_dokumen_perkin`) REFERENCES `kin_trx_perkin_opd_dok` (`id_dokumen_perkin`),
  ADD CONSTRAINT `kin_trx_real_es2_dok_ibfk_2` FOREIGN KEY (`id_sotk_es2`) REFERENCES `ref_sotk_level_1` (`id_sotk_es2`);

--
-- Constraints for table `kin_trx_real_es2_program`
--
ALTER TABLE `kin_trx_real_es2_program`
  ADD CONSTRAINT `kin_trx_real_es2_program_ibfk_1` FOREIGN KEY (`id_real_sasaran`) REFERENCES `kin_trx_real_es2_sasaran` (`id_real_sasaran`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kin_trx_real_es2_program_ibfk_2` FOREIGN KEY (`id_perkin_program`) REFERENCES `kin_trx_perkin_opd_program` (`id_perkin_program`),
  ADD CONSTRAINT `kin_trx_real_es2_program_ibfk_3` FOREIGN KEY (`id_real_program_es3`) REFERENCES `kin_trx_real_es3_program` (`id_real_program`);

--
-- Constraints for table `kin_trx_real_es2_sasaran`
--
ALTER TABLE `kin_trx_real_es2_sasaran`
  ADD CONSTRAINT `kin_trx_real_es2_sasaran_ibfk_1` FOREIGN KEY (`id_dokumen_real`) REFERENCES `kin_trx_real_es2_dok` (`id_dokumen_real`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_real_es2_sasaran_indikator`
--
ALTER TABLE `kin_trx_real_es2_sasaran_indikator`
  ADD CONSTRAINT `kin_trx_real_es2_sasaran_indikator_ibfk_1` FOREIGN KEY (`id_real_sasaran`) REFERENCES `kin_trx_real_es2_sasaran` (`id_real_sasaran`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_real_es3_dok`
--
ALTER TABLE `kin_trx_real_es3_dok`
  ADD CONSTRAINT `kin_trx_real_es3_dok_ibfk_1` FOREIGN KEY (`id_dokumen_perkin`) REFERENCES `kin_trx_perkin_es3_dok` (`id_dokumen_perkin`),
  ADD CONSTRAINT `kin_trx_real_es3_dok_ibfk_2` FOREIGN KEY (`id_sotk_es3`) REFERENCES `ref_sotk_level_2` (`id_sotk_es3`);

--
-- Constraints for table `kin_trx_real_es3_kegiatan`
--
ALTER TABLE `kin_trx_real_es3_kegiatan`
  ADD CONSTRAINT `kin_trx_real_es3_kegiatan_ibfk_1` FOREIGN KEY (`id_real_program`) REFERENCES `kin_trx_real_es3_program` (`id_real_program`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kin_trx_real_es3_kegiatan_ibfk_2` FOREIGN KEY (`id_real_kegiatan_es4`) REFERENCES `kin_trx_real_es4_kegiatan` (`id_real_kegiatan`);

--
-- Constraints for table `kin_trx_real_es3_program`
--
ALTER TABLE `kin_trx_real_es3_program`
  ADD CONSTRAINT `kin_trx_real_es3_program_ibfk_1` FOREIGN KEY (`id_dokumen_real`) REFERENCES `kin_trx_real_es3_dok` (`id_dokumen_real`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kin_trx_real_es3_program_ibfk_2` FOREIGN KEY (`id_perkin_program`) REFERENCES `kin_trx_perkin_es3_program` (`id_perkin_program`);

--
-- Constraints for table `kin_trx_real_es3_program_indikator`
--
ALTER TABLE `kin_trx_real_es3_program_indikator`
  ADD CONSTRAINT `kin_trx_real_es3_program_indikator_ibfk_1` FOREIGN KEY (`id_real_program`) REFERENCES `kin_trx_real_es3_program` (`id_real_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_real_es4_dok`
--
ALTER TABLE `kin_trx_real_es4_dok`
  ADD CONSTRAINT `kin_trx_real_es4_dok_ibfk_1` FOREIGN KEY (`id_dokumen_perkin`) REFERENCES `kin_trx_perkin_es4_dok` (`id_dokumen_perkin`),
  ADD CONSTRAINT `kin_trx_real_es4_dok_ibfk_2` FOREIGN KEY (`id_sotk_es4`) REFERENCES `ref_sotk_level_3` (`id_sotk_es4`);

--
-- Constraints for table `kin_trx_real_es4_kegiatan`
--
ALTER TABLE `kin_trx_real_es4_kegiatan`
  ADD CONSTRAINT `kin_trx_real_es4_kegiatan_ibfk_1` FOREIGN KEY (`id_dokumen_real`) REFERENCES `kin_trx_real_es4_dok` (`id_dokumen_real`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kin_trx_real_es4_kegiatan_ibfk_2` FOREIGN KEY (`id_perkin_kegiatan`) REFERENCES `kin_trx_perkin_es4_kegiatan` (`id_perkin_kegiatan`);

--
-- Constraints for table `kin_trx_real_es4_kegiatan_indikator`
--
ALTER TABLE `kin_trx_real_es4_kegiatan_indikator`
  ADD CONSTRAINT `kin_trx_real_es4_kegiatan_indikator_ibfk_1` FOREIGN KEY (`id_real_kegiatan`) REFERENCES `kin_trx_real_es4_kegiatan` (`id_real_kegiatan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_bidang`
--
ALTER TABLE `ref_bidang`
  ADD CONSTRAINT `fk_ref_bidang` FOREIGN KEY (`kd_urusan`) REFERENCES `ref_urusan` (`kd_urusan`),
  ADD CONSTRAINT `fk_ref_fungsi` FOREIGN KEY (`kd_fungsi`) REFERENCES `ref_fungsi` (`kd_fungsi`);

--
-- Constraints for table `ref_data_sub_unit`
--
ALTER TABLE `ref_data_sub_unit`
  ADD CONSTRAINT `fk_data_sub_unit` FOREIGN KEY (`id_sub_unit`) REFERENCES `ref_sub_unit` (`id_sub_unit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_desa`
--
ALTER TABLE `ref_desa`
  ADD CONSTRAINT `ref_desa_ibfk_1` FOREIGN KEY (`id_kecamatan`) REFERENCES `ref_kecamatan` (`id_kecamatan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_kecamatan`
--
ALTER TABLE `ref_kecamatan`
  ADD CONSTRAINT `fk_ref_kecamatan` FOREIGN KEY (`id_pemda`) REFERENCES `ref_kabupaten` (`id_kab`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_kegiatan`
--
ALTER TABLE `ref_kegiatan`
  ADD CONSTRAINT `fk_ref_kegiatan` FOREIGN KEY (`id_program`) REFERENCES `ref_program` (`id_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_kolom_tabel_dasar`
--
ALTER TABLE `ref_kolom_tabel_dasar`
  ADD CONSTRAINT `ref_kolom_tabel_dasar_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `ref_kolom_tabel_dasar` (`id_kolom_tabel_dasar`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ref_kolom_tabel_dasar_ibfk_2` FOREIGN KEY (`id_tabel_dasar`) REFERENCES `ref_tabel_dasar` (`id_tabel_dasar`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_mapping_asb_renstra`
--
ALTER TABLE `ref_mapping_asb_renstra`
  ADD CONSTRAINT `fk_ref_mapping_asb_renstra` FOREIGN KEY (`id_aktivitas_asb`) REFERENCES `trx_asb_aktivitas` (`id_aktivitas_asb`),
  ADD CONSTRAINT `fk_ref_mapping_asb_renstra1` FOREIGN KEY (`id_kegiatan_renstra`) REFERENCES `trx_renstra_kegiatan` (`id_kegiatan_renstra`);

--
-- Constraints for table `ref_pegawai_pangkat`
--
ALTER TABLE `ref_pegawai_pangkat`
  ADD CONSTRAINT `ref_pegawai_pangkat_ibfk_1` FOREIGN KEY (`id_pegawai`) REFERENCES `ref_pegawai` (`id_pegawai`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_pegawai_unit`
--
ALTER TABLE `ref_pegawai_unit`
  ADD CONSTRAINT `ref_pegawai_unit_ibfk_1` FOREIGN KEY (`id_pegawai`) REFERENCES `ref_pegawai` (`id_pegawai`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ref_pegawai_unit_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_program`
--
ALTER TABLE `ref_program`
  ADD CONSTRAINT `fk_ref_program` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`);

--
-- Constraints for table `ref_rek_2`
--
ALTER TABLE `ref_rek_2`
  ADD CONSTRAINT `fk_ref_rek_2` FOREIGN KEY (`kd_rek_1`) REFERENCES `ref_rek_1` (`kd_rek_1`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ref_rek_3`
--
ALTER TABLE `ref_rek_3`
  ADD CONSTRAINT `fk_ref_rek_3` FOREIGN KEY (`kd_rek_1`,`kd_rek_2`) REFERENCES `ref_rek_2` (`kd_rek_1`, `kd_rek_2`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ref_rek_4`
--
ALTER TABLE `ref_rek_4`
  ADD CONSTRAINT `fk_ref_rek_4` FOREIGN KEY (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`) REFERENCES `ref_rek_3` (`kd_rek_1`, `kd_rek_2`, `kd_rek_3`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ref_rek_5`
--
ALTER TABLE `ref_rek_5`
  ADD CONSTRAINT `ref_rek_5_ibfk_1` FOREIGN KEY (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`,`kd_rek_4`) REFERENCES `ref_rek_4` (`kd_rek_1`, `kd_rek_2`, `kd_rek_3`, `kd_rek_4`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_sotk_level_1`
--
ALTER TABLE `ref_sotk_level_1`
  ADD CONSTRAINT `ref_sotk_level_1_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_sotk_level_2`
--
ALTER TABLE `ref_sotk_level_2`
  ADD CONSTRAINT `ref_sotk_level_2_ibfk_1` FOREIGN KEY (`id_sotk_es2`) REFERENCES `ref_sotk_level_1` (`id_sotk_es2`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_sotk_level_3`
--
ALTER TABLE `ref_sotk_level_3`
  ADD CONSTRAINT `ref_sotk_level_3_ibfk_1` FOREIGN KEY (`id_sotk_es3`) REFERENCES `ref_sotk_level_2` (`id_sotk_es3`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_kelompok`
--
ALTER TABLE `ref_ssh_kelompok`
  ADD CONSTRAINT `fk_ssh_kelompok` FOREIGN KEY (`id_golongan_ssh`) REFERENCES `ref_ssh_golongan` (`id_golongan_ssh`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_perkada_tarif`
--
ALTER TABLE `ref_ssh_perkada_tarif`
  ADD CONSTRAINT `fk_ref_tarif_jumlah` FOREIGN KEY (`id_tarif_ssh`) REFERENCES `ref_ssh_tarif` (`id_tarif_ssh`),
  ADD CONSTRAINT `fk_ref_tarif_jumlah_1` FOREIGN KEY (`id_zona_perkada`) REFERENCES `ref_ssh_perkada_zona` (`id_zona_perkada`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_perkada_zona`
--
ALTER TABLE `ref_ssh_perkada_zona`
  ADD CONSTRAINT `FK_ref_ssh_perkada_zona_ref_ssh_zona` FOREIGN KEY (`id_zona`) REFERENCES `ref_ssh_zona` (`id_zona`),
  ADD CONSTRAINT `FK_ref_ssh_perkada_zona_ref_ssh_zona_1` FOREIGN KEY (`id_perkada`) REFERENCES `ref_ssh_perkada` (`id_perkada`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_rekening`
--
ALTER TABLE `ref_ssh_rekening`
  ADD CONSTRAINT `fk_ref_ssh_rekening` FOREIGN KEY (`id_tarif_ssh`) REFERENCES `ref_ssh_tarif` (`id_tarif_ssh`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_sub_kelompok`
--
ALTER TABLE `ref_ssh_sub_kelompok`
  ADD CONSTRAINT `fk_ref_ssh_sub_kelompok` FOREIGN KEY (`id_kelompok_ssh`) REFERENCES `ref_ssh_kelompok` (`id_kelompok_ssh`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_tarif`
--
ALTER TABLE `ref_ssh_tarif`
  ADD CONSTRAINT `fk_ref_ssh_tarif` FOREIGN KEY (`id_sub_kelompok_ssh`) REFERENCES `ref_ssh_sub_kelompok` (`id_sub_kelompok_ssh`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_zona_lokasi`
--
ALTER TABLE `ref_ssh_zona_lokasi`
  ADD CONSTRAINT `fk_zona_lokasi` FOREIGN KEY (`id_zona`) REFERENCES `ref_ssh_zona` (`id_zona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_sub_unit`
--
ALTER TABLE `ref_sub_unit`
  ADD CONSTRAINT `fk_ref_sub_unit` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`);

--
-- Constraints for table `ref_unit`
--
ALTER TABLE `ref_unit`
  ADD CONSTRAINT `fk_ref_unit` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`);

--
-- Constraints for table `trx_anggaran_aktivitas_pd`
--
ALTER TABLE `trx_anggaran_aktivitas_pd`
  ADD CONSTRAINT `FK_trx_anggaran_aktivitas_pd_trx_anggaran_pelaksana_pd` FOREIGN KEY (`id_pelaksana_pd`) REFERENCES `trx_anggaran_pelaksana_pd` (`id_pelaksana_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_anggaran_belanja_pd`
--
ALTER TABLE `trx_anggaran_belanja_pd`
  ADD CONSTRAINT `FK_trx_anggaran_belanja_pd_trx_anggaran_aktivitas_pd` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_anggaran_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_anggaran_indikator`
--
ALTER TABLE `trx_anggaran_indikator`
  ADD CONSTRAINT `FK_trx_anggaran_indikator_trx_anggaran_program` FOREIGN KEY (`id_anggaran_pemda`) REFERENCES `trx_anggaran_program` (`id_anggaran_pemda`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_anggaran_kegiatan_pd`
--
ALTER TABLE `trx_anggaran_kegiatan_pd`
  ADD CONSTRAINT `FK_trx_anggaran_kegiatan_pd_trx_anggaran_program_pd` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_anggaran_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_anggaran_keg_indikator_pd`
--
ALTER TABLE `trx_anggaran_keg_indikator_pd`
  ADD CONSTRAINT `FK_trx_anggaran_keg_indikator_pd_trx_anggaran_kegiatan_pd` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_anggaran_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_anggaran_lokasi_pd`
--
ALTER TABLE `trx_anggaran_lokasi_pd`
  ADD CONSTRAINT `FK_trx_anggaran_lokasi_pd_trx_anggaran_aktivitas_pd` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_anggaran_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_anggaran_pelaksana`
--
ALTER TABLE `trx_anggaran_pelaksana`
  ADD CONSTRAINT `FK_trx_anggaran_pelaksana_trx_anggaran_program` FOREIGN KEY (`id_anggaran_pemda`) REFERENCES `trx_anggaran_program` (`id_anggaran_pemda`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_anggaran_pelaksana_pd`
--
ALTER TABLE `trx_anggaran_pelaksana_pd`
  ADD CONSTRAINT `FK_trx_anggaran_pelaksana_pd_trx_anggaran_kegiatan_pd` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_anggaran_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_anggaran_program`
--
ALTER TABLE `trx_anggaran_program`
  ADD CONSTRAINT `FK_trx_anggaran_program_trx_anggaran_dokumen` FOREIGN KEY (`id_dokumen_keu`) REFERENCES `trx_anggaran_dokumen` (`id_dokumen_keu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_anggaran_program_pd`
--
ALTER TABLE `trx_anggaran_program_pd`
  ADD CONSTRAINT `FK_trx_anggaran_program_pd_trx_anggaran_pelaksana` FOREIGN KEY (`id_pelaksana_anggaran`) REFERENCES `trx_anggaran_pelaksana` (`id_pelaksana_anggaran`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_anggaran_prog_indikator_pd`
--
ALTER TABLE `trx_anggaran_prog_indikator_pd`
  ADD CONSTRAINT `FK_trx_anggaran_prog_indikator_pd_trx_anggaran_program_pd` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_anggaran_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_anggaran_tapd`
--
ALTER TABLE `trx_anggaran_tapd`
  ADD CONSTRAINT `trx_anggaran_tapd_ibfk_1` FOREIGN KEY (`id_dokumen_keu`) REFERENCES `trx_anggaran_dokumen` (`id_dokumen_keu`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_anggaran_tapd_ibfk_2` FOREIGN KEY (`id_pegawai`) REFERENCES `ref_pegawai` (`id_pegawai`);

--
-- Constraints for table `trx_anggaran_tapd_unit`
--
ALTER TABLE `trx_anggaran_tapd_unit`
  ADD CONSTRAINT `trx_anggaran_tapd_unit_ibfk_1` FOREIGN KEY (`id_tapd`) REFERENCES `trx_anggaran_tapd` (`id_tapd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_anggaran_unit_kpa`
--
ALTER TABLE `trx_anggaran_unit_kpa`
  ADD CONSTRAINT `trx_anggaran_unit_kpa_ibfk_1` FOREIGN KEY (`id_pa`) REFERENCES `trx_anggaran_unit_pa` (`id_pa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_anggaran_unit_kpa_ibfk_2` FOREIGN KEY (`id_pegawai`) REFERENCES `ref_pegawai` (`id_pegawai`);

--
-- Constraints for table `trx_anggaran_unit_pa`
--
ALTER TABLE `trx_anggaran_unit_pa`
  ADD CONSTRAINT `trx_anggaran_unit_pa_ibfk_1` FOREIGN KEY (`id_dokumen_keu`) REFERENCES `trx_anggaran_dokumen` (`id_dokumen_keu`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_anggaran_unit_pa_ibfk_2` FOREIGN KEY (`id_pegawai`) REFERENCES `ref_pegawai` (`id_pegawai`);

--
-- Constraints for table `trx_anggaran_urusan`
--
ALTER TABLE `trx_anggaran_urusan`
  ADD CONSTRAINT `FK_trx_anggaran_urusan_trx_anggaran_program` FOREIGN KEY (`id_anggaran_pemda`) REFERENCES `trx_anggaran_program` (`id_anggaran_pemda`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_asb_aktivitas`
--
ALTER TABLE `trx_asb_aktivitas`
  ADD CONSTRAINT `FK_trx_asb_aktivitas_trx_asb_sub_sub_kelompok` FOREIGN KEY (`id_asb_sub_sub_kelompok`) REFERENCES `trx_asb_sub_sub_kelompok` (`id_asb_sub_sub_kelompok`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_asb_kelompok`
--
ALTER TABLE `trx_asb_kelompok`
  ADD CONSTRAINT `FK_trx_asb_cluster_trx_asb_perkada` FOREIGN KEY (`id_asb_perkada`) REFERENCES `trx_asb_perkada` (`id_asb_perkada`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_asb_komponen`
--
ALTER TABLE `trx_asb_komponen`
  ADD CONSTRAINT `FK_trx_asb_komponen_trx_asb_aktivitas` FOREIGN KEY (`id_aktivitas_asb`) REFERENCES `trx_asb_aktivitas` (`id_aktivitas_asb`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_asb_komponen_rinci`
--
ALTER TABLE `trx_asb_komponen_rinci`
  ADD CONSTRAINT `FK_trx_asb_komponen_rinci_ref_ssh_tarif` FOREIGN KEY (`id_tarif_ssh`) REFERENCES `ref_ssh_tarif` (`id_tarif_ssh`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_trx_asb_komponen_rinci_trx_asb_komponen` FOREIGN KEY (`id_komponen_asb`) REFERENCES `trx_asb_komponen` (`id_komponen_asb`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_asb_perhitungan_rinci`
--
ALTER TABLE `trx_asb_perhitungan_rinci`
  ADD CONSTRAINT `trx_asb_perhitungan_rinci_ibfk_1` FOREIGN KEY (`id_perhitungan`) REFERENCES `trx_asb_perhitungan` (`id_perhitungan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_asb_sub_kelompok`
--
ALTER TABLE `trx_asb_sub_kelompok`
  ADD CONSTRAINT `trx_asb_sub_kelompok_ibfk_1` FOREIGN KEY (`id_asb_kelompok`) REFERENCES `trx_asb_kelompok` (`id_asb_kelompok`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_asb_sub_sub_kelompok`
--
ALTER TABLE `trx_asb_sub_sub_kelompok`
  ADD CONSTRAINT `FK_trx_asb_sub_sub_kelompok_trx_asb_sub_kelompok` FOREIGN KEY (`id_asb_sub_kelompok`) REFERENCES `trx_asb_sub_kelompok` (`id_asb_sub_kelompok`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd`
--
ALTER TABLE `trx_forum_skpd`
  ADD CONSTRAINT `FK_trx_forum_skpd_trx_forum_skpd_program` FOREIGN KEY (`id_forum_program`) REFERENCES `trx_forum_skpd_program` (`id_forum_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_aktivitas`
--
ALTER TABLE `trx_forum_skpd_aktivitas`
  ADD CONSTRAINT `FK_trx_forum_skpd_aktivitas_trx_forum_skpd` FOREIGN KEY (`id_forum_skpd`) REFERENCES `trx_forum_skpd_pelaksana` (`id_pelaksana_forum`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_belanja`
--
ALTER TABLE `trx_forum_skpd_belanja`
  ADD CONSTRAINT `trx_forum_skpd_belanja_ibfk_1` FOREIGN KEY (`id_lokasi_forum`) REFERENCES `trx_forum_skpd_aktivitas` (`id_aktivitas_forum`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_kegiatan_indikator`
--
ALTER TABLE `trx_forum_skpd_kegiatan_indikator`
  ADD CONSTRAINT `trx_forum_skpd_kegiatan_indikator_ibfk_1` FOREIGN KEY (`id_forum_skpd`) REFERENCES `trx_forum_skpd` (`id_forum_skpd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_lokasi`
--
ALTER TABLE `trx_forum_skpd_lokasi`
  ADD CONSTRAINT `trx_forum_skpd_lokasi_ibfk_1` FOREIGN KEY (`id_pelaksana_forum`) REFERENCES `trx_forum_skpd_aktivitas` (`id_aktivitas_forum`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_pelaksana`
--
ALTER TABLE `trx_forum_skpd_pelaksana`
  ADD CONSTRAINT `trx_forum_skpd_pelaksana_ibfk_1` FOREIGN KEY (`id_aktivitas_forum`) REFERENCES `trx_forum_skpd` (`id_forum_skpd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_program`
--
ALTER TABLE `trx_forum_skpd_program`
  ADD CONSTRAINT `FK_trx_forum_skpd_program_trx_forum_skpd_program_ranwal` FOREIGN KEY (`id_forum_rkpdprog`) REFERENCES `trx_forum_skpd_program_ranwal` (`id_forum_rkpdprog`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_program_indikator`
--
ALTER TABLE `trx_forum_skpd_program_indikator`
  ADD CONSTRAINT `trx_forum_skpd_program_indikator_ibfk_1` FOREIGN KEY (`id_forum_program`) REFERENCES `trx_forum_skpd_program` (`id_forum_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_usulan`
--
ALTER TABLE `trx_forum_skpd_usulan`
  ADD CONSTRAINT `FK_trx_forum_skpd_usulan_trx_forum_skpd_lokasi` FOREIGN KEY (`id_lokasi_forum`) REFERENCES `trx_forum_skpd_lokasi` (`id_lokasi_forum`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_isian_data_dasar`
--
ALTER TABLE `trx_isian_data_dasar`
  ADD CONSTRAINT `trx_isian_data_dasar_ibfk_1` FOREIGN KEY (`id_kolom_tabel_dasar`) REFERENCES `ref_kolom_tabel_dasar` (`id_kolom_tabel_dasar`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_isian_data_dasar_ibfk_2` FOREIGN KEY (`id_kecamatan`) REFERENCES `ref_kecamatan` (`id_kecamatan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrencam`
--
ALTER TABLE `trx_musrencam`
  ADD CONSTRAINT `trx_musrencam_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_ranwal_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrencam_lokasi`
--
ALTER TABLE `trx_musrencam_lokasi`
  ADD CONSTRAINT `trx_musrencam_lokasi_ibfk_1` FOREIGN KEY (`id_musrencam`) REFERENCES `trx_musrencam` (`id_musrencam`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrendes`
--
ALTER TABLE `trx_musrendes`
  ADD CONSTRAINT `fk_trx_musrendes` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_ranwal_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrendes_lokasi`
--
ALTER TABLE `trx_musrendes_lokasi`
  ADD CONSTRAINT `fk_trx_musrendes_lokasi` FOREIGN KEY (`id_musrendes`) REFERENCES `trx_musrendes` (`id_musrendes`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrendes_rw`
--
ALTER TABLE `trx_musrendes_rw`
  ADD CONSTRAINT `trx_musrendes_rw_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_ranwal_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_aktivitas_pd`
--
ALTER TABLE `trx_musrenkab_aktivitas_pd`
  ADD CONSTRAINT `trx_musrenkab_aktivitas_pd_ibfk_1` FOREIGN KEY (`id_pelaksana_pd`) REFERENCES `trx_musrenkab_pelaksana_pd` (`id_pelaksana_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_belanja_pd`
--
ALTER TABLE `trx_musrenkab_belanja_pd`
  ADD CONSTRAINT `trx_musrenkab_belanja_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_musrenkab_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_indikator`
--
ALTER TABLE `trx_musrenkab_indikator`
  ADD CONSTRAINT `trx_musrenkab_indikator_ibfk_1` FOREIGN KEY (`id_musrenkab`) REFERENCES `trx_musrenkab` (`id_musrenkab`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_kegiatan_pd`
--
ALTER TABLE `trx_musrenkab_kegiatan_pd`
  ADD CONSTRAINT `trx_musrenkab_kegiatan_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_musrenkab_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_keg_indikator_pd`
--
ALTER TABLE `trx_musrenkab_keg_indikator_pd`
  ADD CONSTRAINT `trx_musrenkab_keg_indikator_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_musrenkab_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_lokasi_pd`
--
ALTER TABLE `trx_musrenkab_lokasi_pd`
  ADD CONSTRAINT `trx_musrenkab_lokasi_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_musrenkab_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_pelaksana`
--
ALTER TABLE `trx_musrenkab_pelaksana`
  ADD CONSTRAINT `trx_musrenkab_pelaksana_ibfk_1` FOREIGN KEY (`id_urusan_rkpd`) REFERENCES `trx_musrenkab_urusan` (`id_urusan_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_musrenkab_pelaksana_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_pelaksana_pd`
--
ALTER TABLE `trx_musrenkab_pelaksana_pd`
  ADD CONSTRAINT `trx_musrenkab_pelaksana_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_musrenkab_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_program_pd`
--
ALTER TABLE `trx_musrenkab_program_pd`
  ADD CONSTRAINT `trx_musrenkab_program_pd_ibfk_1` FOREIGN KEY (`id_pelaksana_rkpd`) REFERENCES `trx_musrenkab_pelaksana` (`id_pelaksana_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_prog_indikator_pd`
--
ALTER TABLE `trx_musrenkab_prog_indikator_pd`
  ADD CONSTRAINT `trx_musrenkab_prog_indikator_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_musrenkab_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_urusan`
--
ALTER TABLE `trx_musrenkab_urusan`
  ADD CONSTRAINT `trx_musrenkab_urusan_ibfk_1` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_musrenkab_urusan_ibfk_2` FOREIGN KEY (`id_musrenkab`) REFERENCES `trx_musrenkab` (`id_musrenkab`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_pokir_lokasi`
--
ALTER TABLE `trx_pokir_lokasi`
  ADD CONSTRAINT `trx_pokir_lokasi_ibfk_1` FOREIGN KEY (`id_pokir_usulan`) REFERENCES `trx_pokir_usulan` (`id_pokir_usulan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_pokir_tl`
--
ALTER TABLE `trx_pokir_tl`
  ADD CONSTRAINT `trx_pokir_tl_ibfk_1` FOREIGN KEY (`id_pokir_usulan`) REFERENCES `trx_pokir_usulan` (`id_pokir_usulan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_pokir_tl_unit`
--
ALTER TABLE `trx_pokir_tl_unit`
  ADD CONSTRAINT `trx_pokir_tl_unit_ibfk_1` FOREIGN KEY (`id_pokir_tl`) REFERENCES `trx_pokir_tl` (`id_pokir_tl`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_pokir_usulan`
--
ALTER TABLE `trx_pokir_usulan`
  ADD CONSTRAINT `trx_pokir_usulan_ibfk_1` FOREIGN KEY (`id_pokir`) REFERENCES `trx_pokir` (`id_pokir`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_pokir_usulan_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `trx_prioritas_pemda`
--
ALTER TABLE `trx_prioritas_pemda`
  ADD CONSTRAINT `trx_prioritas_pemda_ibfk_1` FOREIGN KEY (`id_tema_rkpd`) REFERENCES `trx_prioritas_pemda_tema` (`id_tema_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_program_nasional`
--
ALTER TABLE `trx_program_nasional`
  ADD CONSTRAINT `trx_program_nasional_ibfk_1` FOREIGN KEY (`id_prioritas`) REFERENCES `trx_prioritas_nasional` (`id_prioritas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_program_nasional_detail`
--
ALTER TABLE `trx_program_nasional_detail`
  ADD CONSTRAINT `trx_program_nasional_detail_ibfk_1` FOREIGN KEY (`id_prognas_unit`) REFERENCES `trx_program_nasional_unit` (`id_prognas_unit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_program_nasional_unit`
--
ALTER TABLE `trx_program_nasional_unit`
  ADD CONSTRAINT `trx_program_nasional_unit_ibfk_1` FOREIGN KEY (`id_prognas`) REFERENCES `trx_program_nasional` (`id_prognas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_program_provinsi`
--
ALTER TABLE `trx_program_provinsi`
  ADD CONSTRAINT `trx_program_provinsi_ibfk_1` FOREIGN KEY (`id_prioritas`) REFERENCES `trx_prioritas_provinsi` (`id_prioritas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_program_provinsi_detail`
--
ALTER TABLE `trx_program_provinsi_detail`
  ADD CONSTRAINT `trx_program_provinsi_detail_ibfk_1` FOREIGN KEY (`id_progprov_unit`) REFERENCES `trx_program_provinsi_unit` (`id_progprov_unit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_program_provinsi_unit`
--
ALTER TABLE `trx_program_provinsi_unit`
  ADD CONSTRAINT `trx_program_provinsi_unit_ibfk_1` FOREIGN KEY (`id_progprov`) REFERENCES `trx_program_provinsi` (`id_progprov`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_aktivitas`
--
ALTER TABLE `trx_renja_aktivitas`
  ADD CONSTRAINT `trx_renja_aktivitas_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_pelaksana` (`id_pelaksana_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_belanja`
--
ALTER TABLE `trx_renja_belanja`
  ADD CONSTRAINT `trx_renja_belanja_ibfk_1` FOREIGN KEY (`id_lokasi_renja`) REFERENCES `trx_renja_aktivitas` (`id_aktivitas_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_kebijakan`
--
ALTER TABLE `trx_renja_kebijakan`
  ADD CONSTRAINT `trx_renja_kebijakan_ibfk_1` FOREIGN KEY (`id_sasaran_renstra`) REFERENCES `trx_renja_rancangan` (`id_sasaran_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_kegiatan`
--
ALTER TABLE `trx_renja_kegiatan`
  ADD CONSTRAINT `trx_renja_kegiatan_ibfk_2` FOREIGN KEY (`id_rkpd_renstra`) REFERENCES `trx_rkpd_renstra` (`id_rkpd_renstra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_renja_kegiatan_ibfk_3` FOREIGN KEY (`id_rkpd_ranwal`) REFERENCES `trx_rkpd_ranwal` (`id_rkpd_ranwal`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_renja_kegiatan_ibfk_4` FOREIGN KEY (`id_renja_program`) REFERENCES `trx_renja_program` (`id_renja_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_kegiatan_indikator`
--
ALTER TABLE `trx_renja_kegiatan_indikator`
  ADD CONSTRAINT `trx_renja_kegiatan_indikator_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_lokasi`
--
ALTER TABLE `trx_renja_lokasi`
  ADD CONSTRAINT `trx_renja_lokasi_ibfk_1` FOREIGN KEY (`id_pelaksana_renja`) REFERENCES `trx_renja_aktivitas` (`id_aktivitas_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_pelaksana`
--
ALTER TABLE `trx_renja_pelaksana`
  ADD CONSTRAINT `trx_renja_pelaksana_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_program_indikator`
--
ALTER TABLE `trx_renja_program_indikator`
  ADD CONSTRAINT `trx_renja_program_indikator_ibfk_1` FOREIGN KEY (`id_renja_program`) REFERENCES `trx_renja_program` (`id_renja_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan`
--
ALTER TABLE `trx_renja_rancangan`
  ADD CONSTRAINT `FK_trx_renja_rancangan_trx_renja_rancangan_program` FOREIGN KEY (`id_renja_program`) REFERENCES `trx_renja_rancangan_program` (`id_renja_program`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trx_rancangan_renja_1` FOREIGN KEY (`id_rkpd_ranwal`) REFERENCES `trx_rkpd_ranwal` (`id_rkpd_ranwal`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_aktivitas`
--
ALTER TABLE `trx_renja_rancangan_aktivitas`
  ADD CONSTRAINT `trx_renja_rancangan_aktivitas_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_rancangan_pelaksana` (`id_pelaksana_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_belanja`
--
ALTER TABLE `trx_renja_rancangan_belanja`
  ADD CONSTRAINT `FK_trx_renja_rancangan_belanja_trx_renja_rancangan_lokasi` FOREIGN KEY (`id_lokasi_renja`) REFERENCES `trx_renja_rancangan_aktivitas` (`id_aktivitas_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_indikator`
--
ALTER TABLE `trx_renja_rancangan_indikator`
  ADD CONSTRAINT `FK_trx_renja_rancangan_indikator_trx_renja_rancangan` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_rancangan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_kebijakan`
--
ALTER TABLE `trx_renja_rancangan_kebijakan`
  ADD CONSTRAINT `fk_trx_renja_rancangan_kebijakan` FOREIGN KEY (`id_sasaran_renstra`) REFERENCES `trx_renja_rancangan` (`id_sasaran_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_lokasi`
--
ALTER TABLE `trx_renja_rancangan_lokasi`
  ADD CONSTRAINT `fk_rancangan_renja_lokasi` FOREIGN KEY (`id_pelaksana_renja`) REFERENCES `trx_renja_rancangan_aktivitas` (`id_aktivitas_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_pelaksana`
--
ALTER TABLE `trx_renja_rancangan_pelaksana`
  ADD CONSTRAINT `fk_trx_rancangan_renja_pelaksana` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_rancangan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_program_indikator`
--
ALTER TABLE `trx_renja_rancangan_program_indikator`
  ADD CONSTRAINT `trx_renja_rancangan_program_indikator_ibfk_1` FOREIGN KEY (`id_renja_program`) REFERENCES `trx_renja_rancangan_program` (`id_renja_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_ref_pokir`
--
ALTER TABLE `trx_renja_rancangan_ref_pokir`
  ADD CONSTRAINT `trx_renja_rancangan_ref_pokir_ibfk_1` FOREIGN KEY (`id_aktivitas_renja`) REFERENCES `trx_renja_rancangan_aktivitas` (`id_aktivitas_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_ranwal_aktivitas`
--
ALTER TABLE `trx_renja_ranwal_aktivitas`
  ADD CONSTRAINT `trx_renja_ranwal_aktivitas_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_ranwal_pelaksana` (`id_pelaksana_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_ranwal_kegiatan`
--
ALTER TABLE `trx_renja_ranwal_kegiatan`
  ADD CONSTRAINT `trx_renja_ranwal_kegiatan_ibfk_1` FOREIGN KEY (`id_renja_program`) REFERENCES `trx_renja_ranwal_program` (`id_renja_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_ranwal_kegiatan_indikator`
--
ALTER TABLE `trx_renja_ranwal_kegiatan_indikator`
  ADD CONSTRAINT `trx_renja_ranwal_kegiatan_indikator_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_ranwal_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_ranwal_pelaksana`
--
ALTER TABLE `trx_renja_ranwal_pelaksana`
  ADD CONSTRAINT `trx_renja_ranwal_pelaksana_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_ranwal_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_ranwal_program`
--
ALTER TABLE `trx_renja_ranwal_program`
  ADD CONSTRAINT `trx_renja_ranwal_program_ibfk_1` FOREIGN KEY (`id_renja_ranwal`) REFERENCES `trx_renja_ranwal_program_rkpd` (`id_renja_ranwal`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_ranwal_program_indikator`
--
ALTER TABLE `trx_renja_ranwal_program_indikator`
  ADD CONSTRAINT `trx_renja_ranwal_program_indikator_ibfk_1` FOREIGN KEY (`id_renja_program`) REFERENCES `trx_renja_ranwal_program` (`id_renja_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_dokumen`
--
ALTER TABLE `trx_renstra_dokumen`
  ADD CONSTRAINT `fk_trx_renstra_dokumen` FOREIGN KEY (`id_rpjmd`) REFERENCES `trx_rpjmd_dokumen` (`id_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trx_renstra_dokumen_1` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_kebijakan`
--
ALTER TABLE `trx_renstra_kebijakan`
  ADD CONSTRAINT `fk_trx_renstra_kebijakan` FOREIGN KEY (`id_sasaran_renstra`) REFERENCES `trx_renstra_sasaran` (`id_sasaran_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_kegiatan`
--
ALTER TABLE `trx_renstra_kegiatan`
  ADD CONSTRAINT `fk_trx_renstra_kegiatan` FOREIGN KEY (`id_program_renstra`) REFERENCES `trx_renstra_program` (`id_program_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_kegiatan_indikator`
--
ALTER TABLE `trx_renstra_kegiatan_indikator`
  ADD CONSTRAINT `fk_trx_renstra_kegiatan_indikator` FOREIGN KEY (`id_kegiatan_renstra`) REFERENCES `trx_renstra_kegiatan` (`id_kegiatan_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_kegiatan_pelaksana`
--
ALTER TABLE `trx_renstra_kegiatan_pelaksana`
  ADD CONSTRAINT `fk_trx_renstra_kegiatan_pelaksana` FOREIGN KEY (`id_kegiatan_renstra`) REFERENCES `trx_renstra_kegiatan` (`id_kegiatan_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_misi`
--
ALTER TABLE `trx_renstra_misi`
  ADD CONSTRAINT `fk_trx_renstra_misi` FOREIGN KEY (`id_visi_renstra`) REFERENCES `trx_renstra_visi` (`id_visi_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_program`
--
ALTER TABLE `trx_renstra_program`
  ADD CONSTRAINT `fk_trx_renstra_program` FOREIGN KEY (`id_sasaran_renstra`) REFERENCES `trx_renstra_sasaran` (`id_sasaran_renstra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trx_renstra_program_1` FOREIGN KEY (`id_program_rpjmd`) REFERENCES `trx_rpjmd_program` (`id_program_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_program_indikator`
--
ALTER TABLE `trx_renstra_program_indikator`
  ADD CONSTRAINT `fk_trx_renstra_program_indikator` FOREIGN KEY (`id_program_renstra`) REFERENCES `trx_renstra_program` (`id_program_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_sasaran`
--
ALTER TABLE `trx_renstra_sasaran`
  ADD CONSTRAINT `fk_trx_renstra_sasaran` FOREIGN KEY (`id_tujuan_renstra`) REFERENCES `trx_renstra_tujuan` (`id_tujuan_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_sasaran_indikator`
--
ALTER TABLE `trx_renstra_sasaran_indikator`
  ADD CONSTRAINT `fk_trx_renstra_sasaran_indikator` FOREIGN KEY (`id_sasaran_renstra`) REFERENCES `trx_renstra_sasaran` (`id_sasaran_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_strategi`
--
ALTER TABLE `trx_renstra_strategi`
  ADD CONSTRAINT `fk_trx_renstra_strategi` FOREIGN KEY (`id_sasaran_renstra`) REFERENCES `trx_renstra_sasaran` (`id_sasaran_renstra`);

--
-- Constraints for table `trx_renstra_tujuan`
--
ALTER TABLE `trx_renstra_tujuan`
  ADD CONSTRAINT `fk_trx_renstra_tujuan` FOREIGN KEY (`id_misi_renstra`) REFERENCES `trx_renstra_misi` (`id_misi_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_tujuan_indikator`
--
ALTER TABLE `trx_renstra_tujuan_indikator`
  ADD CONSTRAINT `trx_renstra_tujuan_indikator_ibfk_1` FOREIGN KEY (`id_tujuan_renstra`) REFERENCES `trx_renstra_tujuan` (`id_tujuan_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_visi`
--
ALTER TABLE `trx_renstra_visi`
  ADD CONSTRAINT `FK_trx_renstra_visi_ref_unit` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_aktivitas_pd`
--
ALTER TABLE `trx_rkpd_final_aktivitas_pd`
  ADD CONSTRAINT `trx_rkpd_final_aktivitas_pd_ibfk_1` FOREIGN KEY (`id_pelaksana_pd`) REFERENCES `trx_rkpd_final_pelaksana_pd` (`id_pelaksana_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_belanja_pd`
--
ALTER TABLE `trx_rkpd_final_belanja_pd`
  ADD CONSTRAINT `trx_rkpd_final_belanja_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_rkpd_final_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_indikator`
--
ALTER TABLE `trx_rkpd_final_indikator`
  ADD CONSTRAINT `trx_rkpd_final_indikator_ibfk_1` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_final` (`id_rkpd_rancangan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_kegiatan_pd`
--
ALTER TABLE `trx_rkpd_final_kegiatan_pd`
  ADD CONSTRAINT `trx_rkpd_final_kegiatan_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_rkpd_final_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_keg_indikator_pd`
--
ALTER TABLE `trx_rkpd_final_keg_indikator_pd`
  ADD CONSTRAINT `trx_rkpd_final_keg_indikator_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_rkpd_final_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_lokasi_pd`
--
ALTER TABLE `trx_rkpd_final_lokasi_pd`
  ADD CONSTRAINT `trx_rkpd_final_lokasi_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_rkpd_final_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_pelaksana`
--
ALTER TABLE `trx_rkpd_final_pelaksana`
  ADD CONSTRAINT `trx_rkpd_final_pelaksana_ibfk_1` FOREIGN KEY (`id_urusan_rkpd`) REFERENCES `trx_rkpd_final_urusan` (`id_urusan_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_final_pelaksana_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_pelaksana_pd`
--
ALTER TABLE `trx_rkpd_final_pelaksana_pd`
  ADD CONSTRAINT `trx_rkpd_final_pelaksana_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_rkpd_final_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_program_pd`
--
ALTER TABLE `trx_rkpd_final_program_pd`
  ADD CONSTRAINT `trx_rkpd_final_program_pd_ibfk_1` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_final_pelaksana` (`id_pelaksana_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_prog_indikator_pd`
--
ALTER TABLE `trx_rkpd_final_prog_indikator_pd`
  ADD CONSTRAINT `trx_rkpd_final_prog_indikator_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_rkpd_final_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_urusan`
--
ALTER TABLE `trx_rkpd_final_urusan`
  ADD CONSTRAINT `trx_rkpd_final_urusan_ibfk_1` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_final_urusan_ibfk_2` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_final` (`id_rkpd_rancangan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_aktivitas_pd`
--
ALTER TABLE `trx_rkpd_rancangan_aktivitas_pd`
  ADD CONSTRAINT `trx_rkpd_rancangan_aktivitas_pd_ibfk_1` FOREIGN KEY (`id_pelaksana_pd`) REFERENCES `trx_rkpd_rancangan_pelaksana_pd` (`id_pelaksana_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_belanja_pd`
--
ALTER TABLE `trx_rkpd_rancangan_belanja_pd`
  ADD CONSTRAINT `trx_rkpd_rancangan_belanja_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_rkpd_rancangan_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_indikator`
--
ALTER TABLE `trx_rkpd_rancangan_indikator`
  ADD CONSTRAINT `trx_rkpd_rancangan_indikator_ibfk_1` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_rancangan` (`id_rkpd_rancangan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_kegiatan_pd`
--
ALTER TABLE `trx_rkpd_rancangan_kegiatan_pd`
  ADD CONSTRAINT `FK_trx_rkpd_rancangan_kegiatan_pd_trx_rkpd_rancangan_program_pd` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_rkpd_rancangan_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_keg_indikator_pd`
--
ALTER TABLE `trx_rkpd_rancangan_keg_indikator_pd`
  ADD CONSTRAINT `trx_rkpd_rancangan_keg_indikator_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_rkpd_rancangan_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_lokasi_pd`
--
ALTER TABLE `trx_rkpd_rancangan_lokasi_pd`
  ADD CONSTRAINT `trx_rkpd_rancangan_lokasi_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_rkpd_rancangan_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_pelaksana`
--
ALTER TABLE `trx_rkpd_rancangan_pelaksana`
  ADD CONSTRAINT `trx_rkpd_rancangan_pelaksana_ibfk_1` FOREIGN KEY (`id_urusan_rkpd`) REFERENCES `trx_rkpd_rancangan_urusan` (`id_urusan_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_rancangan_pelaksana_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_pelaksana_pd`
--
ALTER TABLE `trx_rkpd_rancangan_pelaksana_pd`
  ADD CONSTRAINT `trx_rkpd_rancangan_pelaksana_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_rkpd_rancangan_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_program_pd`
--
ALTER TABLE `trx_rkpd_rancangan_program_pd`
  ADD CONSTRAINT `test` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_rancangan_pelaksana` (`id_pelaksana_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_prog_indikator_pd`
--
ALTER TABLE `trx_rkpd_rancangan_prog_indikator_pd`
  ADD CONSTRAINT `trx_rkpd_rancangan_prog_indikator_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_rkpd_rancangan_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_urusan`
--
ALTER TABLE `trx_rkpd_rancangan_urusan`
  ADD CONSTRAINT `trx_rkpd_rancangan_urusan_ibfk_2` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_rancangan_urusan_ibfk_3` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_rancangan` (`id_rkpd_rancangan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_aktivitas_pd`
--
ALTER TABLE `trx_rkpd_ranhir_aktivitas_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_aktivitas_pd_ibfk_1` FOREIGN KEY (`id_pelaksana_pd`) REFERENCES `trx_rkpd_ranhir_pelaksana_pd` (`id_pelaksana_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_belanja_pd`
--
ALTER TABLE `trx_rkpd_ranhir_belanja_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_belanja_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_rkpd_ranhir_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_indikator`
--
ALTER TABLE `trx_rkpd_ranhir_indikator`
  ADD CONSTRAINT `trx_rkpd_ranhir_indikator_ibfk_1` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_ranhir` (`id_rkpd_rancangan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_kegiatan_pd`
--
ALTER TABLE `trx_rkpd_ranhir_kegiatan_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_kegiatan_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_rkpd_ranhir_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_keg_indikator_pd`
--
ALTER TABLE `trx_rkpd_ranhir_keg_indikator_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_keg_indikator_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_rkpd_ranhir_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_lokasi_pd`
--
ALTER TABLE `trx_rkpd_ranhir_lokasi_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_lokasi_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_rkpd_ranhir_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_pelaksana`
--
ALTER TABLE `trx_rkpd_ranhir_pelaksana`
  ADD CONSTRAINT `trx_rkpd_ranhir_pelaksana_ibfk_1` FOREIGN KEY (`id_urusan_rkpd`) REFERENCES `trx_rkpd_ranhir_urusan` (`id_urusan_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_ranhir_pelaksana_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_pelaksana_pd`
--
ALTER TABLE `trx_rkpd_ranhir_pelaksana_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_pelaksana_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_rkpd_ranhir_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_program_pd`
--
ALTER TABLE `trx_rkpd_ranhir_program_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_program_pd_ibfk_1` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_ranhir_pelaksana` (`id_pelaksana_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_prog_indikator_pd`
--
ALTER TABLE `trx_rkpd_ranhir_prog_indikator_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_prog_indikator_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_rkpd_ranhir_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_urusan`
--
ALTER TABLE `trx_rkpd_ranhir_urusan`
  ADD CONSTRAINT `trx_rkpd_ranhir_urusan_ibfk_1` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_ranhir_urusan_ibfk_2` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_ranhir` (`id_rkpd_rancangan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranwal_indikator`
--
ALTER TABLE `trx_rkpd_ranwal_indikator`
  ADD CONSTRAINT `fk_trx_rkpd_ranwal_indikator` FOREIGN KEY (`id_rkpd_ranwal`) REFERENCES `trx_rkpd_ranwal` (`id_rkpd_ranwal`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranwal_kebijakan`
--
ALTER TABLE `trx_rkpd_ranwal_kebijakan`
  ADD CONSTRAINT `fk_trx_rkpd_ranwal_kebijakan` FOREIGN KEY (`id_rkpd_ranwal`) REFERENCES `trx_rkpd_ranwal` (`id_rkpd_ranwal`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranwal_pelaksana`
--
ALTER TABLE `trx_rkpd_ranwal_pelaksana`
  ADD CONSTRAINT `FK_trx_rkpd_ranwal_pelaksana_trx_rkpd_ranwal_urusan` FOREIGN KEY (`id_urusan_rkpd`) REFERENCES `trx_rkpd_ranwal_urusan` (`id_urusan_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trx_rkpd_ranwal_pelaksana_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranwal_urusan`
--
ALTER TABLE `trx_rkpd_ranwal_urusan`
  ADD CONSTRAINT `trx_rkpd_ranwal_urusan_ibfk_1` FOREIGN KEY (`id_rkpd_ranwal`) REFERENCES `trx_rkpd_ranwal` (`id_rkpd_ranwal`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_ranwal_urusan_ibfk_2` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`) ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_renstra`
--
ALTER TABLE `trx_rkpd_renstra`
  ADD CONSTRAINT `fk_trx_rkpd_renstra` FOREIGN KEY (`id_rkpd_rpjmd`) REFERENCES `trx_rkpd_rpjmd_ranwal` (`id_rkpd_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_renstra_indikator`
--
ALTER TABLE `trx_rkpd_renstra_indikator`
  ADD CONSTRAINT `trx_rkpd_renstra_indikator_ibfk_1` FOREIGN KEY (`id_rkpd_renstra`) REFERENCES `trx_rkpd_renstra` (`id_rkpd_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_renstra_pelaksana`
--
ALTER TABLE `trx_rkpd_renstra_pelaksana`
  ADD CONSTRAINT `fk_trx_rkpd_renstra_pelaksana` FOREIGN KEY (`id_rkpd_renstra`) REFERENCES `trx_rkpd_renstra` (`id_rkpd_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rpjmd_kebijakan`
--
ALTER TABLE `trx_rkpd_rpjmd_kebijakan`
  ADD CONSTRAINT `fk_trx_rkpd_rpjmd_kebijakan` FOREIGN KEY (`id_rkpd_rpjmd`) REFERENCES `trx_rkpd_rpjmd_ranwal` (`id_rkpd_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rpjmd_program_indikator`
--
ALTER TABLE `trx_rkpd_rpjmd_program_indikator`
  ADD CONSTRAINT `fk_rkpd_rpjmd_indikator` FOREIGN KEY (`id_rkpd_rpjmd`) REFERENCES `trx_rkpd_rpjmd_ranwal` (`id_rkpd_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rpjmd_program_pelaksana`
--
ALTER TABLE `trx_rkpd_rpjmd_program_pelaksana`
  ADD CONSTRAINT `fk_rkpd_rpjmd_pelaksana` FOREIGN KEY (`id_rkpd_rpjmd`) REFERENCES `trx_rkpd_rpjmd_ranwal` (`id_rkpd_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rpjmd_ranwal`
--
ALTER TABLE `trx_rkpd_rpjmd_ranwal`
  ADD CONSTRAINT `FK_trx_rkpd_rpjmd_ranwal_trx_rpjmd_visi` FOREIGN KEY (`id_visi_rpjmd`) REFERENCES `trx_rpjmd_visi` (`id_visi_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_kebijakan`
--
ALTER TABLE `trx_rpjmd_kebijakan`
  ADD CONSTRAINT `fk_trx_rpjmd_kebijakan` FOREIGN KEY (`id_sasaran_rpjmd`) REFERENCES `trx_rpjmd_sasaran` (`id_sasaran_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_misi`
--
ALTER TABLE `trx_rpjmd_misi`
  ADD CONSTRAINT `fk_trx_rpjmd_misi` FOREIGN KEY (`id_visi_rpjmd`) REFERENCES `trx_rpjmd_visi` (`id_visi_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_program`
--
ALTER TABLE `trx_rpjmd_program`
  ADD CONSTRAINT `fk_trx_rpjmd_program` FOREIGN KEY (`id_sasaran_rpjmd`) REFERENCES `trx_rpjmd_sasaran` (`id_sasaran_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_program_indikator`
--
ALTER TABLE `trx_rpjmd_program_indikator`
  ADD CONSTRAINT `fk_trx_rpjmd_program_indikator` FOREIGN KEY (`id_program_rpjmd`) REFERENCES `trx_rpjmd_program` (`id_program_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_program_pelaksana`
--
ALTER TABLE `trx_rpjmd_program_pelaksana`
  ADD CONSTRAINT `fk_trx_rpjmd_program_pelaksana` FOREIGN KEY (`id_urbid_rpjmd`) REFERENCES `trx_rpjmd_program_urusan` (`id_urbid_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_program_urusan`
--
ALTER TABLE `trx_rpjmd_program_urusan`
  ADD CONSTRAINT `fk_trx_rpjmd_program_urusan` FOREIGN KEY (`id_program_rpjmd`) REFERENCES `trx_rpjmd_program` (`id_program_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_sasaran`
--
ALTER TABLE `trx_rpjmd_sasaran`
  ADD CONSTRAINT `FK_trx_rpjmd_sasaran_trx_rpjmd_tujuan` FOREIGN KEY (`id_tujuan_rpjmd`) REFERENCES `trx_rpjmd_tujuan` (`id_tujuan_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_sasaran_indikator`
--
ALTER TABLE `trx_rpjmd_sasaran_indikator`
  ADD CONSTRAINT `fk_trx_rpjmd_sasaran_indikator` FOREIGN KEY (`id_sasaran_rpjmd`) REFERENCES `trx_rpjmd_sasaran` (`id_sasaran_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_strategi`
--
ALTER TABLE `trx_rpjmd_strategi`
  ADD CONSTRAINT `fk_trx_rpjmd_strategi` FOREIGN KEY (`id_sasaran_rpjmd`) REFERENCES `trx_rpjmd_sasaran` (`id_sasaran_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_tujuan`
--
ALTER TABLE `trx_rpjmd_tujuan`
  ADD CONSTRAINT `fk_trx_rpjmd_tujuan` FOREIGN KEY (`id_misi_rpjmd`) REFERENCES `trx_rpjmd_misi` (`id_misi_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_tujuan_indikator`
--
ALTER TABLE `trx_rpjmd_tujuan_indikator`
  ADD CONSTRAINT `trx_rpjmd_tujuan_indikator_ibfk_1` FOREIGN KEY (`id_tujuan_rpjmd`) REFERENCES `trx_rpjmd_tujuan` (`id_tujuan_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_visi`
--
ALTER TABLE `trx_rpjmd_visi`
  ADD CONSTRAINT `fk_trx_rpjmd_visi` FOREIGN KEY (`id_rpjmd`) REFERENCES `trx_rpjmd_dokumen` (`id_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_usulan_kab`
--
ALTER TABLE `trx_usulan_kab`
  ADD CONSTRAINT `trx_usulan_kab_ibfk_1` FOREIGN KEY (`id_kab`) REFERENCES `ref_kabupaten` (`id_kab`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_usulan_kab_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_usulan_kab_lokasi`
--
ALTER TABLE `trx_usulan_kab_lokasi`
  ADD CONSTRAINT `trx_usulan_kab_lokasi_ibfk_1` FOREIGN KEY (`id_usulan_kab`) REFERENCES `trx_usulan_kab` (`id_usulan_kab`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_usulan_kab_lokasi_ibfk_2` FOREIGN KEY (`id_lokasi`) REFERENCES `ref_lokasi` (`id_lokasi`) ON UPDATE CASCADE;

--
-- Constraints for table `user_app`
--
ALTER TABLE `user_app`
  ADD CONSTRAINT `user_app_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_app_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `ref_group` (`id`);

--
-- Constraints for table `user_desa`
--
ALTER TABLE `user_desa`
  ADD CONSTRAINT `user_desa_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_level_sakip`
--
ALTER TABLE `user_level_sakip`
  ADD CONSTRAINT `user_level_sakip_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_sub_unit`
--
ALTER TABLE `user_sub_unit`
  ADD CONSTRAINT `user_sub_unit_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;