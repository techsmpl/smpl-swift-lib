import SwiftUI

extension String {
	func load()-> UIImage{
		do {
			guard let url: URL = URL(string: self) else {
				return UIImage()
			}
			let data: Data = try Data(contentsOf: url)
			//print(UIImage(data:data) ?? UIImage())
			return UIImage(data:data) ?? UIImage()
		}catch{
			
		}
		return UIImage()
	}
}

struct CustomImageView: View {
    var urlString: String
    //@ObservedObject var imageLoader = ImageLoaderService()
	@State var image: UIImage = UIImage()
    var body: some View {
		Image(uiImage: urlString.load())
            .resizable()
			.aspectRatio(contentMode: .fill)
            .frame(width:150, height:250)
            
    }
}

struct PopupView: View {
	@Binding var isPresented: Bool;
	@Binding var data: NSDictionary;
	var body: some View {
		VStack(spacing: 12) {
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
				isPresented = false;
				mainStore.dispatch(RemoveView(payload:data))
				if(data["type"] as? String != "nil"){
					isPresented = true
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
	}
}

struct Popups_Previews: PreviewProvider {
	static var previews: some View {
		PopupView(
			isPresented: .constant(true),
			data: .constant(["type":"Test"])
		)
	}
}
