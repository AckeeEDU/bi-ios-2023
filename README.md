# BI-IOS 2023

| Přednáška | Přednášející | Stanford |
| --------- | -------- | -------- |
| 01 Xcode, Swift Basics | IR | [Swift](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/r1_0.pdf) |
| 02 More Swift & SwiftUI Basics | IR | [Getting Started with SwiftUI](https://www.youtube.com/watch?v=n1qabtjZ_jg) |
| 03 More SwiftUI | RB | [Getting Started with SwiftUI](https://www.youtube.com/watch?v=n1qabtjZ_jg) |
| 04 More SwiftUI & Navigation | RB | [Learning More about SwiftUI](https://www.youtube.com/watch?v=sXiD-2XrkKQ) |
| 05 Navigation | RB | [Learning More about SwiftUI](https://www.youtube.com/watch?v=sXiD-2XrkKQ) |
| 06 Networking |  IR | [Multithreading, Error Handling](https://www.youtube.com/watch?v=9gA1_Ipm-yY) |
| 07 Async/await |  IR | [Multithreading, Error Handling](https://www.youtube.com/watch?v=9gA1_Ipm-yY) |
| 08 MVVM |  RB | [MVVM Architecture](https://www.youtube.com/watch?v=W1ymVx6dmvc)<br>[Applying MVVM](https://www.youtube.com/watch?v=4CkEVfdqjLw) |
| 09 MVVM |  RB | [More MVVM](https://www.youtube.com/watch?v=W1ymVx6dmvc)<br>[Applying MVVM](https://www.youtube.com/watch?v=4CkEVfdqjLw) |
| 10 Enviroment | JO | Není

V průběhu kurzu doporučujeme shlédnout online přednášky ze Stanfordu, které slouží jako hlavní zdroj informací pro tento kurz [https://cs193p.sites.stanford.edu](https://cs193p.sites.stanford.edu).

> Dokumentace ke kompletnímu API je [zde](https://fitstagram.ackee.cz/docs/)

> [Interactful aplikaci](https://apps.apple.com/tr/app/interactful/id1528095640) je potřeba si stáhnout na iOS zařízení. Je dostupná i pro mac, ale tam zobrazuje komponenty přizpůsobené pro macOS.

## 1. domácí úkol

> :exclamation: Deadline: **21. 11. 2023 23:59:59**

> Dokumentace ke kompletnímu API je [zde](https://fitstagram.ackee.cz/docs/)

Vaším úkolem je vytvořit detail příspěvku.

Detail bude obsahovat všechny fotografie, které jsou u příspěvku nahrány = může jich být více než jenom jedna. Zobrazení je na vás, ale může se hodit pogooglit, jak se dělá `PageView` ve SwiftUI. :bulb: :smirk:

Na detailu budé také vidět autorovo uživatelské jméno a nějak hezky do toho zakomponujte komentáře u daného příspěvku – všechno bude zobrazeno na jedné obrazovce.

Pro načtení komentářů použijte následující url:
```
https://fitstagram.ackee.cz/api/feed/{postID}/comments
```
kde místo `{postID}` dáte ID postu, které přijde z Feedu. Na cviku jsme si říkali něco o tom, jak neblokovat hlavní vlákno, zkuste to dodržet. :pray:

Všechny tyto věci zkuste hezky spojit na jedné obrazovce.

Odevzdávání můžete udělat přes mail `igor.rosocha@ackee.cz`, nebo mě pozvěte do svého repa, kde budete mít řešení, a na mail mi pošlete větev / commit, kde řešení najdu.

**Bonus** (max 2 body): Přidejte na obrazovku tlačítko (nebo nějakou jinou akci), pomocí které se skryjí / zobrazí ostatní informace až na fotky. Tedy provedu akci, všechno až na fotky zmizí, udělám znova akci a informace se zobrazí zpět. Nechceme zobrazit novou obrazovku, kde budou pouze fotky, ale upravit tu stávající.

## 2. domácí úkol

> :exclamation: Deadline: **12. 12. 2023 23:59:59**

Vaším druhým úkolem bude vytvořit obrazovku a kompletní logiku pro přidání nového příspěvku.

Každý nový příspěvek bude obsahovat vybranou fotografii a popisek. Oba parametry jsou povinné.

UI pro vytvoření příspěvku je ve vašich rukou. Do appky přidejte button, který povede na vámi vytvořenou screenu - nabízí se místo vpravo nahoře v navigation baru.

Základní flow pro přídání příspěvku by mělo být následující:

1. Tapnu na "+" a zobrazí se mi obrazovka pro přidání nového příspěvku.
2. Na této obrazovce vyberu obrázek z galerie (nebo třeba i foťáku, nepovinné), který se potom zobrazí.
3. Pomocí textového pole přidám k obrázku popisek.
4. Tapnutím na nějaké další tlačítko se sestaví request na API a data se odešlou.
6. Vrátí-li se ze serveru chyba, zobrazte ji.
7. Po úspěšném vytvoření a odeslání příspěvku jsem přesměrován zpět na seznam.
8. Na seznamu mám možnost na nový příspěvek nascrollovat.

Pro vytvoření příspěvku použijte tento [endpoint](https://fitstagram.ackee.cz/docs/#/Feed/post_feed).

Fotografie je potřeba před odesláním na server upravit.

1. Šířka ani výška fotografie nesmí přesáhnout 2048 pixelů. Může tedy vzniknout potřeba obrázek zmenšit. 
2. Fotky posílejte na server jako JPEG zakódovaný do řetězce pomocí base64.

Obě výše zmíněné operace jsme na cvikách neukazovali, ale jednoduchým Googlením se dostanete k odpovědím. Pokud by se nedařilo, dáme vám k dispozici kód, pomocí kterého to uděláte. Záměrně vám to nechceme dávat hned na začátek, ať si to můžete zkusit. Opravdu to není nic složitého.

Odevzdání stejně jako první úkol - na `igor.rosocha@ackee.cz`, nebo invite do repa, popř. dejte vědět o nových změnách v repu z prvního úkolu.

## Semestrální práce

V rámci semestrální práce je vaším úkolem ukázat, co jste se naučili. Téma je na vás, ale je potřeba si ho nechat mnou schválit. Schválení musí proběhnout do konce výuky, tedy do posledního cvika.

Na vypracování pak máte celý semestr – až do konce zkouškového.

Odevzdávání, pokud nám to situace dovolí, bude probíhat osobně [u nás v kancelářích](https://mapy.cz/zakladni?source=firm&id=12749992&ds=1&x=14.3907423&y=50.0997880&z=17). Nenechávejte odevzdání na poslední chvíli, aby na vás vystačil nějaký termín. Může se stát, že pokud necháte odevzdání do posledního dne, nebude možné pro vás najít termín na odevzdání a tedy i dokončit předmět.

Pokud to situace nedovolí, bude odevzdávání online.

Rozsah práce by mělo být 3 - 5 obrazovek (může být míň, pokud to dává smysl v rámci zadání) s použitím architektury MVVM. Ideálně ukázat nějaké zajímavější věci než jenom statické obrazovky – networking, multithreading, gesta, mapa, výběr obrázků, malování, atd.

## Přednášky

### 01 Xcode, Swift Basics
* Xcode
* Swift
  * `String`, `Int`, `Bool`, `Double`
  * Conditions, cycles
  * `Optional`
  * Array, dictionaries, tuples
  * `struct`, `enum`, `class`
  * Protocols, extensions 

### 02 SwiftUI Basics
* Swift
  * Access control
  * Trailing closure syntax
* SwiftUI
  * `View`, `some`, `@ViewBuilder`
  * `VStack`, `HStack`, `Text`, `Button`, `Image`
  * SFSymbols

### 03 SwiftUI
* SwiftUI
  * `View`, `View Tree` `some View`
  * Xcode
  * Recap `VStack`, `HStack`, `Text`, `Button`, `Image`
  * `Color`, Shepes, `Label`, `Group`, `Spacer`, `Divider`
  * View Sizing, View modifiers
  * `PostView` live coding

### 04 More SwiftUI
* Human Interface Guidelines, Good resources to start with
* Important Xcode shortcuts
* SwiftUI
  * `ScrollView`, `ForEach`, `LazyVStack`/`LazyHStack`
  * `PostList` live coding
  * Why structs?
* Protocols
  * Equatable, Hashable, Identifiable, Comparable
* PropertyWrappers 

### 05 SwiftUI Navigation
* SwiftUI
  * `@State`, `@Binding`, `@Environment`
  * `.sheet`, `.fullScreenCover`, `.alert` 
  * `NavigationStack`, `NavigationPath`
  * `.toolbar`, `TabView`
  * `PostList`, `LikesList`, `CommentsView` live coding

### 06 Networking
* Multithreading
  * Process
  * Thread
  * `DispatchQueue`
* Networking
  * REST, JSON
  * HTTP Request
  * `URLRequest`, `URLSession`

### 07 Async/Await
* `Codable`
  * `Decodable`, `Encodable`
  * `CodingKeys`
  * `init(from decoder: Dedocer)`
  * `encode(to encoder: Encoder)`
* Async/await
  * `Task`
  * `@MainActor`
  * func async

### 08_MVVM
* Architecture
  * MVVM
* Bindings/UI update iOS13+
  * `ObservableObject`, `@ObservedObject`, `@StateObject`
  * `@Published`, `objectWillChange.send()`
* Bindings/UI update iOS17+
  * `@Observable`, `@Bindable`

### 09_MVVM
* POST requests
  * without request body, with request body
  * refreshing views after post requests
  * faking likes
* Custom error
* Interfacing UIKit with SwiftUI
  * UIImagePickerController - Library and Camera

### 10 Environment
• řešení přvního domácího úkolu
* `@Environment` & `EnvironmentKeys`
