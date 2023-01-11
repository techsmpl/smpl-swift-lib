import SwiftUI

public struct SheetPopupView: View {
	@Binding var isPresented: Bool;
	@Binding var data: NSDictionary;

	
	public var body: some View {
		ZStack{EmptyView()}.sheet(isPresented: $isPresented,
								  content: {
			VStack() {
				Button(action: {
					isPresented = false;
					mainStore.dispatch(RemoveView(payload:data))
				}) {
					Image(systemName: "xmark.circle")
						.padding(10)
				}
				//CustomImageView(urlString: "https://images.deliveryhero.io/image/foodpanda/home-yemeksepeti-apps.png")
				//CustomImageView(urlString:"https://upload.wikimedia.org/wikipedia/commons/3/3a/Cat03.jpg");
				CustomImageView(urlString: data["image"] as! String) // This is where you extract urlString from Model ( transaction.imageUrl)
				
				Text(data["title"] as! String)
					.foregroundColor(.black)
					.font(.system(size: 24))
					.padding(.top, 12)
				
				Text(data["description"] as! String)
					.foregroundColor(.black)
					.font(.system(size: 16))
					.opacity(0.6)
					.multilineTextAlignment(.center)
					.padding(.bottom, 20)
				
				Button("Thanks") {
					isPresented = false
					mainStore.dispatch(RemoveView(payload:data))
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
						// Put your code here that you want to execute after delay
						if(data["type"] as? String != "nil"){
							isPresented = true
						}
					}
					
				}
				.buttonStyle(.plain)
				.font(.system(size: 18, weight: .bold))
				.frame(maxWidth: .infinity)
				.padding(.vertical, 18)
				.padding(.horizontal, 24)
				.foregroundColor(.red)
				.background(Color("9265F8"))
				.cornerRadius(12)
			}
			.padding(EdgeInsets(top: 37, leading: 24, bottom: 40, trailing: 24))
			.background(Color.white.cornerRadius(20))
			.padding(.horizontal, 40)
		})
		
	}
}

struct SheetPopupView_Previews: PreviewProvider {
	static var previews: some View {
		SheetPopupView(
			isPresented: .constant(true),
			data: .constant(["type":"Test"])
		)
	}
}
