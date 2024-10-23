//
//  TermsAndConditionsView.swift
//  NewsToday
//
//  Created by Kate Kashko on 23.10.2024.
//

import SwiftUI

struct TermsAndConditionsView: View {
    var body: some View {
        ScrollView {
                   VStack(alignment: .leading, spacing: 16) {

                       Text("""

                       By using News App, you agree to these Terms & Conditions. Please discontinue using the app if you do not agree.

                       1. Acceptance of Terms
                       By accessing News App, you agree to these terms and any future updates. Continued use after changes implies acceptance.

                       2. User Conduct
                       You agree to use the app lawfully and avoid any behavior that could harm others or the app.

                       3. Disclaimer
                       News App is provided "as is." We do not guarantee its accuracy, reliability, or uninterrupted service.

                       4. Limitation of Liability
                       We are not liable for any damages arising from your use of the app.

                       5. Termination
                       We may suspend or terminate access to the app if these terms are violated.

                       6. Contact
                       For questions, email us at support@newsapp.com.
                       """)
                       .font(.body)
                       .foregroundColor(Color("GreyDarker"))
                       .padding(.bottom)
                       

                       Spacer()
                   }
                   .padding()
               }
               .navigationTitle("Terms & Conditions")
               .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TermsAndConditionsView()
}
