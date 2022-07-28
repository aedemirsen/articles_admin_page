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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              const Text(
                'Başlık',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              titleField(),
              //body
              const Text(
                'İçerik',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              bodyField(),
              //author
              const Text(
                'Yazar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              authorField(),
              //category - group
              categoryGroupText(),
              categoryGroupFields(),
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
            record.dateMiladi =
                "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}";
            record.dateHicri = '';
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
