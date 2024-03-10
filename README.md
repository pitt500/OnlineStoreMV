# OnlineStore made with SwiftUI (Vanilla) and Observation

## Motivation

Since I began using SwiftUI in 2019, there has been ongoing debate about what should be considered the "official" architecture or pattern for starting projects with it. This concern is understandable, as many developers transitioned from the imperative paradigm of UIKit to a declarative approach that fundamentally alters how we design and implement our applications.

Over time, the community has largely adopted MVVM as the "go-to" pattern/architecture for working in SwiftUI. However, this approach is not without its issues right off the bat:

1. View Models are closely tied to views, which can lead to the "massive view model" problem if not carefully managed.
2. View Models necessitate the use of `ObservableObjects`, often sidelining `@State` and `@Binding` in many scenarios.
3. View models face compatibility issues with `@Environment` and `@EnvironmentObject`, both of which are cornerstones of the SwiftUI framework.
4. View models often become a requirement as a means to facilitate testing of view logic and to prevent the emergence of "Smart Views" — views laden with logic and operations, complicating unit testing.
5. MVVM is not a "silver bullet"; it won't suit many problems out there. Assuming a "default" pattern/architecture merely for the sake of it is not a prudent approach to problem-solving. These issues and more have motivated the community to explore other approaches, such as [TCA](https://github.com/pointfreeco/swift-composable-architecture).


This raises the question: **Are View Models truly necessary in SwiftUI?**

According to a [post](https://forums.developer.apple.com/forums/thread/699003), the answer is not necessarily. It's entirely feasible to develop applications in SwiftUI without relying on view models. To demonstrate this, I've developed the OnlineStore app from scratch using only the SwiftUI framework, bypassing the need for any view models. This approach has informally been dubbed "Model-View" (MV).

> The original implementation of OnlineStore utilized The Composable Architecture (TCA). For more details about TCA, visit this [repo](https://github.com/pitt500/OnlineStoreTCA).

Now, I anticipate some of you might be wondering:
- "But what about incorporating logic into views?"
- "How do we approach testing without View Models?"
- "Does the MV pattern adhere to SOLID principles?"

No need to worry; continue reading, and we will address all these points 😉!

> I've referred to MV and MVVM as a pattern/architecture above because it depends on whom you ask; you may receive one answer or another. For simplicity, from now on, I will refer to MV and MVVM as a pattern.

## MV Pattern
TBD

## MV vs MVVM
TBD

## MV vs TCA
TBD

## Wrap up
TBD
