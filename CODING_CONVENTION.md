# Coding Convention

이 문서는 특정 프로젝트에만 묶인 기능 설명이 아니라, 여러 앱과 여러 언어에 반복해서 적용할 수 있는 코딩 스타일과 구조화 습관을 정리한다.
프레임워크가 달라도 핵심 원칙은 같다: 진입점은 얇게, 설정은 중앙화하고, 화면과 로직과 데이터 모양은 분리한다.

## 1. 기본 원칙

- 코드는 "어디에 무엇이 있는지"를 먼저 알 수 있어야 한다.
- 파일 하나가 너무 많은 역할을 하지 않게 한다.
- 화면, 데이터, 외부 통신, 설정, 공통 도구를 섞지 않는다.
- 같은 종류의 코드는 같은 위치와 같은 이름 규칙으로 둔다.
- 프로젝트 고유 기능보다 재사용 가능한 습관을 우선한다.
- 새 추상화는 중복이 실제로 줄거나 책임이 더 선명해질 때만 만든다.
- 작은 프로젝트에서는 과한 계층을 만들지 않고, 커질 때 자연스럽게 나눌 수 있는 구조를 유지한다.

## 2. 폴더 구조 원칙

권장 구조는 역할 기준으로 나눈다.

```text
src/
  app/
    router/
    theme/
    extensions/
    config/
  models/
  services/
  ui/
    common/
    pages/
      feature_name/
        feature_page.*
        widgets/
  platform/
  tests/
```

Flutter/Dart에서는 `src/` 대신 `lib/`를 사용한다.

```text
lib/
  main.dart
  app/
    router/
    theme/
    extensions/
  models/
  services/
  ui/
    common/
    pages/
      feature_a/
      feature_b/
      feature_c/
```

### 폴더별 책임

- `main` 또는 앱 진입점: 앱 실행만 담당한다.
- `app`: 라우터, 테마, 앱 전역 설정, 전역 확장처럼 애플리케이션 전체에 걸친 코드만 둔다.
- `models`: API 응답, 저장 데이터, 화면 간 전달 데이터처럼 데이터 모양을 표현하는 타입을 둔다.
- `services`: 네트워크, 로컬 저장소, 파일 시스템, 외부 SDK처럼 앱 밖과 통신하는 코드를 둔다.
- `ui/common`: 여러 화면에서 재사용되는 UI 컴포넌트를 둔다.
- `ui/pages`: 실제 화면 단위 코드를 둔다.
- `ui/pages/<feature>/widgets`: 특정 화면에서만 쓰는 작은 위젯을 둔다.
- `platform`: Android, iOS, Web, Desktop 등 플랫폼 설정 파일을 둔다.
- `tests`: 테스트 코드를 실제 코드 구조와 비슷한 모양으로 둔다.

### 배치 규칙

- 두 곳 이상에서 쓰이면 `common`, 한 화면에서만 쓰이면 해당 화면 폴더에 둔다.
- 외부 통신 코드는 화면 파일 안에 직접 쓰지 말고 `services`로 보낸다.
- 데이터 파싱 코드는 화면 파일 안에 직접 쓰지 말고 `models` 또는 데이터 계층으로 보낸다.
- 라우팅과 화면 목록은 한 곳에서 관리한다.
- 테마, 색상, 버튼 스타일, 입력창 스타일은 화면마다 직접 반복하지 않고 전역 스타일에서 관리한다.

## 3. 앱 진입점 스타일

진입점은 최대한 얇게 유지한다.

### 원칙

- `main()` 또는 엔트리 함수는 앱 루트 컴포넌트를 실행하는 역할만 한다.
- 루트 앱 클래스는 라우터, 테마, 전역 설정을 연결한다.
- API 호출, 인증 검사, 화면 로직, 복잡한 초기화는 루트 UI 안에 직접 넣지 않는다.
- 초기화가 필요하면 별도 함수나 별도 bootstrap 파일로 분리한다.

### Flutter 예시

```dart
void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
```

핵심은 `MaterialApp`, `App`, `RouterProvider`, `ThemeProvider` 같은 프레임워크 루트 객체에 전역 설정을 모으는 것이다.

## 4. 라우팅 스타일

라우트는 문자열을 여기저기 흩뿌리지 않는다.

### 원칙

- 화면 이름, 경로, 실제 화면 객체를 한 구조에서 관리한다.
- 라우트 이름과 경로는 상수, enum, sealed type, 객체 배열 등으로 중앙화한다.
- 라우터 설정 파일은 라우트 목록을 순회해서 생성한다.
- 화면 이동은 가능하면 하드코딩된 문자열보다 이름 기반 이동을 사용한다.

### 권장 패턴

```dart
enum AppPage { start, detail, settings }

extension AppPageExtension on AppPage {
  String get path => '/$name';

  Widget get page => switch (this) {
    .start => const StartPage(),
    .detail => const DetailPage(),
    .settings => const SettingsPage(),
  };
}
```

```dart
final appRouter = GoRouter(
  initialLocation: AppPage.start.path,
  routes: AppPage.values.map((e) {
    return GoRoute(
      name: e.name,
      path: e.path,
      builder: (context, state) => e.page,
    );
  }).toList(),
);
```

다른 언어에서도 같은 원칙을 적용한다. 라우트 테이블, 화면 매핑, 경로 문자열을 한 곳에 둔다.

## 5. 테마와 스타일

시각 스타일은 화면마다 흩어놓지 않는다.

### 원칙

- 색상, 버튼 모양, 입력창 모양, 앱바 스타일은 테마 또는 디자인 토큰으로 중앙화한다.
- 라이트 모드와 다크 모드는 같은 구조로 정의한다.
- 자주 쓰는 색상은 의미 있는 이름의 상수로 만든다.
- 위젯 안에는 예외적인 경우에만 직접 색상과 모양을 넣는다.
- 화면은 "어떤 컴포넌트를 배치할지"에 집중하고, "기본 버튼이 어떻게 생겼는지"는 테마가 담당한다.

### 권장 습관

- primary, background, error, surface 같은 의미 기반 이름을 사용한다.
- `blue1`, `blue2`처럼 용도를 알 수 없는 이름은 피한다.
- 버튼 radius, 입력창 radius, 기본 간격은 프로젝트 기준값을 정한다.
- 전역 테마가 있는 프레임워크에서는 가능한 한 전역 테마를 먼저 사용한다.

## 6. 확장 함수와 헬퍼

확장 함수는 코드를 짧게 만들 수 있지만, 숨겨진 동작이 많아지면 읽기 어려워진다.

### 사용 기준

- 매우 자주 쓰이고 의미가 명확한 표현만 확장으로 만든다.
- 단순한 UI 간격, 반복되는 알림 표시, 안전한 변환처럼 작은 도구에 적합하다.
- 네트워크 요청, 데이터 저장, 화면 이동처럼 큰 동작은 확장 함수에 숨기지 않는다.
- 확장은 기능별 파일로 나누고 `app/extensions` 또는 `core/extensions`에 모은다.

### 예시

```dart
extension SizedBoxExtension on num {
  Widget get widthBox => SizedBox(width: toDouble());
  Widget get heightBox => SizedBox(height: toDouble());
}
```

```dart
extension SnackbarExtension on BuildContext {
  void showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

다른 언어에서는 extension, helper, utility, composable, hook, mixin 등으로 같은 역할을 구현할 수 있다. 이름은 작고 명확해야 한다.

## 7. UI 컴포넌트 작성

UI 컴포넌트는 입력값을 명확히 받고, 내부 책임을 작게 유지한다.

### 공통 규칙

- 여러 화면에서 반복되는 UI는 공통 컴포넌트로 분리한다.
- 특정 화면에서만 쓰는 UI는 그 화면 폴더 안에 둔다.
- 컴포넌트 생성자는 필수 값과 선택 값을 명확히 구분한다.
- 상태가 없는 컴포넌트는 stateless로 둔다.
- 내부에서 UI 상태를 바꿔야 할 때만 stateful로 둔다.
- 텍스트 필드, 스크롤, 탭 컨트롤러처럼 해제가 필요한 객체는 반드시 dispose 한다.

### 생성자와 필드 순서

권장 순서:

1. public final 필드
2. 생성자
3. override 메서드
4. private 상태 필드
5. private 헬퍼 메서드
6. build 또는 render 메서드

상태 클래스에서는 다음 순서를 권장한다.

1. controller, focus node, animation controller 같은 리소스
2. loading, selected, obscure 같은 단순 상태
3. 상태 변경 메서드
4. lifecycle 메서드
5. async 이벤트 핸들러
6. build 또는 render 메서드

### 레이아웃 습관

- 화면 루트는 `Scaffold`, `Page`, `Screen`, `RouteView`처럼 명확한 최상위 컨테이너를 둔다.
- 키보드나 작은 화면에서 넘칠 수 있는 화면은 스크롤 가능하게 만든다.
- 입력 폼은 라벨, 힌트, 아이콘, 오류 메시지의 위치를 일관되게 유지한다.
- 버튼은 가능한 한 부모 너비를 명확히 지정한다.
- 반복되는 간격은 같은 숫자 체계를 사용한다.
- 동적 텍스트가 버튼이나 카드 밖으로 튀어나오지 않게 한다.

## 8. 폼과 입력 처리

폼 로직은 화면 이벤트 핸들러 안에서 한눈에 보이게 둔다.

### 원칙

- 입력값은 사용 직전에 읽고 정리한다.
- 앞뒤 공백이 의미 없는 값은 `trim` 또는 동등한 처리를 한다.
- 빈 값 검증은 API 호출 전에 한다.
- 검증 실패 시 즉시 사용자에게 알려주고 함수를 종료한다.
- 비밀번호 확인처럼 서로 비교하는 값은 API 호출 전에 비교한다.
- API 요청 중에는 중복 요청을 막는 장치를 둔다.

### 이벤트 핸들러 흐름

```text
1. 입력값 읽기
2. 값 정리
3. 클라이언트 검증
4. 로딩 시작 또는 중복 요청 방지
5. 서비스 호출
6. 로딩 종료
7. 실패 처리
8. 성공 처리
```

## 9. 비동기 처리와 사용자 피드백

비동기 코드는 성공보다 실패와 중복 클릭을 먼저 생각한다.

### 원칙

- API 호출 전후로 loading 상태를 명확히 관리한다.
- 같은 요청이 중복 실행되지 않도록 방지한다.
- 실패는 `null`, `false`, 예외, Result 타입 중 하나로 일관되게 표현한다.
- UI에서 비동기 작업 후 context나 state를 사용할 때는 mounted 여부를 확인한다.
- 사용자에게 보여줄 실패 메시지와 개발자가 볼 debug 로그를 구분한다.
- debug 로그는 문제를 찾을 수 있을 만큼만 남기고 민감한 값은 출력하지 않는다.

### mounted 확인 기준

- async 함수에서 `await` 이후 화면 이동, 스낵바, setState를 호출한다면 mounted를 확인한다.
- 화면이 사라진 뒤 UI를 조작하지 않게 한다.

## 10. 서비스 계층

서비스는 외부 세계와 통신하는 계층이다. UI는 서비스의 내부 구현을 몰라야 한다.

### 원칙

- API URL, endpoint, request body 구성은 서비스 파일에 둔다.
- 화면 파일에서 HTTP 클라이언트를 직접 import하지 않는다.
- 서비스 메서드는 필요한 값만 named parameter 또는 명확한 request 객체로 받는다.
- 응답 상태 코드를 확인하고 실패를 일관되게 반환한다.
- JSON encode/decode는 서비스와 모델 계층에서 처리한다.
- 서비스는 UI 위젯을 직접 만들거나 화면 이동을 하지 않는다.

### 반환값 기준

- 성공/실패만 필요하면 boolean 또는 Result 타입을 반환한다.
- 응답 데이터가 필요하면 model 타입을 반환한다.
- 실패 가능성이 있으면 nullable, Result, Either, exception 중 하나를 선택해 프로젝트 전체에서 일관되게 사용한다.
- `void`는 호출자가 결과를 전혀 알 필요 없을 때만 사용한다.

## 11. 모델과 데이터 구조

모델은 데이터 모양을 표현한다. 화면 로직을 넣지 않는다.

### 원칙

- 필드는 가능한 한 불변으로 둔다.
- 생성자에서 필수 값을 명확히 요구한다.
- 외부 데이터 이름과 내부 필드 이름이 다르면 변환 지점을 모델에 모은다.
- JSON, Map, DTO 변환은 모델 또는 전용 mapper에서 처리한다.
- `copyWith`, equality, `toString`은 필요한 경우에만 둔다.
- 토큰, 비밀번호, 개인 정보 같은 민감 값은 `toString`이나 로그에 그대로 노출하지 않는다.

### 네이밍 변환

- API는 `snake_case`, 앱 코드는 `camelCase`처럼 서로 다른 규칙을 쓸 수 있다.
- 변환은 한 곳에서 처리하고, 화면 코드에는 API 필드명을 퍼뜨리지 않는다.

## 12. 네이밍 규칙

언어별 표준을 우선하되, 의미는 항상 구체적으로 쓴다.

### 일반 규칙

- 클래스, 타입, 컴포넌트: PascalCase
- 변수, 함수, 메서드: camelCase
- 파일과 폴더: snake_case 또는 kebab-case 중 하나로 통일
- 상수: 언어 관례를 따르되 의미 기반 이름 사용
- private 값: 언어가 지원하면 private 표기를 사용
- boolean: `is`, `has`, `can`, `should`, `enable` 같은 접두사를 사용
- 이벤트 핸들러: `onSubmit`, `onSave`, `handleSubmit`처럼 동작이 드러나게 쓴다.

### 피해야 할 이름

- `data`, `value`, `temp`, `result2`처럼 역할이 흐린 이름
- `manager`, `helper`, `util`처럼 범위가 너무 넓은 이름
- 화면 이름과 무관한 약어
- 팀이 공유하지 않은 축약어

## 13. import와 의존성

import는 읽는 사람이 의존성 방향을 알 수 있게 정리한다.

### 순서

1. 표준 라이브러리
2. 프레임워크 또는 외부 패키지
3. 프로젝트 내부 패키지

각 그룹 사이에는 빈 줄을 둔다.

### 의존성 방향

- UI는 services와 models를 사용할 수 있다.
- services는 models를 사용할 수 있다.
- models는 UI를 몰라야 한다.
- app 계층은 화면과 설정을 조립할 수 있다.
- 공통 컴포넌트는 특정 화면을 import하지 않는다.

## 14. 상수와 매직 넘버

숫자와 문자열은 의미가 반복되면 이름을 붙인다.

### 원칙

- 한 번만 쓰이고 의미가 명확한 작은 값은 inline으로 허용한다.
- 여러 곳에서 반복되는 색상, 간격, duration, endpoint는 상수화한다.
- 사용자에게 보이는 문구는 앱 규모가 커지면 별도 메시지/로컬라이즈 계층으로 옮긴다.
- API endpoint는 화면 파일에 두지 않는다.

## 15. 주석과 문서화

주석은 코드가 말하지 못하는 의도를 설명한다.

### 좋은 주석

- 왜 이렇게 했는지 설명한다.
- 외부 API 제약, 플랫폼 제약, 임시 우회 이유를 남긴다.
- 복잡한 분기 앞에 짧게 방향을 알려준다.

### 피할 주석

- 코드 그대로를 반복하는 주석
- 오래된 TODO
- 실제 동작과 맞지 않는 설명
- 파일 곳곳에 남겨진 학습용 메모

## 16. 오류 처리와 로그

오류 처리는 사용자 메시지와 개발자 로그를 분리한다.

### 원칙

- 사용자 메시지는 짧고 행동 가능하게 작성한다.
- 개발자 로그는 status code, 실패 이유, 응답 body 등 디버깅에 필요한 정보를 담는다.
- 민감 정보는 로그에 출력하지 않는다.
- 실패 시 함수가 계속 진행되지 않도록 즉시 return 한다.
- 성공 처리와 실패 처리는 같은 함수 안에서 순서가 명확해야 한다.

## 17. 플랫폼 설정

플랫폼 설정 파일은 필요한 권한과 설정만 최소로 유지한다.

### 원칙

- 권한은 실제 기능에 필요한 경우에만 추가한다.
- Android, iOS, Web 등 플랫폼별 설정은 프레임워크 공식 구조를 따른다.
- 자동 생성 파일은 필요한 경우가 아니면 직접 수정하지 않는다.
- 권한 태그, bundle id, package name처럼 오타가 치명적인 값은 공식 이름을 확인한다.

## 18. 코드 포맷과 lint

자동 포맷과 lint를 기준으로 삼는다.

### 원칙

- 팀에서 정한 formatter를 사용한다.
- 저장 전 또는 커밋 전 format을 실행한다.
- lint 경고는 가능한 한 남기지 않는다.
- lint를 끌 때는 파일 전체보다 가장 좁은 범위에 적용하고 이유를 남긴다.
- 줄바꿈, 들여쓰기, trailing comma 같은 스타일은 개인 취향보다 formatter에 맡긴다.

## 19. 커밋 전 체크리스트

- 새 파일이 올바른 폴더에 있는가?
- 화면 코드에 API 상세 구현이 섞이지 않았는가?
- 모델에 UI 의존성이 들어가지 않았는가?
- async 이후 UI 조작 전에 mounted 확인이 필요한가?
- controller, subscription, timer, animation 같은 리소스를 dispose 했는가?
- 사용자 메시지와 debug 로그가 적절히 분리되었는가?
- 하드코딩된 route, endpoint, 색상, 반복 문자열이 불필요하게 늘지 않았는가?
- formatter와 lint를 실행했는가?
- 새 구조가 다른 프로젝트에도 설명 가능한 일반 규칙인가?

## 20. 언어가 바뀌어도 유지할 습관

- Entry point는 얇게 둔다.
- Routing과 navigation table은 중앙화한다.
- Theme 또는 design token은 중앙화한다.
- External I/O는 service 계층으로 격리한다.
- Data shape은 model 계층으로 격리한다.
- Shared UI는 common/components로 분리한다.
- Feature-only UI는 feature 폴더 안에 둔다.
- Async flow는 validation, request, failure, success 순서로 읽히게 한다.
- Disposable resource는 만든 곳에서 정리한다.
- Error는 사용자 메시지와 개발자 로그를 분리한다.
- Magic string과 magic number는 반복되는 순간 이름을 붙인다.
