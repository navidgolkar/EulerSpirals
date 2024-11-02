int i, num = 1000;
float x, y, x1, y1, n = 0, angle = 0, theta = 0, leng = 10., zx, zy;
String text;
boolean flag = false;


void setup() {
  size(1000, 1000);
  zx = width/2;
  zy = height/2;
}

void draw() {
  background(51);
  theta = theta%360;
  theta = round(theta*100)/100.;
  angle = theta;
  x = zx;
  y = zy;
  color c;
  for (i=1; i<=num; i++) {
    x1 = x + (leng*cos(radians(-i*angle)));
    y1 = y + (leng*sin(radians(-i*angle)));
    c = colorset((float)i/num);
    stroke(c);
    line(x, y, x1, y1);
    angle+=theta;
    angle = angle%360;
    n = 0;
    x = x1;
    y = y1;
  }
  if (flag) {
    String name="EulerSpiral_number"+num+"_angle="+theta+"_length="+leng+".png";
    text="";
    saveFrame(name);
    flag=false;
  }
  text="angle = "+Float.toString(theta)+"\nn = "+num+"\nlength = "+leng;
  text += "\npress SPACE to save image";
  textSize(20);
  fill(255);
  text(text, 20, 20);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) theta += 0.01;
    else if (keyCode == DOWN) theta -= 0.01;
    if (keyCode == RIGHT || keyCode == LEFT) {
      int counter = 0;
      while (int(num/pow(10, counter)) > 1) counter++;
      counter--;
      if (keyCode == RIGHT && counter < 7) num += pow(10, counter);
      else if (num > 10) num -= pow(10, counter);
    }
  }

  if (key == ' ') flag=true;
  if ((key == '=' || key == '+') && leng < 20) {
    if (leng < 1) leng += 0.1;
    else leng += 1;
    leng = round(leng*10)/10.;
  }
  if ((key == '-' || key == '_') && leng > 0.1) {
    if (leng <= 1) leng -= 0.1;
    else leng -= 1;
    leng = round(leng*10)/10.;
  }
}

color colorset(float in) {
  colorMode(HSB, 360, 100, 100);
  color a1=color(60, 100, 100), a2=color(255, in*20+235, (1-in)*80+175);
  return lerpColor(a1, a2, in);
}

void mouseDragged() {
  zx -= (pmouseX - mouseX);
  zy -= (pmouseY - mouseY);
}
