# Tarot Compatibility System Integration Plan

## Phase 1: Preparation & Setup
1. **Add lucide-react CDN**  
   Insert in `<head>` after Tailwind:
   ```html
   <script src="https://unpkg.com/lucide-react@0.200.0/dist/umd/lucide-react.js"></script>
   ```
2. **Icon Replacement Strategy**  
   Replace all emoji icons with lucide components
3. **Data Structure Review**  
   Modify compatibility system to use existing `cardDetails`

## Phase 2: Core Integration
1. **Create Compatibility Component**  
   ```jsx
   const TarotCompatibilitySystem = () => {
     const [person1Date, setPerson1Date] = useState('');
     const [person2Date, setPerson2Date] = useState('');
     // ...calculation logic
   }
   ```
2. **State Management**  
   Add `activeTool` state to main component
3. **Conditional Rendering**  
   Switch between single and compatibility views

## Phase 3: UI/UX Implementation
1. **Navigation System**  
   Tab-based navigation below title
2. **Responsive Layout**  
   Ensure mobile-friendly design
3. **Shadow Card Notation**  
   Add clarification in compatibility results

## Phase 4: Documentation Update
1. **Theory Section Update**  
   Add compatibility explanation to `TarotTheoryInfo`
2. **User Guidance**  
   Clear input labels and error messages

## Phase 5: Testing Plan
1. **Test Cases**  
   - Single calculator functionality
   - Compatibility calculations
   - Navigation between modes
   - Mobile responsiveness
   - Browser compatibility