# 프로젝트 코딩 컨벤션 및 설계 패턴 (AI 지침서)

이 문서는 본 프로젝트의 고유한 코딩 습관, 위젯 구성 전략, 로직 처리 패턴을 정의합니다. 새로운 기능을 추가하거나 기존 코드를 수정할 때 반드시 이 패턴을 준수해야 합니다.

---

## 1. UI 구조화: 원자적 위젯 분할 (Atomic Decomposition)

### 1.1. 로컬 위젯 스코핑 (Local Widget Scoping)
- **원칙:** 특정 화면(Page)에서만 사용되는 위젯은 해당 페이지의 하위 디렉토리에 격리합니다.
- **구조:** `lib/ui/pages/[FeatureName]/widget/`
- **이유:** 전역 네임스페이스 오염을 방지하고, 특정 기능을 수정할 때 영향 범위를 해당 디렉토리로 제한하기 위함입니다.

### 1.2. 스켈레톤 페이지 패턴 (Skeleton Page Pattern)
- 최상위 페이지 위젯(예: `TodoPage`)은 로직이나 복잡한 UI를 직접 구현하지 않습니다.
- 대신, `Header`, `List`, `BottomNavigation` 등 추상화된 고수준 컴포넌트들을 조립하는 **'배치도'** 역할만 수행합니다.

### 1.3. 프라이빗 UI 헬퍼 (Private UI Helpers)
- 클래스로 분리하기에는 너무 작지만 `build` 메서드를 복잡하게 만드는 UI 조각은 파일 내부의 프라이빗 메서드(`_buildTitle()`)로 선언하여 코드의 선언적 가독성을 높입니다.

---

## 2. 상태 관리 및 로직: 페이로드 기반 열거형 (Payload-Bearing Enums)

### 2.1. 비주얼 로직의 중앙화 (Centralized Visual Logic)
- **패턴:** 상태값(Enum)이 단순한 식별자를 넘어, 그 상태에 따른 **시각적 데이터(색상, 텍스트, 아이콘)**를 직접 들고 있도록 설계합니다.
- **구현:** Enum의 확장(Extension) 기능을 사용하여 `state.primaryColor`, `state.title`과 같이 호출합니다.
- **이유:** UI 코드에서 `if (state == X) color = Y`와 같은 조건문을 제거하여 UI와 로직을 완전히 분리합니다.

### 2.2. 전수 검사 (Exhaustive Matching)
- 상태에 따른 분기 처리 시 반드시 모든 케이스를 명시적으로 처리(Pattern Matching)하여, 새로운 상태가 추가되었을 때 컴파일 단계에서 누락을 발견할 수 있도록 합니다.

---

## 3. 데이터 기반 UI 생성 (Data-Driven UI Mapping)

### 3.1. 선언적 데이터 매핑 (Declarative Mapping)
- 반복되는 UI 요소(네비게이션 버튼, 필터 탭 등)는 데이터 구조(Records/Tuples/List)를 먼저 정의한 후, 이를 위젯 리스트로 `map` 하여 생성합니다.
- 데이터(Menu List)와 표현(Widget Implementation)을 분리하여 유지보수성을 극대화합니다.

---

## 4. 레이아웃 및 스타일링 철학

### 4.1. 일관된 간격 시스템 (Unified Spacing)
- 위젯 간의 간격은 `spacing` 속성이나 일정한 수치의 `Padding`을 사용하여 시스템화합니다. 임의의 수치를 남발하지 않고 프로젝트의 기준 수치(예: 24)를 준수합니다.

### 4.2. 방어적 레이아웃 (Defensive Layout)
- 하드웨어 특성(노치, 하단 바)에 구애받지 않도록 최상위 영역에서 안전 영역(SafeArea)을 확보한 후 레이아웃을 시작합니다.

---

## 5. 개발 프로세스: 인터페이스 우선 구현 (Interface-First)

### 5.1. 구조 선점 (Structural Placeholder)
- 새로운 컴포넌트를 만들 때, 내부 UI를 완성하기 전에 필요한 **매개변수(Interface)**를 먼저 정의하고 `Placeholder`를 반환하도록 작성합니다.
- 이는 전체적인 데이터 흐름과 레이아웃 구조를 먼저 확정 짓는 Top-Down 방식을 따르기 위함입니다.
