# 계산기 프로젝트

## 프로젝트 소개
1. (STEP2/3 확인 후 작성 예정)

### 프로젝트 참여자
   - 팀원 : 애플사이다 @just1103
   - 리뷰어 : 찌루루 @jae57

### 프로젝트 일정
* 1주차 - STEP1
   - 11/08 (월) 스크럼, 프로젝트 확인, Linked List/Queue 구현
   - 11/09 (화) 스크럼, UML 작성, PR 요청

## STEP1
### 구현 내용
- 사용자가 계산기에 입력한 숫자 및 연산자를 Queue (CalculatorItemQueue 클래스)에 차례로 저장한다.
- Queue를 구현하기 위해 Linked List를 활용했다.
- TDD 방식으로 프로그래밍을 진행했다. XCTest를 통해 Test Case를 작성하여 테스트를 실행했다.

### UML

### 고려사항
* 기능
   - Queue를 사용하는 이유 : 계산기 프로그램에는 맨 앞과 맨 뒤를 삭제/추가하는 기능이 필요하며, 임의의 값을 탐색하지 않으므로 Queue가 적절하다.
   - Queue를 구현할 때 Array보다 Linked List가 적합한 이유 : Array의 removeFirst 메서드는 메모리 상에서 삭제한 요소 뒤에 위치한 요소들의 index를 모두 변경해야 하므로 성능이 낮다. (시간복잡도 O(n)) 반면 Linked List는 다음 요소를 가리키고 있는 포인터만 변경해주면 되므로 메모리 관리에 유리하다. (시간복잡도 O(1))

* 주요 메서드
   - append : Linked List의 마지막에 새로운 노드를 추가한다.
   - removeFirst : Linked List의 첫 번째 노드 (head)를 제거 및 반환한다. (Queue에서 꺼낸 숫자 및 연산자를 사용하기 위해 반환타입을 지정했다.)
   - scanAllValue : 계산기 프로그램에 필요한 기능은 아니지만, 테스트 코드에서 사용한다.

### 키워드
- TDD (Unit Test, XCTest), Data Structure (Queue/Linked List), Time Complexity, Generic, Inheritance, UML
