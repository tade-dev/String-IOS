import SwiftUI

struct CustomCalendarView: View {
    // MARK: - State Properties
    @State private var currentDate: Date = Date()
    @State private var selectedDay: Int? = Calendar.current.component(.day, from: Date())
    @State private var currentPage: Int = 1 // Start at middle page
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    
    @Binding var selectedData: String
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Constants & Colors
    let brandYellow = Color(red: 1.0, green: 0.85, blue: 0.0)
    let paleYellow = Color(red: 1.0, green: 0.95, blue: 0.6)
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    let yearRange = Array(1950...Calendar.current.component(.year, from: Date()))
    
    var body: some View {
        VStack(spacing: 20) {
            
            // 1. Header (Chevron, Year, Month, Chevron)
            HStack {
                Button(action: { moveToMonth(offset: -1) }) {
                    Image(systemName: "chevron.left")
                        .font(.title2.bold())
                        .foregroundColor(.black)
                        .padding(10)
                }
                
                Spacer()
                
                Menu {
                    Picker("Year", selection: $selectedYear) {
                        ForEach(yearRange, id: \.self) { year in
                            Text(String(year))
                                .tag(year)
                        }
                    }
                    .onChange(of: selectedYear) { oldValue, newValue in
                        jumpToYear(newValue)
                    }
                } label: {
                    VStack(spacing: 2) {
                        Text(yearString)
                            .font(.system(size: 25, weight: .heavy, design: .rounded))
                            .foregroundColor(brandYellow)
                        
                        Text(monthString)
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .foregroundColor(brandYellow)
                    }
                    .id(currentDate)
                    .animation(.easeInOut(duration: 0.2), value: currentDate)
                }
                
                Spacer()
                
                Button(action: { moveToMonth(offset: 1) }) {
                    Image(systemName: "chevron.right")
                        .font(.title2.bold())
                        .foregroundColor(.black)
                        .padding(10)
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
            .padding(.bottom, 10)
            
            // 2. Scrollable Calendar Grid using TabView
            TabView(selection: $currentPage) {
                // Previous month
                CalendarGridView(
                    date: dateForOffset(-1),
                    selectedDay: $selectedDay,
                    columns: columns,
                    brandYellow: brandYellow,
                    paleYellow: paleYellow,
                    isCurrentMonth: false
                )
                .tag(0)
                
                // Current month
                CalendarGridView(
                    date: currentDate,
                    selectedDay: $selectedDay,
                    columns: columns,
                    brandYellow: brandYellow,
                    paleYellow: paleYellow,
                    isCurrentMonth: true
                )
                .tag(1)
                
                // Next month
                CalendarGridView(
                    date: dateForOffset(1),
                    selectedDay: $selectedDay,
                    columns: columns,
                    brandYellow: brandYellow,
                    paleYellow: paleYellow,
                    isCurrentMonth: false
                )
                .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 290)
            .onChange(of: currentPage) { oldValue, newValue in
                handlePageChange(from: oldValue, to: newValue)
            }
            
            Spacer()
            
            // 3. Save Button
            PrimaryBtn(
                onButtonPressed: {
                    saveDate()
                },
                buttonLabel: "Save"
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .padding(.top, 20)
    }
    
    // MARK: - Helper Functions
    var yearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: currentDate)
    }
    
    var monthString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: currentDate)
    }
    
    func dateForOffset(_ offset: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: offset, to: currentDate) ?? currentDate
    }
    
    func handlePageChange(from oldValue: Int, to newValue: Int) {
        if newValue == 0 {
            // Swiped to previous month
            currentDate = dateForOffset(-1)
            selectedDay = nil
            // Reset to middle page without animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                currentPage = 1
            }
        } else if newValue == 2 {
            // Swiped to next month
            currentDate = dateForOffset(1)
            selectedDay = nil
            // Reset to middle page without animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                currentPage = 1
            }
        }
    }
    
    func moveToMonth(offset: Int) {
        withAnimation(.easeInOut(duration: 0.3)) {
            if offset > 0 {
                currentPage = 2
            } else {
                currentPage = 0
            }
        }
    }
    
    func saveDate() {
        if let day = selectedDay {
            var components = Calendar.current.dateComponents([.year, .month], from: currentDate)
            components.day = day
            
            if let finalDate = Calendar.current.date(from: components) {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy"
                let result = formatter.string(from: finalDate)
                selectedData = result
                dismiss()
            }
        }
    }
    
    func jumpToYear(_ year: Int) {
        var components = Calendar.current.dateComponents([.month, .day], from: currentDate)
        components.year = year
        
        if let newDate = Calendar.current.date(from: components) {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentDate = newDate
            }
            selectedDay = nil
            currentPage = 1
        }
    }
}

// MARK: - Calendar Grid View
struct CalendarGridView: View {
    let date: Date
    @Binding var selectedDay: Int?
    let columns: [GridItem]
    let brandYellow: Color
    let paleYellow: Color
    let isCurrentMonth: Bool
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(daysInMonth(), id: \.self) { day in
                DayCell(
                    day: day,
                    isSelected: isCurrentMonth && selectedDay == day,
                    brandYellow: brandYellow,
                    paleYellow: paleYellow
                )
                .onTapGesture {
                    if isCurrentMonth {
                        selectedDay = day
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    func daysInMonth() -> [Int] {
        let range = Calendar.current.range(of: .day, in: .month, for: date)!
        return Array(range)
    }
}

// MARK: - Day Cell
struct DayCell: View {
    let day: Int
    let isSelected: Bool
    let brandYellow: Color
    let paleYellow: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.black, lineWidth: 1.5)
                .background(
                    Circle()
                        .fill(isSelected ? paleYellow : Color.clear)
                )
            
            Text("\(day)")
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .foregroundColor(.black)
        }
        .frame(height: 40)
        .contentShape(Circle())
    }
}


// MARK: - Year Picker View
struct YearPickerView: View {
    @Binding var selectedYear: Int
    let brandYellow: Color
    let onYearSelected: (Int) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    // Generate a range of years (e.g., 1900 to 2100)
    let yearRange = Array(1900...2100)
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Text("Select Year")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(brandYellow)
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            // Menu Picker
            Menu {
                Picker("Year", selection: $selectedYear) {
                    ForEach(yearRange, id: \.self) { year in
                        Text("\(year)")
                            .tag(year)
                    }
                }
            } label: {
                HStack {
                    Text("\(selectedYear)")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                    
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(brandYellow)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(.systemGray6))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(brandYellow, lineWidth: 2)
                )
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Confirm Button
            Button(action: {
                onYearSelected(selectedYear)
            }) {
                Text("Confirm")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(brandYellow)
                    .clipShape(Capsule())
            }
            .padding()
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    CustomCalendarView(selectedData: .constant(""))
}
