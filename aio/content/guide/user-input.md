# User Input

User actions such as clicking a link, pushing a button, and entering
text raise DOM events.
This page explains how to bind those events to component event handlers using the Angular
event binding syntax.

사용자는 링크 클릭, 버틀 클릭, 텍스트 엔터등의 DOM 이벤트들을 일으킨다. 이 페이지에서는 어떻게 컴포넌트에서 이벤트 핸들링을 앵귤러 이벤트 바인딩 문법을 사용하여 하는지 설명한다.


Run the <live-example></live-example>.


## Binding to user input events

You can use [Angular event bindings](guide/template-syntax#event-binding)
to respond to any [DOM event](https://developer.mozilla.org/en-US/docs/Web/Events).
Many DOM events are triggered by user input. Binding to these events provides a way to
get input from the user.

To bind to a DOM event, surround the DOM event name in parentheses and assign a quoted
[template statement](guide/template-syntax#template-statements) to it.

The following example shows an event binding that implements a click handler:


당신은 Dom 이벤트(DOM event)에 반응하여 앵귤러 이벤트 바인딩(Angular event bindings)들을 할수 있다. 많은 DOM 이벤트들을 유저 입력에 발동한다. 이러한 이벤트 바인딩은 유저의 입력을 얻는 방법이다. Dom 이벤트에 바인딩 하기 위해서. 괄호 속에 이벤트명을 둘러싸고 템플릿 선언으로 이것을 할당한다. 아래에 클릭 핸들러를 구현한 이벤트 바인딩을 보여주고 있다.


<code-example path="user-input/src/app/click-me.component.ts" region="click-me-button" title="src/app/click-me.component.ts" linenums="false">

</code-example>

{@a click}

The `(click)` to the left of the equals sign identifies the button's click event as the **target of the binding**.
The text in quotes to the right of the equals sign
is the **template statement**, which responds
to the click event by calling the component's `onClickMe` method.

When writing a binding, be aware of a template statement's **execution context**.
The identifiers in a template statement belong to a specific context object,
usually the Angular component controlling the template.
The example above shows a single line of HTML, but that HTML belongs to a larger component:


<code-example path="user-input/src/app/click-me.component.ts" region="click-me-component" title="src/app/click-me.component.ts" linenums="false">

</code-example>



When the user clicks the button, Angular calls the `onClickMe` method from `ClickMeComponent`.



## Get user input from the $event object
DOM events carry a payload of information that may be useful to the component.
This section shows how to bind to the `keyup` event of an input box to get the user's input after each keystroke.

The following code listens to the `keyup` event and passes the entire event payload (`$event`) to the component event handler.

<code-example path="user-input/src/app/keyup.components.ts" region="key-up-component-1-template" title="src/app/keyup.components.ts (template v.1)" linenums="false">

</code-example>



When a user presses and releases a key, the `keyup` event occurs, and Angular provides a corresponding
DOM event object in the `$event` variable which this code passes as a parameter to the component's `onKey()` method.

<code-example path="user-input/src/app/keyup.components.ts" region="key-up-component-1-class-no-type" title="src/app/keyup.components.ts (class v.1)" linenums="false">

</code-example>



The properties of an `$event` object vary depending on the type of DOM event. For example,
a mouse event includes different information than a input box editing event.

All [standard DOM event objects](https://developer.mozilla.org/en-US/docs/Web/API/Event)
have a `target` property, a reference to the element that raised the event.
In this case, `target` refers to the [`<input>` element](https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement) and
`event.target.value` returns the current contents of that element.

After each call, the `onKey()` method appends the contents of the input box value to the list
in the component's `values` property, followed by a  separator character (|).
The [interpolation](guide/template-syntax#interpolation)
displays the accumulating input box changes from the `values` property.

Suppose the user enters the letters "abc", and then backspaces to remove them one by one.
Here's what the UI displays:

<code-example>
  a | ab | abc | ab | a | |
</code-example>



<figure>
  <img src='generated/images/guide/user-input/keyup1-anim.gif' alt="key up 1">
</figure>



<div class="l-sub-section">



Alternatively, you could accumulate the individual keys themselves by substituting `event.key`
for `event.target.value` in which case the same user input would produce:

<code-example>
  a | b | c | backspace | backspace | backspace |

</code-example>



</div>



{@a keyup1}


### Type the _$event_

The example above casts the `$event` as an `any` type.
That simplifies the code at a cost.
There is no type information
that could reveal properties of the event object and prevent silly mistakes.

The following example rewrites the method with types:

<code-example path="user-input/src/app/keyup.components.ts" region="key-up-component-1-class" title="src/app/keyup.components.ts (class v.1 - typed )" linenums="false">

</code-example>



The `$event` is now a specific `KeyboardEvent`.
Not all elements have a `value` property so it casts `target` to an input element.
The `OnKey` method more clearly expresses what it expects from the template and how it interprets the event.

### Passing _$event_ is a dubious practice
Typing the event object reveals a significant objection to passing the entire DOM event into the method:
the component has too much awareness of the template details.
It can't extract information without knowing more than it should about the HTML implementation.
That breaks the separation of concerns between the template (_what the user sees_)
and the component (_how the application processes user data_).

The next section shows how to use template reference variables to address this problem.

이벤트 객체 타입핑은 전체 전체 돔의 이벤트가 메소드로 통과할때 아주 중요한 사항을 밝혀낸다: 컴포넌트는 너무 많은 템플릿에 상세함에 대한 자각을 가진다. 이것은 HTML 구현에 대한 것을 알아야 하는 것 없이는 정보를 추출할수 없다. 이것은 템플릿과 컴포넌트 사이의 관심사 분리를 깨지게 한다.
그 다음은 섹션에서는 이 문제에 대해서 템플릿 레퍼런스 변수들을 사용하는 것을 보여준다.

그 다음은 섹션에서는 이 문제에 대해서 템플릿 레퍼런스 변수들을 사용하는 것을 보여준다.



## Get user input from a template reference variable
There's another way to get the user data: use Angular
[**template reference variables**](guide/template-syntax#ref-vars).
These variables provide direct access to an element from within the template.


To declare a template reference variable, precede an identifier with a hash (or pound) character (#).

The following example uses a template reference variable
to implement a keystroke loopback in a simple template.

<code-example path="user-input/src/app/loop-back.component.ts" region="loop-back-component" title="src/app/loop-back.component.ts" linenums="false">

</code-example>



The template reference variable named `box`, declared on the `<input>` element,
refers to the `<input>` element itself.
The code uses the `box` variable to get the input element's `value` and display it
with interpolation between `<p>` tags.

<input> 엘리멘트에 선언된 box로 네이밍한 템플릿 레퍼런스 변수는 ,  <input> 엘리멘트 자체를 참조한다. 코드에서 box 변수는 input 변수의 값을 얻기 위해서 사용되고 <p> 태그들 사이에 interpolation으로 나타낸다.


The template is completely self contained. It doesn't bind to the component,
and the component does nothing.

 템플릿은 자체로 포험되었다. 이것은 컴포넌트에 바인드 되지않았고 컴포넌트는 아무것도 하지 않았다.


Type something in the input box, and watch the display update with each keystroke.


<figure>
  <img src='generated/images/guide/user-input/keyup-loop-back-anim.gif' alt="loop back">
</figure>



<div class="l-sub-section">



**This won't work at all unless you bind to an event**.

Angular updates the bindings (and therefore the screen)
only if the app does something in response to asynchronous events, such as keystrokes.
This example code binds the `keyup` event
to the number 0, the shortest template statement possible.
While the statement does nothing useful,
it satisfies Angular's requirement so that Angular will update the screen.

</div>



It's easier to get to the input box with the template reference
variable than to go through the `$event` object. Here's a rewrite of the previous
`keyup` example that uses a template reference variable to get the user's input.

 $event  객체를 통해서 보다 , 템플릿 레퍼런스 변수를 가진 input box 를 얻는것이 더 쉽다. 여기 템플릿 레퍼런스 변수로 사용자의 입력을 얻는 방법이 사용된 KeyUp 이전 예제를 다시 작성했다.


<code-example path="user-input/src/app/keyup.components.ts" region="key-up-component-2" title="src/app/keyup.components.ts (v2)" linenums="false">

</code-example>



A nice aspect of this approach is that the component gets clean data values from the view.
It no longer requires knowledge of the `$event` and its structure.
{@a key-event}


이러한 좋은 접근은 컴포넌트가 view 로부터 깨끗한 데이터들을 가져온다. 이것은 $event 그리고 이 구조에 대한 지식은 더이상 필요로 하지 않는다.


## Key event filtering (with `key.enter`)
The `(keyup)` event handler hears *every keystroke*.
Sometimes only the _Enter_ key matters, because it signals that the user has finished typing.
One way to reduce the noise would be to examine every `$event.keyCode` and take action only when the key is _Enter_.

keyup 이벤트 핸들러는 모든 키입력을 듣는다. 가끔  유저가 타이핑을 끝냈다고 하는 신호이기 때문에 중요하다. 소음을 줄이는 한 방법은 키가 엔터키 일때 동작을 취하거나 모든  $event.keyCode 를 검사하는 것이다.


There's an easier way: bind to Angular's `keyup.enter` pseudo-event.
Then Angular calls the event handler only when the user presses _Enter_.

여기에는 쉬운 방법이 있다. 앵귤러의   keyup.enter 의 가짜 이벤트를 바인드 한다. 그리고 나서 앵귤러 유저가 엔터를 입력할때만 이벤트 핸들러를 호출한다.

<code-example path="user-input/src/app/keyup.components.ts" region="key-up-component-3" title="src/app/keyup.components.ts (v3)" linenums="false">

</code-example>



Here's how it works.

<figure>
  <img src='generated/images/guide/user-input/keyup3-anim.gif' alt="key up 3">
</figure>




## On blur

In the previous example, the current state of the input box
is lost if the user mouses away and clicks elsewhere on the page
without first pressing _Enter_.
The component's `value` property is updated only when the user presses _Enter_.

To fix this issue, listen to both the _Enter_ key and the _blur_ event.

이전 예시에서 input box 의 현재의 상태는 만약에 유저가 마우스를 벗어나거나 엔터 키 없이 페이지를 클릭한 상태라면 데이터를 소실할수 있다. 컴포넌트의 value 속성은 유저가 엔터키를 누룰때마다 업데이가 일어난다. 이러한 이슈를 바로잡기 위해서, 엔터키, blur 이벤를 각각 리스닝한다.

<code-example path="user-input/src/app/keyup.components.ts" region="key-up-component-4" title="src/app/keyup.components.ts (v4)" linenums="false">

</code-example>




## Put it all together
The previous page showed how to [display data](guide/displaying-data).
This page demonstrated event binding techniques.

Now, put it all together in a micro-app
that can display a list of heroes and add new heroes to the list.
The user can add a hero by typing the hero's name in the input box and
clicking **Add**.

이전 페이지는 어떻게 데이터를 보여주는 지를 알아보았다. 이 페이지는 이벤트 바인딩 기술들을 설명하려고한다. 

현재, heroes의 목록과 새로운 히어로즈를 추가하는 마이크로 앱을 함께 놓았다. 유저는 heroe의 이름을 입력 박스에 타이핑하여 추가 할수 있고 클릭하여 추가한다.

<figure>
  <img src='generated/images/guide/user-input/little-tour-anim.gif' alt="Little Tour of Heroes">
</figure>



Below is the "Little Tour of Heroes"  component.


<code-example path="user-input/src/app/little-tour.component.ts" region="little-tour" title="src/app/little-tour.component.ts" linenums="false">

</code-example>



### Observations

* **Use template variables to refer to elements** &mdash;
The `newHero` template variable refers to the `<input>` element.
You can reference `newHero` from any sibling or child of the `<input>` element.

엘리멘트들을 참조하기 위해서 template variables 를 사용하라 - newHero template variable은 input 엘리멘트를 참조한다. 당신은  <input> 엘리멘트의 형제 , 또는 자식로부터 새로운 newHero 를 참조할수 있다. 


* **Pass values, not elements** &mdash;
Instead of passing the `newHero` into the component's `addHero` method,
get the input box value and pass *that* to `addHero`.

엘리멘트가 아닌 값을 통과시켜라.- 컴포넌트의 addHero 메서드로부터 newHero로를 통과 시키는 것 대신에 input box 로부터 값을 얻어오고 addHero로 통과시켜라


* **Keep template statements simple** &mdash;
The `(blur)` event is bound to two JavaScript statements.
The first statement calls `addHero`.  The second statement, `newHero.value=''`,
clears the input box after a new hero is added to the list.

 template statements을 간단하게 유지하라 - blur 이벤트는 두개의 자바스크립트 선언을 바인드 한것이다.첫번쨰 선언은 addHero 를 호출했다. 두번째 선언은 newHero.value='' 은 새로운 hero 입력후에 입력 박스를 초기화했다.




## Source code

Following is all the code discussed in this page.

<code-tabs>

  <code-pane title="click-me.component.ts" path="user-input/src/app/click-me.component.ts">

  </code-pane>

  <code-pane title="keyup.components.ts" path="user-input/src/app/keyup.components.ts">

  </code-pane>

  <code-pane title="loop-back.component.ts" path="user-input/src/app/loop-back.component.ts">

  </code-pane>

  <code-pane title="little-tour.component.ts" path="user-input/src/app/little-tour.component.ts">

  </code-pane>

</code-tabs>




## Summary

You have mastered the basic primitives for responding to user input and gestures.

These techniques are useful for small-scale demonstrations, but they
quickly become verbose and clumsy when handling large amounts of user input.
Two-way data binding is a more elegant and compact way to move
values between data entry fields and model properties.
The next page, `Forms`, explains how to write
two-way bindings with `NgModel`.
