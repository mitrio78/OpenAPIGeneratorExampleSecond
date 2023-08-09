//
//  ContentView.swift
//  OpenAPIGeneratorExample
//
//  Created by anduser on 30.07.2023.
//

import MediaStackAPI
import SwiftUI

// MARK: - ContentView

struct ContentView: View {

    // MARK: - Properties

    @StateObject var viewModel: ViewModel = ViewModel()

    // MARK: - Body

    var body: some View {
        List {
            ForEach(viewModel.news) { item in
                VStack {
                    HStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)

                        VStack(alignment: .leading) {
                            Text(item.title ?? "")
                            Text(item.description ?? "")
                        }
                        .padding()
                    } //: HStack
                } //: VStack
                .padding()
            } //: Repeat
        } //: List
        .onAppear {
            viewModel.fetchNews()
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension NewsListDataInner: Identifiable {
    public var id: String { url! }
}

// MARK: - ViewModel

final class ViewModel: ObservableObject {

    @Published var news: [NewsListDataInner] = []

    let apiKey = "f556071334fe2d67eff332fe872b384f"

    func fetchNews() {
        ArticlesAPI.everythingGet(accessKey: apiKey, apiResponseQueue: .main) { [weak self] newsList, error in
            guard let newsList = newsList else {
                return
            }

            self?.news = newsList.data
        }
    }
}

// MARK: - News

struct News: Hashable {

    let title: String
    let description: String
}
