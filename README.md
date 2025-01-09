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
#### Creating a basic `Simple DynamicTextField`:

```dart
        import 'package:dinamis_text_form_field/dinamis_text_form_field.dart';
        import 'package:flutter/material.dart';

        
        class MyApp extends StatelessWidget {
        const MyApp({super.key});

        // This widget is the root of your application.
        @override
        Widget build(BuildContext context) {
            return MaterialApp(
            debugShowCheckedModeBanner: false,
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
        final _passwordController = TextEditingController();

        final List<SelectedItem> _listGenders = [
            SelectedItem(key: '1', value: 'Male'),
            SelectedItem(key: '2', value: 'Female'),
        ];

        final List<SelectedItem> _listCitys = [
            SelectedItem(key: '1', value: 'Banda Aceh'),
            SelectedItem(key: '2', value: 'Lhokseumawe'),
            SelectedItem(key: '3', value: 'Jakarta Selatan'),
            SelectedItem(key: '4', value: 'Bandung'),
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
            padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
            child: ListView(
                children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(
                        height: size.height * 0.01,
                    ),
                    //// this sample for Form Type besic
                    DynamicTextField(
                        textDynamicController: _fullnameController,
                        title: 'Full Name',
                        hint: 'Input full name...',
                    ),
                    DynamicTextField(
                        fieldtype: FieldType.listDropdown,
                        textDynamicController: _gendersController,
                        title: 'Gender',
                        hint: 'Input gender...',
                        titleList: "Select gender",
                        listItem: _listGenders,
                    ),
                    DynamicTextField(
                        fieldtype: FieldType.listNewPage,
                        textDynamicController: _citysController,
                        title: 'City',
                        hint: 'Input city...',
                        titleList: "Select City",
                        listItem: _listCitys,
                    ),
                    DynamicTextField(
                        fieldtype: FieldType.password,
                        textDynamicController: _passwordController,
                        title: 'Password',
                        hint: 'Input password...',
                    ),
                    
                    ],
                ),
                ],
            ),
            );
        }
    }


```


#### Creating a material `Simple DynamicTextField`:

```dart
        import 'package:dinamis_text_form_field/dinamis_text_form_field.dart';
        import 'package:flutter/material.dart';

        
        class MyApp extends StatelessWidget {
        const MyApp({super.key});

        // This widget is the root of your application.
        @override
        Widget build(BuildContext context) {
            return MaterialApp(
            debugShowCheckedModeBanner: false,
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
        final _passwordController = TextEditingController();

        final List<SelectedItem> _listGenders = [
            SelectedItem(key: '1', value: 'Male'),
            SelectedItem(key: '2', value: 'Female'),
        ];

        final List<SelectedItem> _listCitys = [
            SelectedItem(key: '1', value: 'Banda Aceh'),
            SelectedItem(key: '2', value: 'Lhokseumawe'),
            SelectedItem(key: '3', value: 'Jakarta Selatan'),
            SelectedItem(key: '4', value: 'Bandung'),
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
            padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
            child: ListView(
                children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(
                        height: size.height * 0.01,
                    ),
                     //// this sample for Form Type material
                    DynamicTextField(
                        formType: FormType.material,
                        textDynamicController: _fullnameController,
                        title: 'Full Name',
                        hint: 'Input full name...',
                    ),
                    DynamicTextField(
                        formType: FormType.material,
                        fieldtype: FieldType.listDropdown,
                        textDynamicController: _gendersController,
                        title: 'Gender',
                        hint: 'Input gender...',
                        titleList: "Select gender",
                        listItem: _listGenders,
                    ),
                    DynamicTextField(
                        formType: FormType.material,
                        fieldtype: FieldType.listNewPage,
                        textDynamicController: _citysController,
                        title: 'City',
                        hint: 'Input city...',
                        titleList: "Select City",
                        listItem: _listCitys,
                    ),
                    DynamicTextField(
                        formType: FormType.material,
                        fieldtype: FieldType.password,
                        textDynamicController: _passwordController,
                        title: 'Password',
                        hint: 'Input password...',
                    ),
                    /// this sample for custom InputDecoration
                    DynamicTextField(
                        formType: FormType.material,
                        textDynamicController: _citysController,
                        title: 'City',
                        hint: 'Input city...',
                        titleList: "Select City",
                        listItem: _listCitys,
                        inputDecoration: customInputDecoration,
                    ),
                    ],
                ),
                ],
            ),
            );
        }
    }

```


#### Decorations can be customized  `Customized DynamicTextField`:

```dart
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
 
```
And can also use other default TextFormField function

#### And can also use other default TextFormField function  `Other function TextFormField`:
```dart
        final TextEditingController textDynamicController;
        final String title;
        final String? titleList;
        final String? hintSearch;
        final String hint;
        final FieldType? fieldtype;
        final FormType? formType;
        final List<SelectedItem>? listItem;
        final InputDecoration? inputDecoration;
        final Color? backgroundColor;
        final String? Function(String?)? validator;
        final void Function(String)? onChanged;
        final void Function(String?)? onSaved;
        final AutovalidateMode? autovalidateMode;
        final TextInputType? keyboardType;
        final TextInputAction? textInputAction;
        final int? maxLength;

```

## Preview  FormType basic
<img width="514" height="540"  alt="Preview  FormType basic"  src="https://raw.githubusercontent.com/block7code/dinamis_text_form_field/refs/heads/main/screenshots/image_01.gif" > 

## Preview  FormType material
<img width="514" height="540" alt="Preview  FormType material"  src="https://raw.githubusercontent.com/block7code/dinamis_text_form_field/refs/heads/main/screenshots/image_02.gif" > 



