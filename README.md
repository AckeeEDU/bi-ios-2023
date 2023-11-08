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
| 08 MVVM |  TBA | [MVVM Architecture](https://www.youtube.com/watch?v=W1ymVx6dmvc)<br>[Applying MVVM](https://www.youtube.com/watch?v=4CkEVfdqjLw) |

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

TBA

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