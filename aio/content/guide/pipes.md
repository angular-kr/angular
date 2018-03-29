# Pipes

Every application starts out with what seems like a simple task: get data, transform them, and show them to users.
Getting data could be as simple as creating a local variable or as complex as streaming data over a WebSocket.

모든 어플리케이션은 데이터를 얻거나 , 데이터를 변형하거나 , 사용자에게 이를 다시 보여주는 간단한 작업들을 처리한다.
데이터를 얻고서 로컬 변수로 만드는 것처럼 쉽거나 , 웹소켓의 스트리밍 데이터 만큼 복잡할수도 있다.

Once data arrive, you could push their raw `toString` values directly to the view,
but that rarely makes for a good user experience.
For example, in most use cases, users prefer to see a date in a simple format like
<samp>April 15, 1988</samp> rather than the raw string format
<samp>Fri Apr 15 1988 00:00:00 GMT-0700 (Pacific Daylight Time)</samp>.


데이터를 전송되면, 우리는 화면에 직접적으로 가공되지 않은 `toString` 값들로 밀어넣지만, 이것은 유저에게 좋은 경험을 주지 못한다.
예를들면, 대부분의 유즈케이서 에서는, 사용자는 데이터를  Fri Apr 15 1988 00:00:00 GMT-0700 (Pacific Daylight Time)의 문자열 형식보다는 
April 15, 1988와 같은 간단한 포맷으로 보길 원한다.

Clearly, some values benefit from a bit of editing. You may notice that you
desire many of the same transformations repeatedly, both within and across many applications.
You can almost think of them as styles.
In fact, you might like to apply them in your HTML templates as you do styles.

확실히, 몇몇 값들은 수정하는데 이득을 준다. 우리는 반복적으로 많은 같은 형식으로 변형하기를 바라며, 어플리케이션 안에서도 마찬가지다.
당신은 이것을 스타일로써 거의 생각할수 있다.
사실상, 우리는 HMTL 템플릿에서 스타일을 주는 것처럼 적용할수 있다.

Introducing Angular pipes, a way to write display-value transformations that you can declare in your HTML.
앵귤러 pipe에를 도입함으로서,  화면-값의 변형을 하기위해서 HTML에서 선언할수 있다.


You can run the <live-example></live-example> in Stackblitz and download the code from there.


## Using pipes

A pipe takes in data as input and transforms it to a desired output.
In this page, you'll use pipes to transform a component's birthday property into
a human-friendly date.

pipe는 데이터를 원하는 출력대로 입력과 변형을 한다.
이페이지에서느, 우리는 컴포넌트의 birthday 속성을 a human-friendly 날짜형태로 변경하기 위해서 
Pipe를 사용할것이다. 


<code-example path="pipes/src/app/hero-birthday1.component.ts" title="src/app/hero-birthday1.component.ts" linenums="false">

</code-example>



Focus on the component's template.

컴포넌트의 템플릿을 집중하라.


<code-example path="pipes/src/app/app.component.html" region="hero-birthday-template" title="src/app/app.component.html" linenums="false">

</code-example>



Inside the interpolation expression, you flow the component's `birthday` value through the
[pipe operator](guide/template-syntax#pipe) ( | ) to the [Date pipe](api/common/DatePipe)
function on the right. All pipes work this way.

interpolation 표현식 안에서, 컴포넌트의 `birthday`의 값은 [pipe 연산자](guide/template-syntax#pipe) ( | ) 를 통해서 [Date pipe](api/common/DatePipe)
함수로 흐른다. 모든 컴포넌트의 이런 방식으로 동작한다.



## Built-in pipes
Angular comes with a stock of pipes such as
`DatePipe`, `UpperCasePipe`, `LowerCasePipe`, `CurrencyPipe`, and `PercentPipe`.
They are all available for use in any template.

앵귤러는 `DatePipe`, `UpperCasePipe`, `LowerCasePipe`, `CurrencyPipe`, 그리고 `PercentPipe`와 파이프들 내장하고 있다.
어떤 템플릿에서도 접근이 가능하다
( 번역자 추가 설명 : Common 모듈에 해당 Pipe 구현체들이 import 되어 있다. 사용하려면 꼭 commom 모듈을 import 해라 )


<div class="l-sub-section">



Read more about these and many other built-in pipes in the [pipes topics](api?type=pipe) of the
[API Reference](api); filter for entries that include the word "pipe".

많은 내장 필터에 대한 정도는 [API Reference](api)의 [pipes topics](api?type=pipe) 에서 더 많은 정보를 볼수 읽어 보아라.
filter for entries that include the word "pipe".


Angular doesn't have a `FilterPipe` or an `OrderByPipe` for reasons explained in the [Appendix](guide/pipes#no-filter-pipe) of this page.

앵귤러는  `FilterPipe` 또는 `OrderByPipe` 가지고 있지 않다. 이 이유에 대한 설명은 이 페이지에 [부록](guide/pipes#no-filter-pipe) 있다.

</div>




## Parameterizing a pipe

A pipe can accept any number of optional parameters to fine-tune its output.
To add parameters to a pipe, follow the pipe name with a colon ( : ) and then the parameter value
(such as `currency:'EUR'`). If the pipe accepts multiple parameters, separate the values with colons (such as `slice:1:5`)

Modify the birthday template to give the date pipe a format parameter.
After formatting the hero's April 15th birthday, it renders as **<samp>04/15/88</samp>**:


<code-example path="pipes/src/app/app.component.html" region="format-birthday" title="src/app/app.component.html" linenums="false">

</code-example>



The parameter value can be any valid template expression,
(see the [Template expressions](guide/template-syntax#template-expressions) section of the
[Template Syntax](guide/template-syntax) page)
such as a string literal or a component property.
In other words, you can control the format through a binding the same way you control the birthday value through a binding.

Write a second component that *binds* the pipe's format parameter
to the component's `format` property. Here's the template for that component:


<code-example path="pipes/src/app/hero-birthday2.component.ts" region="template" title="src/app/hero-birthday2.component.ts (template)" linenums="false">

</code-example>



You also added a button to the template and bound its click event to the component's `toggleFormat()` method.
That method toggles the component's `format` property between a short form
(`'shortDate'`) and a longer form (`'fullDate'`).


<code-example path="pipes/src/app/hero-birthday2.component.ts" region="class" title="src/app/hero-birthday2.component.ts (class)" linenums="false">

</code-example>



As you click the button, the displayed date alternates between
"**<samp>04/15/1988</samp>**" and
"**<samp>Friday, April 15, 1988</samp>**".


<figure>
  <img src='generated/images/guide/pipes/date-format-toggle-anim.gif' alt="Date Format Toggle">
</figure>



<div class="l-sub-section">



Read more about the `DatePipe` format options in the [Date Pipe](api/common/DatePipe)
API Reference page.


</div>



## Chaining pipes

You can chain pipes together in potentially useful combinations.
In the following example, to display the birthday in uppercase,
the birthday is chained to the `DatePipe` and on to the `UpperCasePipe`.
The birthday displays as **<samp>APR 15, 1988</samp>**.


<code-example path="pipes/src/app/app.component.html" region="chained-birthday" title="src/app/app.component.html" linenums="false">

</code-example>



This example&mdash;which displays **<samp>FRIDAY, APRIL 15, 1988</samp>**&mdash;chains
the same pipes as above, but passes in a parameter to `date` as well.


<code-example path="pipes/src/app/app.component.html" region="chained-parameter-birthday" title="src/app/app.component.html" linenums="false">

</code-example>




## Custom pipes

You can write your own custom pipes.
Here's a custom pipe named `ExponentialStrengthPipe` that can boost a hero's powers:


<code-example path="pipes/src/app/exponential-strength.pipe.ts" title="src/app/exponential-strength.pipe.ts" linenums="false">

</code-example>



This pipe definition reveals the following key points:

* A pipe is a class decorated with pipe metadata.
* The pipe class implements the `PipeTransform` interface's `transform` method that
accepts an input value followed by optional parameters and returns the transformed value.
* There will be one additional argument to the `transform` method for each parameter passed to the pipe.
Your pipe has one such parameter: the `exponent`.
* To tell Angular that this is a pipe, you apply the
`@Pipe` decorator, which you import from the core Angular library.
* The `@Pipe` decorator allows you to define the
   pipe name that you'll use within template expressions. It must be a valid JavaScript identifier.
   Your pipe's name is `exponentialStrength`.


<div class="l-sub-section">



## The *PipeTransform* interface

The `transform` method is essential to a pipe.
The `PipeTransform` *interface* defines that method and guides both tooling and the compiler.
Technically, it's optional; Angular looks for and executes the `transform` method regardless.

</div>

Now you need a component to demonstrate the pipe.

<code-example path="pipes/src/app/power-booster.component.ts" title="src/app/power-booster.component.ts" linenums="false">
</code-example>

<figure>
  <img src='generated/images/guide/pipes/power-booster.png' alt="Power Booster">
</figure>



Note the following:

* You use your custom pipe the same way you use built-in pipes.
* You must include your pipe in the `declarations` array of the `AppModule`.

<div class="callout is-helpful">

<header>
  Remember the declarations array
</header>


You must register custom pipes.
If you don't, Angular reports an error.
Angular CLI's generator registers the pipe automatically.


</div>



To probe the behavior in the <live-example></live-example>,
change the value and optional exponent in the template.

## Power Boost Calculator

It's not much fun updating the template to test the custom pipe.
Upgrade the example to a "Power Boost Calculator" that combines
your pipe and two-way data binding with `ngModel`.


<code-example path="pipes/src/app/power-boost-calculator.component.ts" title="src/app/power-boost-calculator.component.ts">

</code-example>



<figure>
  <img src='generated/images/guide/pipes/power-boost-calculator-anim.gif' alt="Power Boost Calculator">
</figure>




{@a change-detection}


## Pipes and change detection

Angular looks for changes to data-bound values through a *change detection* process that runs after every DOM event:
every keystroke, mouse move, timer tick, and server response. This could be expensive.
Angular strives to lower the cost whenever possible and appropriate.

앵귤러는 모든 브라우저 이벤트가 발행후에 일어나는 *변화 탐지* 프로세스를 통해서  data-bound 값의 변화를 지켜보고 있다: 모든 키입력,
마우스 이동, 시간의 지남, 서버의 응답. 이것은 매우 비용이 크다.
앵귤러는 언제든지 가능하고 적절하게 비용을 줄일수 있게 노력했다.

Angular picks a simpler, faster change detection algorithm when you use a pipe.

앵귤러는 Pipe 사용시에 간단하고, 빠른 변화 탐지 알고리즘을 선택했다.

<h3 class="no-toc">No pipe</h3>

In the next example, the component uses the default, aggressive change detection strategy to monitor and update
its display of every hero in the `heroes` array. Here's the template:

다음 예세에서, 컴포넌트 `heroes` 배열의 모든 hero의 이 화면에서 변경과 감시를 하기 위해서 기본적으로 공격적인 변화 탐지 전략을 사용한다.
여기에 그 template이다.


<code-example path="pipes/src/app/flying-heroes.component.html" region="template-1" title="src/app/flying-heroes.component.html (v1)" linenums="false">

</code-example>



The companion component class provides heroes, adds heroes into the array, and can reset the array.

위 코드를 가진 컴포넌트는 class는 hero들을 공급하고 배열로 hero들을 추가하고, 그리고 다시 배열을 리셋한다.

<code-example path="pipes/src/app/flying-heroes.component.ts" region="v1" title="src/app/flying-heroes.component.ts (v1)" linenums="false">

</code-example>



You can add heroes and Angular updates the display when you do.
If you click the `reset` button, Angular replaces `heroes` with a new array of the original heroes and updates the display.
If you added the ability to remove or change a hero, Angular would detect those changes and update the display as well.

heroes를 추가할수 있고 앵귤러는 추가할떄마다 다시 화면을 갱신한다.
만약 `reset` 버튼을 누루면 ,앵귤러는  본래 `heroes` 배열로 교체하고 이것을 화면에 반영한다.
hero를 제거하고 추가하는 것을 추가한다면, 앵귤러는 그러한 변화를 감지하고 이를 화면에 업데이트한다.

<h3 class="no-toc"><i>FlyingHeroesPipe</i></h3>

Add a `FlyingHeroesPipe` to the `*ngFor` repeater that filters the list of heroes to just those heroes who can fly.

`*ngFor` 반복자안에 heroes 중에 날수 있는 hero로만 필터링 하는 `FlyingHeroesPipe`를 추가해라.

<code-example path="pipes/src/app/flying-heroes.component.html" region="template-flying-heroes" title="src/app/flying-heroes.component.html (flyers)" linenums="false">

</code-example>



Here's the `FlyingHeroesPipe` implementation, which follows the pattern for custom pipes described earlier.

이전에 설명한 커스텀 Pipe를 위한 패턴를 따른 `FlyingHeroesPipe` 에 대한 구현이다.

<code-example path="pipes/src/app/flying-heroes.pipe.ts" region="pure" title="src/app/flying-heroes.pipe.ts" linenums="false">

</code-example>



Notice the odd behavior in the <live-example></live-example>:
when you add flying heroes, none of them are displayed under "Heroes who fly."

<live-example></live-example>에서 이상한 동작을 유의하라:
만약에 날수있는 heroes를 추가하면, 날수있는 Heroes 들에 표시되지 않는다.

Although you're not getting the behavior you want, Angular isn't broken.
It's just using a different change-detection algorithm that ignores changes to the list or any of its items.

만약 당신이 원하는 동작이 안 일어났더라도, 앵귤러가 잘못된 아니다.
이것은 리스트와 다른 아이템들의 변화를 무시하는 다른 변화-감지 알고리즘을 사용한것이다.

Notice how a hero is added:

어떻게 hero를 추가하는지 유의하라:

<code-example path="pipes/src/app/flying-heroes.component.ts" region="push" title="src/app/flying-heroes.component.ts" linenums="false">

</code-example>



You add the hero into the `heroes` array.  The reference to the array hasn't changed.
It's the same array. That's all Angular cares about. From its perspective, *same array, no change, no display update*.

`heroes` 배열에 새로운 hero를 추가한다. 배열에 참조는 변경되지 않았다.
이것은 같은 배열이다. 이러한 관점에서는 *같은 배열, 변경없음, 화면 변경 없음이다*.

To fix that, create an array with the new hero appended and assign that to `heroes`.
This time Angular detects that the array reference has changed.
It executes the pipe and updates the display with the new array, which includes the new flying hero.

이것을 고치기 위해서, 새로운 hero가 추가된 배열을 생성하고  `heroes`에 할당한다.
이댸 앵귤러는 배열의 참조가 변경되었는지 감지한다.
이것은 pipe를 실행하고 날수 있게된 새로운 hero를 추가한 새로운 배열로 화면을 변경한다.

If you *mutate* the array, no pipe is invoked and the display isn't updated;
if you *replace* the array, the pipe executes and the display is updated.
The Flying Heroes application extends the
code with checkbox switches and additional displays to help you experience these effects.

만약 배열을 *변형* 시키거나, pipe는 실행되지 않고 화면도 갱신되지 않게된다;
만약에 배열을 교체한다면 pipe는 실행되고 이는다시 화면을 갱신시킨다.
Flying Heroes 어플리케이션은 체크 박스 스위치를 확장하고 추가적으로 이러한 효과들을 경험하는데 
도움을 주기위해서 표시했다.



<figure>
  <img src='generated/images/guide/pipes/flying-heroes-anim.gif' alt="Flying Heroes">
</figure>



Replacing the array is an efficient way to signal Angular to update the display.
When do you replace the array? When the data change.
That's an easy rule to follow in *this* example
where the only way to change the data is by adding a hero.

배열을 교체하는건은 앵귤러가 화면을 갱신하라고 신호를 보내는 효율적인 방식이다.
언제 배열을 교체하는가? 데이터 변경이 있을때.
hero를 추가함으로서 데이터 변화가 일어나는 이 예제서 이 규칙은 매우 간단한다.

More often, you don't know when the data have changed,
especially in applications that mutate data in many ways,
perhaps in application locations far away.
A component in such an application usually can't know about those changes.
Moreover, it's unwise to distort the component design to accommodate a pipe.
Strive to keep the component class independent of the HTML.
The component should be unaware of pipes.

더 빈번하게, 당신은 데이터 변화가 언제 일어나는지 알수없다, 특히 많은 방식으로 데이터를 변형하는 어플리케이션 안에서, 
아마도 어플리케이션내 위치와 멀리 떨어질수록/
보통 그러한 어플리케이션은 그러한 변화에 대해서 알수없다.
더군다마, 이것은 pipe를 수용하기 위해서 컴포넌트 디자인을 뒤틀어 버리는것은 어리석다.
HTML과 컴포넌트 class를 독립적으로 되게 유지해야한다.
커뮤넌트는 pipe를 알지 못해야한다.
     
For filtering flying heroes, consider an *impure pipe*.
날아가는 heroes 필터링을 위해서 , *비순수 Pipe*를 고려해라 


## Pure and impure pipes

There are two categories of pipes: *pure* and *impure*.
Pipes are pure by default. Every pipe you've seen so far has been pure.
You make a pipe impure by setting its pure flag to false. You could make the `FlyingHeroesPipe`
impure like this:


<code-example path="pipes/src/app/flying-heroes.pipe.ts" region="pipe-decorator" title="src/app/flying-heroes.pipe.ts" linenums="false">

</code-example>



Before doing that, understand the difference between pure and impure, starting with a pure pipe.
이것을 하기전에, pure pipe를 시작하기전에 pure와 impure의 차이를 이해하라. 

<h3 class="no-toc">Pure pipes</h3>

Angular executes a *pure pipe* only when it detects a *pure change* to the input value.
A pure change is either a change to a primitive input value (`String`, `Number`, `Boolean`, `Symbol`)
or a changed object reference (`Date`, `Array`, `Function`, `Object`).

앵귤러는 입력값에 대한 *pure change*를 감지할때, *pure pipe*를 실행한다.
가장 pure한 변화는 primitive 입력(`String`, `Number`, `Boolean`, `Symbol`)의 값 또는 객체 참조(`Date`, `Array`, `Function`, `Object`)의 변화이다.

Angular ignores changes within (composite) objects.
It won't call a pure pipe if you change an input month, add to an input array, or update an input object property.

앵귤러는 객체 내부의 변화를 무시한다.


This may seem restrictive but it's also fast.
An object reference check is fast&mdash;much faster than a deep check for
differences&mdash;so Angular can quickly determine if it can skip both the
pipe execution and a view update.

이것은 제한적이지만 빠르다.
객체 참조 체크는 차이점에 대한 깊은 체크 보다  빠르다.
그래서 pipe 실행과 화면 변경을 생략 할수 있다면, 앵귤러는 빠르게 결정할수있다. 

For this reason, a pure pipe is preferable when you can live with the change detection strategy.
When you can't, you *can* use the impure pipe.


이런 이유로, pure pipe는 변화 감지 전략을 유지하려고 할떄 , 순수 Pipe는 더 선호된다.
먄악 이를 할수 없다면, 우리는 비순수 Pipe를 사용할수 있다.


<div class="l-sub-section">



Or you might not use a pipe at all.
It may be better to pursue the pipe's purpose with a property of the component,
a point that's discussed later in this page.

또는 당신은 전혀 Pipe를 사용하지 않을것이다. 컴포넌트의 속성에 대해서 pipe의 목적을 추구하는것이 나을지 모른다.
후에 이 페이지에대해서 이 논점을 토론할것이다. 



</div>



<h3 class="no-toc">Impure pipes</h3>

Angular executes an *impure pipe*  during every component change detection cycle.
An impure pipe is called often, as often as every keystroke or mouse-move.

앵귤러는 모든 컴포넌트의 변화 감지 사이클 동안에 *impure pipe* 실행한다.
 impure pipe는 모든 키입력 , 마우스 이동을 자주 호출한다.

With that concern in mind, implement an impure pipe with great care.
An expensive, long-running pipe could destroy the user experience.


이것을 염두하고서,  아주 좋은 방식으로 impure pipe을 구현하라.
오랜시간 돌아가는 pipe의 비용은 유저의 경험을 망가뜨린다. 

{@a impure-flying-heroes}


<h3 class="no-toc">An impure <i>FlyingHeroesPipe</i></h3>

A flip of the switch turns the `FlyingHeroesPipe` into a `FlyingHeroesImpurePipe`.
The complete implementation is as follows:

스위치 플립을 `FlyingHeroesPipe` 에서 `FlyingHeroesImpurePipe` 바꾸어라.
완전한구현은 다음과 같다.


<code-tabs>

  <code-pane title="FlyingHeroesImpurePipe" path="pipes/src/app/flying-heroes.pipe.ts" region="PipeTransform impure">

  </code-pane>

  <code-pane title="FlyingHeroesPipe" path="pipes/src/app/flying-heroes.pipe.ts" region="pure">

  </code-pane>

</code-tabs>



You inherit from `FlyingHeroesPipe` to prove the point that nothing changed internally.
The only difference is the `pure` flag in the pipe metadata.

내부적으로 어떤 변경적도 없는 것을 증명하기 위해서 `FlyingHeroesPipe`를 상속받아라.
오로지 메타에이터 pure 플러그 차이가 있다.  

This is a good candidate for an impure pipe because the `transform` function is trivial and fast.

`transform` 기능이 아주 사소하고 빠르기 떄문에 impure pipe 로써 좋은 예이다.

<code-example path="pipes/src/app/flying-heroes.pipe.ts" linenums="false" title="src/app/flying-heroes.pipe.ts (filter)" region="filter">

</code-example>



You can derive a `FlyingHeroesImpureComponent` from `FlyingHeroesComponent`.


<code-example path="pipes/src/app/flying-heroes-impure.component.html" linenums="false" title="src/app/flying-heroes-impure.component.html (excerpt)" region="template-flying-heroes">

</code-example>



The only substantive change is the pipe in the template.
You can confirm in the <live-example></live-example> that the _flying heroes_
display updates as you add heroes, even when you mutate the `heroes` array.

실질적인 변화는 템플릿안에 Pipe이다. <live-example></live-example>에서 _flying heroes_는 hero들이 추가되면 화면이
변경되고, 심지어 `heroes` 배열이 변형될떄도.


{@a async-pipe}
<h3 class="no-toc">The impure <i>AsyncPipe</i></h3>


The Angular `AsyncPipe` is an interesting example of an impure pipe.
The `AsyncPipe` accepts a `Promise` or `Observable` as input
and subscribes to the input automatically, eventually returning the emitted values.

앵귤러 `AsyncPipe`는 impure pipe의 흥미있는 예시다. `AsyncPipe`는 `Promise` 또는 `Observable` 를 입력으로 받고
결국적으로 방출되는 값을 입력을 자동적으로 구독한다. 

The `AsyncPipe` is also stateful.
The pipe maintains a subscription to the input `Observable` and
keeps delivering values from that `Observable` as they arrive.

 `AsyncPipe` 상태지향적이다.
 pipe는  입력 `Observable`의  구독을 유지하고  이 `Observable`로부터 전달된 값을 받는것을 유지한다.

This next example binds an `Observable` of message strings
(`message$`) to a view with the `async` pipe.

`Observable` 의  `async` pipe를 가진 view 의 메세지 문자열(`message$`)에 주목한라. 



<code-example path="pipes/src/app/hero-async-message.component.ts" title="src/app/hero-async-message.component.ts">

</code-example>



The Async pipe saves boilerplate in the component code.
The component doesn't have to subscribe to the async data source,
extract the resolved values and expose them for binding,
and have to unsubscribe when it's destroyed
(a potent source of memory leaks).

Async pipe는 컴포넌트 코드에서 Async pipe 저장한다.
컴포넌트는 비동기 데이터 소스를 구독하지 않고, 반환된 값들을 추출하고 , 바인딩에 대해서 그것들을 노출하고
이것이 제거될때 구독해지를 해야한다.(메모리 누수의 잠재적 가능성)

<h3 class="no-toc">An impure caching pipe</h3>

Write one more impure pipe, a pipe that makes an HTTP request.

한개 이상의 HTTP 요청을 하는 impure pipe 작성하라.

Remember that impure pipes are called every few milliseconds.
If you're not careful, this pipe will punish the server with requests.

impure pipes 매번 밀리세컨트로 호출하는것을기억하라.
이것을 유의하지 않으면, pipe가 서버를 요청으로 응징한다.


In the following code, the pipe only calls the server when the request URL changes and it caches the server response.
The code uses the [Angular http](guide/http) client to retrieve data:


다음 코드에 따르면, pipe는 요청 URL 이 변경될때 오로지 서버를 호출하고 서버의 응답을 캐싱한다.
이 코드는 데이터를 돌려주기 위해서 [Angular http](guide/http)를 사용했다.


<code-example path="pipes/src/app/fetch-json.pipe.ts" title="src/app/fetch-json.pipe.ts">

</code-example>



Now demonstrate it in a harness component whose template defines two bindings to this pipe,
both requesting the heroes from the `heroes.json` file.




<code-example path="pipes/src/app/hero-list.component.ts" title="src/app/hero-list.component.ts">

</code-example>



The component renders as the following:


<figure>
  <img src='generated/images/guide/pipes/hero-list.png' alt="Hero List">
</figure>



A breakpoint on the pipe's request for data shows the following:

데이터 대한 pipe의 요청은 다음과 같은 논점을 보여준다.

* Each binding gets its own pipe instance. 각각의 바인딩은 자기 자신의 Pipe 인스턴스를 가진다.
* Each pipe instance caches its own URL and data. 각각의 pipe 인스턴스는 자신의 URL 과 데이터를 캐싱한다.
* Each pipe instance only calls the server once. 각각의 인스턴스는 서버에 호출한다.

<h3 class="no-toc"><i>JsonPipe</i></h3>

In the previous code sample, the second `fetch` pipe binding demonstrates more pipe chaining.
It displays the same hero data in JSON format by chaining through to the built-in `JsonPipe`.

이전 코드 샘플에서 , 2번째 `fetch` pipe 바인딩은 더 많은 pipe 체이닝의 설명한다.
이것은 내장인`JsonPipe`를 통해서 체이닝된 JSON 포맷으로 hero 데이터를 보여준다.

<div class="callout is-helpful">



<header>
  Debugging with the json pipe
</header>



The [JsonPipe](api/common/JsonPipe)
provides an easy way to diagnosis a mysteriously failing data binding or
inspect an object for future binding.


</div>



{@a pure-pipe-pure-fn}


<h3 class="no-toc">Pure pipes and pure functions</h3>

A pure pipe uses pure functions.
Pure functions process inputs and return values without detectable side effects.
Given the same input, they should always return the same output.

pure pipe는 순수 함수를 사용했다.
순수함수들은 입력을 처리하고 발견가능한 사이트 이펙트 없이 값을 리턴하낟.
같은 입력이 주어지면, 항상 같은 값을 리턴한다.

The pipes discussed earlier in this page are implemented with pure functions.
The built-in `DatePipe` is a pure pipe with a pure function implementation.
So are the `ExponentialStrengthPipe` and `FlyingHeroesPipe`.
A few steps back, you reviewed the `FlyingHeroesImpurePipe`&mdash;an impure pipe with a pure function.


Pipe는 이 페이지에서 이전에 언급한것 처럼 순수함수로 구현되었다.
내장인 `DatePipe`도 순순 함수 구현을 가진다.
그래서 `ExponentialStrengthPipe` 그리고 `FlyingHeroesPipe` 마찬가지다.
이전 단계를 보면, 우리는 `FlyingHeroesImpurePipe`는  pure function 가진 impure pipe이다.

But always implement a *pure pipe* with a *pure function*.
Otherwise, you'll see many console errors regarding expressions that changed after they were checked.

하지만 항상 *pure function*를 가진 *pure pipe* 구현하라.
Otherwise, you'll see many console errors regarding expressions that changed after they were checked.


## Next steps

Pipes are a great way to encapsulate and share common display-value
transformations. Use them like styles, dropping them
into your template's expressions to enrich the appeal and usability
of your views.

Pipes 화면의 값의 변형을 공유하고 캡슐화하는 좋은 방법이다.
Use them like styles, dropping them
into your template's expressions to enrich the appeal and usability
of your views.

Explore Angular's inventory of built-in pipes in the [API Reference](api?type=pipe).
Try writing a custom pipe and perhaps contributing it to the community.


{@a no-filter-pipe}



## Appendix: No *FilterPipe* or *OrderByPipe*

Angular doesn't provide pipes for filtering or sorting lists.
Developers familiar with AngularJS know these as `filter` and `orderBy`.
There are no equivalents in Angular.

앵귤러는 리스트들에 대한 필터링과 정렬에 관한 pipes는 제공하지 않는다.
앵귤러JS 개발자에 들에게 친숙한 `filter` 그리고 `orderBy` 등으로 알고 있다.
앵귤러에는 동일한 것은 없다.

This isn't an oversight. Angular doesn't offer such pipes because
they perform poorly and prevent aggressive minification.
Both `filter` and `orderBy` require parameters that reference object properties.
Earlier in this page, you learned that such pipes must be [impure](guide/pipes#pure-and-impure-pipes) and that
Angular calls impure pipes in almost every change-detection cycle.

이것 실수가 아니다. 앵귤러는 동작을 악화시키고 aggressive minification 을 막기 때문에 그런 파이프를 제공한지 않는다.
`filter` 그리고 `orderBy`는 객체 속성들의 참조한 파라미터를 필요로한다.
이전에 ,그러한  pipe는 [impure](guide/pipes#pure-and-impure-pipes)가 되어야만 한다. 앵귤러는 상항 모든 변화감지 사이클에서 inpure pipe를 호출한다.



Filtering and especially sorting are expensive operations.
The user experience can degrade severely for even moderate-sized lists when Angular calls these pipe methods many times per second.
`filter` and `orderBy` have often been abused in AngularJS apps, leading to complaints that Angular itself is slow.
That charge is fair in the indirect sense that AngularJS prepared this performance trap
by offering `filter` and `orderBy` in the first place.

필터링과 정렬은 매우 비싼 연산이다.
유저의 경험은 중간 이상의 크기의 리스트는 떨어뜨린다. 앵귤러는 그러한 pipe를 매번마다 호출ㄹ한다.
`filter` 그리고 `orderBy` 는 앵귤러JS 앱에서 남용되었고, 앵귤러 자체가 느리다는 불평을 이끌었다.
처음에 `filter` 그리고 `orderBy` 제공함으로써 성능 떨어드렸다는 것은 간접적으로도 명확한다.


The minification hazard is also compelling, if less obvious. Imagine a sorting pipe applied to a list of heroes.
The list might be sorted by hero `name` and `planet` of origin properties in the following way:

<code-example language="html">
  &lt;!-- NOT REAL CODE! -->
  &lt;div *ngFor="let hero of heroes | orderBy:'name,planet'">&lt;/div>
</code-example>



You identify the sort fields by text strings, expecting the pipe to reference a property value by indexing
(such as `hero['name']`).
Unfortunately, aggressive minification manipulates the `Hero` property names so that `Hero.name` and `Hero.planet`
become something like `Hero.a` and `Hero.b`. Clearly `hero['name']` doesn't work.

While some may not care to minify this aggressively,
the Angular product shouldn't prevent anyone from minifying aggressively.
Therefore, the Angular team decided that everything Angular provides will minify safely.

The Angular team and many experienced Angular developers strongly recommend moving
filtering and sorting logic into the component itself.
The component can expose a `filteredHeroes` or `sortedHeroes` property and take control
over when and how often to execute the supporting logic.
Any capabilities that you would have put in a pipe and shared across the app can be
written in a filtering/sorting service and injected into the component.

If these performance and minification considerations don't apply to you, you can always create your own such pipes
(similar to the [FlyingHeroesPipe](guide/pipes#impure-flying-heroes)) or find them in the community.
