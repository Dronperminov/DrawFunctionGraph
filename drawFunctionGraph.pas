uses
  graphABC;

const
  W = 1200; 
  H = 550;
  
  //Координаты левой верхней границы системы координат:
  xLeft = 50; 
  yLeft = 50;
  
  //Координаты правой нижней границы системы координат:
  xRight = W - 50; 
  yRight = H - 50;
  
  a = -10; 
  b = 10; 
  dx = 0.5;
  
  fmin = -1;
  fmax = 1;
  dy = 0.1;

  step = 0.001;

type
  funcT = function(x:real):real;

function F(x: real):real;
begin
  F := sin(x);
end;

var
  x0, y0: integer;
  mx, my: real;

procedure drawCoordinates(var x0, y0:integer; var mx, my:real);
var 
  n, i, x, y:integer;
  num:real;
  s: string;
begin
  mx := (xRight - xLeft) / (b - a); // масштаб по Х
  my := (yRight - yLeft) / (fmax - fmin); // масштаб по Y
  
  //начало координат:
  x0 := trunc(abs(a) * mx) + xLeft;
  y0 := yRight - trunc(abs(fmin) * my);
  
  line(xLeft, y0, xRight + 10, y0); //ось ОХ
  line(x0, yLeft - 10, x0, yRight); //ось ОY
  SetFontSize(12); //Размер шрифта
  SetFontColor(clBlue); //Цвет шрифта
  TextOut(xRight + 20, y0 - textHeight('X') div 2, 'X'); //Подписываем ось OX
  TextOut(x0 - textWidth('Y') div 2, yLeft - 30, 'Y'); //Подписываем ось OY
  SetFontSize(8); //Размер шрифта
  SetFontColor(clRed); //Цвет шрифта
  
  n := round((b - a) / dx) + 1; //количество засечек по ОХ
  
  for i := 1 to n do begin
    num := a + (i - 1) * dx; //Координата на оси ОХ
    x := xLeft + trunc(mx * (num - a)); //Координата num в окне
    Line(x, y0 - 3, x, y0 + 3); //рисуем засечки на оси OX
    str(Num:0:1, s);
    
    //Исключаем 0 на оси OX
    if abs(num) > 1E-15 then 
      TextOut(x - TextWidth(s) div 2, y0 + 10, s)
  end;
  
  // Засечки на оси OY:
  n := round((fmax - fmin) / dy) + 1; //количество засечек по ОY
  
  for i := 1 to n do begin
    num := fMin + (i - 1) * dy; //Координата на оси ОY
    y := yRight - trunc(my * (num - fmin));
    Line(x0 - 3, y, x0 + 3, y); //рисуем засечки на оси Oy
    str(num:0:1, s);
    
    //Исключаем 0 на оси OY
    if abs(num) > 1E-15 then
      TextOut(x0 + 7, y - TextHeight(s) div 2, s)
  end;
  
  TextOut(x0 - 10, y0 + 10, '0'); //Нулевая точка
end;

procedure drawGraph(f:funcT; x0, y0:integer; mx, my:real);
var 
  x, y:integer;
  x1:real;
begin
  x1 := a;
  LockDrawing();
  
  while x1 <= b do  begin
    x := x0 + round(x1 * mx);
    y := y0 - round(F(x1) * my);
    
    if (y >= yLeft) and (y <= yRight) then 
      SetPixel(x, y, clGreen);
      
    x1 := x1 + step //Увеличиваем абсциссу
  end;
  
  Redraw();
end;

begin
  SetWindowSize(W, H); //Устанавливаем размеры графического окна  
    
  drawCoordinates(x0, y0, mx, my);  
  drawGraph(f, x0, y0, mx, my);
end.