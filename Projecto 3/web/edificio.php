<html>
    <body>
    <h3>Edificios</h3>
<?php
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist181950";
        $password = "evlw3510";
        $dbname = $user;
    
        $db = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
        $sql = "SELECT morada FROM edificio;";
    
        $result = $db->query($sql);
    
        echo("<table border=\"0\" cellspacing=\"5\">\n");
        echo("<td>morada</td>\n");
        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['morada']}</td>\n");
            echo("<td><a href=\"edificio_remove.php?morada={$row['morada']}\">Remover Edificio</a></td>\n");
            echo("<td><a href=\"alugavel.php?morada={$row['morada']}\">Seleciona Edificio</a></td>\n");
            echo("<td><a href=\"total_realizado.php?morada={$row['morada']}\">Total Realizado</a></td>\n");
            echo("</tr>\n");
        }
        echo("</table>\n");
        echo("<td><a href=\"edificio_insere.php\">Inserir Edificio</a></td>\n");
        echo("<td><a href=\"reserva.php?morada={$row['morada']}&codigo={$row['codigo']}&data_inicio={$row['data_inicio']}\">Pagar Reservas</a></td>\n");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
