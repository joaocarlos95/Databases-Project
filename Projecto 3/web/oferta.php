<html>
    <body>
    <h3>Ofertas</h3>
<?php
    $morada = $_REQUEST['morada'];
    $codigo = $_REQUEST['codigo'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist181950";
        $password = "evlw3510";
        $dbname = $user;
    
        $db = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
        $sql = "SELECT * FROM oferta WHERE morada = '$morada' AND codigo = '$codigo';";
    
        $result = $db->query($sql);
    
        echo("<table border=\"0\" cellspacing=\"5\">\n");
        echo("<td>morada</td>\n");
        echo("<td>codigo</td>\n");
        echo("<td>data de inicio</td>\n");
        echo("<td>data de fim</td>\n");
        echo("<td>tarifa</td>\n");
        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['morada']}</td>\n");
            echo("<td>{$row['codigo']}</td>\n");
            echo("<td>{$row['data_inicio']}</td>\n");
            echo("<td>{$row['data_fim']}</td>\n");
            echo("<td>{$row['tarifa']}</td>\n");
            echo("<td><a href=\"oferta_remove.php?morada={$row['morada']}&codigo={$row['codigo']}&data_inicio={$row['data_inicio']}\">Remover Oferta</a></td>\n");
            echo("<td><a href=\"reserva_insere.php?morada={$row['morada']}&codigo={$row['codigo']}&data_inicio={$row['data_inicio']}\">Criar Reserva</a></td>\n");
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
