pragma circom 2.0.8;

include "./circomlib/gates.circom";
include "./circomlib/comparators.circom";

/*
check if the puzzle is valid
 */
template IsValidPuzzle(){
    signal input number;
    signal output result;

    result<==1;
}

/*
check if the solution is valid for the givem puzzle
*/
template IsValidSolution(){
    signal input number;
    signal output result;

    result<==1;
}

/*
check if number is in range [from,to] inclusive of limits 
*/
template IsNumberInRange(from, to){
signal input number;
signal output result;

component greater = GreaterEqThan(4); // max number required will be 9 thus 2**4 works
component lesser = LessEqThan(4);

greater.in[0] <== number;
greater.in[1] <== from;

lesser.in[0] <== number;
lesser.in[1] <== to;

component add = ADD();

add.a <== greater.out;
add.b <== lesser.out;

result <== and.out;

}

/*

* checks if the group is solved state
* All numbers are in range of [1-9]
* No duplication of numbers in the group

 */
template IsValidSolutionNumberGroup(){
    signal input number;
    signal output result;

    result<==1;
}

/**/
template IsValidPuzzleNumberGroup(){
    signal input number;
    signal output result;

    result<==1;
}

/**/
template IsValidSolutionOfPuzzle(){
    signal input number;
    signal output result;

    result<==1;
}

/*
* gives an array of numbers in the given row
* logic-> index*9 + i
*/
template GetNumberGroupForRow(index){
    signal input board[81];
    signal output numberGroup[9];

    for(var i=0; i<9; i++){
        for(var j=0; j<9;j++){
        numberGroup[i] = board[index*9 + i];
        }
    }
}

/*
* gives an array of numbers used in a column
* used simple logic-> index + 9* i
*/
template GetNumberGroupForColumn(index){
    signal input board[81];
    signal output numberGroup[9];

    for(var i = 0; i<9;i++){
        numberGroup[i] = board[index + 9*i];
    }
}

/*
* each 9*9 box has 9 3*3 boxes, index denotes each of that box
* logic-> declared an array which includes the very first position n0. of every box
       -> boxStarts[i] + (i/3)*9 + (i%3)
       -> the second element is the row switcher and the last one is column switcher          
*/
template GetNumberGroupForBox(index){
    signal input board[81];
    signal output numberGroup[9];

    var boxStarts[9] = [0,3,6,27,30,33,54,57,60];

    for(var i=0; i<9;i++){
       var position = boxStarts[index] + (i/3)*9 + (i%3); // 
       numberGroup[i] <== board[position];

    }
}
