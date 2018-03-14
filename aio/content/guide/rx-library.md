# The RxJS library

Reactive programming is an asynchronous programming paradigm concerned with data streams and the propagation of change ([Wikipedia](https://en.wikipedia.org/wiki/Reactive_programming)). RxJS (Reactive Extensions for JavaScript) is a library for reactive programming using observables that makes it easier to compose asynchronous or callback-based code ([RxJS Docs](http://reactivex.io/rxjs/)).

Reactive programming는 데이터 steream 과 변화의 전파에 대한 비동기 프로그램 패러다임이다([Wikipedia](https://en.wikipedia.org/wiki/Reactive_programming)). RXJS(자바스크립트를 위한 리액티브 익스텐션들) 는  비동기와 callback-기반  의  코드를 더 쉽게 구성하는 observables 을 사용하는 리액티브 프로그래밍을 위한 라이브러리 입니다. ([RxJS Docs](http://reactivex.io/rxjs/)).



RxJS provides an implementation of the `Observable` type, which is needed until the type becomes part of the language and until browsers support it. The library also provides utility functions for creating and working with observables. These utility functions can be used for:
RxJS 는 `Observable` 타입의 구현이 언어의 한 부분으로 되거나 브라우져에서 이것을 지원될때까지 제공한다. 또한 라이브러리는 observables을 가지고 생성하거나 도작하는 유틸리티 함수들을 제공한다. 그러한 유틸리티 함수들은 다음 위해서 사용될 수 있다.

* Converting existing code for async operations into observables
* 존재하는 코드를 비동기 operations 을  observables 로 전환.

* Iterating through the values in a stream
* stream 값을 순회

* Mapping values to different types
* 다른 타입에 대한 맵핑한 값

* Filtering streams
* 스트림 필터링.

* Composing multiple streams
* multiple streams 의 생성

## Observable creation functions(Observable 생성 함수들)

RxJS offers a number of functions that can be used to create new observables. These functions can simplify the process of creating observables from things such as events, timers, promises, and so on. For example:

RxJS는 새로운 observables을 생성하여 사용할수 있는 새로운 많은 수의 함수들을 제공한다. 그러한 함수들을 이벤트, timers, promises 등과 같이 것으로부터 observables의 생서의 과정을 간단하게 만든다. 예를 들면:


<code-example path="rx-library/src/simple-creation.ts" region="promise" title="Create an observable from a promise"></code-example>

<code-example path="rx-library/src/simple-creation.ts" region="interval" title="Create an observable from a counter"></code-example>

<code-example path="rx-library/src/simple-creation.ts" region="event" title="Create an observable from an event"></code-example>

<code-example path="rx-library/src/simple-creation.ts" region="ajax" title="Create an observable that creates an AJAX request"></code-example>

## Operators

Operators are functions that build on the observables foundation to enable sophisticated manipulation of collections. For example, RxJS defines operators such as `map()`, `filter()`, `concat()`, and `flatMap()`.

Operators는 컬렉션의 정교한 조작을 가능하게 만드는 observables 기본을 이루는 함수들이다. 예를 들면, RxJS는 `map()`, `filter()`, `concat()`, 그리고 `flatMap()` 같은 operators룰 정의한다.


Operators take configuration options, and they return a function that takes a source observable. When executing this returned function, the operator observes the source observable’s emitted values, transforms them, and returns a new observable of those transformed values. Here is a simple example:

Operators은 설정 옵션들을 가지고 , 본래의 observable을 가지는 함수들 리턴한다. 리턴된 함수를 실행할때, observes은  본래의 observable의 방출된 값을 관찰하고, 변형하고, 변형된 값으로 새로운 observable을 리턴한다. 여기 간단한 예가 있다:

<code-example path="rx-library/src/operators.ts" title="Map operator"></code-example>

You can use _pipes_ to link operators together. Pipes let you combine multiple functions into a single function. The `pipe()` function takes as its arguments the functions you want to combine, and returns a new function that, when executed, runs the composed functions in sequence.

당신은 operators를 함께 연결하기 위해서 _pipes_ 를 사용할수 있다. Pipes는 multiple functions 을 single function으로 결합하도록 한다. `pipe()` function는 당신이 결합하길 원하는 함수들을 인자로 취하고 , 실행시에는 , 순차적으로 구성된 함수가 동작하는 새로운 함수를 리턴한다. 

A set of operators applied to an observable is a recipe&mdash;that is, a set of instructions for producing the values you’re interested in. By itself, the recipe doesn’t do anything. You need to call `subscribe()` to produce a result through the recipe.

observable이 적용된 operators 의 묶음은 레시피이다; 즉, 당신이 관심이 있어하는 값을 생성하기 위한 명령어의 묶음이다. 이것 자체로는, 레시피는 어떤 것도 하지 않는다. 레시피를 통해서 결과를 생성하기 위해서 `subscribe()` 를 호출해야만 한다.


Here’s an example:
여기 그 예이다:

<code-example path="rx-library/src/operators.1.ts" title="Standalone pipe function"></code-example>

The `pipe()` function is also a method on the RxJS `Observable`, so you use this shorter form to define the same operation:

`pipe()` 함수는 또한 RxJS `Observable` 에 메서드이다, 그래서 당신은 같은 operation 을 정의하는것을 축약하여 형성할수 있다.

<code-example path="rx-library/src/operators.2.ts" title="Observable.pipe function"></code-example>

### Common operators

RxJS provides many operators (over 150 of them), but only a handful are used frequently. Here is a list of common operators; for usage examples, see  [RxJS 5 Operators By Example](https://github.com/btroncone/learn-rxjs/blob/master/operators/complete.md) in RxJS documentation.

RxJS는 많은 operators(150 이상으로)를 제공하지만, 오로지 몇 안되는 것들을 자주 사용할 것이다. 여기 공통적인 operators의 목록이다; RxJS 문서에서 사용의 예[RxJS 5 Operators By Example](https://github.com/btroncone/learn-rxjs/blob/master/operators/complete.md)를 보라. 


<div class="l-sub-section">
  Note that, for Angular apps, we prefer combining operators with pipes, rather than chaining. Chaining is used in many RxJS examples.

  Angular 앱들을 위해서, 우리는 chaining 보다는 pipes 가지고 operator 결합하는 것을 선호한다. Chaining은 많은 RxJS 예에서 사용된다.
</div>

| Area | Operators |
| :------------| :----------|
| Creation |  `from`, `fromPromise`,`fromEvent`, `of` |
| Combination | `combineLatest`, `concat`, `merge`, `startWith` , `withLatestFrom`, `zip` |
| Filtering | `debounceTime`, `distinctUntilChanged`, `filter`, `take`, `takeUntil` |
| Transformation | `bufferTime`, `concatMap`, `map`, `mergeMap`, `scan`, `switchMap` |
| Utility | `tap` |
| Multicasting | `share` |

## Error handling

In addition to the `error()` handler that you provide on subscription, RxJS provides the `catchError` operator that lets you handle known errors in the observable recipe.

게다가 subscription 에 사용하는  `error()` handler 외에도 . RxJS는  observable recipe 에서 알려주는 에러들을 다루기 위한 `catchError` operator를 제공한다.

For instance, suppose you have an observable that makes an API request and maps to the response from the server. If the server returns an error or the value doesn’t exist, an error is produced. If you catch this error and supply a default value, your stream continues to process values rather than erroring out.

예를들면, API 요청을 하거나 서버로부터 응답을 발견하도록 하는 observable 을 가지고 추측해보다. 서버에서 에러나 값이 존재하지 않을 리턴한다면, 에러는 발생된다. 만약 이 에러를 잡아내거나 기본값을 제공한다면, stream은 에러를 제거하는 것보다는 값을 처리하는 것을 지속한다.


Here's an example of using the `catchError` operator to do this:

여기  `catchError` operator 사용하는 예시이다: 

<code-example path="rx-library/src/error-handling.ts" title="catchError operator"></code-example>

### Retry failed observable

Where the `catchError` operator provides a simple path of recovery, the `retry` operator lets you retry a failed request.

`catchError` operator 는 간단한 재개의 길을 제공하고 하는 영역이고,  `retry` operator는 실패된 요청을 재개하도록 하는것이다.

Use the `retry` operator before the `catchError` operator. It resubscribes to the original source observable, which can then re-run the full sequence of actions that resulted in the error. If this includes an HTTP request, it will retry that HTTP request.

`retry` operator 는 `catchError` operator 전에 사용하라. ,에러로 떨어진 모든 일렬의 동작들을 재개할수 있도록, 원래의 근원 observable 을 다시 재구독한다. 만약 이것이 HTTP 요청을 포함하고 있다면 , HTTP 요청을 재개할 것이다.

The following converts the previous example to retry the request before catching the error:


다음은 이전의 예시를 에러를 잡기전에 요청을 재개하는 예로 바꾸었다.


<code-example path="rx-library/src/retry-on-error.ts" title="retry operator"></code-example>

<div class="l-sub-section">

   Do not retry **authentication** requests, since these should only be initiated by user action. We don't want to lock out user accounts with repeated login requests that the user has not initiated.

  **authentication** 요청들은 재개하지 마라, 왜냐하면 유저의 행동에 의해서 재개되어야 하낟. 우리는 유저가 초기화하지 않은 반복되는 로그인을 요청하여 유저 계정이 잠기지 않길 바란다.
</div>

## Naming conventions for observables

Because Angular applications are mostly written in TypeScript, you will typically know when a variable is an observable. Although the Angular framework does not enforce a naming convention for observables, you will often see observables named with a trailing “$” sign.

Angular applications 은 주로 타입스크립트로 작성되기 때문에, 당신으 일반적으로 변수가 observable 일때를 알고 있을것이다. 비록 Angular framework는 observables 에 대한 네이밍 컨벤션을 강요하지 않지만, 우리는 보통 “$” 표시가 달린 이름을 가진 observables을 종종 볼수 있다.

This can be useful when scanning through code and looking for observable values. Also, if you want a property to store the most recent value from an observable, it can be convenient to simply use the same name with or without the “$”.
observable 값을 찾거산 코드를 살펴볼때 아주 유용하다. 또한, 만약
observable 로부터 가장 최근 값을 속성으로 저장하길 원한다면, 
같은 이름에 “$” 있던 없던 간단하게 사용할수 있다.
For example :
예시:

<code-example path="rx-library/src/naming-convention.ts" title="Naming observables"></code-example>