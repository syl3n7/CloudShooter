class Highscore{

//propriedades
Table t1;

//construtor
    Highscore(){

        //inicializar a tabela para armazenar highscore
        t1 = new Table();
        //adicionar colunas na tabela
        table.addColumn("id");
        table.addColumn("name");
        table.addColumn("score");

        //inicializar as linhas
        TableRow newRow = table.addRow();

        //adicionar linhas na tabela
        newRow.setInt("id", table.lastRowIndex()+1);
        newRow.setString("name", "José");
        newRow.setInt("score", 100);

        saveTable(table, "data/highscore.csv"); );

    }

    //metodos
    int top5(){

        //ler o ficheiro e determinar o top 5



        return 1, 2, 3, 4, 5;
    }

}