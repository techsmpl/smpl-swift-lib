//
//  SwiftUIView.swift
//  Alamofire
//
//  Created by CanGokceaslan on 22.11.2022.
//

import SwiftUI;

struct TestPopupViewSmpl: View {
    @State private var showScreen: Bool = true;
    @State private var showAlert: Bool = false;
    @ObservedObject private var state = ObservableState(store: mainStore);
    var body: some View {
        VStack{
            Text("hi")
            
            ZStack{
                Text("Test")
            }
            .sheet(isPresented: $showScreen,
				   content: {
				Button("Close"){
					mainStore.dispatch(CounterActionIncrease())
					//showScreen.toggle()
					mainStore.dispatch(AddViews(payload: [["test":1]]))
					print(state.current.views)
				}
                ZStack{
                    Color.white.edgesIgnoringSafeArea(.all)
                Button("Close"){
                    mainStore.dispatch(CounterActionIncrease())
                    //showScreen.toggle()
                    mainStore.dispatch(AddViews(payload: [["test":1]]))
                    print(state.current.views)
                }
                VStack{
                    Text("Can Uygulamaya Hoşgeldin");
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.");
                    Text(String(state.current.counter))
                    Text(String(state.current.counter))

                    Button("Close"){
                        showScreen.toggle()
                    }
                }
                }
                /* PopupUIViewControllerRepresentable(
                    labelText: "Hello, world",
                    text: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                    stateBool: true
                ) */
            })
        }
    }
}

struct TestPopupView_Previews: PreviewProvider {
    static var previews: some View {
        TestPopupViewSmpl()
    }
}
