/*SELECT morada 
FROM (
	SELECT morada, COUNT(morada) m_count 
	FROM oferta GROUP by morada, codigo) A 
WHERE m_count >1;

SELECT r.numero, estado 
FROM reserva r 
NATURAL JOIN (
SELECT * 
FROM estado e 
NATURAL JOIN (
SELECT numero, MAX(time_stamp) max_time_stamp 
FROM estado 
GROUP BY numero) A 
WHERE e.numero = A.numero AND e.time_stamp = A.max_time_stamp) B 
WHERE r.numero = B.numero AND data IS NOT NULL;


SELECT espaco_morada, espaco_codigo, m, n 
FROM (
	SELECT *, COUNT(espaco_codigo) m 
	FROM inserido 
	GROUP BY espaco_morada, espaco_codigo) v 
NATURAL JOIN (
	SELECT *, COUNT(espaco_morada) n 
	FROM estado e 
	NATURAL JOIN (
		SELECT numero, espaco_morada, espaco_codigo 
		FROM aluga a 
		NATURAL JOIN inserido b 
		WHERE a.morada = b.posto_morada AND a.codigo = b.posto_codigo) x 
	WHERE estado = 'Aceite' 
	GROUP BY espaco_morada, espaco_codigo) w 
WHERE w.espaco_morada = v.espaco_morada AND w.espaco_codigo = v.espaco_codigo AND n=m;*/

#------------------------------------1-----------------------------------
/*SELECT morada, codigo 
FROM (
SELECT espaco.morada, espaco.codigo, y.morada ym 
FROM espaco 
LEFT JOIN (
SELECT morada, codigo_espaco 
FROM posto 
NATURAL JOIN (
SELECT morada, codigo, estado 
FROM estado 
NATURAL JOIN aluga) x 
WHERE x.morada = posto.morada AND x.codigo = posto.codigo AND estado = 'Aceite') y 
ON espaco.morada = y.morada AND espaco.codigo = y.codigo_espaco) z 
WHERE ym IS NULL;*/

SELECT morada, t_codigo codigo 
FROM (
SELECT morada, t_codigo, CASE WHEN codigo_espaco IS NULL THEN codigo ELSE codigo_espaco END codigo 
FROM (
SELECT t.morada, t.codigo t_codigo, codigo_espaco, u.codigo 
FROM (
SELECT espaco.morada, codigo, codigo_espaco 
FROM espaco 
LEFT JOIN (
SELECT morada, codigo_espaco, z.c  
FROM ( 
SELECT morada, codigo_espaco, COUNT(morada) c  
FROM ( 
SELECT *  
FROM ( 
SELECT *  
FROM posto  
NATURAL JOIN aluga  
NATURAL JOIN estado  
WHERE estado = 'Aceite') x 
GROUP BY morada, codigo) y  
GROUP BY morada, codigo_espaco) z  
NATURAL JOIN ( 
SELECT *, COUNT(morada) c  
FROM posto  
GROUP BY morada, codigo_espaco) w) v 
ON espaco.morada = v.morada AND espaco.codigo = codigo_espaco) t 
LEFT JOIN (
SELECT espaco.morada, espaco.codigo, estado  
FROM espaco  
LEFT JOIN aluga  
NATURAL JOIN estado  
ON espaco.morada = aluga.morada AND espaco.codigo = aluga.codigo 
WHERE estado = 'Aceite') u 
ON t.morada = u.morada AND t.codigo =u.codigo) r) s 
WHERE codigo IS NULL;


#-----------------------------------2-------------------------------------
SELECT * 
FROM (
SELECT morada, COUNT(morada) cn, y.a 
FROM aluga, (
SELECT AVG(c) a 
FROM (
SELECT *, COUNT(morada) c 
FROM aluga 
GROUP BY morada) x
) y 
GROUP BY morada) z 
WHERE z.cn > z.a;

#-----------------------------------3--------------------------------------
SELECT nif 
FROM (
SELECT *, COUNT(nif) c 
FROM (
SELECT * 
FROM arrenda 
NATURAL JOIN fiscaliza 
GROUP BY nif, id) A 
GROUP BY nif) B 
WHERE c = 1;

#-----------------------------------4--------------------------------------
SELECT espaco.morada, espaco.codigo, CASE WHEN sum IS NULL THEN 0 ELSE sum END sum 
FROM espaco 
LEFT JOIN (
SELECT morada, codigo, SUM(tarifa_total) sum  
FROM ( 
SELECT a_morada morada, CASE WHEN codigo_espaco IS NULL THEN a_codigo ELSE codigo_espaco END as codigo, tarifa_total  
FROM ( 
SELECT *  
FROM ( 
SELECT morada a_morada, codigo a_codigo, (data_diff+1)*tarifa tarifa_total   
FROM ( 
SELECT *, DATEDIFF(data_fim, data_inicio) data_diff   
FROM oferta  
NATURAL JOIN aluga  
NATURAL JOIN paga) x  
WHERE data like '2016_%') y  
LEFT JOIN posto p  
ON a_morada = p.morada AND a_codigo = p.codigo) w) v  
GROUP BY morada, codigo) u 
ON espaco.morada = u.morada AND espaco.codigo = u.codigo;


#-----------------------------------5--------------------------------------
/*SELECT morada, codigo_espaco codigo 
FROM (
SELECT *, COUNT(morada) count_a 
FROM posto 
GROUP BY morada, codigo_espaco) z 
NATURAL JOIN (
SELECT *, COUNT(morada) count_b 
FROM (
SELECT * 
FROM posto 
NATURAL JOIN aluga 
NATURAL JOIN estado 
WHERE estado = 'Aceite' 
GROUP BY morada, codigo) x 
GROUP BY morada, codigo_espaco) y 
WHERE count_a = count_b;*/

SELECT morada, codigo 
FROM (
SELECT e_morada, codigo, CASE WHEN t.morada IS NULL THEN u.morada ELSE t.morada END morada 
FROM (
SELECT e.morada e_morada, e.codigo, v.morada 
FROM espaco e 
LEFT JOIN (
SELECT morada, codigo, estado 
FROM espaco 
NATURAL JOIN aluga 
NATURAL JOIN estado 
WHERE estado = 'Aceite' 
GROUP BY morada, codigo) v 
ON e.morada = v.morada AND e.codigo = v.codigo) t 
LEFT JOIN (
SELECT morada, codigo_espaco, z.c 
FROM (
SELECT morada, codigo_espaco, COUNT(morada) c 
FROM (
SELECT * 
FROM (
SELECT * 
FROM posto 
NATURAL JOIN aluga 
NATURAL JOIN estado 
WHERE estado = 'Aceite') x 
GROUP BY morada, codigo) y 
GROUP BY morada, codigo_espaco) z 
NATURAL JOIN (
SELECT *, COUNT(morada) c 
FROM posto 
GROUP BY morada, codigo_espaco) w) u 
ON e_morada = u.morada AND codigo = codigo_espaco) r 
WHERE morada IS NOT NULL;
