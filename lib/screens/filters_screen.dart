import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.currentFilters, this.saveFilters);
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters["gluten"] ?? false;
    _lactoseFree = widget.currentFilters["lactose"] ?? false;
    _vegetarian = widget.currentFilters["vegetarian"] ?? false;
    _vegan = widget.currentFilters["vegan"] ?? false;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      value: currentValue,
      subtitle: Text(description),
      title: Text(title),
      onChanged: updateValue as void Function(bool?)?,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                "gluten": _glutenFree,
                "lactose": _lactoseFree,
                "vegan": _vegan,
                "vegetarian": _vegetarian
              };
              widget.saveFilters(selectedFilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Adjust your Meal selection",
                style: Theme.of(context).textTheme.headline6,
              )),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitchListTile(
                  "Gluten-free", "Only include gluten free meals", _glutenFree,
                  (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              _buildSwitchListTile("lactose-free",
                  "Only include lactose free meals", _lactoseFree, (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              }),
              _buildSwitchListTile(
                  "vegetarian", "Only include vegetarian meals", _vegetarian,
                  (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
              _buildSwitchListTile("vegan", "Only include vegan meals", _vegan,
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              })
            ],
          ))
        ],
      ),
    );
  }
}
