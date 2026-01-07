import SwiftUI
import PhotosUI

struct PhotosView: View {
    
    @Binding var path: NavigationPath
    @State private var animate: Bool = false
    @State private var selectedPhotoIndex: Int? = nil // Track which grid cell was tapped
    @State private var selectedImages: [Int: UIImage] = [:] // Store images by index
    @State private var showPictureSelectionSheet: Bool = false
    @State private var showPhotoPicker: Bool = false
    @State private var photoPickerItem: PhotosPickerItem?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            BlurredCircleBg()
            
            AuthIntroViewCircles()
            
            VStack {
                
                HStack {
                    AppBackButton(onTap: {
                        dismiss()
                    })
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                ScrollView {
                    VStack(spacing: 5) {
                        Image(.bestPhotos)
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.easeInOut, value: animate)
                            .padding(.bottom, 15)
                        
                        Text("Add your best photos")
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.easeInOut.delay(0.15), value: animate)
                            .stingerBoldFont(size: 25)
                        
                        Text("Profile pictures leads to more matches")
                            .stingerRegularFont(size: 15)
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.easeInOut.delay(0.25), value: animate)
                            .padding(.bottom, 20)
                        
                        // GRID OF PHOTO SLOTS
                        LazyVGrid(columns: .init(repeating: .init(.flexible(minimum: 100, maximum: 200)), count: 3)) {
                            ForEach(0..<6) { index in
                                BestPhotosView(selectedImage: selectedImages[index])
                                    .onTapGesture {
                                        selectedPhotoIndex = index // Remember which slot was tapped
                                        showPictureSelectionSheet = true
                                    }
                                    .opacity(animate ? 1 : 0)
                                    .scaleEffect(animate ? 1 : 0.7)
                                    .animation(.easeInOut.delay((Double(index) * 0.1) + 0.5), value: animate)
                            }
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.85)
                        
                    }
                }
                Spacer()
                PrimaryBtn(
                    onButtonPressed: {
                        // Handle continue action
                        if let firstImage = selectedImages[0] {
                            path.append(AuthRoute.verifyImageView(image: firstImage))
                        }
                    },
                    buttonLabel: "Continue"
                )
                .padding(.horizontal, 20)
                .opacity(animate ? 1 : 0)
                .scaleEffect(animate ? 1 : 0.7)
                .animation(.easeInOut.delay(1), value: animate)
                .padding(.bottom, 10)
            }
        }
        .onAppear(perform: {
            animate = true
        })
        .navigationBarBackButtonHidden()
        // SELECTION SHEET - Shows options for selecting photo
        .sheet(isPresented: $showPictureSelectionSheet) {
            VStack(spacing: 20) {
                GenderTileSelection(image: Image(.lensIcon), title: "Camera roll") {
                    showPictureSelectionSheet = false
                    showPhotoPicker = true
                }
                GenderTileSelection(image: Image(.facbookIcon), title: "Facebook") {
                    // Handle Facebook import
                    showPictureSelectionSheet = false
                }
                GenderTileSelection(image: Image(.instagramIcon), title: "Instagram") {
                    // Handle Instagram import
                    showPictureSelectionSheet = false
                }
                GenderTileSelection(image: Image(.cameraIcon), title: "Take a photo") {
                    // Handle camera
                    showPictureSelectionSheet = false
                }
            }
            .padding(.horizontal, 20)
            .presentationDetents([.fraction(0.5), .medium])
        }
        // PHOTO PICKER - Shows iOS photo library
        .photosPicker(isPresented: $showPhotoPicker, selection: $photoPickerItem, matching: .images)
        .onChange(of: photoPickerItem) { oldValue, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data),
                   let index = selectedPhotoIndex {
                    // Save the image to the correct slot
                    selectedImages[index] = uiImage
                }
            }
        }
    }
}

// UPDATED BestPhotosView to show selected image
struct BestPhotosView: View {
    let selectedImage: UIImage?
    
    var body: some View {
        ZStack {
            if let selectedImage {
                // Show the selected image
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 88, height: 88)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(Color.black, lineWidth: 1.2)
                    }
            } else {
                // Show empty circle with plus icon
                Circle()
                    .stroke(lineWidth: 1.2)
                    .fill(.black)
                    .frame(width: 88, height: 88)
                    .overlay {
                        Image(.addPlus)
                    }
            }
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    PhotosView(
        path: .constant(NavigationPath())
    )
}
