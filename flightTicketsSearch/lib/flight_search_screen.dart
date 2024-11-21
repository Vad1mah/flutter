import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Для форматирования даты

class FlightSearchScreen extends StatefulWidget {
  const FlightSearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FlightSearchScreenState createState() => _FlightSearchScreenState();
}

class _FlightSearchScreenState extends State<FlightSearchScreen> {
  final List<String> cities = ['Москва', 'Санкт-Петербург', 'Новосибирск', 'Екатеринбург', 'Казань'];

  String? selectedDepartureCity;
  String? selectedArrivalCity;
  DateTime? departureDate;
  DateTime? returnDate;
  final TextEditingController adultsController = TextEditingController();
  final TextEditingController childrenController = TextEditingController();
  final TextEditingController infantsController = TextEditingController();
  final TextEditingController departureDateController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();

  // Функция для выбора даты
  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isDeparture ? departureDate : returnDate)) {
      setState(() {
        if (isDeparture) {
          departureDate = picked;
          departureDateController.text = DateFormat('dd/MM/yyyy').format(departureDate!);
        } else {
          returnDate = picked;
          returnDateController.text = DateFormat('dd/MM/yyyy').format(returnDate!);
        }
      });
    }
  }

  // Сброс формы
  void _resetForm() {
    setState(() {
      selectedDepartureCity = null;
      selectedArrivalCity = null;
      departureDate = null;
      returnDate = null;
      departureDateController.clear();
      returnDateController.clear();
      adultsController.clear();
      childrenController.clear();
      infantsController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск авиабилетов'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Выпадающий список для города вылета
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Город вылета',
                border: OutlineInputBorder(),
              ),
              value: selectedDepartureCity,
              items: cities
                  .map((city) => DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedDepartureCity = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            // Выпадающий список для города прилёта
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Город прилёта',
                border: OutlineInputBorder(),
              ),
              value: selectedArrivalCity,
              items: cities
                  .map((city) => DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedArrivalCity = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            // Поля ввода для даты вылета и прилёта
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, true),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: departureDateController,
                        decoration: InputDecoration(
                          labelText: 'Дата вылета',
                          border: const OutlineInputBorder(),
                          hintText: departureDate != null
                              ? DateFormat('dd/MM/yyyy').format(departureDate!)
                              : 'Выберите дату',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, false),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: returnDateController,
                        decoration: InputDecoration(
                          labelText: 'Дата прилёта',
                          border: const OutlineInputBorder(),
                          hintText: returnDate != null
                              ? DateFormat('dd/MM/yyyy').format(returnDate!)
                              : 'Выберите дату',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Поля для количества пассажиров
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: adultsController,
                    decoration: const InputDecoration(
                      labelText: 'Взрослые',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    controller: childrenController,
                    decoration: const InputDecoration(
                      labelText: 'Дети',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    controller: infantsController,
                    decoration: const InputDecoration(
                      labelText: 'Младенцы',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            // Кнопка поиска (с сбросом формы)
            ElevatedButton(
              onPressed: () {
                // Логика поиска (можно добавить функционал здесь)
                // Сброс значений после поиска
                _resetForm();
              },
              child: const Text('Найти билеты'),
            ),
          ],
        ),
      ),
    );
  }
}
