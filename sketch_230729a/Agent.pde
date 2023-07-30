class Agent {
  float x;
  float y;
  //float speed = sizeText;
  float speed = sizeText * ((int)random(1,3));
  String str = "";
  int pointer = 0;
  float partOfLine = 0.7;

  Agent() {
    for (int i=0; i<height/sizeText * partOfLine; ++i)
      str += alphabet.charAt((int)random(0, alphabet.length()));
  }

  void step() {
    y = (y + speed) % height;
    
    //if (y > height + sizeText) {
    //  y = - sizeText;
    //}
  }

  void display() {
    for (int i=0; i<str.length(); ++i) {
      text(str.charAt((pointer++)%str.length()), x, (y + i * sizeText)% height);
    }
    pointer = (pointer + 1)%str.length();
  }
}
