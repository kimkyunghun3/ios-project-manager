# 📑 프로젝트 관리 앱
> 프로젝트 기간: 2022-07-04 ~ 2022-07-29
> 
> 팀원: [malrang](https://github.com/malrang-malrang), [Eddy](https://github.com/kimkyunghun3)
> 
> 리뷰어: [Lucas](https://github.com/innocarpe)

## 🔎 프로젝트 소개
**업무들의 스케줄을 관리하고 싶다구요?? 프로젝트 매니저로 관리하세요 🤗**

## 📺 프로젝트 실행화면

| history 내역 | 목록 추가 | 
|:---:|:---:|
|<img src = "https://i.imgur.com/QcORGZo.gif" width="500" height="300" >|<img src = "https://i.imgur.com/CLIzu1y.gif" width="500" height="300">|

| 목록 이동 | 목록 편집 |
|:---:|:---:|
|<img src = "https://i.imgur.com/283CtT5.gif" width="500" height="300">|<img src = "https://i.imgur.com/8Y82R1L.gif" width="500" height="300">|

| 목록 삭제 | local Notification  | 
|:---:|:---:|
|<img src = "https://i.imgur.com/3jdaT0H.gif" width="500" height="300">|<img src = "https://i.imgur.com/ACd8x9K.gif" width="500" height="300">|


| Realm 저장 | 
|:---:|
|<img src = "https://i.imgur.com/CA8RWFZ.gif" width="1000" height="300">|

| firebase 동기화 | 
|:---:|
|<img src = "https://i.imgur.com/OCghVZQ.gif" width="1000" height="300">|

## 👀 PR
- [STEP 1](https://github.com/yagom-academy/ios-project-manager/pull/119)
- STEP 2
    - [STEP 2-1](https://github.com/yagom-academy/ios-project-manager/pull/127)
    - [STEP 2-2](https://github.com/yagom-academy/ios-project-manager/pull/134)
    - [STEP 2-3](https://github.com/yagom-academy/ios-project-manager/pull/140)
    - [STEP 2-4, 2-5](https://github.com/yagom-academy/ios-project-manager/pull/146)
    - [STEP 2-6, 2-7](https://github.com/yagom-academy/ios-project-manager/pull/150)
- STEP 3
    - [STEP 3-1](https://github.com/yagom-academy/ios-project-manager/pull/152)
    - [STEP 3-2](https://github.com/yagom-academy/ios-project-manager/pull/158)
    - [STEP 3-3](https://github.com/yagom-academy/ios-project-manager/pull/162)
- [STEP 4](https://github.com/yagom-academy/ios-project-manager/pull/170)

## 🛠 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.0-orange)]()[![xcode](https://img.shields.io/badge/Xcode-13.0-blue)]()[![Realm](https://img.shields.io/badge/Realm-10.2-brown)]()[![Firebase](https://img.shields.io/badge/Firebase-9.0.0-yellow)]()[![Rxswift](https://img.shields.io/badge/Rxswift-6.5-hotpink)]()

## 🔑 키워드
`Swift Package Manager` ` Realm` `Firebase` `Rxswift` `MVVM` `Popover` `Coordinator Pattern` `LongPressGesture` `Undo, Redo`

## ✨ 구현내용
[STEP 1]
- Swift Package Manager를 통해 라이브러리를 관리
- 로컬 DB로 Realm, remote DB로 Firebase 설치

[STEP 2-1, 2-2]
- TodoList 네비게이션 바 구현
- MVVM + Rxswift를 활용하여 TodoList TableView UI 구현
- 하나의 View로 status에 따라 Tableview 구분

[STEP 2-3, 2-4, 2-5]
- TodoList 생성, 편집, 삭제 기능 구현
- Popover를 통해 TodoList를 Todo, Doing, Done 이동

[STEP 2-6, 2-7]
- longPressGesture시 Popover창이 띄워지며 메뉴에 따라 원하는 Status로 가도록 구현
- 할일 목록 기한 초과시 DateLabel(TODO, DOING Status에서만)의 색상 변경 구현
 
[STEP 3-1, 3-2]
- 로컬 디스크인 Realm를 활용해 데이터를 저장, 삭제, 편집 기능 구현
- 리모트 디스크인 Firebase에 데이터 저장, 삭제, 편집 및 로컬 디스크와 동기화 기능 구현
- 네트워크 연결 유무에 따라 유저에게 알려주는 와이파이 image 구현

[STEP 3-3]
- 변경사항을 보여주는 history view 구현

[STEP 4]
- Local notification 생석, 삭제, 업데이트 기능 구현
- undo, redo 기능 구현

## 🤔 고민한점, 트러블 슈팅

### 1️⃣ 로컬DB / 원격DB 라이브러리 선택

✅ **선택한 라이브러리**
로컬DB는 `Realm`/ 원격DB는 `Firebase Realtime Database` 로 결정했다.

**🤔 하위 버전 호환성에는 문제가 없는가?**
✅ 선택한 `Firebase Realtime Database`는 iOS 10, `Realm`는 iOS 8 부터 지원한다.
[iOS 및 IPad 사용현황](https://developer.apple.com/kr/support/app-store/)을 보게되면 IPad를 사용하는 유저의 90% 이상이 iOS 14 버전 이상을 사용하는것을 알수 있었고 하위 버전 호환성에 문제가 없다고 판단했다.

<img src = "https://i.imgur.com/YXe7g8z.png" width = "200">

**🤔 안정적으로 운용 가능한가?**
✅ Realm은 MongoDB의 서비스로 대중적으로 사용되어 검증된 기술이기 때문에 안정적인 운용이 가능할것으로 판단한다.

또한 Realm은 기존의 정형화된 데이터 베이스와 다르게 NoSQL 데이터베이스를 지향하며 Realm API를 사용해 좀더 직관적인 사용이 가능하며 데이터 처리 속도가 향상된 장점이 있다.
* Realm과 다른 DataBase의 성능비교 그래프

<img src = "https://i.imgur.com/wps0N9Q.png" width = "300"><img src = "https://i.imgur.com/5RBdKIF.png" width = "370">

[자료 출처](https://hesam-kamalan.medium.com/database-benchmark-realm-vs-snappydb-f4b89711f424)

✅ Firebase는 Google의 서비스로 Realm과 같이 대중적으로 사용되어 검증된 기술이기 때문에 안정적인 운용이 가능할 것으로 판단한다.

### 2️⃣ Coordinator Pattern
프로젝트를 진행하면서 화면전환 기능을 구현했다.
ListView에서 DetailView로 화면전환을 할때의 트리거는 2개 이며 각 트리거는 tableView의 Cell을 Tap했을때, 네비게이션 컨트롤러 우측의 "+" 버튼을 Tap 했을때 DetailView로 화면전환을 하게 된다.

구조상 tableView를 소유하고 있는 ListView와 네비게이션 컨트롤러를 소유하는 TodoListViewController 모두 화면전환을 하는 기능이 필요하게되며 같은 기능이지만 각각 구현해주어야하는 문제가 발생했다.

이를 해결하기위해 Coordinator Pattern을 활용하여 화면전환 역할을 담당하는 AppCoordinator를 구현하였고 구조는 아래의 그림과 같다.

<img src="https://i.imgur.com/hoZY3g2.png" width="400">
<img src="https://i.imgur.com/VJDXp4y.png" width="401">

ListView, TodoListViewController는 화면전환을 필요로 하게되면 AppCoordinator에게 화면을 전환해달라고 요청하는 방식으로 화면을 전환할수 있도록 구현하였.

AppCoordinator를 구현함으로써 화면을 전환하는 기능의 중복코드 문제를 개선할수 있었고 추상화를 통해 View는 화면을 어떻게 보여줄것인지만을 정의할수있게 되었다.

### 3️⃣ Reactive longPress ControlEvent 구현
tableView의 Cell을 longPress 할경우 Popover view를 보여주는 기능을 구현하기위해 tableView에 longPress Gesture를 추가 해주어야 했다.

RxSwift 라이브러리를 사용하고 있기에 RxGesture 라이브러리를 추가 하여 longPress ControlEvent 를 사용할수도 있었지만 RxGesture라이브러리의 longPress Gesture를 사용하더라도 longPress한 Cell의 데이터를 활용하기 위해서는 세부 로직을 구현해주어야하는 문제가 발생했다.

그렇다면 RxGesture 라이브러리를 추가하는것이 아닌 이번 프로젝트에서 좀더 쉽게 활용할 수 있도록 Reactive를 extension 하여 longPress ControlEvent를 구현하였다.

```swift
extension Reactive where Base: UITableView {
    func modelLongPressed<T>(_ modelType: T.Type) -> ControlEvent<(UITableViewCell, T)> {
        let longPressGesture = UILongPressGestureRecognizer(target: nil, action: nil)
        
        base.addGestureRecognizer(longPressGesture)
        let source = longPressGesture.rx.event
            .filter { $0.state == .began }
            .map { base.indexPathForRow(at: $0.location(in: base)) }
            .flatMap { [weak tableView = base as UITableView] indexPath -> Observable<(UITableViewCell, T)> in
                guard let tableView = tableView,
                      let indexPath = indexPath,
                      let cell = tableView.cellForRow(at: indexPath) else { return Observable.empty() }
                return Observable.zip(
                    Observable.just(cell),
                    Observable.just(try tableView.rx.model(at: indexPath))
                )
            }
        return ControlEvent(events: source)
    }
}
```
RxSwift tableView.rx의 modelselected, modelDeleted와 유사하게 사용할수 있도록 네이밍에 model을 키워드를 추가해주었다.

tableView의 modelLongPressed 이벤트가 감지될경우 어떤위치의 Cell인지 알수있도록 하고 어떤 데이터를 가지고 있는지 알수 있도록 외부에 전달 하도록 구현했다.

하지만 위와같이 구현했을때 기존에 구현해 두었던 tableView의 tap 이벤트가 감지되지 않는 문제가 발생했다.
tap, modelLongPressed 둘중 어떤 이벤트를 감지할지 알수 없게 된것이다.
문제를 해결하기 위해 ControlEvent에 우선순위를 설정할수 있을까? 고민하였고 modelLongPressed 이벤트 내부의 UILongPressGestureRecognizer 속성중 minimumPressDuration 을 활용하여 문제를 해결했다.

```swift
 let longPressGesture: UILongPressGestureRecognizer = {
            let gesture = UILongPressGestureRecognizer(target: nil, action: nil)
            gesture.minimumPressDuration = 0.5
            return gesture
        }()
```
0.5초 이상 longPress 했을 경우에 인식되도록 수정하였다.

### 4️⃣ DataManager를 활용하여 추상화 구현
DataManager에서 Local Database, Remote Database를 관리할 수 있도록 구현한다.

<img src ="https://i.imgur.com/Lm8A4EW.png" width="350">

DataManager를 사용하면 새로운 Database가 오더라도 이곳에서 관리하고 CRUD를 실행시키면 되기 때문에 최소한의 변경으로 구현이 가능해진다.

프토로콜을 통해 필요 기능들을 정의해두고 구현을 내부에서 해주는 방식으로 추상화했다.
```swift
protocol DatabaseManagerProtocol {
    var todoListBehaviorRelay: BehaviorRelay<[Todo]> { get }
    var historyBehaviorRelay: BehaviorRelay<[History]> { get }

    func create(todoData: Todo)
    func update(selectedTodo: Todo)
    func delete(todoID: UUID)
    func isConnected() -> Observable<Bool>
    func isHistoryEmpty() -> Observable<Bool>
    func deleteHistory()
}

final class DatabaseManager: DatabaseManagerProtocol {
        // 실제 구현이 이루어지는 곳
    let todoListBehaviorRelay = BehaviorRelay<[Todo]>(value: [])
    let historyBehaviorRelay = BehaviorRelay<[History]>(value: [])

    private let realm = RealmDatabase()
    private let firebase = FirebaseDatabase()
}
```

### 5️⃣ 로컬 디스크와 리모트 디스크 동기화 기능 구현
로컬 디스크에 저장된 데이터를 리모트 디스크에 동기화 하는 기능을 추가하기 위해서 규칙을 세워야 한다고 생각했다.
로직을 잘못 구현하거나 동기화 방식이 적절하지 않는 경우 로컬 디스크 혹은 리모트 디스크의 데이터가 소실될 위험이 있을것이라 생각했다.

데이터가 소실되지 않도록 동기화 기능을 구현하기위해 로컬 디스크, 리모트 디스크 둘 중 어떤 것을 프로젝트의 메인 디스크로 사용할 것인지 고민하고 네트워크가 연결되지 않는 상황을 고려하여 로컬디스크를 메인 디스크로 사용하도록 했다.

로컬 디스크의 데이터를 리모트 디스크와 동기화 기능을 수행하는 시점은 아래와 같다.
- 앱 실행 시 리모트 디스크와 동기화하도록 한다.
- 앱 실행 중에 로컬 디스크 CRUD 기능 동작 시 리모트 디스크와 실시간 동기화하도록 한다.

동기화 기능은 아래와 같은 방식으로 이루어진다.
RealmDatabase에서 데이터의 변화가 감지되면 이를 감지하고 있던 dataBehaviorRelay의 스트림을 활용해서 이를 구독하고 있는 DatabaseManager에서 각각의 CRUDType에 따라 firebase에서 동기화하도록 기능을 구현했다.

```swift
// RealDatabase.swift
enum CRUDType {
    case create(at: Todo)
    case update(at: Todo)
    case delete(at: UUID)
    case read(at: [Todo])
}

let dataBehaviorRelay = BehaviorRelay<CRUDType>(value: .read(at: []))

func create(todoData: Todo) {
    try? self.realm?.write { [weak self] in
        self?.realm?.add(todoData.todoDTO())
    }
    self.dataBehaviorRelay.accept(.create(at: todoData))
}
```

```swift
// DatabaseManager.swift
private func bind() {
    self.realm.dataBehaviorRelay.subscribe(onNext: { CRUDType in
        switch CRUDType {
        case .create(at: let todoData):
            self.firebase.create(todoData: todoData)
        case .update(at: let selectedTodoData):
            self.firebase.update(selectedTodo: selectedTodoData)
        case .delete(at: let selectedTodoData):
            self.firebase.delete(todoID: selectedTodoData)
        case .read(at: let todoDataList):
            self.firebase.sync(todoData: todoDataList)
            self.todoListBehaviorRelay.accept(todoDataList)
        }
    })
    .disposed(by: self.disposeBag)
}

```
### 6️⃣ Local Notification
NotificationManager에서 local notification 관련 로직을 모두 관리하게 되었다.

마감기한 당일 오전 9시에 사용자에게 Notficiation이 전달되도록 구현했다.
```swift
// NotificationManager.swift
func setNotification(todoData: Todo) {
    // 생략
    
    var todoDateComponent = Calendar.current.dateComponents([.year, .month, .day], from: todoData.date)
    todoDateComponent.hour = 9

    let trigger = UNCalendarNotificationTrigger(dateMatching: todoDateComponent, repeats: false)
    let request = UNNotificationRequest(
        identifier: todoData.identifier.uuidString,
        content: content,
        trigger: trigger
    )
    self.notificationCenter.add(request)
}

```

그리고 삭제는 identifer를 확인하여 해당 notification을 제거할수 있도록 구현했다.
```swift
func deleteNotification(todoIdentifier: String) {
    self.notificationCenter.removePendingNotificationRequests(withIdentifiers: [todoIdentifier])
}
```

업데이트는 done status에서는 울리지 않아야 하므로 done이면 notification을 지우고 그게 아니라면 해당하는 notification를 업데이트해주도록 한다.
```swift
func updateNotification(todoData: Todo) {
    guard todoData.todoListItemStatus != .done else {
        return deleteNotification(todoIdentifier: todoData.identifier.uuidString)
    }
    self.setNotification(todoData: todoData)
}
```

사용 되는 시점은 유저가 목록을 만들 때, listView인 첫 화면 시점에 권한 획득을 위해 사용했으며 실제 Notification는 background 진입 시 되도록 설계했다.


### 7️⃣ Undo, Redo 기능
Swift에 기본적으로 제공되는 UndoManager를 사용할수도 있었지만 직접 기능을 구현해보고싶었다.
팀원과 상의 끝에 구현하고자 했던 Undo, Redo 기능은 다음과 같다.
1. History 내역이 존재할경우 HistoryButton, UndoButton이 활성화 된다. 내역이 존재하지 않는다면 비활성화 된다.
2. Undo내역이 존재할경우 RedoButton이 활성화 된다. 내역이 존재하지 않는다면 비활성화 된다.
3. 앱을 재실행할경우 기존의 History내역이 모두 제거된다.

기능을 구현하기위해 undo, redo의 버튼을 감지하는 relay를 만들고 어떤데이터를 undo, redo 해야 하는지 알기위해 undoDataStack, redoDataStack을 만들어두었다.

```swift
final class UndoRedoManager {
    let undoRelay = PublishRelay<Void>()
    let redoRelay = PublishRelay<Void>()

    private var undoDataStack: [History] = []
    private var redoDataStack: [History] = []
}
```

undo Button을 Tap할 경우 undoDataStack의 마지막 데이터를 redoDataStack에 넣어주고 되돌리기(Undo)기능을 수행한 뒤 마지막 데이터를 제거한다.

redo Button을 Tap 할경우 redoDataStack의 마지막 데이터를 확인해 Redo(되돌리기 취소)기능을 수행한 뒤 마지막 내역을 제거한다.

undo, redo의 행동은 history의 삭제, 이동, 추가, 편집 등 내역에 따라 각각 다르게 정의내려야 하므로 switch 구문을 사용해 대응해주었다.

그리고 history에 값이 변하는 것을 감지하는 database에 있는 historyBehaviorRelay를 통해 값의 변화가 생길 때마다 undoDataStack에 대입해주었다.

```swift
self.undoRelay
    .subscribe(onNext: { [weak self] _ in
        guard let lastHistory = self?.undoDataStack.removeLast() else { return }
        self?.undoRedoActionAble.undoTapEvent(history: lastHistory)
        self?.redoDataStack.append(lastHistory)
    })
    .disposed(by: self.disposeBag)

self.redoRelay
    .subscribe(onNext: { [weak self] _ in
        guard let lastHistory = self?.redoDataStack.removeLast() else { return }
        self?.undoRedoActionAble.redoTapEvent(history: lastHistory)
    })
    .disposed(by: self.disposeBag)
```

그리고 redoButton 활성화 관련해서 isRedoEmpty() 메서드를 통해 undoRelay, redoRelay를 통합적으로 관리하여 만약 redoDataStack에 아무것도 없다면 false를 옵저버로 보내고 그게 아니면 true를 보내도록 구현했다.
```swift
func isRedoEmpty() -> Observable<Bool> {
    return Observable.create { observer in
        let _ = Observable.of(self.undoRelay, self.redoRelay)
            .merge()
            .subscribe(onNext: { [weak self] _ in
                if self?.redoDataStack.count == 0 {
                    observer.onNext(false)
                } else {
                    observer.onNext(true)
                }
            })
        return Disposables.create()
    }
}
```

이를 ViewModel에서 결과적으로 처리할 수 있도록 하여 역할과 책임분리를 했다.

결론적으로 viewModel에서 Driver로 변경하고 이를 View에서 사용하여 변화에 감지하여 active, inactive가 되도록 구현했다.

```swift
// TodoListViewModel.swift
self.isRedoEmpty = self.undoRedoManager.isRedoEmpty()
    .asDriver(onErrorJustReturn: false)

// TodoListViewController.swift
self.viewModel.isRedoEmpty
    .drive(onNext: { [weak self] isRedo in
        self?.isRedoButtonActive(isRedoEmpty: isRedo)
    })
    .disposed(by: self.disposeBag)
```
