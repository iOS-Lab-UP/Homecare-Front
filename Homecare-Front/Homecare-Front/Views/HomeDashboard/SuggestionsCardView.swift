import SwiftUI
import Alamofire

struct SuggestionsCardView: View {
    @EnvironmentObject var globalDataModel: GlobalDataModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.red]), // Colores sin opacidad
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .frame(height: 150)
                .shadow(radius: 5)
            
            HStack {
                Spacer() // Este Spacer empuja todo el contenido hacia la derecha.
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Oxxo points")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
  
                    HStack {
                        Spacer() // Centrar el contenido de HStack
                        Image(systemName: "o.circle")
                            .font(.system(size: 20))
                            .foregroundColor(.yellow)
                            .frame(width: 50, height: 50)
                        
                        Text("500")
                            .font(.system(size: 20))
                            .foregroundColor(.white.opacity(0.7))
                        
                        Spacer() // Centrar el contenido de HStack
                        
                        Text(globalDataModel.advicePrompt)
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                            .frame(width: 240, alignment: .center)
                        
                        Spacer() // Ajuste adicional para asegurar el centro
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)  // Alineación a la derecha del VStack
            }
            Spacer()
        }
        .padding(.horizontal, 16) // Aplica padding al ZStack en lugar de solo al HStack

        }
    }

struct SuggestionsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsCardView()
    }
}
