import SwiftUI
import Alamofire

struct SuggestionsCardView: View {
    @EnvironmentObject var globalDataModel: GlobalDataModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.red]),
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .frame(height: 150)
                .shadow(radius: 5)
            
            HStack {
                Image("Logo_oxxo")  // Asegúrate de que el nombre coincida exactamente con el que está en Assets
                    .resizable()  // Hace que la imagen pueda cambiar de tamaño
                    .aspectRatio(contentMode: .fit)  // Mantiene la proporción de la imagen mientras se ajusta al espacio disponible
                    .frame(width: 70, height: 70)  // Define el tamaño de la imagen
                    .foregroundColor(.white)  // Este modificador no afectará a las imágenes de Assets, sólo a SF Symbols
                    .padding(.leading, 16)  // Añade padding al lado izquierdo
    // Espacio desde el borde izquierdo

                Spacer()  // Este Spacer separa la imagen del texto
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Oxxo points")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)  // Añade padding en la parte superior

                    Spacer()

                    HStack {
                        Image(systemName: "o.circle")  // Icono "O" al lado de "500"
                            .font(.system(size: 20))    // Tamaño del icono
                            .foregroundColor(.white)    // Color del icono
                        Text("500")
                            .font(.system(size: 25))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    
                    Text(globalDataModel.advicePrompt)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                        .frame(width: 240, alignment: .center)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)  // Asegura que el VStack esté alineado a la derecha
                
                Spacer()  // Ajuste adicional para asegurar el espacio
            }
            .padding(.horizontal, 16)  // Espacio uniforme en los lados del HStack
        }
        .padding()  // Añade padding alrededor del ZStack para evitar que se pegue a los bordes
    }
}

struct SuggestionsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsCardView()
    }
}
