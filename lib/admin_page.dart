import 'package:articles_admin_page/cubit/controller_cubit.dart';
import 'package:articles_admin_page/model/record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPage extends StatelessWidget {
  AdminPage({Key? key, required this.title}) : super(key: key);

  final String title;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  TextEditingController miladiController = TextEditingController();
  TextEditingController hicriController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    miladiController.text =
        "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}";
    return scaffold(context);
  }

  Scaffold scaffold(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Visibility(
            visible: context.watch<ControllerCubit>().passwordValid,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //title
                          const Text(
                            'Başlık',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          titleField(),
                          //body
                          const Text(
                            'İçerik',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          bodyField(),
                          //author
                          const Text(
                            'Yazar',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          authorField(),
                          //category - group
                          categoryGroupText(),
                          categoryGroupFields(),
                          //date hicri - miladi
                          dateMiladiHicriText(),
                          dateMiladiHicriFields(),
                          //add button
                          addButton(context),
                          //info text
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text(
                              context.watch<ControllerCubit>().info,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Flexible(
                    //   child: Column(
                    //     children: [],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: !context.watch<ControllerCubit>().passwordValid,
            child: Center(
              child: Container(
                height: 250,
                width: 500,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Parola',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          obscureText: true,
                          controller: context
                              .watch<ControllerCubit>()
                              .passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 3,
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ControllerCubit>().getPassword();
                          },
                          child: Stack(
                            children: [
                              Visibility(
                                visible: !context
                                    .watch<ControllerCubit>()
                                    .isPasswordLoading,
                                child: const Text(
                                  'Giriş',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: context
                                    .watch<ControllerCubit>()
                                    .isPasswordLoading,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(context.watch<ControllerCubit>().passwordInfo),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding addButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        height: 55,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Record record = Record();
            record.title = titleController.text;
            record.body = bodyController.text;
            record.author = authorController.text;
            record.category = categoryController.text;
            record.group = groupController.text;
            record.dateMiladi = miladiController.text;
            record.dateHicri = hicriController.text;
            context.read<ControllerCubit>().addRecord(record);
          },
          child: Stack(
            children: [
              Visibility(
                visible: !context.watch<ControllerCubit>().isLoading,
                child: const Text(
                  'Kayıt Oluştur',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Visibility(
                visible: context.watch<ControllerCubit>().isLoading,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row categoryGroupFields() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20.0),
            child: TextField(
              controller: categoryController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 3,
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20.0),
            child: TextField(
              controller: groupController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 3,
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row dateMiladiHicriFields() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20.0),
            child: TextField(
              controller: miladiController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 3,
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20.0),
            child: TextField(
              controller: hicriController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 3,
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row dateMiladiHicriText() {
    return Row(
      children: const [
        Expanded(
          child: Text(
            'Miladi Tarih',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          child: Text(
            'Hicri Tarih',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
  }

  Row categoryGroupText() {
    return Row(
      children: const [
        Expanded(
          child: Text(
            'Kategori',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          child: Text(
            'Grup (Seri)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
  }

  Padding authorField() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20.0),
      child: TextField(
        controller: authorController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 3,
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  Padding bodyField() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20.0),
      child: SizedBox(
        height: 500,
        child: TextField(
          controller: bodyController,
          maxLines: 30,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 3,
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }

  Padding titleField() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20.0),
      child: TextField(
        controller: titleController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 3,
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
