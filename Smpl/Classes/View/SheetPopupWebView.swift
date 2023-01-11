import SwiftUI

public struct SheetPopupWebView: View {
	@Binding var isPresented: Bool;
	@Binding var data: NSDictionary;
	
	
	
	@ViewBuilder
	public var body: some View {
		// Presentation Detents works after iOS 16
		if #available(iOS 16, *) {
			ZStack{EmptyView()}.sheet(isPresented: $isPresented,
									  content: {
				SwiftUIWebView(data:data).presentationDetents((data["variation"] as? String) == "medium" ? [.medium]: [.large])
			})
		} else {
			ZStack{EmptyView()}.sheet(isPresented: $isPresented,
									  content: {
				SwiftUIWebView(data:data)
			})
		}
		
	}
}

struct SheetPopupWebView_Previews: PreviewProvider {
	static var previews: some View {
		SheetPopupWebView(
			isPresented: .constant(true),
			data: .constant(["type":"Test"])
		)
	}
}
