import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixbayimages/Model/Images/get_images_model.dart';
import 'package:pixbayimages/Repositories/Bloc/images_bloc.dart';
import 'package:pixbayimages/Screens/image_full_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late GetImagesModel getImagesModel;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Images'),
        centerTitle: true,
      ),
      body: Container(
        height: mHeight,
        width: mWidth,
        padding: EdgeInsets.only(
            top: mHeight * .02, left: mWidth * .03, right: mWidth * .03),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: mHeight * .0),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              height: mHeight * .098,
              width: mWidth,
              child: SizedBox(
                height: mHeight * .05,
                width: mWidth,
                child: TextFormField(
                  onChanged: (query) {
                    BlocProvider.of<ImagesBloc>(context)
                        .add(GetImagesEvent(query));
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 5),
                    fillColor: Color.fromARGB(255, 207, 227, 243),
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search Here...",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(70),
                        right: Radius.circular(70),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ImagesBloc, ImagesState>(
                builder: (context, state) {
                  if (state is ImagesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ImagesError) {
                    return Center(
                      child: Text('Images Not Loaded'),
                    );
                  }
                  if (state is ImagesLoaded) {
                    print(state);
                    print('Images Loaded');
                    getImagesModel =
                        BlocProvider.of<ImagesBloc>(context).getImagesModel;
                    return GridView.builder(
                      itemCount: getImagesModel.hits!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                        childAspectRatio: .9,
                      ),
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImagesScreen(
                                image:
                                    getImagesModel.hits![index].largeImageURL!),
                          ),
                        ),
                        child: Container(
                          height: mHeight * .40,
                          width: mWidth * .40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Container(
                            height: mHeight * .15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                  getImagesModel.hits![index].previewURL!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Text('Search for Images'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
