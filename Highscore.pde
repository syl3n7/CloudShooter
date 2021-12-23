class Highscore{

//propriedades
Table table;

//construtor
    Highscore(){
        //inicializar a tabela para armazenar highscore
        table = new Table();
        //adicionar colunas na tabela
        table.addColumn("id");
        table.addColumn("score");
    }

    void addData(){
        TableRow newRow = table.addRow();
        //adicionar linhas na tabela
        newRow.setInt("id", table.lastRowIndex()+1);
        newRow.setInt("score", score);
    }

    void saveData(){
        //guardar os dados da tabela no ficheiro
        saveTable(table, "data/highscore.csv");
    }

    //metodos
    int top5(){ // tenho que por isto a funcionar para mostrar pelo botao highscore
        int result = 0;
        //ler o ficheiro e determinar o top 5
        
        return result;
    }

}