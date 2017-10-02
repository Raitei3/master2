var arg = 100;
var money = document.getElementById('money');
money.innerHTML=arg;
var ptBank = document.getElementById('ptBank');
var ptPlay = document.getElementById('ptPlayer');
var playButton = document.getElementById('play');
var cardPlayer = document.getElementById('cardPlayer');
var cardBank = document.getElementById('cardBank');
var divButton = document.getElementById('button');
var mise = document.getElementById('mise');
var piocheButton = document.getElementById('pioche');
var tourButton = document.getElementById('endTour');

var manche = false;
var miseManche = 0;



var deck = new Array(52);
var color = new Array("pique","trefle","carreau","coeur");
var mainBank = new Array();
var mainPlayer = new Array();
var ptB =0;
var ptP=0;

function card(v,c){
  this.value = v;
  this.couleur = c;
}

var c = 0;
for (var i = 0; i < 4; i++) {
  for (var j = 0; j < 13; j++) {
    deck[c]= new card(j+1,color[i]);
    c++;
  }
}

/*function printCard(tab){
  var img = document.createElement("img",src='../card/0_1.svg',alt = "carte");
  cardPlayer.addChildren(img);
}*/

function displayImg(card,player){
  var img = new Image();
  img.addEventListener('load', function() {
    if (player) {
      cardPlayer.appendChild(img);
    }
    else {
      cardBank.appendChild(img);
    }
    img.width = 175;
    img.height = 254;
  });
  var type;
  switch (card.couleur) {
    case "coeur":
      type = "hearts";
      break;
      case "trefle":
        type = "clubs"
        break;
      case "carreau":
        type = "diamonds"
        break;
      case "pique":
        type = "spades"
        break;
    default:
    break;
  }

  var src = "deck/" + card.value + "_of_" + type + ".png"
  //img.src="deck/1_of_clubs.png";
  img.src=src;
  return img;
}

/*var img2 = document.createElement("svg", xmlns = "file:///F:/Cours/web/tp2/0_1.svg", alt = "tamere");
svg.setAttribute('style', 'border: 1px solid black');
function display(){
  var img = document.createElement("svg",alt = "tamere" ,xmlns = "0_1.svg" );
  cardPlayer.appendChild(img);
  cardPlayer.appendChild(img2);
}*/

function calculeScore(tab,x){

}

function pioche(isMe){
  var x = Math.floor(Math.random()*52);
  //console.log(x)
  var y = deck[x].value;
  if (isMe) {
    mainPlayer.push(y);
    console.log("player : "+ deck[x]);
    console.log(deck[x]);
    displayImg(deck[x],true);
  }
  else {
    mainBank.push(y)
    console.log("banque : "+deck[x]);
    console.log(deck[x]);
    var img = displayImg(deck[x],false);
    sleep(1000);
    cardBank.appendChild(img);

  }
  if (y>10) {
    return 10;
  }
  else{
    return y;
  }
}

function bankPlay(){
  var pt = 0 ;
  while (ptB < ptP && ptP<=21) {
    pt = pioche(false);
    //console.log(pt);
    ptB = ptB+pt;
    ptBank.innerHTML=ptB;
  }
  if (ptB>21) {
    endManche(true);
    return;
  }
  else if (ptB >= ptP) {
    endManche(false);
    return;
  }
}

function initManche (){
  manche = true;
  console.log("début de manche \n");
  while (cardBank.firstChild) {
    cardBank.removeChild(cardBank.firstChild);
  }
  while (cardPlayer.firstChild) {
    cardPlayer.removeChild(cardPlayer.firstChild);
  }
//  bankPlay();
}


playButton.addEventListener('click',function(){
  var m = +mise.value;
  if (manche==false && mise.value != 0 && m < arg) {
    miseManche=m;
    mise.value=0;
    initManche();
    p();
  }
  else {}
});


piocheButton.addEventListener('click',function(){
  p();
});

tourButton.addEventListener('click',function(){
  if (manche == true) {
    bankPlay();
  }
});


function p(){
  if (manche==true && ptP <= 21) {
    var x = pioche(true);
    ptP = ptP + x;
    ptPlayer.innerHTML = ptP
    if (ptP>21) {
      endManche(false);
      return;
    }
  }
  else {}
}

function endManche(win){
  if (win==true) {
    arg=arg+miseManche;
    alert("Vous remportez la manche");
  }
  else {
    arg=arg-miseManche;
    alert("La banque remporte la manche")
  }
  money.innerHTML = arg;
  ptB=0;
  ptP=0;
  mainBank.splice(0,mainBank.length);
  mainPlayer.splice(0,mainPlayer.length)
  ptPlayer.innerHTML =0;
  ptBank.innerHTML =0;
  manche = false;
  while (cardBank.firstChild) {
    cardBank.removeChild(cardBank.firstChild);
  }
  while (cardPlayer.firstChild) {
    cardPlayer.removeChild(cardPlayer.firstChild);
  }
}

function sleep(miliseconds) {
   var currentTime = new Date().getTime();

   while (currentTime + miliseconds >= new Date().getTime()) {
   }
}
