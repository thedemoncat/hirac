
&HTTPMethod("GET")
Функция list() Экспорт

	ПараметрыЗапроса = ЗапросHTTP.ПараметрыЗапроса();

	Поля = "_all";
	Если НЕ ПараметрыЗапроса["field"] = Неопределено Тогда
		Поля = ПараметрыЗапроса["field"];
	КонецЕсли;

	Фильтр = ОбщегоНазначения.ФильтрИзПараметровЗапроса(ПараметрыЗапроса);

	Подключение = Новый ПодключениеКАгентам();

	Результат = ОбщегоНазначения.ДанныеВJSON(Подключение.Серверы(Поля, Фильтр, Истина));

	Возврат Содержимое(Результат);

КонецФункции // list()

&HTTPMethod("GET")
Функция get() Экспорт

	АдресСервера = Неопределено;
	ПортСервера  = Неопределено;
	ИмяПараметра = Неопределено;

	Если ТипЗнч(ЗначенияМаршрута) = Тип("Соответствие") Тогда
		АдресСервера = ЗначенияМаршрута.Получить("host");
		ПортСервера  = Число(ЗначенияМаршрута.Получить("port"));
		ИмяПараметра = ЗначенияМаршрута.Получить("parameter");
	КонецЕсли;
	
	ПараметрыЗапроса = ЗапросHTTP.ПараметрыЗапроса();

	Формат = "json";
	Если НЕ ПараметрыЗапроса["format"] = Неопределено Тогда
		Формат = ПараметрыЗапроса["format"];
	КонецЕсли;

	Поля = "_all";
	Если НЕ ПараметрыЗапроса["field"] = Неопределено Тогда
		Поля = ПараметрыЗапроса["field"];
	КонецЕсли;

	Подключение = Новый ПодключениеКАгентам();

	Данные = Подключение.Сервер(АдресСервера, ПортСервера, Поля, Истина);
	
	Если ЗначениеЗаполнено(ИмяПараметра) Тогда
		Если Данные = Неопределено Тогда
			ЗначениеПараметра = Подключение.ПустойОбъектКластера("server", Поля)[ИмяПараметра];
		Иначе
			ЗначениеПараметра = Данные[ИмяПараметра];
		КонецЕсли;
		Если ТипЗнч(ЗначениеПараметра) = Тип("Дата") Тогда
			ЗначениеПараметра = Формат(ЗначениеПараметра, "ДФ=yyyy-MM-ddThh:mm:ss");
		КонецЕсли;
		Результат = СтрШаблон("%1=%2", ИмяПараметра, ЗначениеПараметра);
	Иначе
		Результат = ОбщегоНазначения.ДанныеВJSON(Данные);
	КонецЕсли;

	Возврат Содержимое(Результат);

КонецФункции // get()
