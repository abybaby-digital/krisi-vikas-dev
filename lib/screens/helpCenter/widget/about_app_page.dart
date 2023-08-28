import 'package:flutter/material.dart';
import '../../../const/colors.dart';
import '../../../widgets/all_widgets.dart';

class AboutAppPage extends StatelessWidget {
  final String? tearmsTitle;

  const AboutAppPage({
    Key? key,
    this.tearmsTitle = "",
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: barlowBold(
          text: tearmsTitle!,
          color: white,
          size: 20,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VSpace(10),
              barlowBold(
                text: "About Krishi Vikas",
                size: 20,
                color: black,
              ),
              VSpace(10),
              Divider(
                height: 1,
                color: black,
              ),
              VSpace(10),
              barlowRegular(
                text:
                    "Krishi Vikas Udyog is the first one-stop solution for the farming community scattered across the country, by connecting buyers and sellers of Agri-products and equipment through technology ( Mobile and Desktop Application). We help farmers to Buy, Sell, Finance, Insure and Service New/Used tractors and every kind of farm equipment. ",
                size: 15,
                color: black,
              ),
              VSpace(10),
              barlowRegular(
                text: "This platform is created to solve the "
                    "Agri-crisis"
                    " to healthy "
                    "Agri-culture"
                    " and improve with every decision making, thereby making it convenient for them to solve their occupation-related requirements by providing them access to those having relevant solutions – Peer to Peer or B2C.",
                size: 15,
                color: black,
              ),
              VSpace(10),
              barlowRegular(
                text:
                    "We have created an ecosystem on the back of technology, shared economy and useful content, that connects the demand side of agriculture to its supply side, we have created a wide range of variety categorization from tractors to seeds, from fertilizer to implements where people from all walks can either buy, sell or rent as per their need with our user-friendly Krishi Vikas Udyog Application.",
                size: 15,
                color: black,
              ),
              VSpace(10),
              barlowBold(
                text: "Krishi Vikas Udyog to Fulfill Farmer's Dreams.",
                size: 15,
                color: black,
              ),
              VSpace(10),
              barlowRegular(
                text:
                    "Krishi Vikas Udyog considered Indian farmers as the most important backbone of Indian society. That's why we show complete information in every separate section so that you can get every farm information comfortably sitting at home. We aim to revolutionise the Indian tractor industry by bringing transparency to pricing, information and comparison of tractors, farm equipment and related financial products.",
                size: 15,
                color: black,
              ),
              VSpace(10),
              barlowBold(
                text: "Krishi Vikas Udyog- Solution at your fingertip.",
                size: 15,
                color: black,
              ),
              VSpace(10),
              barlowRegular(
                text:
                    "We aim to provide all information related to farming to every part of India. Download our Krishi Vikas Udyog Application and get exciting offers, deals, expert reviews, videos and a lot of agriculture-related things. We provide you with a one-stop solution to all your farming needs and queries. ",
                size: 15,
                color: black,
              ),
              VSpace(10),
              barlowRegular(
                text:
                    "Our mission is to provide an easy solution to tractor buying or selling, fertilizers, seeds and every farming product. Through Krishi Vikas Udyog, we aim to empower Indian farmers with exhaustive and unbiased information on farming products through expert reviews, owner reviews, detailed specifications and comparisons. ",
                size: 15,
                color: black,
              ),
              VSpace(10),
              barlowRegular(
                text:
                    "We understand that farmers are one of the essential parts of having a thriving country.",
                size: 15,
                color: black,
              ),
              VSpace(10),
            ],
          ),
        ),
      ),
    );
  }
}
