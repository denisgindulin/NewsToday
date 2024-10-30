//
//  OnboardingView.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 29.10.2024.
//

import SwiftUI

struct OnboardingView: View {
    @State private var isCardTapped = false
    @State private var currentCardIndex = -(OnboardingItem.onboardingItems.count / 2) // ряд карточек отцентрирован и, чтобы показать первую карточку, устанавливаю отрицательное значение индекса
    
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { outerView in
            HStack(spacing: 0) {
                ForEach(OnboardingItem.onboardingItems.indices, id: \.self) { index in
                    GeometryReader { innerView in
                        OnboardingCard(imageName: OnboardingItem.onboardingItems[index].image)
                            .shadow(color: .black, radius: 10, x: 0, y: 5)
                        
                    }
                    .opacity(currentCardIndex + (OnboardingItem.onboardingItems.count / 2) == index ? 1.0 : 0.5)
                    .frame(
                        width: outerView.size.width * 0.8,
                        height: outerView.size.height * 0.8
                    )
                    .scaleEffect(currentCardIndex + (OnboardingItem.onboardingItems.count / 2) == index ? CGSize(width: 1, height: 1) : CGSize(width: 0.9, height: 0.9))
                }
            }
            .frame(width: outerView.size.width, height: outerView.size.height, alignment: .center) // выравнивание ряда карточек сделано по центру, чтобы получилось  для каждой текущей карточки показать соседние карточки с обеих сторон
            .offset(x: (-CGFloat(currentCardIndex) * (outerView.size.width * 0.8)))
            .gesture(
                !isCardTapped // жест
                ? DragGesture()
                    .updating($dragOffset, body: { value, state, transaction in
                        state = value.translation.width
                    })
                    .onEnded({ value in
                        let threshold = outerView.size.width * 0.4 // свайп считается совершившимся, если длина горизонтального смахивания достигнет 40 процентов от ширины представления, являющегося родительским для карточки
                        var newIndex = Int(-value.translation.width / threshold) + currentCardIndex
                        newIndex = min(max(newIndex, -(OnboardingItem.onboardingItems.count / 2)), (OnboardingItem.onboardingItems.count / 2)) // проверка остается ли новый индекс в диапазоне индексов массива карточек (с поправкой на то, что нумерация индексов смещена для центрирования карточного ряда: т.е. от -Х до Х)
                        currentCardIndex = newIndex
                        print("currentCardIndex = \(currentCardIndex); index = \(newIndex)")
                    })
                : nil
            )
        }
        .animation(.interpolatingSpring(stiffness: 100, damping: 10), value: dragOffset) // аналог для iOS15 анимации .interpolatingSpring(.bouncy), которая есть в iOS17+
        
        // индикатор текущей карточки в карточном ряду
        HStack {
            ForEach(0..<OnboardingItem.onboardingItems.count, id: \.self) { index in
                if index == currentCardIndex + (OnboardingItem.onboardingItems.count / 2) {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 30, height: 10)
                        .foregroundStyle(.red)
                } else {
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(.gray)
                }
            }
        }
        .animation(.interpolatingSpring(stiffness: 150, damping: 7), value: dragOffset)
        
        // заголовок для текущей карточки
        Text(OnboardingItem.onboardingItems[currentCardIndex + (OnboardingItem.onboardingItems.count / 2)].title)
            .font(.title)
            .padding()
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.5)
        
        // описание для текущей карточки
        Text(OnboardingItem.onboardingItems[currentCardIndex + (OnboardingItem.onboardingItems.count / 2)].description)
            .font(.headline)
            .padding()
        
        // кнопка "Next" для перехода к следующей карточке в ряду (или "Get Started" для перехода на другой экран, если карточка последняя)
        Button(
            action: {
                if currentCardIndex < (OnboardingItem.onboardingItems.count / 2) {
                    withAnimation(.interpolatingSpring(stiffness: 50, damping: 7)) {
                        currentCardIndex += 1
                    }
                } else {
                    // TODO: здесь добавить переход на другой экран
                    print("Navigate to other View")
                }
            },
            label: {
                ZStack {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    Text(currentCardIndex < (OnboardingItem.onboardingItems.count / 2)
                         ? "Next"
                         : "Get Started")
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
                }
            }
        )
        .padding()
        
    }
}

#Preview {
    OnboardingView()
}
