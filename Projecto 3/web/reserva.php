<html>
    <body>
    <h3>Reservas</h3>
<?php
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist181950";
        $password = "evlw3510";
        $dbname = $user;
    
        $db = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
        $sql = " SELECT * FROM aluga NATURAL JOIN estado e NATURAL JOIN (SELECT numero, MAX(time_stamp) max_time_stamp FROM estado GROUP BY numero) A WHERE e.numero = A.numero AND e.time_stamp = A.max_time_stamp;";
    
        $result = $db->query($sql);
    
        echo("<table border=\"0\" cellspacing=\"5\">\n");
        echo("<td>num reserva</td>\n");
        echo("<td>morada</td>\n");
        echo("<td>codigo</td>\n");
        echo("<td>time stamp</td>\n");
        echo("<td>estado</td>\n");
        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['numero']}</td>\n");
            echo("<td>{$row['morada']}</td>\n");
            echo("<td>{$row['codigo']}</td>\n");
            echo("<td>{$row['time_stamp']}</td>\n");
            echo ("<td>{$row['estado']}</td>\n");
            if ($row['estado'] == 'Pendente') {
                echo("<td><a href=\"reserva_paga.php?numero={$row['numero']}\">Pagar</a></td>\n");
            }
            echo("</tr>\n");
        }
        echo("</table>\n");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
