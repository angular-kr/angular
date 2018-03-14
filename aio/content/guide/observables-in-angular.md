# Observables in Angular

Angular makes use of observables as an interface to handle a variety of common asynchronous operations. 

Angular는 다양한 공통적인 비동기 operations를 다루기 interface 로써 observables을 사용하게 하게 한다.

For example:

예시:

* The `EventEmitter` class extends `Observable`.
* `EventEmitter` class 느 `Observable`를 상속 받았다.


* The HTTP module uses observables to handle AJAX requests and responses.
* HTTP module은  AJAX 요청 , 응답을 핸들링하는 observables 을 사용한다.


* The Router and Forms modules use observables to listen for and respond to user-input events.
* Router,Forms modules은 사용자-입력 이벤트에 응답하거나 리스닝하기 위해서  observables 을 사용한다.


## Event emitter

Angular provides an `EventEmitter` class that is used when publishing values from a component through the `@Output()` decorator. `EventEmitter` extends `Observable`, adding an `emit()` method so it can send arbitrary values. When you call `emit()`, it passes the emitted value to the `next()` method of any subscribed observer.


Angular는 `@Output()` 데코레이터를 통해서 컴포넌트로 값을 발행할때 사용하는 `EventEmitter` class 사용한다. `EventEmitter`는 `Observable`를 상속하고, 임의로 값을 보낼수 있게 하도록 `emit()`를 추가하였다. `emit()` 를 호출할때, 어떤 구독된 observer에게 `next()` method로 배출되는 값을 넘겨준다.


A good example of usage can be found on the [EventEmitter](https://angular.io/api/core/EventEmitter) documentation. Here is the example component that listens for open and close events:

사용에 대한 좋은 예시는 문서[EventEmitter](https://angular.io/api/core/EventEmitter)에서 찾을수있다. 여기에서는  열림/닫힘 이벤드에 대한 리스닝을 하는 컴포넌트 예시이다.

`<zippy (open)="onOpen($event)" (close)="onClose($event)"></zippy>`

Here is the component definition:
이건 컴포넌 정의의 대한 예시이다:

<code-example path="observables-in-angular/src/main.ts" title="EventEmitter" region="eventemitter"></code-example>

## HTTP
Angular’s `HttpClient` returns observables from HTTP method calls. For instance, `http.get(‘/api’)` returns an observable. This provides several advantages over promise-based HTTP APIs:

* Observables do not mutate the server response (as can occur through chained `.then()` calls on promises). Instead, you can use a series of operators to transform values as needed.
* HTTP requests are cancellable through the `unsubscribe()` method.
* Requests can be configured to get progress event updates.
* Failed requests can be retried easily.

## Async pipe

The [AsyncPipe](https://angular.io/api/common/AsyncPipe) subscribes to an observable or promise and returns the latest value it has emitted. When a new value is emitted, the pipe marks the component to be checked for changes.

The following example binds the `time` observable to the component's view. The observable continuously updates the view with the current time.

<code-example path="observables-in-angular/src/main.ts" title="Using async pipe" region="pipe"></code-example>

## Router

[`Router.events`](https://angular.io/api/router/Router#events) provides events as observables. You can use the `filter()` operator from RxJS to look for events of interest, and subscribe to them in order to make decisions based on the sequence of events in the navigation process. Here's an example:

<code-example path="observables-in-angular/src/main.ts" title="Router events" region="router"></code-example>

The [ActivatedRoute](https://angular.io/api/router/ActivatedRoute) is an injected router service that makes use of observables to get information about a route path and parameters. For example, `ActivateRoute.url` contains an observable that reports the route path or paths. Here's an example:

<code-example path="observables-in-angular/src/main.ts" title="ActivatedRoute" region="activated_route"></code-example>

## Reactive forms

Reactive forms have properties that use observables to monitor form control values. The [`FormControl`](https://angular.io/api/forms/FormControl) properties `valueChanges` and `statusChanges` contain observables that raise change events. Subscribing to an observable form-control property is a way of triggering application logic within the component class. For example:

<code-example path="observables-in-angular/src/main.ts" title="Reactive forms" region="forms"></code-example>
