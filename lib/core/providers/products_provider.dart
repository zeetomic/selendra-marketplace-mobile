import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/products.dart';
import 'package:http/http.dart' as _http;
import 'package:selendra_marketplace_app/core/storage/storage.dart';

class ProductsProvider with ChangeNotifier {

  List<Product> data = [
    Product(),
    Product(),
    Product(),
    Product()
  ];

  final String myImageUrl = 'https://purepng.com/public/uploads/medium/purepng.com-single-carrotcarrotonesinglevegetablesfreshdeliciousefoodhealthy-481521740676q8i3l.png';

  List<Product> _vegProduct = [];

  List<Product> get items => [...data];

  List<Product> get vegProduct => [..._vegProduct];

  Product findById(int id) => data.firstWhere((prod) => prod.id == id);

  GetRequest _getRequest = GetRequest();

  ProductsProvider(){
    getData();
  }

  Future<void> getData() async {
    await StorageServices.fetchData('fruit').then((value) async {
      data.clear();
      if (value == null) {
        _http.Response response = await _http.get(
          'https://data.wa.gov/resource/tgdf-dvhm.json',
          headers: {
            "Content-Type": "application/json; charset=utf-8", 
          }
        );
        
        await fromDB(response);

        print("From DB $data");

        await objectToJson(data).then((value) async => await StorageServices.setData(value, 'fruit'));
      } else {

        print("From storage");
        jsonToObject(value);
      }
    });
    notifyListeners();
  }

  // Extract Data From Object To Json
  Future<List<Map<String, dynamic>>> objectToJson(List<Product> data) async{
    List<Map<String, dynamic>> list = List<Map<String, dynamic>>();
    data.forEach((element) {
      list.add({
        'id': element.id == null ? '' : element.id,
        'image': element.image == null ? '' : element.image,
        'title': element.title == null ? '' : element.title,
        'price': element.orderQty == null ? '' : element.orderQty,
        'description': element.description == null ? '' : element.description,
        'color': element.color == null ? '' : element.color,
        'seller_name': element.sellerName == null ? '' : element.sellerName,
        'seller_phone': element.sellerPhoneNum == null ? '' : element.sellerPhoneNum,
        'category': element.category == null ? '' : element.category,
        'isFavority': element.isFavorite == null ? '' : element.isFavorite,
      });
    });
    return list;
  }

  // Retrieve Data From Database
  Future<void> fromDB(_http.Response response) async {
    List.from(json.decode(response.body)).forEach((element) {
      data.addAll({
        Product(
          id: element['id'] == null ? '' : int.parse(element['id']),
          image: element['image'] == null ? '' : myImageUrl,
          title: element['title'] == null ? '' : element['fruit'],
          price: element['price'] == null ? '' : double.parse(element['price']),
          description: element['description'] == null ? '' : element['description'], 
          color: element['color'] == null ? '' : element['color'], 
          sellerName: element['seller_name'] == null ? '' : element['seller_name'], 
          sellerPhoneNum: element['seller_phone'] == null ? '' : element['seller_phone'], 
          category: element['category'] == null ? '' : element['category'], 
          isFavorite: element['isFavority'] == null ? '' : element['isFavority'] == '1' ? true : false
        )
      });
    });
  }

  // Extract Data From Json To Object
  Future<void> jsonToObject(List value) async {
    List.from(value).forEach((element) {
      print("Category ${element['category']}");
      data.addAll({
        Product(
          id: element['id'].round(),
          image: element['image'],
          title: element['title'],
          price: element['price'].toDouble(),
          description: element['description'],
          color: element['color'],
          sellerName: element['seller_name'],
          sellerPhoneNum: element['seller_phone'],
          category: element['category'],
          isFavorite: element['isFavority'] == '1' ? true : false,
        )
      });
    });
  }

  //ADD NEW PRODUCT
  void addItem(AddProduct newProduct) {

      newProduct.toProduct(
        newProduct, 
        "12", 
        'https://github.com/rajayogan/flutterui-fruitcookbook/blob/master/assets/blueberries.png?raw=true', 
        'FF3D82AE'
      );

      print(newProduct.name.text);
      print(newProduct.address.text);
      print(newProduct.categories.text);
      print(newProduct.city.text);
      print(newProduct.description.text);
      print(newProduct.district.text);
      print(newProduct.images);
      print(newProduct.price.text);
      print(newProduct.sellerName.text);
      print(newProduct.sellerNumber.text);
    
    // data.add(
    //   newProduct.toProduct(
    //     newProduct, 
    //     "12", 
    //     'https://github.com/rajayogan/flutterui-fruitcookbook/blob/master/assets/blueberries.png?raw=true', 
    //     'FF3D82AE'
    //   )
    // );
    // objectToJson(data).then((value) async => { await StorageServices.setData(value, 'fruit')});
    // notifyListeners();
  }

  //FETCH PRODUCTS INTO DIFFERENT CATEGORIES
  void getVegi() {
    for (int i = 0; i < data.length; i++) {
      if (data[i].category == 'veg') {
        _vegProduct.add(data[i]);
      }

      notifyListeners();
    }
  }

  //INCREASE ORDER QUANTITY OF PRODUCT
  void addOrderQty(Product product) {
    product.orderQty++;
    notifyListeners();
  }

  //DECREASE ORDER QUANTIY OF PRODUCT
  void minusOrderQty(Product product) {
    if (product.orderQty > 1) {
      product.orderQty--;
      notifyListeners();
    }
  }
}