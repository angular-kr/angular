# Observables(옵저버블)

Observables provide support for passing messages between publishers and subscribers in your application. Observables offer significant benefits over other techniques for event handling, asynchronous programming, and handling multiple values.

Observables은 application 에서 구독자와 발행자 사이에서 메세지를 전달하는 것에 대한 지원을 해준다. Observables은 이벤트 핸들링, 비동기 프로그래밍, 그리고 multiple values 핸들링에 대해서 기술적으로 중요한 이점을 제공한다.

Observables are declarative&mdash;that is, you define a function for publishing values, but it is not executed until a consumer subscribes to it. The subscribed consumer then receives notifications until the function completes, or until they unsubscribe.

Observables 은 선언적이다. 즉, 값을 발행하는 기능을 정의하지만, 소비자가 발행한 값을 구동하기 전까지는 실행되지 않는다. 그리고 나서 기능이 완료될떄 또는 소비자가 구독을 해지할떄까지 , 구독한 소비자는 통지를 받는다.

An observable can deliver multiple values of any type&mdash;literals, messages, or events, depending on the context. The API for receiving values is the same whether the values are delivered synchronously or asynchronously. Because setup and teardown logic are both handled by the observable, your application code only needs to worry about subscribing to consume values, and when done, unsubscribing. Whether the stream was keystrokes, an HTTP response, or an interval timer, the interface for listening to values and stopping listening is the same.

observable 은 literals, 메세지 또는 이벤트의 어떠한  타입의  multiple values 도 전달할수 있다. 값을 수신하는 API는 값을 동기적 또는 비동기적으로 보내는지 할것이다.
구성 또는 제거 로직은 observable 에 의해서 각각 핸들링 되기 떄문에, application 코드는 오직 값을 소비하도록 구독하는 것과 , 그리고 완료시에 구독 해지하는 것에 대해서 신경쓰면 된다. 스트림이 keystrokes, HTTP response 또는 interval timer 이든지 간에, 값을 수신하거나 수신을 멈추는 인터페이스는 같다.

Because of these advantages, observables are used extensively within Angular, and are recommended for app development as well.

이러한 이 점 때문에, observables은 앵귤러 내 확장적으로 사용되고 있고, 앵귤러 내에서 개발을 위해서 권장하고 있다.

## Basic usage and terms(기본적인 사용과 용어)

As a publisher, you create an `Observable` instance that defines a *subscriber* function. This is the function that is executed when a consumer calls the `subscribe()` method. The subscriber function defines how to obtain or generate values or messages to be published.

발행자로, 우리는 *subscriber*  함수를 정의한  `Observable` instance를 생성한다. 이것은 소비자가 `subscribe()` method 를 호출시에 실행되는 함수이다. 구독자 함수는 어떻게 값을 획득, 발생 또는 메세지를 발행될지를 정의하는 함수다.


To execute the observable you have created and begin receiving notifications, you call its `subscribe()` method, passing an *observer*.  This is a JavaScript object that defines the handlers for the notifications you receive. The `subscribe()` call returns a `Subscription` object that has an `unsubscribe()` method, which you call to stop receiving notifications.

당신이 생성한 observable 실행하거나, 통지를 받기 위해서는  *observer*를 받는 `subscribe()` method 를 호출한다. 이것은 당신이 수신하는 통지에 대한 핸들러들을 정의한 자바스크립트 객체이다.  `subscribe()` 호출은 통지 수신을 중단시키는 `unsubscribe()` 메서드를 포함한 `Subscription` object 를 리턴한다.

Here's an example that demonstrates the basic usage model by showing how an observable could be used to provide geolocation updates.

여기에서는 어떻게 observable 가 geolocation 변경을 제공하는데에 사용할수 있는지 보여주는 기본적 사용 모델을 가지고 설명한다. 

<code-example path="observables/src/geolocation.ts" title="Observe geolocation updates"></code-example>

## Defining observers (observers 정의)

A handler for receiving observable notifications implements the `Observer` interface. It is an object that defines callback methods to handle the three types of notifications that an observable can send:
수신 observable 통지에 대한 핸들러는 `Observer` interface를 구현한다. observable 보낼수 있는 통지의 3가지 타입을 다루는 callback methods 메서드를 정의한 객체이다.


| Notification type | Description |
|:---------|:-------------------------------------------|
| `next`  | Required. A handler for each delivered value. Called zero or more times after execution starts. 필수적. 각가의 전달된 값을 다루는 핸들러.  실행 시작후에 0 또는 이상의 시간에 호출된다.|
| `error` | Optional. A handler for an error notification. An error halts execution of the observable instance.조건적. 에러에 대한 핸들러. 에러는 observable instance 의 실행을 중지시킨다.|
| `complete` | Optional. A handler for the execution-complete notification. Delayed values can continue to be delivered to the next handler after execution is complete.조건적. 실핼 완료 핸들러.  실행이 완료후에  지연된 값들은 다음 핸들러 전달되게 하기 위해서 지속된다.|

An observer object can define any combination of these handlers. If you don't supply a handler for a notification type, the observer ignores notifications of that type.
observer object 3개의 핸들러의 조합으로 정의할수있다. 만약 notification type 으로 핸들러를 전달하지 않으면, observer 는 그 타입의 통지를 무시한다.

## Subscribing (구독하기)

An `Observable` instance begins publishing values only when someone subscribes to it. You subscribe by calling the `subscribe()` method of the instance, passing an observer object to receive the notifications.

오로지 누군가 Observable 구독시에,  `Observable` instance 는 값 발행을 시작한다. 당신은 통지를 수신하기 위해서 observer object 받는 `Observable` 의 `subscribe()` method를 호출함으로써 구독한다.


<div class="l-sub-section">

   In order to show how subscribing works, we need to create a new observable. There is a  constructor that you use to create new instances, but for illustration, we can use some static methods on the `Observable` class that create simple observables of frequently used types:
   어떻게 구독하는지 작업을 보기 위해서는, 우리는  새로운 observable을 만들어야 한다. 우리는 사용한 new instances 로 생성하는 것에서는 생성자가 있지만, 예시를 위해서 우리는 빈번하게 사용하는 타입의 간단한 observables 생성하는 `Observable` class 의 static method를 사용할수 있다.

  * `Observable.of(...items)`&mdash;Returns an `Observable` instance that synchronously delivers the values provided as arguments.
  
  * `Observable.of(...items)`&mdash; 동기적으로 매개변수로써 제공되는 값을 받는  `Observable` instance 를 리턴한다.
  
  * `Observable.from(iterable)`&mdash;Converts its argument to an `Observable` instance. This method is commonly used to convert an array to an observable.

  * `Observable.from(iterable)`&mdash;iterable 형태의 매개변수를 `Observable` instance 로 바꾼다. 이 메서드는 보통  array 을  observable 바꿀때 사용한다. 


</div>

Here's an example of creating and subscribing to a simple observable, with an observer that logs the received message to the console:

여기에는 콘솔로 메세지를 로고 출력하는 observer를 가진 간단한 observable 을 생성하고 구독하는 예가 있다.

<code-example
  path="observables/src/subscribing.ts"
  region="observer"
  title="Subscribe using observer"></code-example>

Alternatively, the `subscribe()` method can accept callback function definitions in line, for `next`, `error`, and `complete` handlers. For example, the following `subscribe()` call is the same as the one that specifies the predefined observer:

대체적으로, `subscribe()` method 는 `next`, `error`, 그리고 `complete` 의 핸들러를 콜백 함수 정의를 할수 있다. 예를들면, 다음 `subscribe()`의 호출은 미리 정의된 observer 의 중에 하나로 볼수 있다.

<code-example path="observables/src/subscribing.ts" region="sub_fn" title="Subscribe with positional arguments"></code-example>

In either case, a `next` handler is required. The `error` and `complete` handlers are optional. 어떤 경우에도, `next`핸드럴는 필수적이다. `error` 그리고 `complete` 핸드러는 선택적이다.

Note that a `next()` function could receive, for instance, message strings, or event objects, numeric values, or stuctures, depending on context. As a general term, we refer to data published by an observable as a *stream*. Any type of value can be represented with an observable, and the values are published as a stream.  예를 들면, `next()` 함수는 메세지 문자열들 또는 이벤트 객체 ,숫자 형태의 값 , 구조들을 받 받을수 있는 함수 임을 주의하라. 일반적인 용어로, 우리는 이것을 *stream* 로서 observable 의해서 발행되는 값으로 언급할 수 있다. 값의 어떤 타입도 observable을 가지고 나타낼수 있고, 값은 stream 으로서 발행된다.

## Creating observables(observables 생성)

Use the `Observable` constructor to create an observable stream of any type. The constructor takes as its argument the subscriber function to run when the observable’s `subscribe()` method executes. A subscriber function receives an `Observer` object, and can publish values to the observer's `next()` method.

어떤 타입의 observable stream을 생성하기 위해서 `Observable` constructor를 사용하라. 생성자는 observable의 `subscribe()` method를 실행 시에 구독자 함수를 인자로써 받아드린다. 구독자 함수는 `Observer` object 받고 observer의 `next()` method로 값을 발행할 수 있다.



For example, to create an observable equivalent to the `Observable.of(1, 2, 3)` above, you could do something like this:
예를 들면, 위에 `Observable.of(1, 2, 3)` 동등한 observable 을 생성하기 위해서 다음과 같이 할수있다.

<code-example path="observables/src/creating.ts" region="subscriber" title="Create observable with constructor"></code-example>

To take this example a little further, we can create an observable that publishes events. In this example, the subscriber function is defined inline.

조금 더 예시를 들기 위해서, 우리는 이벤트를 발행하는 observable 을 생성할수있다. 예를들면, 구독자 함수를 즉시 정의한다.

<code-example path="observables/src/creating.ts" region="fromevent" title="Create with custom fromEvent function"></code-example>

Now you can use this function to create an observable that publishes keydown events:
지금 키 이벤트를 발행하는 observable 을 생성하는 함수를 이것을 가지고서 사용할수 있다:

<code-example path="observables/src/creating.ts" region="fromevent_use" title="Use custom fromEvent function"></code-example>

## Multicasting

A typical observable creates a new, independent execution for each subscribed observer. When an observer subscribes, the observable wires up an event handler and delivers values to that observer. When a second observer subscribes, the observable then wires up a new event handler and delivers values to that second observer in a separate execution. 

일반적인 observable은 각각의 구독된 observer의 독립적인 실행을 새로 생성한다. observer 가 구독시에 , observable은 이벤트 핸들러를 묶으며 observer에게 값을 보낸다. 두번쨰 observer 구독시에는 , 새로운 이벤트 핸들러르 묵고 , 분리된 실행으로 두번쨰 observer에게 값을 전달한다. 


Sometimes, instead of starting an independent execution for each subscriber, you want each subscription to get the same values&mdash;even if values have already started emitting. This might be the case with something like an observable of clicks on the document object.

각각의 구독자의 독립적인 실행 대신에, 만약에 값이 이미 배출되기 시작해다면 , 각각의 구독의 같은 값을 얻기를 원한다.  이것은 document objectr의 클릭에 대한 observable 와 같이 같은 케이스될지도 모른다.

*Multicasting* is the practice of broadcasting to a list of multiple subscribers in a single execution. With a multicasting observable, you don't register multiple listeners on the document, but instead re-use the first listener and send values out to each subscriber.

*Multicasting*은 하나의 실행에서 다중 구독자들의 목록에게 전파하는 예이다. multicasting observable 을 가지고 , 문서에 첫번째 리스너를 재 사용하는것 대신에 각각의 구독자에게 값을 보내는것 대신에 다중 리스너를 등록하지 않는다., 


When creating an observable you should determine how you want that observable to be used and whether or not you want to multicast its values. 
observable 생성시에 어떻게 observable 사용될지를  , 어찌되었든 간에 이것을 multicast 할지에 대해서 원한든지 결정한다.



Let’s look at an example that counts from 1 to 3, with a one-second delay after each number emitted.

각각의 숫자를 방출하고 1초 지연하여 1 부터 3를 세는 예를 보라.

<code-example path="observables/src/multicasting.ts" region="delay_sequence" title="Create a delayed sequence"></code-example>

Notice that if you subscribe twice, there will be two separate streams, each emitting values every second. It looks something like this:
만약 두번 구독한다면, 매초마다 값을 배출하는 두개의 별개의 스트림될것을 주목해야하낟. 이것은 이 예를 보여주는 것이다.

<code-example path="observables/src/multicasting.ts" region="subscribe_twice" title="Two subscriptions"></code-example>

 Changing the observable to be multicasting could look something like this:
 
 observable 을 multicasting 하는것을 연쇄적으로 하는것은 이것과 같이 보일수 있다:

<code-example path="observables/src/multicasting.ts" region="multicast_sequence" title="Create a multicast subscriber"></code-example>

<div class="l-sub-section">
   Multicasting observables take a bit more setup, but they can be useful for certain applications. Later we will look at tools that simplify the process of multicasting, allowing you to take any observable and make it multicasting.
</div>

## Error handling

Because observables produce values asynchronously, try/catch will not effectively catch errors. Instead, you handle errors by specifying an `error` callback on the observer. Producing an error also causes the observable to clean up subscriptions and stop producing values. An observable can  either produce values (calling the `next` callback), or it can complete, calling either the `complete` or `error` callback.

observables가 비동기적으로 값을 생산하면, try/catch는 에러를 잡아네는데 비효율적일 것이다.
대신에, 당신은 observer 의 `error` callback 를 지정하여 에러를 다룬다. 에러는 발생시키는것은 observable이 subscriptions을 지워버리게 만들고 값의 생산하는 것을 멈춘다. observable 는 값을 생산하던지(the `next` callback 을 호출하면서) 또는 `complete` 또는 `error` callback 을 호출 하면서 완료되게 한다.
<code-example>
myObservable.subscribe({
  next(num) { console.log('Next num: ' + num)},
  error(err) { console.log('Received an errror: ' + err)}
});
</code-example>

Error handling (and specifically recovering from an error) is covered in more detail in a later section.
에러 핸들링 (그리고  에러로부터 특정한 복구 )는 다음 섹션에서 상세하게 포함되어 있다.