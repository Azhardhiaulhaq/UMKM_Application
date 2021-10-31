import 'package:flutter/material.dart';
import 'package:umkm_application/Model/category.dart';
import 'package:umkm_application/Model/event.dart';
import 'package:umkm_application/Model/product.dart';
import 'package:umkm_application/Model/store.dart';

class AppData{
  static List<Category> categoryList = [
    Category(id:1,name:"Semua",isSelected:true,icon:Icons.store),
    Category(id:2,name:"Makanan",icon:Icons.fastfood),
    Category(id:3,name:"Pakaian",icon:Icons.emoji_people),
    Category(id:4,name:"Kesenian",icon:Icons.emoji_nature),
  ];

  static List<Store> storeList = [
    Store(id:"1",name:"Sepatu Murah Bandung Raya",image:"https://marketplace-images-production.s3-us-west-2.amazonaws.com/vault/items/preview-552e2ef3-5814-481c-8390-74360a141525-1180x660-DqZTZ.jpg", city:"Bandung",province:"Jawa Barat",tags:["Pakaian"]),
    Store(id:"2",name:"Mie Kocok Mang Adi",image:"https://image.freepik.com/free-vector/noodle-logo-template-vector-illustration_158608-18.jpg", city:"Cibadak",province:"Jawa Barat",tags:["Makanan"]),
    Store(id:"3",name:"Jasa Lukis Wajah",image:"https://t4.ftcdn.net/jpg/02/23/50/33/360_F_223503328_ueDVAxhdDOpETMxjaIR1JSZYYABnsjed.webp", city:"Bandung",province:"Jawa Barat",tags:["Kesenian"]),
    Store(id:"4",name:"Seblak Jeletet Murah",image:"https://img.freepik.com/free-vector/food-logo-design_139869-254.jpg?size=626&ext=jpg", city:"Antapani",province:"Jawa Barat",tags:["Makanan"]),
  ];

  // static List<Event> eventList = [
  //   Event(id:1,name:"Event UMKM Bandung", description: "Event ini adalah hasil kerjasama pemerintah Bandung dengan berbagai UMKM yang ada.",location: "Gedung Sate, Bandung, Jawa Barat", date : "Sabtu, 29 Juni 2021"),
  //   Event(id:2,name:"Event UMKM Bandung 2", description: "Event ini adalah hasil kerjasama pemerintah Bandung dengan berbagai UMKM yang ada.",location: "Gedung Sate, Bandung, Jawa Barat", date : "Senin, 01 Juli 2021"),
  //   Event(id:3,name:"Event UMKM Bandung 3", description: "Event ini adalah hasil kerjasama pemerintah Bandung dengan berbagai UMKM yang ada.",location: "Gedung Sate, Bandung, Jawa Barat", date : "Senin, 01 Juli 2021"),
  // ];

  // static List<Product> productList = [
  //   Product(id:1,name:"Sepatu Casual", description: "Sepatu casual dengan bahan yang ramah lingkungan dan sangat ringan. Dibuat dengan sepenuh hati dan dengan tingkat ketelitian yang sangat tinggi. Merupakan produk lokal asli Indonesia.", image: 'https://static.vecteezy.com/system/resources/thumbnails/000/060/594/small/sport-shoes.jpg', price: 200000),
  //   Product(id:2,name:"Sepatu Sepakbola", description: "Gaming mouse serbaguna", image: 'https://5.imimg.com/data5/SS/JM/EU/SELLER-16369040/vector-x-football-shoes-500x500.jpg', price: 500000),
  //   Product(id:3,name:"Sepatu Lari", description: "Gaming mouse serbaguna", image: 'https://png.pngtree.com/png-vector/20201224/ourlarge/pngtree-original-running-shoes-marathon-sports-shoes-png-image_2611777.jpg', price: 300000),
  //   Product(id:4,name:"Sepatu Badminton", description: "Gaming mouse serbaguna", image: 'https://rukminim1.flixcart.com/image/714/857/j687jbk0/shoe/9/z/k/ts-7000-blu-orng-6-6-vector-x-blue-orange-original-imaewqm8a25uybhe.jpeg', price: 250000),
  // ];
}
