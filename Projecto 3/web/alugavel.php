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
    
        $sql = "SELECT * FROM posto WHERE morada = '$morada';";
        $sql2 = "SELECT * FROM espaco WHERE morada = '$morada';";
    
        $result = $db->query($sql);
        $result2 = $db->query($sql2);
    
        echo("<table border=\"0\" cellspacing=\"5\">\n");
        echo("<td>morada</td>\n");
        echo("<td>codigo do posto</td>\n");
        echo("<td>codigo do espaco</td>\n");
        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['morada']}</td>\n");
            echo("<td>{$row['codigo']}</td>\n");
            echo("<td>{$row['codigo_espaco']}</td>\n");
            echo("<td><a href=\"posto_remove.php?morada={$row['morada']}&codigo={$row['codigo']}\">Remover Posto</a></td>\n");
            echo("<td><a href=\"oferta_insere.php?morada={$row['morada']}&codigo={$row['codigo']}\">Criar Oferta</a></td>\n");
            echo("<td><a href=\"oferta.php?morada={$row['morada']}&codigo={$row['codigo']}\">Seleciona Posto</a></td>\n");
            echo("</tr>\n");
        }
        echo("<table border=\"0\" cellspacing=\"5\">\n");
        echo("<td>morada</td>\n");
        echo("<td>codigo do espaco</td>\n");
        foreach($result2 as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['morada']}</td>\n");
            echo("<td>{$row['codigo']}</td>\n");
            echo("<td><a href=\"espaco_remove.php?morada={$row['morada']}&codigo={$row['codigo']}\">Remover Espaco</a></td>\n");
            echo("<td><a href=\"posto_insere.php?morada={$row['morada']}&codigo_espaco={$row['codigo']}\">Inserir Posto</a></td>\n");
            echo("<td><a href=\"oferta_insere.php?morada={$row['morada']}&codigo={$row['codigo']}\">Criar Oferta</a></td>\n");
            echo("<td><a href=\"oferta.php?morada={$row['morada']}&codigo={$row['codigo']}\">Seleciona Espaco</a></td>\n");
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
