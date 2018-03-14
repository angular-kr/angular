# Practical observable usage(실제적인 observable 사용)

Here are some examples of domains in which observables are particularly useful.

여기에 observables을 특별하게 유용한 도메인들에 몇몇 예이다. 


## Type-ahead suggestions

Observables can simplify the implementation of type-ahead suggestions. Typically, a type-ahead has to do a series of separate tasks:

Observables은 type-ahead suggestions 의 구현을 간단하게 한다.
일반적으로, type-ahead 는 연속적인 분리된 작업을 해야한다:

* Listen for data from an input.
* 입력으로부터 데이터를 감지한다.

* Trim the value (remove whitespace) and make sure it’s a minimum length.
* 값을  Trim 하거나(whitespace 제거)  그리고 이것의 길이 최소화 시킨다.

* Debounce (so as not to send off API requests for every keystroke, but instead wait for a break in keystrokes).
* Debounce (모든 keystrokes를 API 요청으로 보내지 않기 위해서 ,하지만 대신 끼여들어 기다린다).


* if the value stays the same (rapidly hit a character, then backspace, for instance).
*  만약 값이 그대로 라면, 요청을 보내지마라(문자열을 빠르게 치거나, 아니면 backspace , 예를들면)

* Cancel ongoing AJAX requests if their results will be invalidated by the updated results.
* 그 결과들이 수정된 결과들에 의해서 무효되가 될거이라면 진행중인 AJAX 요청들을 취소하라.



Writing this in full JavaScript can be quite involved. With observables, you can use a simple series of RxJS operators:
완전하게 자바스크립트로 쓰여진 거라면 꽤 연관될 것이다. observables RxJS operators 를 연속적으로 사용할수있다.

<code-example path="practical-observable-usage/src/typeahead.ts" title="Typeahead"></code-example>

## Exponential backoff

Exponential backoff is a technique in which you retry an API after failure, making the time in between retries longer after each consecutive failure, with a maximum number of retries after which the request is considered to have failed. This can be quite complex to implement with promises and other methods of tracking AJAX calls. With observables, it is very easy:

Exponential backoff는 각개의 연이른 실패 이후에 더오래 시도하는 시간 만드는것과 요청이 실패가 되어진다고 고려한후에 재개의 횟수까지를 정해서 실패 후에 API 재개 시킴에 대한 기술이다. 이것을 promises 와 다른 추적 AJAX 호출 메서드를 가지고 구현하려면 꽤 복잡해질수 있다. observables 을 가지고서 이것은 매우 쉽다:

<code-example path="practical-observable-usage/src/backoff.ts" title="Exponential backoff"></code-example>
