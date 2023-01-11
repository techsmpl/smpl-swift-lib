public class ImageLoaderService: ObservableObject {
    @Published var image: UIImage = UIImage()
    func loadImage(for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
			print("Starting Task");
			guard let data:Data = data else { return }
            DispatchQueue.main.async {
				print("Recevied task");
				print(data)
				self.image = UIImage(data: data) ?? UIImage()
				print(self.image)
            }
        }
        task.resume()
    }
    
}
