import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage/home/bloc/home_bloc.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool switchValue = false;
  bool checkboxValue = false;
  double sliderValue = 0.0;
  // Drop down list variables
  String _dropSelectedValue = "dos";
  static const List<String> _options = ["uno", "dos", "tres", "cuatro"];
  final List<DropdownMenuItem<String>> _itemOptionsList = _options
      .map(
        (val) => DropdownMenuItem<String>(
          value: val,
          child: Text("$val"),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(LoadConfigsEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if(state is LoadedConfigsState){
            switchValue = state.configs["switch"];
            checkboxValue = state.configs["checkbox"];
            sliderValue = state.configs["slider"];
            _dropSelectedValue = state.configs["dropdown"];
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: Text("Configuraciones cargados con éxito!")));
          }else if(state is ErrorState){
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: Text("Error detectado: ${state.error}")));
          }
        },
        builder: (context, state) {
          return buildListView(context);
        },
      ),
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView(
      children: <Widget>[
        // Drop down list
        ListTile(
          title: Text("Dropdown"),
          trailing: DropdownButton(
            items: _itemOptionsList,
            value: _dropSelectedValue,
            onChanged: (newValue) {
              setState(() {
                _dropSelectedValue = newValue;
              });
            },
          ),
        ),
        Divider(),
        // Switch
        ListTile(
          title: Text("Switch"),
          trailing: Switch(
              value: switchValue,
              onChanged: (value) {
                setState(() {
                  switchValue = value;
                });
              }),
        ),
        Divider(),
        // Checkbox
        ListTile(
          title: Text("CheckBox"),
          trailing: Checkbox(
              tristate: false,
              value: checkboxValue,
              onChanged: (value) {
                setState(() {
                  checkboxValue = value;
                });
              }),
        ),
        Divider(),
        // Slider
        Text("Slider", textAlign: TextAlign.center),
        Slider(
          min: 0,
          max: 10,
          label: "${sliderValue.round()}",
          divisions: 10,
          value: sliderValue,
          onChanged: (value) {
            setState(() {
              sliderValue = value;
            });
          },
        ),

        Divider(),
        MaterialButton(
          color: Colors.green,
          child: Text("Guardar"),
          onPressed: () {
            BlocProvider.of<HomeBloc>(context).add(
              SaveConfigsEvent(
                configs: {
                  "dropdown": _dropSelectedValue,
                  "switch": switchValue,
                  "checkbox": checkboxValue,
                  "slider": sliderValue,
                },
              ),
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: Text("Guardando las configuraciones...")));
          },
        ),
      ],
    );
  }
}
