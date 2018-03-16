# Component Interaction

{@a top}

This cookbook contains recipes for common component communication scenarios
in which two or more components share information.

이 가이드느 하나 또는 둘 이상의 컴포넌트 끼리의 정보 공유에 대한 공통적인 컴포넌트 소통 시나니오를 담고 있습니다. 

{@a toc}

<!--

# Contents

* [Pass data from parent to child with input binding](guide/component-interaction#parent-to-child)
* [Intercept input property changes with a setter](guide/component-interaction#parent-to-child-setter)
* [Intercept input property changes with `ngOnChanges()`](guide/component-interaction#parent-to-child-on-changes)
* [Parent calls an `@ViewChild()`](guide/component-interaction#parent-to-view-child)
* [Parent and children communicate via a service](guide/component-interaction#bidirectional-service)

-->

**See the <live-example name="component-interaction"></live-example>**.

{@a parent-to-child}

## Pass data from parent to child with input binding

`HeroChildComponent` has two ***input properties***,
typically adorned with [@Input decorations](guide/template-syntax#inputs-outputs).

`HeroChildComponent`는 일반적으로 [@Input decorations](guide/template-syntax#inputs-outputs)로 되어 있는
 ***input properties***를 가진다. 

<code-example path="component-interaction/src/app/hero-child.component.ts" title="component-interaction/src/app/hero-child.component.ts">

</code-example>



The second `@Input` aliases the child component property name `masterName` as `'master'`.

두번째 `@Input`는 자식 컴포넌트 속성명으로 `masterName` 인것에 `'master'`로 별칭을 지었다.

The `HeroParentComponent` nests the child `HeroChildComponent` inside an `*ngFor` repeater,
binding its `master` string property to the child's `master` alias,
and each iteration's `hero` instance to the child's `hero` property.

`HeroParentComponent`는 자식 `HeroChildComponent` 안에 `*ngFor` 반복자를 끼어넣고, 
자식의 `master` alias 에  `master` 문자열 속성과 자식의  `hero` 인스턴스의 반복인자를 바인딩하였다.

<code-example path="component-interaction/src/app/hero-parent.component.ts" title="component-interaction/src/app/hero-parent.component.ts">

</code-example>



The running application displays three heroes:
동작하는 어플리케이션은 3개의 heroes 표시한다:


<figure>
  <img src="generated/images/guide/component-interaction/parent-to-child.png" alt="Parent-to-child">
</figure>



<h3 class="no-toc">Test it</h3>

E2E test that all children were instantiated and displayed as expected:

E2E로 모든 자식들은 예상된것 처럼 인스턴스화되고 보여지게 되는 것을 테스트한다.

<code-example path="component-interaction/e2e/app.e2e-spec.ts" region="parent-to-child" title="component-interaction/e2e/app.e2e-spec.ts">

</code-example>



[Back to top](guide/component-interaction#top)

{@a parent-to-child-setter}

## Intercept input property changes with a setter(setter 르 가지고 입력속성 변화를 가로체기)

Use an input property setter to intercept and act upon a value from the parent.

부모부터의 값에 따라 동작시키거나, 값을 가로채기 위해서,input property setter를 사용하라. 

The setter of the `name` input property in the child `NameChildComponent`
trims the whitespace from a name and replaces an empty value with default text.

자식 `NameChildComponent` 에 `name` input property 의 setter는 name의 공백문자를 trim 하고 빈 문자열을  기본 문자열로 바꾼다.

<code-example path="component-interaction/src/app/name-child.component.ts" title="component-interaction/src/app/name-child.component.ts">

</code-example>



Here's the `NameParentComponent` demonstrating name variations including a name with all spaces:

여기에서는 모든 스페이스를 포함된 이름을 포함한 이름 변화를 나타내는 `NameParentComponent`의 예이다.  

<code-example path="component-interaction/src/app/name-parent.component.ts" title="component-interaction/src/app/name-parent.component.ts">

</code-example>



<figure>
  <img src="generated/images/guide/component-interaction/setter.png" alt="Parent-to-child-setter">
</figure>



<h3 class="no-toc">Test it</h3>

E2E tests of input property setter with empty and non-empty names:

E2E 공백 또는 공백이 아닌 이름을 가지고 input property setter를 테스트한다. 

<code-example path="component-interaction/e2e/app.e2e-spec.ts" region="parent-to-child-setter" title="component-interaction/e2e/app.e2e-spec.ts">

</code-example>



[Back to top](guide/component-interaction#top)

{@a parent-to-child-on-changes}

## Intercept input property changes with *ngOnChanges()*

Detect and act upon changes to input property values with the `ngOnChanges()` method of the `OnChanges` lifecycle hook interface.

`OnChanges` lifecycle hook interface 의 `ngOnChanges()` method를 가지고 입력 속성 값들의 변화에 따라 동작하고 감지하라.

<div class="l-sub-section">



You may prefer this approach to the property setter when watching multiple, interacting input properties.

이런 접근을 여러개를 감시하거나, 입력 속성들과 상호작용시에, the property setter 로 하는 하는것을 선호할지도 모른다. 

Learn about `ngOnChanges()` in the [LifeCycle Hooks](guide/lifecycle-hooks) chapter.

 the [LifeCycle Hooks](guide/lifecycle-hooks)의 챕터에서 `ngOnChanges()`를 대해서 배워보자.

</div>



This `VersionChildComponent` detects changes to the `major` and `minor` input properties and composes a log message reporting these changes:

이 `VersionChildComponent`는 `major` 그리고 `minor` input 속성들에 대한 변화를 찾고, 그리고 그러한 변화에 따른 로그 메세지를 조합한다.


<code-example path="component-interaction/src/app/version-child.component.ts" title="component-interaction/src/app/version-child.component.ts">

</code-example>



The `VersionParentComponent` supplies the `minor` and `major` values and binds buttons to methods that change them.

 `VersionParentComponent`는  `minor` 그리고 `major` 값을 제공하고 , 이것이 변경하도록 하는 버튼에 메서드를 바인딩한다.


<code-example path="component-interaction/src/app/version-parent.component.ts" title="component-interaction/src/app/version-parent.component.ts">

</code-example>



Here's the output of a button-pushing sequence:

여기에는 연속적인 버튼 입력 출력의 예시이다:

<figure>
  <img src="generated/images/guide/component-interaction/parent-to-child-on-changes.gif" alt="Parent-to-child-onchanges">
</figure>



<h3 class="no-toc">Test it</h3>

Test that ***both*** input properties are set initially and that button clicks trigger
the expected `ngOnChanges` calls and values:


  각가의 입력 속성들을 초기에 세팅하고 버튼 클랙시에 예상되는 `ngOnChanges` 호출과 값들이 발생하도록 테스트하라.


<code-example path="component-interaction/e2e/app.e2e-spec.ts" region="parent-to-child-onchanges" title="component-interaction/e2e/app.e2e-spec.ts">

</code-example>



[Back to top](guide/component-interaction#top)

{@a child-to-parent}

## Parent listens for child event

The child component exposes an `EventEmitter` property with which it `emits` events when something happens.
The parent binds to that event property and reacts to those events.

자식 component는  어떤 것이 발생했을대 이벤트를 내보내는 `EventEmitter` 속성을 노출한다.
부모는 이 이벤트 속성에 바인딩하고 , 이러한 이벤트들에 반응한다.  

The child's `EventEmitter` property is an ***output property***,
  typically adorned with an [@Output decoration](guide/template-syntax#inputs-outputs)
  as seen in this `VoterComponent`:

자식의 `EventEmitter` 속성은 `VoterComponent`에서 보여지는 것과 같이 일반적으로 [@Output decoration](guide/template-syntax#inputs-outputs)로 붙여지는 출력 속성이다.


<code-example path="component-interaction/src/app/voter.component.ts" title="component-interaction/src/app/voter.component.ts">

</code-example>



Clicking a button triggers emission of a `true` or `false`, the boolean *payload*.
버튼을 클릭하는것은 boolean 형태의 payload인 `true` 또는 `false`로 배출이 일어나게 한다.

The parent `VoteTakerComponent` binds an event handler called `onVoted()` that responds to the child event payload `$event` and updates a counter.

부모 `VoteTakerComponent`는 자식 이벤트 payload `$event`에 반응하거나 카운터를 변경하는 `onVoted()`를 호출하는 이벤트 핸들러를 바인딩 한다.

<code-example path="component-interaction/src/app/votetaker.component.ts" title="component-interaction/src/app/votetaker.component.ts">

</code-example>



The framework passes the event argument&mdash;represented by `$event`&mdash;to the handler method,
and the method processes it:

프레임워크는 `$event`로 나타나는 이벤트 인자를 핸들러 메서드에 통과시키고, 메서드는 이것을 처리한다. :


<figure>
  <img src="generated/images/guide/component-interaction/child-to-parent.gif" alt="Child-to-parent">
</figure>



<h3 class="no-toc">Test it</h3>

Test that clicking the *Agree* and *Disagree* buttons update the appropriate counters:

*Agree* 그리고 *Disagree* 버튼들을 클릭하는것은 적절하게 카운터를 변경하는지 테스트한다.


<code-example path="component-interaction/e2e/app.e2e-spec.ts" region="child-to-parent" title="component-interaction/e2e/app.e2e-spec.ts">

</code-example>



[Back to top](guide/component-interaction#top)



## Parent interacts with child via *local variable*

A parent component cannot use data binding to read child properties
or invoke child methods. You can do both
by creating a template reference variable for the child element
and then reference that variable *within the parent template*
as seen in the following example.

부모 component는 자식의 속성을 읽기 위해서 , 자식 메서드를 호출하기위해서 데이터 바인딩을 사용할수 없다. 다음 예에서는 각각 자식 자식 엘리멘트의 템플릿 참조 변수 생성하는 것과 그리고 나서 부모의 템플릿 안에서 이 변수를 참조하는것으로 할수 있다.

{@a countdown-timer-example}
The following is a child `CountdownTimerComponent` that repeatedly counts down to zero and launches a rocket.

다음에는 반복적은 0에서 카운트 다운를 하여 로켓을 발사하는 것처럼 숫자를 새는 자식 `CountdownTimerComponent` 이다.

It has `start` and `stop` methods that control the clock and it displays a
countdown status message in its own template.

이것은 시간과 자신의 템플릿 안에서 카운트 다운 상태 메세지를 보여주는 통제하는 `start` 그리고 `stop` methods 이다.

<code-example path="component-interaction/src/app/countdown-timer.component.ts" title="component-interaction/src/app/countdown-timer.component.ts">

</code-example>



The `CountdownLocalVarParentComponent` that hosts the timer component is as follows:

the timer component의 주인인 `CountdownLocalVarParentComponent`는 다음과 같다:


<code-example path="component-interaction/src/app/countdown-parent.component.ts" region="lv" title="component-interaction/src/app/countdown-parent.component.ts">

</code-example>



The parent component cannot data bind to the child's
`start` and `stop` methods nor to its `seconds` property.

부모 컴포넌트는 자식의 `start` 그리고`stop` methods 또는 `seconds`  속성으로  데이터 바인딩 할수없다.

You can place a local variable, `#timer`, on the tag `<countdown-timer>` representing the child component.
That gives you a reference to the child component and the ability to access
*any of its properties or methods* from within the parent template.


자식 컴포넌트를 나타내는 `<countdown-timer>` 태그에  `#timer` 로컬 변수를 둘수있다.


This example wires parent buttons to the child's `start` and `stop` and
uses interpolation to display the child's `seconds` property.

이 예시는 자식의 `start` 그리고 `stop`를 부모의 버튼에 묶고, 자신의 `seconds`  속성을 보여주기 위해서 interpolation을 사용한다.

Here we see the parent and child working together.

여기 부모와 자식이 함께 동작하는 것을 보라.

<figure>
  <img src="generated/images/guide/component-interaction/countdown-timer-anim.gif" alt="countdown timer">
</figure>



{@a countdown-tests}


<h3 class="no-toc">Test it</h3>

Test that the seconds displayed in the parent template
match the seconds displayed in the child's status message.
Test also that clicking the *Stop* button pauses the countdown timer:

부모 템플릿에서 seconds가 표시되는것과 자식의 상태 메세지에서 표시되는 seconds가 일치하는지 테스트하다.
또한  *Stop* button을 클릭하여 카운터 타이머가 정지하는지도 테스트 하라:


<code-example path="component-interaction/e2e/app.e2e-spec.ts" region="countdown-timer-tests" title="component-interaction/e2e/app.e2e-spec.ts">

</code-example>



[Back to top](guide/component-interaction#top)

{@a parent-to-view-child}

## Parent calls an _@ViewChild()_

The *local variable* approach is simple and easy. But it is limited because
the parent-child wiring must be done entirely within the parent template.
The parent component *itself* has no access to the child.

로컬 변수의 접근 아주 간단하고 쉽다. 하지만 이것은 부모-자식간의 연결이 부모이 템플릿이내에만 전체적으로 동작하기 때문에 제한이 있다.

You can't use the *local variable* technique if an instance of the parent component *class*
must read or write child component values or must call child component methods.

만약 부모의 인스턴스가 컴포넌트 클래스라면, 로컬 변수 기술은 사용할수 없다.

When the parent component *class* requires that kind of access,
***inject*** the child component into the parent as a *ViewChild*.

부모 컴포넌트 클래스가 다른 접근을 필요로 할때, *ViewChild* 로써 자식 컴포넌트를 부모에게 주입한다.

The following example illustrates this technique with the same
[Countdown Timer](guide/component-interaction#countdown-timer-example) example.
Neither its appearance nor its behavior will change.
The child [CountdownTimerComponent](guide/component-interaction#countdown-timer-example) is the same as well.


다음의 예시는 같은 [Countdown Timer](guide/component-interaction#countdown-timer-example) 예시인
 이 기술에 대해서 설명한다. 
이것의 외관과 행동의 변경과는 변경될것이다.
자식 [CountdownTimerComponent](guide/component-interaction#countdown-timer-example)는 또한 같은 예이다.

<div class="l-sub-section">



The switch from the *local variable* to the *ViewChild* technique
is solely for the purpose of demonstration.

로컬 변수에서 *ViewChild* 의 기술로 변환은 오로지 설명에 목적을 둔다.

</div>



Here is the parent, `CountdownViewChildParentComponent`:

여기  부모 `CountdownViewChildParentComponent` 이다.:

<code-example path="component-interaction/src/app/countdown-parent.component.ts" region="vc" title="component-interaction/src/app/countdown-parent.component.ts">

</code-example>



It takes a bit more work to get the child view into the parent component *class*.

이것은 부모컴포넌트로 자식 view를 얻기 위해서 조금만 하면된다.

First, you have to import references to the `ViewChild` decorator and the `AfterViewInit` lifecycle hook.

첫번쨰, `ViewChild` 데코레이터와  `AfterViewInit` lifecycle hook을  import 참조 해야한다.

Next, inject the child `CountdownTimerComponent` into the private `timerComponent` property
via the `@ViewChild` property decoration.

다름에는, `@ViewChild` 속성 데코레이터를 통해서 private `timerComponent` 속성으로   자식 `CountdownTimerComponent`를 주입한다. 


The `#timer` local variable is gone from the component metadata.
Instead, bind the buttons to the parent component's own `start` and `stop` methods and
present the ticking seconds in an interpolation around the parent component's `seconds` method.

 `#timer` 로컬 변수는 컴포넌트 메타데이터로부터 사라진다.
 대신에, 부모 컴포넌트  `start` 그리고 `stop` methods를 바인딩하고, 부모 컴포넌트에[ ticking seconds의 interpolation에 `seconds` 메서드를 위치시켜라.


These methods access the injected timer component directly.

그러한 메서드는 주입된 타이머 컴포넌트에 직접적으로 접근한다.

The `ngAfterViewInit()` lifecycle hook is an important wrinkle.
The timer component isn't available until *after* Angular displays the parent view.
So it displays `0` seconds initially.

`ngAfterViewInit()` lifecycle hook은 중요한 단서이다.
앵귤러가 부모 view가 표시된후에는 타이머 컴포넌트에 접근할수 없다는 것이다.
그래서 초기에는  0 초로 표시된다.

Then Angular calls the `ngAfterViewInit` lifecycle hook at which time it is *too late*
to update the parent view's display of the countdown seconds.
Angular's unidirectional data flow rule prevents updating the parent view's
in the same cycle. The app has to *wait one turn* before it can display the seconds.

그리고 나서 앵귤러는 다소 늦은 시점에 카운터 초에 대한 부모의 표시를 변경하기 위해서 `ngAfterViewInit` lifecycle hook  호출한다.


Use `setTimeout()` to wait one tick and then revise the `seconds()` method so
that it takes future values from the timer component.

`setTimeout()`를 한번 기다리기 위해서 사용하고 그러고 나서  `seconds()` method 수정해라 왜냐하면 타이머 컴포넌트로부터 미래의 값을 가져오기 떄문이다.

<h3 class="no-toc">Test it</h3>

Use [the same countdown timer tests](guide/component-interaction#countdown-tests) as before.

[Back to top](guide/component-interaction#top)

{@a bidirectional-service}

## Parent and children communicate via a service

A parent component and its children share a service whose interface enables bi-directional communication
*within the family*.

부모 컴포넌트와 자식은 가족안에서 양방양 소통이 가능하게 하는 서비스를 공유한다.

The scope of the service instance is the parent component and its children.
Components outside this component subtree have no access to the service or their communications.

서비스 인스턴스의 영역은 부모,자식 컴포넌트이다.
이 하위 컴포넌트 밖에 컴포넌트들은 이 서비스와 그글의 소통에 접근할수 없다. 

This `MissionService` connects the `MissionControlComponent` to multiple `AstronautComponent` children.

`MissionService`는 복수의 `AstronautComponent` 자식들과 `MissionControlComponent` 를 연결한다.


<code-example path="component-interaction/src/app/mission.service.ts" title="component-interaction/src/app/mission.service.ts">

</code-example>



The `MissionControlComponent` both provides the instance of the service that it shares with its children
(through the `providers` metadata array) and injects that instance into itself through its constructor:

`MissionControlComponent` 각각의 서비스 인스턴스를 자식들과 공유하는 것(`providers` 메타 배열을 통해서)과 생성자를 통해서 이것드 자체에 인스턴스를 주입한다. 


<code-example path="component-interaction/src/app/missioncontrol.component.ts" title="component-interaction/src/app/missioncontrol.component.ts">

</code-example>



The `AstronautComponent` also injects the service in its constructor.
Each `AstronautComponent` is a child of the `MissionControlComponent` and therefore receives its parent's service instance:

`AstronautComponent` 또한 생성자를 통해서 서비스를 주입한다.
각가의 `AstronautComponent`는  `MissionControlComponent`의 자식이고 그러므로 부모의 서비스 인스턴스를 받는다.

<code-example path="component-interaction/src/app/astronaut.component.ts" title="component-interaction/src/app/astronaut.component.ts">

</code-example>



<div class="l-sub-section">



Notice that this example captures the `subscription` and `unsubscribe()` when the `AstronautComponent` is destroyed.
This is a memory-leak guard step. There is no actual risk in this app because the
lifetime of a `AstronautComponent` is the same as the lifetime of the app itself.
That *would not* always be true in a more complex application.

You don't add this guard to the `MissionControlComponent` because, as the parent,
it controls the lifetime of the `MissionService`.

이 예시에서 `AstronautComponent`가 제거될때 `subscription` 그리고 `unsubscribe()` 잡는것에  주목하라.
이것은 메모리 누수를 막는 단계이다. 이것은  왜냐하면  `AstronautComponent`의 생명주기는 이 앱 자체의 생명주기와 같이 떄문이므로 이 앱에서 실제적으로 위험은 없다. 이것은 복잡한 어플리케이션에서 항상 참은 아니다.

`MissionControlComponent`에 이러한 방어를 추가하지 않는다 이유는, 부모로써 `MissionService`를 관리하기 때문이다.

</div>



The *History* log demonstrates that messages travel in both directions between
the parent `MissionControlComponent` and the `AstronautComponent` children,
facilitated by the service:


<figure>
  <img src="generated/images/guide/component-interaction/bidirectional-service.gif" alt="bidirectional-service">
</figure>



<h3 class="no-toc">Test it</h3>

Tests click buttons of both the parent `MissionControlComponent` and the `AstronautComponent` children
and verify that the history meets expectations:


<code-example path="component-interaction/e2e/app.e2e-spec.ts" region="bidirectional-service" title="component-interaction/e2e/app.e2e-spec.ts">

</code-example>



[Back to top](guide/component-interaction#top)
