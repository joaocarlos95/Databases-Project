delimiter //
CREATE TRIGGER data_oferta_check BEFORE INSERT ON oferta
FOR EACH ROW
BEGIN
IF EXISTS (SELECT * FROM oferta WHERE NEW.morada = oferta.morada AND NEW.codigo = oferta.codigo AND NEW.data_inicio > oferta.data_inicio AND NEW.data_inicio < oferta.data_fim) THEN 
INSERT INTO oferta VALUES (NEW.morada, NEW.codigo, NEW.data_inicio, NEW.data_fim, NEW.tarifa);
ELSEIF EXISTS (SELECT * FROM oferta WHERE NEW.morada = oferta.morada AND NEW.codigo = oferta.codigo AND NEW.data_fim > oferta.data_inicio AND NEW.data_fim < oferta.data_fim) THEN 
INSERT INTO oferta VALUES (NEW.morada, NEW.codigo, NEW.data_inicio, NEW.data_fim, NEW.tarifa);
ELSEIF EXISTS (SELECT * FROM oferta WHERE NEW.morada = oferta.morada AND NEW.codigo = oferta.codigo AND NEW.data_inicio < oferta.data_inicio AND NEW.data_fim > oferta.data_fim) THEN 
INSERT INTO oferta VALUES (NEW.morada, NEW.codigo, NEW.data_inicio, NEW.data_fim, NEW.tarifa);
END IF;
END //

CREATE TRIGGER data_paga_check BEFORE INSERT ON paga
FOR EACH ROW
BEGIN
IF EXISTS(SELECT * FROM (SELECT * FROM estado e NATURAL JOIN (SELECT numero, MAX(time_stamp) max_time_stamp FROM estado GROUP BY numero) A WHERE e.numero = A.numero AND e.time_stamp = A.max_time_stamp) B WHERE NEW.numero = B.numero AND NEW.data < B.time_stamp) THEN
INSERT INTO paga VALUES (NEW.numero, NEW.data, NEW.metodo);
END IF;
END //
delimiter ;

