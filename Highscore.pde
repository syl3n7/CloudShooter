class Highscore {
//propriedades
Table table;
boolean active;
Button back;
Background background;
//construtor
Highscore() {
    background = new Background("/assets/images/background1080p.png", width/2, height/2);
    active = false;
    back = new Button("assets/images/back_button.png", width-250, 80);//botao para retroceder
    //inicializar a tabela para armazenar highscore
    table = new Table();
    //adicionar colunas na tabela
    table.addColumn("id");
    table.addColumn("score");
}
    void drawme() {
        background.drawme();
        if(active);
        loadData();
    }
    void loadData() { //carregar a tabela com os valores anteriores.
        table = loadTable("data/highscore.csv", "header");
        int contador = table.getRowCount();
        //print all the data from csv
        fill(255, 0, 0);
        textSize(34);
        for (int i = 0; i < contador; i++) {
            text("ID: " + table.getRow(i).getInt("id")+" SCORE: " + table.getRow(i).getInt("score"), width/2, 35 + i*35);
        }
    }
    void addData() { //adicionar dados na tabela
        if (score > 0) {
            TableRow newRow = table.addRow();
            //adicionar linhas na tabela
            newRow.setInt("id", table.lastRowIndex()+1);
            newRow.setInt("score", score);
        } else println("no data to save");
    }
    void saveData() {
        saveTable(table, "data/highscore.csv"); //guardar os dados da tabela no ficheiro
    }
    int top5() { // tenho que por isto a funcionar para mostrar pelo botao highscore
        int result = 0;
        //ler o ficheiro e determinar o top 5   
        return result;
    }
}