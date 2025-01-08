# dinamis_text_form_field
![pub](https://img.shields.io/badge/pub-v0.23.0-orange) ![GitHub](https://img.shields.io/github/license/liodali/checkbox_grouped)


create your dynamic form with easier way

## Getting Started

 * Generate custom form
 * Form Type (basic and material)
 * Field Type (input, listDropdown, listNewPage )

## Installing

Add the following to your `pubspec.yaml` file:

    dependencies:
		dinamis_text_form_field: ^2.0.0




## Simple Usage
#### Creating a basic `SimpleDinamisTextFormField`:

```dart
        import 'package:dinamis_text_form_field/dinamis_text_form_field.dart';
        import 'package:flutter/material.dart';

        void main() {
        runApp(const MyApp());
        }

        class MyApp extends StatelessWidget {
            const MyApp({super.key});

            // This widget is the root of your application.
            @override
            Widget build(BuildContext context) {
                return MaterialApp(
                title: 'Dinamic Text Form Field',
                theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                    useMaterial3: true,
                ),
                home: const MyHomePage(title: 'Dinamic Text Form Field'),
                );
            }
        }

        class MyHomePage extends StatefulWidget {
            const MyHomePage({super.key, required this.title});
            final String title;

            @override
            State<MyHomePage> createState() => _MyHomePageState();
        }

        class _MyHomePageState extends State<MyHomePage> {
            final _fullnameController = TextEditingController();
            final _gendersController = TextEditingController();
            final _citysController = TextEditingController();

            final List<SelectedItem> _listGendes = [
                SelectedItem(key: '1', value: 'Men'),
                SelectedItem(key: '2', value: 'Famele'),
            ];

            final List<SelectedItem> _listCitys = [
                SelectedItem(key: '1', value: 'Banda Aceh'),
                SelectedItem(key: '2', value: 'Lhokseumawe'),
                SelectedItem(key: '3', value: 'Jakarta Selatan'),
                SelectedItem(key: '4', value: 'Kota Bandung'),
            ];

            final InputDecoration customInputDecoration = InputDecoration(
                isDense: true,
                hintText: 'bla bla',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 1.5),
                ),
            );

            @override
            Widget build(BuildContext context) {
                return Scaffold(
                appBar: AppBar(
                    title: Text(widget.title),
                ),
                body: _mainBody(context),
                );
            }

            Widget _mainBody(context) {
                Size size = MediaQuery.of(context).size;

                return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView(
                    children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            SizedBox(
                                height: size.height * 0.01,
                            ),

                            DynamicTextField(
                                textDynamicController: _fullnameController,
                                title: 'Full Name',
                                hint: 'Input full name...',
                            ),
                            DynamicTextField(
                                fieldtype: FieldType.listDropdown,
                                textDynamicController: _gendersController,
                                title: 'Gen',
                                hint: 'Input gender...',
                                titleList: "Select gender",
                                listItem: _listGendes,
                            ),
                            DynamicTextField(
                                fieldtype: FieldType.listNewPage,
                                textDynamicController: _citysController,
                                title: 'City',
                                hint: 'Input city...',
                                titleList: "Select City",
                                listItem: _listCitys,
                            ),
                            // this sample for Form Type material
                            DynamicTextField(
                                formType: FormType.material,
                                textDynamicController: _fullnameController,
                                title: 'Full name',
                                hint: 'Input full name...',
                            ),
                            //// this sample for custom InputDecoration
                            DynamicTextField(
                                textDynamicController: _citysController,
                                title: 'City',
                                hint: 'Input city...',
                                titleList: "Select City",
                                listItem: _listCitys,
                                inputDecoration: customInputDecoration,
                            ),
                            //// this sample for set validator
                            DynamicTextField(
                                textDynamicController: _citysController,
                                title: 'City',
                                hint: 'Input city...',
                                validator: (text) {
                                if (text == null || text.isEmpty) {
                                    return 'Text is empty';
                                }
                                return null;
                                },
                            ),
                            ],
                        ),
                        ],
                    ),
                );
            }
        }

```

## Preview 

<img src="/screenshots/image_01.gif" height="300"> 




