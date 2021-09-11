//
//  CustomView.swift
//  GameCatalogue
//
//  Created by Rasyid Ridla on 10/9/21.
//

import SwiftUI
import Lottie


//komponen indicator
struct Indicator : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let indi = UIActivityIndicatorView(style: .large)
        indi.color = UIColor.green
        return indi
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        uiView.startAnimating()
    }
}

//loading
struct LoadingAnim : View {
    @Environment(\.colorScheme) var colorScheme
    var body : some View {
        if colorScheme == .dark {
            VStack{
                Indicator()
                Text("loading..")
            }.padding()
            .background(Color.black)
            .cornerRadius(20)
            .shadow(color: Color.secondary, radius: 10)
        }else{
            VStack{
                Indicator()
                Text("loading..")
            }.padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.secondary, radius: 10)
            
        }
    }
}

//lootieView
struct LootieView: UIViewRepresentable {
    typealias UIViewType = UIView
    var fileName : String
    
    func makeUIView(context: UIViewRepresentableContext<LootieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation = Animation.named(fileName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([animationView.widthAnchor.constraint(equalTo: view.widthAnchor), animationView.heightAnchor.constraint(equalTo: view.heightAnchor)])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LootieView>) {
    }
}

//button reconnect
struct ReconectView : View {
    @State var message : String = ""
    @State var action : () -> Void
    
    var body: some View{
        VStack{
            LootieView(fileName: "noConnection")
                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(message)
            Button {
                action()
            } label: {
                Text("retry")
            }
        }
    }
}

//custom TabView
func customTabView(){
    let tabBarAppeareance = UITabBarAppearance()
    tabBarAppeareance.backgroundColor = .white
    UITabBar.appearance().standardAppearance = tabBarAppeareance
}

//Custom Shape
struct CustomShape : Shape {
    var corner : UIRectCorner
    var radius : CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomShape(corner: [.bottomLeft, .bottomRight], radius: 20)
    }
}
