<html>
    <body>
    <h3>Alugaveis</h3>
<?php
    $morada = $_REQUEST['morada'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist181950";
        $password = "evlw3510";
        $dbname = $user;
    
        $db = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "SELECT espaco.morada, espaco.codigo, CASE WHEN sum IS NULL THEN 0 ELSE sum END sum 
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
                NATURAL JOIN paga) x) y  
                LEFT JOIN posto p  
                ON a_morada = p.morada AND a_codigo = p.codigo) w) v  
                GROUP BY morada, codigo) u 
                ON espaco.morada = u.morada AND espaco.codigo = u.codigo
                WHERE espaco.morada = '$morada';
                ";
    
        $result = $db->query($sql);
    
        echo("<table border=\"0\" cellspacing=\"5\">\n");
        echo("<td>morada</td>\n");
        echo("<td>codigo do espaco</td>\n");
        echo("<td>montate realizado</td>\n");
        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['morada']}</td>\n");
            echo("<td>{$row['codigo']}</td>\n");
            echo("<td>{$row['sum']}</td>\n");
            echo("</tr>\n");
        }
        echo("</table>\n");
        echo("<td><a href=\"espaco_insere.php?morada=$morada\">Inserir Espaco</a></td>\n");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
