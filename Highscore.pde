class Highscore{
//propriedades
Table table;
boolean active;
Button back;
Background background;
//construtor
Highscore(){
    background = new Background("/assets/images/background1080p.png", width/2, height/2);
    active = false;
    back = new Button("assets/images/back_button.png", width-250, 80);//botao para retroceder
    //inicializar a tabela para armazenar highscore
    table = new Table();
    //adicionar colunas na tabela
    table.addColumn("id");
    table.addColumn("score");
}
void drawme(){
    background.drawme();
    if(active);
    loadData();
}
//carregar a tabela com os valores anteriores.
void loadData(){
    table = loadTable("data/highscore.csv", "header");
}
void addData(){ //adicionar dados na tabela
    if (score > 0){
        TableRow newRow = table.addRow();
        //adicionar linhas na tabela
        newRow.setInt("id", table.lastRowIndex()+1);
        newRow.setInt("score", score);
    } else println("no data to save");
}
void saveData(){
    //guardar os dados da tabela no ficheiro
    saveTable(table, "data/highscore.csv");
}
// tenho que por isto a funcionar para mostrar pelo botao highscore
int top5(){
    int result = 0;
    //ler o ficheiro e determinar o top 5   
    return result;
}
}