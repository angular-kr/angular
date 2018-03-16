# Lifecycle Hooks

A component has a lifecycle managed by Angular.

컴포넌트는 Angular에 의해서 lifecycle이 관리된다.

Angular creates it, renders it, creates and renders its children,
checks it when its data-bound properties change, and destroys it before removing it from the DOM.

앵귤러는 컴포넌트를 생성하고, 렌더링하고 , 컴포넌트의 자식까지 생성과 렌더링을 하고, data-bound 속성들이 변화할때를 체크하고, DOM으로부터 컴포넌트르 제거하기 전에 파괴한다. 

Angular offers **lifecycle hooks**
that provide visibility into these key life moments and the ability to act when they occur.

Angular  핵심적인 주기의 순간에 대한 가시성을 주고,  생명주기가 발생시에 , 동작하는  있도록 해주는 능력을 주는  **lifecycle hooks**을 제공한다.


A directive has the same set of lifecycle hooks.

directive 하나의 lifecycle hooks 같은 주기를 가진다. 
 

{@a hooks-overview}

## Component lifecycle hooks overview

Directive and component instances have a lifecycle
as Angular creates, updates, and destroys them.
Developers can tap into key moments in that lifecycle by implementing
one or more of the *lifecycle hook* interfaces in the Angular `core` library.

Directive 그리고 component instances는 Angular가 생성,수정 그리고 제거하는 lifecycle 가진다. 개발자들은 Angular의 핵심 라이브러리의 *lifecycle hook* interfaces를 하나 또는 여러개 구현하는 방식으로  lifecycle의  key moments 활용할수 있다.

Each interface has a single hook method whose name is the interface name prefixed with `ng`.
For example, the `OnInit` interface has a hook method named `ngOnInit()`
that Angular calls shortly after creating the component:

각각의 interface 는 `ng`를 앞에 단 interface 이름으로 붙여진 하나의 hook method 가진다.
예를 들면,  `OnInit` interface는  앵귤러가 컴포넌트 생성후에 짧은 호출하는`ngOnInit()`이라고 불리우는 hook method 메서드를 가진다.


<code-example path="lifecycle-hooks/src/app/peek-a-boo.component.ts" region="ngOnInit" title="peek-a-boo.component.ts (excerpt)" linenums="false"></code-example>

No directive or component will implement all of the lifecycle hooks.
Angular only calls a directive/component hook method *if it is defined*.

directive 또는 component는 모든  lifecycle hooks을 구현하지 않을 것이다.
Angular 오로지 정의된만큼  directive/component hook method를 호출한다.

{@a hooks-purpose-timing}

## Lifecycle sequence

*After* creating a component/directive by calling its constructor, Angular
calls the lifecycle hook methods in the following sequence at specific moments:

component/directive 의 생성자를  호출하면서 생성한후에 , Angular는 특정한 순간들에 순차적으로 lifecycle hook methods를 호출한다


<table width="100%">
  <col width="20%"></col>
  <col width="80%"></col>
  <tr>
    <th>Hook</th>
    <th>Purpose and Timing</th>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <code>ngOnChanges()</code>
    </td>
    <td>

      Respond when Angular (re)sets data-bound input properties.
      The method receives a `SimpleChanges` object of current and previous property values.

      Angular data-bound 입력 속성들을 (재)세팅할때 반응한다. 이 메서드는 현재와 이전의 속성 값들의 `SimpleChanges` 객체 받는다.

      Called before `ngOnInit()` and whenever one or more data-bound input properties change.

      `ngOnInit()` 전에 호출되고 하나 또는 이상의 data-bound 입력 속성들이 변화가 있마다.

    </td>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <code>ngOnInit()</code>
    </td>
    <td>

      Initialize the directive/component after Angular first displays the data-bound properties
      and sets the directive/component's input properties.

      Angular 처음에  data-bound 속성 표시한후에  directive/component 를 초기화하고 
      directive/component의 입력 속성을 세팅한다.

      Called _once_, after the _first_ `ngOnChanges()`.
      처음에 `ngOnChanges()` 후에, 한번 호출한다.

    </td>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <code>ngDoCheck()</code>
    </td>
    <td>

      Detect and act upon changes that Angular can't or won't detect on its own.

      Angular가 스스로 감지할수 없거나 감지가 안되는 변화에 대해서 찾아내고 동작한다.

      Called during every change detection run, immediately after `ngOnChanges()` and `ngOnInit()`.

      `ngOnChanges()` and `ngOnInit()` 후에 즉각적으로 , 모든 변화 감지 일어나는 동안에 호출된다. 
      

    </td>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <code>ngAfterContentInit()</code>
    </td>
    <td>

      Respond after Angular projects external content into the component's view / the view that a directive is in.

       Angular projects 외부의 컨턴츠가 component/component 내부에 들어온후에 호출된다.

      Called _once_ after the first `ngDoCheck()`.
      최초 `ngDoCheck()` 후에 한번 호출된다.

    </td>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <code>ngAfterContentChecked()</code>
    </td>
    <td>

      Respond after Angular checks the content projected into the directive/component.

      Angular directive/component에 예상되는 컨턴츠를 확인후에 반응한다.

      Called after the `ngAfterContentInit()` and every subsequent `ngDoCheck()`.
      `ngAfterContentInit()` 그리고 모든  `ngDoCheck()` 후에 호출된다. 

    </td>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <code>ngAfterViewInit()</code>
    </td>
    <td>

      Respond after Angular initializes the component's views and child views / the view that a directive is in. 

      Angular는 component의 views 와 그 자식들의 views/ 디렉티브안에 view를 초기화 한후에 반응하다.

      Called _once_ after the first `ngAfterContentChecked()`.
      최초 `ngAfterContentChecked()` 후에 한번 호출된다.

    </td>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <code>ngAfterViewChecked()</code>
    </td>
    <td>

      Respond after Angular checks the component's views and child views / the view that a directive is in.

      Angular component의 views 와 그 자식들의 views/ 디렉티브안에 view를 확인한후에 반응한다.

      Called after the `ngAfterViewInit` and every subsequent `ngAfterContentChecked()`.

      `ngAfterViewInit` 그리고 모든 차후에 `ngAfterContentChecked()` 후에 호출된다.

    </td>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <code>ngOnDestroy()</code>
    </td>
    <td>

      Cleanup just before Angular destroys the directive/component.
      Unsubscribe Observables and detach event handlers to avoid memory leaks.

      Angular는 directive/component 제거하고 오로지 클린한다.
      Observables 구독을 해지하고 , 메모리 누수를 피하기 위해서 이벤트 핸들러를 제거한다. 

      Called _just before_ Angular destroys the directive/component.

      Angular에서 directive/component 제거후에만 호출된다.

    </td>
  </tr>
</table>

{@a interface-optional}

## Interfaces are optional (technically)

The interfaces are optional for JavaScript and Typescript developers from a purely technical perspective.
The JavaScript language doesn't have interfaces.
Angular can't see TypeScript interfaces at runtime because they disappear from the transpiled JavaScript.

interfaces는 자바스크립에서는 선택적이고, 타입 스크립트 개발자드을 순수하게 기술적인 관점에 보고있다.
자바스크립트 언어는 interfaces 를 가지지 않는다.
Angular는 트랜스 컴파일된 자바스크립트로 사라지기 때문에, TypeScript interfaces를 런타임 시점에서 볼수 없다. 

Fortunately, they aren't necessary.
You don't have to add the lifecycle hook interfaces to directives and components to benefit from the hooks themselves.

운좋게도, 이건 필수적인게 아니다.
hooks 하는 것으로 이득을 얻기 위해서, directives 그리고 components에 lifecycle hook interfaces 를 추가할 필요는 없다.

Angular instead inspects directive and component classes and calls the hook methods *if they are defined*.
Angular finds and calls methods like `ngOnInit()`, with or without the interfaces.

Angular 대신에 directive 그리고 component classes를 조사하고 만약 정의 되었다면 the hook methods 호출한다.Angular는 interfaces가 없던지 있던지 간에 `ngOnInit()` 같은 메서드를 찾고 호출한다.

Nonetheless, it's good practice to add interfaces to TypeScript directive classes
in order to benefit from strong typing and editor tooling.
그렇더라도, 타입스크립트의 interfaces 를 directive classes에 추가하는 것은 강한 타입핑과 에디터 툴림의 이점을 위해서는 가장 좋은 방법이다.

{@a other-lifecycle-hooks}

## Other Angular lifecycle hooks

Other Angular sub-systems may have their own lifecycle hooks apart from these component hooks.

또다른 Angular 하위 시스템은 these component hooks과 분리하여 자신의 lifecycle hooks을 가질수 있다.

3rd party libraries might implement their hooks as well in order to give developers more
control over how these libraries are used.

3rd party libraries는 그들 자신만의 hook을 구현할뿐만 아니라  어떻게 그러한 라이브러리 사용되어야 하는지를 기반으로 하여 개발자들에 더 많은 제어를 할수 있도록 한다.

{@a the-sample}

## Lifecycle examples

The <live-example></live-example>
demonstrates the lifecycle hooks in action through a series of exercises
presented as components under the control of the root `AppComponent`.

루트 `AppComponent` 의 제어에서 컴포넌트로써 나타나는 연속적인 동작들을 통해서 lifecycle hooks 동작에 대해서 설명한다.

They follow a common pattern: a *parent* component serves as a test rig for
a *child* component that illustrates one or more of the lifecycle hook methods.

거기에는 공통적인 패턴을 따른다: *parent* component 는 하나 또는 여러개의 lifecycle hook methods 설명하는  a *child* component 를 위한 테스트 리그 로써 제공한다.

Here's a brief description of each exercise:
여기에 각각 예시에 대한 간단한 설명이 있다. 

<table width="100%">
  <col width="20%"></col>
  <col width="80%"></col>
  <tr>
    <th>Component</th>
    <th>Description</th>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <a href="#peek-a-boo">Peek-a-boo</a>
    </td>
    <td>

      Demonstrates every lifecycle hook.
      Each hook method writes to the on-screen log.

      모든 every lifecycle hook 설명한다.
      각각의 화면의 로그로 hook method를 기록한다.

    </td>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <a href="#spy">Spy</a>
    </td>
    <td>

      Directives have lifecycle hooks too.
      A `SpyDirective` can log when the element it spies upon is
      created or destroyed using the `ngOnInit` and `ngOnDestroy` hooks.

      Directives 또한 lifecycle hooks을 가진다.
      `SpyDirective`는 `ngOnInit` 그리고 `ngOnDestroy` hooks 을 사용하여 엘리멘트가 생성 또는 소멸할대 로그화한다. 

      This example applies the `SpyDirective` to a `<div>` in an `ngFor` *hero* repeater
      managed by the parent `SpyComponent`.

      이 예시는 `SpyDirective`에  부모 pyComponent에 의해서 관리되게 <div> 안에 `ngFor`로 *hero* 반복자를 적용하였다.
    </td>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <a href="#onchanges">OnChanges</a>
    </td>
    <td>

      See how Angular calls the `ngOnChanges()` hook with a `changes` object
      every time one of the component input properties changes.
      Shows how to interpret the `changes` object.

      Angular가 어떻게 매순간마다 컴포넌트의 입력 속성 값이 변화시에 `changes` object 가지고  `ngOnChanges()` hook 호출하는지를 보라.
      어떻게 `changes` object를 해석하는지 보라.

    </td>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <a href="#docheck">DoCheck</a>
    </td>
    <td>

      Implements an `ngDoCheck()` method with custom change detection.
      See how often Angular calls this hook and watch it post changes to a log.
      
      커스텀 변화 감지를 가진 `ngDoCheck()` method는 구현한다.
      얼마나 자주 Angular 가 이 hook을 호출하는지를 보고 로그어 변화를 어떻게 보내는지도 보라.

    </td>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <a href="#afterview">AfterView</a>
    </td>
    <td>

      Shows what Angular means by a *view*.
      Demonstrates the `ngAfterViewInit` and `ngAfterViewChecked` hooks.

      Angular에게 *view* 뜻하는 것이 무엇인지 보라.
      `ngAfterViewInit` and `ngAfterViewChecked` hooks을 설명한다.

    </td>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      <a href="#aftercontent">AfterContent</a>
    </td>
    <td>

      Shows how to project external content into a component and
      how to distinguish projected content from a component's view children.
      Demonstrates the `ngAfterContentInit` and `ngAfterContentChecked` hooks.

      어떻게 external content가 컴포넌트로 들어오는지와 a component's view 자식의 어떻게 들어오는 컨텐츠와 구분하는지르 보라. `ngAfterContentInit` 그리고`ngAfterContentChecked` hooks을 설명한다.

    </td>
  </tr>
  <tr style='vertical-align:top'>
    <td>
      Counter
    </td>
    <td>

      Demonstrates a combination of a component and a directive
      each with its own hooks.

      자식의 Hook을 가진 component 그리고 directive 의 조합을 설명한다.

      In this example, a `CounterComponent` logs a change (via `ngOnChanges`)
      every time the parent component increments its input counter property.
      Meanwhile, the `SpyDirective` from the previous example is applied
      to the `CounterComponent` log where it watches log entries being created and destroyed.

      예를 들면,  `CounterComponent`는 매순간마다 부모 component가 입력 카운터 속성을 증가시키는 변화를 로그화 한다(`ngOnChanges` 통해서). 
      그동안에, 이전 `SpyDirective` 의 예제에 `CounterComponent`의 시작과 생성됨과 제거됨으 감시하는 로그 적용한다.


    </td>
  </tr>
</table>

The remainder of this page discusses selected exercises in further detail.

{@a peek-a-boo}

## Peek-a-boo: all hooks

The `PeekABooComponent` demonstrates all of the hooks in one component.

`PeekABooComponent` 하나의 컴포넌트에서 모든 hooks 을 설명한다.

You would rarely, if ever, implement all of the interfaces like this.
The peek-a-boo exists to show how Angular calls the hooks in the expected order.

이것과 같이 모든 interfaces 를 거의 구현하지 것은 거의 없다.
peek-a-boo 는 어떻게 앵규럴가 예상되는 순서에 따라서 hook을 호출하지를 보여주기 위해서 존재한다. 

This snapshot reflects the state of the log after the user clicked the *Create...* button and then the *Destroy...* button.

이 스냅샷은 유저가 *Create...* 버튼을 누루거나 그리고 나서 *Destroy...* 을 버튼을 누룬후에 로그의 상태를 반영하다.

<figure>
  <img src="generated/images/guide/lifecycle-hooks/peek-a-boo.png" alt="Peek-a-boo">
</figure>

The sequence of log messages follows the prescribed hook calling order:
`OnChanges`, `OnInit`, `DoCheck`&nbsp;(3x), `AfterContentInit`, `AfterContentChecked`&nbsp;(3x),
`AfterViewInit`, `AfterViewChecked`&nbsp;(3x), and `OnDestroy`.

<div class="l-sub-section">

  The constructor isn't an Angular hook *per se*.
  The log confirms that input properties (the `name` property in this case) have no assigned values at construction.

</div>

Had the user clicked the *Update Hero* button, the log would show another `OnChanges` and two more triplets of
`DoCheck`, `AfterContentChecked` and `AfterViewChecked`.
Clearly these three hooks fire *often*. Keep the logic in these hooks as lean as possible!

The next examples focus on hook details.


{@a spy}

## Spying *OnInit* and *OnDestroy*

Go undercover with these two spy hooks to discover when an element is initialized or destroyed.

This is the perfect infiltration job for a directive.
The heroes will never know they're being watched.

<div class="l-sub-section">

  Kidding aside, pay attention to two key points:

  1. Angular calls hook methods for *directives* as well as components.<br><br>

  2. A spy directive can provide insight into a DOM object that you cannot change directly.
  Obviously you can't touch the implementation of a native `<div>`.
  You can't modify a third party component either.
  But you can watch both with a directive.

</div>

The sneaky spy directive is simple, consisting almost entirely of `ngOnInit()` and `ngOnDestroy()` hooks
that log messages to the parent via an injected `LoggerService`.

<code-example path="lifecycle-hooks/src/app/spy.directive.ts" region="spy-directive" title="src/app/spy.directive.ts" linenums="false"></code-example>

You can apply the spy to any native or component element and it'll be initialized and destroyed
at the same time as that element.
Here it is attached to the repeated hero `<div>`:

<code-example path="lifecycle-hooks/src/app/spy.component.html" region="template" title="src/app/spy.component.html" linenums="false"></code-example>

Each spy's birth and death marks the birth and death of the attached hero `<div>`
with an entry in the *Hook Log* as seen here:

<figure>
  <img src='generated/images/guide/lifecycle-hooks/spy-directive.gif' alt="Spy Directive">
</figure>

Adding a hero results in a new hero `<div>`. The spy's `ngOnInit()` logs that event.

The *Reset* button clears the `heroes` list.
Angular removes all hero `<div>` elements from the DOM and destroys their spy directives at the same time.
The spy's `ngOnDestroy()` method reports its last moments.

The `ngOnInit()` and `ngOnDestroy()` methods have more vital roles to play in real applications.

{@a oninit}

### _OnInit()_

Use `ngOnInit()` for two main reasons:
`ngOnInit()`은 두가지 이유로 사용한다:

1. To perform complex initializations shortly after construction.(생성후에 복잡한 초기화를 하기 위해서)
1. To set up the component after Angular sets the input properties.(앵귤러가 입력 속성들을 세팅한 후에 컴포넌트를 준비하기 위해서)

Experienced developers agree that components should be cheap and safe to construct.

경험이 있는 개발자들은 컴포넌트는 저렴하고 생성시에 안전해야함에 동의한다.

<div class="l-sub-section">

  Misko Hevery, Angular team lead,
  [explains why](http://misko.hevery.com/code-reviewers-guide/flaw-constructor-does-real-work/)
  you should avoid complex constructor logic.

</div>

Don't fetch data in a component constructor.
You shouldn't worry that a new component will try to contact a remote server 
created under test or before you decide to display it. Constructors should do no more than set the initial local variables to simple values.

컴포넌트 생성자에서 데이터르 가져오지 마라. 새로운 컴포넌트 데스트로 생성된 원격 서버를 접속하려고 하는것과 이것을 화면에 보이지 전에는 걱정하지마라. 
생성자는 초기 로컬 변수를 간단한 값을 세팅하는 이상으로 하지마라. 


An `ngOnInit()` is a good place for a component to fetch its initial data. The
[Tour of Heroes Tutorial](tutorial/toh-pt4#oninit) guide shows how.

`ngOnInit()`는 컴포넌트가 초기 데이터를 가져오기 위한 좋은 장소이다. [Tour of Heroes Tutorial](tutorial/toh-pt4#oninit) 가이드는 방법을 보여주고 있다.


Remember also that a directive's data-bound input properties are not set until _after construction_.
That's a problem if you need to initialize the directive based on those properties.
They'll have been set when `ngOnInit()` runs.

directive의 data-bound 입력 속성은 생성후에도 세팅되지 않는 것을 기억하라.

만약 directive 그러한 속성에 근거하여 초기화 하는 것이 필요로 한다면 이건 문제가 있다. `ngOnInit()` 동작할때, 그것들이 세팅되어 질것이다.


<div class="l-sub-section">

  The `ngOnChanges()` method is your first opportunity to access those properties.
  Angular calls `ngOnChanges()` before `ngOnInit()` and many times after that.
  It only calls `ngOnInit()` once.

  `ngOnChanges()` method 는 처음 그러한 속성들을 접근할 기회이다.
   Angular는  `ngOnInit()` 전에 `ngOnChanges()` 호출하고 그리고 이것 후에 매번 호출한다.


</div>

You can count on Angular to call the `ngOnInit()` method _soon_ after creating the component.
That's where the heavy initialization logic belongs.

컴포넌트가 생성된 후에 `ngOnInit()` method 가 곧 앵귤러 호출됨을 셀수 있다.
여기에는 무거운 생성 로직을 포함한 곳이다.

{@a ondestroy}

### _OnDestroy()_

Put cleanup logic in `ngOnDestroy()`, the logic that *must* run before Angular destroys the directive.

Angular 가 directive 제거하기 전에 동작해야할 제거 로직을 `ngOnDestroy()` 안에 놓는다.

This is the time to notify another part of the application that the component is going away.

이것은 컴포넌트가 사라진다는것을 어플리케이션의 또다른 부분에 알리는 위한 시간입니다.



This is the place to free resources that won't be garbage collected automatically.
Unsubscribe from Observables and DOM events. Stop interval timers.
Unregister all callbacks that this directive registered with global or application services.
You risk memory leaks if you neglect to do so.

garbage collecteed 자동적으로 되지 않는 자원을 해체하기 위한 장소입니다.
Observables 그리고 DOM events를 구독해지합니다. interval timers를 멈추어라.
전역 또는 어플리케이션으로 이 디렉티브에 등록된 모든 콜백들을 해지하라.
만약 이 이를 무시란다면 메모리 부족해진다.

{@a onchanges}

## _OnChanges()_

Angular calls its `ngOnChanges()` method whenever it detects changes to ***input properties*** of the component (or directive).
This example monitors the `OnChanges` hook.

앵귤러는 컴포넌트(또는 디렉티브)의 ***input properties*** 의 변화를 감지할때마다  `ngOnChanges()` method 호출한다. 
이 예제는  `OnChanges` 을 감지하는 것이다.

<code-example path="lifecycle-hooks/src/app/on-changes.component.ts" region="ng-on-changes" title="on-changes.component.ts (excerpt)" linenums="false"></code-example>

The `ngOnChanges()` method takes an object that maps each changed property name to a
[SimpleChange](api/core/SimpleChange) object holding the current and previous property values.
This hook iterates over the changed properties and logs them.

`ngOnChanges()` method는 각각의 변화 속성명으로 현재와 이전 속성 값을 가진[SimpleChange](api/core/SimpleChange) 객체로 맵핑된 객체를 가진다.
이 hook 변화된 값들을 순회하고 그것들을 로그화한다.

The example component, `OnChangesComponent`, has two input properties: `hero` and `power`.

예시에 `OnChangesComponent` 컴포넌트는 2개의 입력 값을 가진다: `hero` 그리고 `power`. 

<code-example path="lifecycle-hooks/src/app/on-changes.component.ts" region="inputs" title="src/app/on-changes.component.ts" linenums="false"></code-example>

The host `OnChangesParentComponent` binds to them like this:
주인인 `OnChangesParentComponent`는 이것과 같이 묶는다.

<code-example path="lifecycle-hooks/src/app/on-changes-parent.component.html" region="on-changes" title="src/app/on-changes-parent.component.html"></code-example>

Here's the sample in action as the user makes changes.
여기 유저가 만드는 변화로 동작하는 같은 예시가 있다.

<figure>
  <img src='generated/images/guide/lifecycle-hooks/on-changes-anim.gif' alt="OnChanges">
</figure>

The log entries appear as the string value of the *power* property changes.
But the `ngOnChanges` does not catch changes to `hero.name`
That's surprising at first.

로그 시작은  *power* 속서의 변화에 대한 문자열 값으로 나타난다. 하지만
`ngOnChanges`은 `hero.name`의 변화를 잡아내지 않는다.
이것은 처음으로 놀라운 것이다.

Angular only calls the hook when the value of the input property changes.
The value of the `hero` property is the *reference to the hero object*.
Angular doesn't care that the hero's own `name` property changed.
The hero object *reference* didn't change so, from Angular's perspective, there is no change to report!

Angular는 오직  입력 속성 값의 변화 할때 , hook 호출한다.  `hero` property 의 값은 hero object의 참조이다.
Angular는 hero's 자신의 `name`속성 변화를 잡아내지 않는다. The hero object 참조는 변화가 아니므로, 앵귤러 관점에서는 , 알려야 할 변화가 없다.


{@a docheck}

## _DoCheck()_

Use the `DoCheck` hook to detect and act upon changes that Angular doesn't catch on its own.

앵귤러 자체에서 잡을수 없는 변화를 감지하고 ,대응하기 위해서 `DoCheck` hook을 사용하라.  

<div class="l-sub-section">

  Use this method to detect a change that Angular overlooked.
  앵귤러가 간과하는 변화를 찾기 위해서 이 메소드를 사용하라.

</div>

The *DoCheck* sample extends the *OnChanges* sample with the following `ngDoCheck()` hook:

 *DoCheck*은 *OnChanges* 샘플에 `ngDoCheck()` hook 가진  간단한 확장이다.

<code-example path="lifecycle-hooks/src/app/do-check.component.ts" region="ng-do-check" title="DoCheckComponent (ngDoCheck)" linenums="false"></code-example>

This code inspects certain _values of interest_, capturing and comparing their current state against previous values.
It writes a special message to the log when there are no substantive changes to the `hero` or the `power`
so you can see how often `DoCheck` is called. The results are illuminating:

이 코드는 이전값과 대비하여 현재 값을 비교하거나 잡아내어 어떤 값의 변화에 대해서 조사하고 있다.

이것은  `hero` 또는 `power` 에 실질적인 변화가 없을때도 로그에 특별한 메서지로 작성했다 그래서 우리는 얼마나 자주  `DoCheck`를 호출하고 있는지 볼수있다. 그 예시를 들고있다.

<figure>
  <img src='generated/images/guide/lifecycle-hooks/do-check-anim.gif' alt="DoCheck">
</figure>

While the `ngDoCheck()` hook can detect when the hero's `name` has changed, it has a frightful cost.
This hook is called with enormous frequency&mdash;after _every_
change detection cycle no matter where the change occurred.
It's called over twenty times in this example before the user can do anything.

`ngDoCheck()` hook은 hero의 `name` 변화 될때 찾을후 있는 반면에, 이것은 끔직한 비용이다.
이 hook은 막대하게 빈번하게 호출한다. 모든 변화 감지는 변화가 발생한 것과 상관없이 돌아간 후에.
이것은 예시에서 유저가 어떤것도 하기전에 20번 이상 호출된다. 


Most of these initial checks are triggered by Angular's first rendering of *unrelated data elsewhere on the page*.
Mere mousing into another `<input>` triggers a call.
Relatively few calls reveal actual changes to pertinent data.
Clearly our implementation must be very lightweight or the user experience suffers.

대부분의 그러한 초기 체크는 Angular의 초기 페이지에서 연관되지 않는 데이터의 렌더링은 의해서 발생된다. 겨우 또다른 `<input>` 의 마우스질을 호출을 발동시킨다.
비교적 거의 적적한 데이터의 실제 변화들은 나타나지 않는다.
명백하게 우리의 구현은 가벼워야 하고 유저 경험 겪어야 한다.


{@a afterview}

## AfterView

The *AfterView* sample explores the `AfterViewInit()` and `AfterViewChecked()` hooks that Angular calls
*after* it creates a component's child views.

*AfterView* sample 은 컴포넌트의 자식 views 가 생성된후에 앵귤러가 호출하는 `AfterViewInit()` 그리고 `AfterViewChecked()`를 살펴본다. 

Here's a child view that displays a hero's name in an `<input>`:

이것 `<input>`의  hero's name을 보여주는 자식 view 이다.

<code-example path="lifecycle-hooks/src/app/after-view.component.ts" region="child-view" title="ChildComponent" linenums="false"></code-example>

The `AfterViewComponent` displays this child view *within its template*:

`AfterViewComponent`는 이 템플릿 안에서 자식 views 를 보여준다.

<code-example path="lifecycle-hooks/src/app/after-view.component.ts" region="template" title="AfterViewComponent (template)" linenums="false"></code-example>

The following hooks take action based on changing values *within the child view*,
which can only be reached by querying for the child view via the property decorated with
[@ViewChild](api/core/ViewChild).

다음 Hook은 자식 view의 변화하는 값을 근거한 동작을 취한다, 이것은 [@ViewChild](api/core/ViewChild)  테코레이터를 통해서 자식 view에 대해서 질의 함으써로 도달될수 있다. 


<code-example path="lifecycle-hooks/src/app/after-view.component.ts" region="hooks" title="AfterViewComponent (class excerpts)" linenums="false"></code-example>

{@a wait-a-tick}

### Abide by the unidirectional data flow rule(단방향 데이터 흐름 규칙에 의해서 견뎌라. )
The `doSomething()` method updates the screen when the hero name exceeds 10 characters.

hero name 이 10 글자 초과 할때, `doSomething()`는  method 는 화면을 수정한다.

<code-example path="lifecycle-hooks/src/app/after-view.component.ts" region="do-something" title="AfterViewComponent (doSomething)" linenums="false"></code-example>

Why does the `doSomething()` method wait a tick before updating `comment`?

왜 `doSomething()` method는 `comment` 를 변경하기 전에 잠시 대기하는 걸까?

Angular's unidirectional data flow rule forbids updates to the view *after* it has been composed.
Both of these hooks fire _after_ the component's view has been composed.

앵귤러의 단방향성 데이터 흐름의 규칙은 , 이것이 구성된 후에 view를 변경하는것을 금지한다.
각각의 그러한 hooks은 component의 views 가 구성된후에 동작한다.

Angular throws an error if the hook updates the component's data-bound `comment` property immediately (try it!).
The `LoggerService.tick_then()` postpones the log update
for one turn of the browser's JavaScript cycle and that's just long enough.

앵귤러를 만약 data-bound `comment`의 속성이 즉시 수정되면 컴포넌트의 에러를 던진다(해보자). `LoggerService.tick_then()`는 브라우저의 자바스크립트 사이틀의 한 주기를 지연으로 하여 로그의 수정을 연기한다. 이것은 너무 길지는 않다.

Here's *AfterView* in action:
여기 *AfterView* 동작의 예이다.

<figure>
  <img src='generated/images/guide/lifecycle-hooks/after-view-anim.gif' alt="AfterView">
</figure>

Notice that Angular frequently calls `AfterViewChecked()`, often when there are no changes of interest.
Write lean hook methods to avoid performance problems.

앵귤러는 빈번하게 어떤 변화가 없을때 , `AfterViewChecked()` 호출함을 주의하라.
성능 문제들을 피하기 위해서 hook methods 에 의존하여 써라.

{@a aftercontent}

## AfterContent

The *AfterContent* sample explores the `AfterContentInit()` and `AfterContentChecked()` hooks that Angular calls
*after* Angular projects external content into the component.

*AfterContent* sample은 앵굴러가 컴포넌트에 외부 컨텐츠를 보여준후에 호출되는 `AfterContentInit()` 그리고 `AfterContentChecked()` hooks들을  살펴본다. 




{@a content-projection}

### Content projection

*Content projection* is a way to import HTML content from outside the component and insert that content
into the component's template in a designated spot.

*Content projection* 는 외부 컴포넌트의 HTML 을  import 하고, 설계한 영역에서 컴포넌트의 템플릿을 컨텐츠를 삽입하는 방법이다.

<div class="l-sub-section">

  AngularJS developers know this technique as *transclusion*.

</div>

Consider this variation on the [previous _AfterView_](guide/lifecycle-hooks#afterview) example.
This time, instead of including the child view within the template, it imports the content from
the `AfterContentComponent`'s parent. Here's the parent's template:

[previous _AfterView_](guide/lifecycle-hooks#afterview)의 예시의 변화를 고려하라. 
이번에는, 템플릿 안에서 자식 view를 포함시키는 대신에, `AfterContentComponent`의 부모에게 이것을 컨텐츠로 import 하라. 여기 그 부모템플릿 예이다.


<code-example path="lifecycle-hooks/src/app/after-content.component.ts" region="parent-template" title="AfterContentParentComponent (template excerpt)" linenums="false"></code-example>

Notice that the `<my-child>` tag is tucked between the `<after-content>` tags.
Never put content between a component's element tags *unless you intend to project that content into the component*.

`<my-child>` tag는 `<after-content>` tag 의 사이에 갇혀 있음을 주목하라.
컴포넌트로 컨테츠를 표시하는것을 의도하는 것 업신느 a component의 element tags 사이에 컨텐츠를 두지마라.


Now look at the component's template:

지금 컴포넌트의 템플릿을 보라:


<code-example path="lifecycle-hooks/src/app/after-content.component.ts" region="template" title="AfterContentComponent (template)" linenums="false"></code-example>

The `<ng-content>` tag is a *placeholder* for the external content.
It tells Angular where to insert that content.
In this case, the projected content is the `<my-child>` from the parent.
`<ng-content>` tag 는 외부의 컨텐츠를 위한  *placeholder*이다.
이것은 컨턴츠를 삽입할 영역을 앵귤러에 알려준다.
이런 경우에, 표시된 컨턴트츠는 부모로부터  `<my-child>`이다.

<figure>
  <img src='generated/images/guide/lifecycle-hooks/projected-child-view.png' alt="Projected Content">
</figure>

<div class="l-sub-section">

  The telltale signs of *content projection* are twofold:
  *content projection*의 숨길수 없는 표시들은 이중적이다.

  * HTML between component element tags.(컴포넌트 엘리멘트 태그 사이의 HTML)
  * The presence of `<ng-content>` tags in the component's template.(컴포넌트 템플릿 안에 `<ng-content>` 의 존재)

</div>

{@a aftercontent-hooks}

### AfterContent hooks

*AfterContent* hooks are similar to the *AfterView* hooks.
The key difference is in the child component.

*AfterContent* hooks은  *AfterView* hooks 와 비슷하다.
핵심 차리점은 자식 컴포넌트에 있다.

* The *AfterView* hooks concern `ViewChildren`, the child components whose element tags
appear *within* the component's template.

*AfterView* hooks은  컴포넌트의 템플릿 이내에서 나타나는 엘리멘트에 자식 컨포넌트 `ViewChildren`하고 연관된다.

* The *AfterContent* hooks concern `ContentChildren`, the child components that Angular
projected into the component.

*AfterContent* hooks 앵귤러가 컴포넌트에서 나타나는 하는 자식 컴포넌트인 `ContentChildren`과 연관된다.

The following *AfterContent* hooks take action based on changing values in a *content child*,
which can only be reached by querying for them via the property decorated with
[@ContentChild](api/core/ContentChild).


여기에서는 *AfterContent* hooks 은  [@ContentChild](api/core/ContentChild)로 데코레이트 된 속성을 통해서 질의하여 결정되는 *content child*에 변경되는 값에 의해서 동작한다. 

<code-example path="lifecycle-hooks/src/app/after-content.component.ts" region="hooks" title="AfterContentComponent (class excerpts)" linenums="false"></code-example>

{@a no-unidirectional-flow-worries}

### No unidirectional flow worries with _AfterContent_(단방향의 흐름에서 _AfterContent_ 신경쓰지 않아도 된다. )

This component's `doSomething()` method update's the component's data-bound `comment` property immediately.
There's no [need to wait](guide/lifecycle-hooks#wait-a-tick).

이 컴포넌트의 `doSomething()` method는 컴포넌트의 data-bound `comment` property을 즉시 변경한다.
기다릴 필요가 없다.[need to wait](guide/lifecycle-hooks#wait-a-tick).


Recall that Angular calls both *AfterContent* hooks before calling either of the *AfterView* hooks.
Angular completes composition of the projected content *before* finishing the composition of this component's view.
There is a small window between the `AfterContent...` and `AfterView...` hooks to modify the host view.

Angular는 *AfterView* hooks을 호출하기전에 각각의 *AfterContent* hooks을 호출함을 기억하세요.
Angular는 컴포넌트의 views의 조합이 완료되기 전에, 나타내는 컨턴츠의 조합을 완료한다. 
the host view 를 수정하기 위해서 `AfterContent...` 그리고 `AfterView...` hooks 사이에 작은 창 있다.





