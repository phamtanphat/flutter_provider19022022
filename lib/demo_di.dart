class XeHoi{
  late BanhXe banhXe;
  late DongCo dongCo;

  XeHoi({required this.banhXe, required this.dongCo});
}

class BanhXe{

}

class DongCo{

}

void main(){

  // phu thuoc

  BanhXe banhXe = BanhXe();
  DongCo dongCo = DongCo();

  XeHoi xeHoi = XeHoi(banhXe: banhXe,dongCo: dongCo);

}