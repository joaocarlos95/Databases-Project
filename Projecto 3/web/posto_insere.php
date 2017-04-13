<html>
    <body>
        <h3>Insere novo posto</h3>
        <form action="posto_update.php" method="post">
        	<p>Morada novo posto: <?php echo ($_REQUEST['morada']); ?><input type="hidden" name="morada" value="<?php echo ($_REQUEST['morada']); ?>"/></p>
        	<p>Codigo espaco novo posto: <?php echo ($_REQUEST['codigo_espaco']); ?><input type="hidden" name="codigo_espaco" value="<?php echo ($_REQUEST['codigo_espaco']); ?>"/></p>
            <p>Codigo posto: <input type="text" name="codigo"/></p>
            <p><input type="submit" value="Submit"/></p>
        </form>
    </body>
</html>