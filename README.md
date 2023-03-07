# Todo
Uma aplicação para gerenciar suas tarefas, você pode escolher uma atividade, horário e o dia que ela ira ocorrer, a mesma é apresentada pela ordem cronológica delas. Os seus dados não são perdidos, pois e salvo no banco de dados



## Feature
- Para apresentar o Cupertino Date Picker idêntico comportamento do IOS precisei usar um modal 
- Modal e apresentando na parte inferior da página

```dart

handleShowCalendar() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                minimumDate: DateTime.now(),
                initialDateTime: dateSelect.value,
                maximumDate: DateTime.now().add(const Duration(days: 366)),
                onDateTimeChanged: handleSumbitDatePicker,
              ),
            );
          });
    }

```

##
- Trabalhei com [Hooks](https://pub.dev/packages/flutter_hooks) na aplicação
- Usando essa abordagem eu tenho um controle mais simples dos efeitos de imutabilidade e mutabilidade na árvore de componentes do flutter
- Para atualizar um estado usando essa abordagem, não posso tentar manipular diretamente o estado, preciso atualizar sua referência e igualar pelo operador de igual como e feito em redux, observable e outros conceitos
- Repara que para atualizar o item selecionado precisei igualar com o operador de igual = 
- Tem um exemplo clássico no redux *** state.data = data.fitler(it => it.id === item.id)   ** quando preciso atualizar uma lista

```dart
var itensSelected = useState<ListImg[]>(null);


 
 itensSelected.value.contains(item)
     ? itensSelected.value = itensSelected.value
          .where((element) => element.id != item.id)
         .toList()
 : itensSelected.value = [...itensSelected.value, item];




```

##


- Abaixo uma implementação do [useReducer](https://github.com/rrousselGit/flutter_hooks/blob/master/packages/flutter_hooks/example/lib/use_reducer.dart) no flutter



```dart
class State {
  String description = "";
  String date = "";
  String hour = "";
  int idListImg = 0;
}

class DispatchAction {
   String? description;
   String? date;
   String? hour;
   int? idListImg;
   DispatchAction(
      {required this.date,
       required this.hour,
       required this.description,
       required this.idListImg});
}


class ShowTask extends HookWidget {
   ShowTask({Key? key}) : super(key: key);


    State _reducer(State state, DispatchAction action) {
      if (action.description != null) {
       state.description = action.description!;
      }
      if (action.idListImg != null) {
      state.idListImg = action.idListImg!;
     }
     if (action.date != null) {
       state.date = action.date!;
     }
     if (action.hour != null) {
       state.hour = action.hour!;
     }
     return state;
   }

   Widget build(BuildContext context) {
   
     var store = useReducer<State, DispatchAction>(
         (state, action) => _reducer(state, action),
         initialState: State(),
         initialAction: DispatchAction(date: '', description: '', idListImg: 0, hour: ''));
   

 
    useEffect(() {
      for (var e in dataTask) {
   
       store.dispatch(DispatchAction(
             date: e.date,
            description: e.description,
            idListImg: e.idListImg,
            hour: e.hour));
      }
    }, []);
  
 
   //  para atualizar na árvore
   
   return  floatingActionButton: FloatingActionButton(
        onPressed: () => _store.dispatch(DispatchAction(description: "estou atualizando")),
        child: const Icon(Icons.add),
      ),
    );
 
 }
 
}

```

##
- Dicas de construí interfaces em Flutter
- Se desejar que um conteúdo se torne flexível e não ultrapasse o conteúdo do pai pode usar um expanded em volta
- Usando essa abordadgem preciso que a columna ocupe o mínimo possível de espaço se não usar essa abordagem ficara um espaço grande vazio
- Por isso no Column usei o mainAxisSize:  MainAxisSize.min, e também usei o Container no texto para funcionar perfeitamente
- Container,Column sao widget [flex](https://api.flutter.dev/flutter/widgets/Flex-class.html) , já Text não por isso e ideal o uso combinado deles


```dart


 Expanded(
                   
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,  
           children: [
             Text(
                appointment.subject,
                style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
                height: 1.2,
                color: ColorsConstants.black),
              ),
         Container(
              margin: const EdgeInsets.only(top: 10),          
              child: Text(
              DateFormat('hh:mm a').format(appointment.startTime),
              style: const TextStyle(
              fontSize: 14,
              color: ColorsConstants.black,
              fontWeight: FontWeight.w400,
                    ),
                  ),
                 ),
                ]),
     )

```
## 
- Abaixo um exemplo como converter uma string em date e depois voltar para date
- Foi usado essa abordagem, porque ao salvar o date no Realm Db devido à diferença de regiões pode ocasionar horários errados salvo no banco
- Também aprendi a converter color em string e vice-versa

```dart

// estou transformando  em string

 dateSelect.value
              .toString(), 

// convertendo para date
DateFormat("yyyy-MM-dd hh:mm:ss")
          .parse(element.dateTime),



// salvando cor em string
listColors[sortColor].toString()


// transformando novamente em color
 String valueString = element.colors.split('(0x')[1].split(')')[0];
 int value = int.parse(valueString,radix: 16);
 color: Color(value),


```

## 
- Para atualizar os inputs, Hooks disponibiliza um controller especifico para campo 
- UpdateInput sera quem vai armazenar nosso valor real e ele que e enviando para banco 
- Se deseja limpar o input a cada certo evento pode usar o controllerText


```dart
final controllerText = useTextEditingController();
final updateInput = useValueListenable(controllerText);


  useEffect(() {
      quantityLetter.value = updateInput.text.length;
  }, [updateInput]);


// limpar 
 controllerText.text = "";

```





