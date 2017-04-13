<html>
    <body>
        <h3>Insere novo espaco</h3>
        <form action="espaco_update.php" method="post">
            <p>Morada novo espaco: <?php echo ($_REQUEST['morada']); ?><input type="hidden" name="morada" value="<?php echo ($_REQUEST['morada']); ?>"/></p>
            <p>Codigo novo espaco: <input type="text" name="codigo"/></p>
            <p><input type="submit" value="Submit"/></p>
        </form>
    </body>
</html>