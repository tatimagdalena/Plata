![Objective-C](https://img.shields.io/badge/Linguagem-Swift-blue.svg)
![Objective-C](https://img.shields.io/badge/iOS-v8.0+-blue.svg)

# Plata

Plata is a Swift framework for iOS, used to handle and display currency in an easy way. It is designed to work with Swift code only.

## Installation

### Carthage

Add the following line to your `Cartfile` and run `carthage update Plata`.
```ogdl
github "tatimagdalena/Plata"
```

### Manually

Copy `Plata.swift`, `PlataField.swift` and `PlataHelper.swift` into your project.

## Usage

### 💰 Plata model

Keep currency values with a Plata model.

#### Initializer

Initialize it with the value in cents (Integer).

```swift
var plata = Plata(cents: 100) //Equivalent to $1.00
```
#### Customization

Currency settings can be updated at any point.

```swift
//Currency symbol - default value: .fromCurrentLocale
plata.currencySymbol = .fromCurrentLocale
plata.currencySymbol = .code(codeString)
plata.currencySymbol = .symbol(symbolString)

//Decimal mark symbol - default value: "."
plata.decimalSeparator = ","

//Thousand mark separator - default value: ","
plata.groupingSeparator = "."
```

#### Properties

```swift
let cents: Int = plata.integer //100
let realValue: Double = plata.realValue //1.00
let formattedValue: String = plata.formattedString //$1.00
let numbers: String = plata.onlyNumbers //100
```


### 💰 PlataField

A textfield to input currency values. It's mask is defined by it's Plata model customization.

#### Storyboard

On the textField Identity Inspector, set the class to PlataField and the module to Plata.

#### Properties

- `plata`
   - The currency value can be get at any time by the `plataField.plata` property
   - You can set an initial value setting `plataField.plata.integer` value

```swift
var plata = plataField.plataModel
plataField.plata.integer = 1000
```

- `valueLimitType`: the input text can be unlimited or limited by digits or value

```swift
// default: .digits(10)
plataField.valueLimitType = .digits(10) //PlataField input limited to 10 digits, including the decimal ones
plataField.valueLimitType = .cents(1000) //PlataField input limited to a $10.00 value
plataField.valueLimitType = .none //no limit, neither by digits nor value
```

- `associatedButton`: if an associated button is set, it will be disabled whenever the PlataField is empty or it's value is 0, and enabled otherwise.

---

## LICENSE

MIT License

Copyright (c) 2017 Tatiana Magdalena

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
