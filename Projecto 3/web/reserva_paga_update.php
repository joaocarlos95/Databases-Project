<html>
    <body>
<?php
    $numero = $_REQUEST['numero'];
    $data = $_REQUEST['data'];
    $metodo = $_REQUEST['metodo'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist181950";
        $password = "evlw3510";
        $dbname = $user;
        $db = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->query("start transaction;");

        $sql1 = "SELECT MAX(numero)+1 FROM reserva;";
        $result = $db->query($sql1);

        foreach($result as $row){
            $nmax =($row[0]);
        }

        $sql = "INSERT INTO paga VALUES ('$numero', '$data', '$metodo');";
        $sql2 = "INSERT INTO estado VALUES ('$numero', '$data', 'Aceite');";

        echo("<p>$sql</p>");

        $db->query($sql);
        $db->query($sql2);

        $db->query("commit;");

        $db = null;
    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
