<html>
    <body>
<?php
    $morada = $_REQUEST['morada'];
    $codigo = $_REQUEST['codigo'];
    $codigo_espaco = $_REQUEST['codigo_espaco'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist181950";
        $password = "evlw3510";
        $dbname = $user;
        $db = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->query("start transaction;");

        $sql = "INSERT INTO alugavel VALUES ('$morada', '$codigo', '');";
        $sql1 = "INSERT INTO posto VALUES ('$morada', '$codigo', '$codigo_espaco');";

        echo("<p>$sql</p>");

        $db->query($sql);
        $db->query($sql1);

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
