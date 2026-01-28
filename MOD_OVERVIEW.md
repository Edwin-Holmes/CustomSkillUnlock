# Mod Overview: Custom Skill Unlock

This document provides a technical overview of the **Custom Skill Unlock** mod, tracking implemented features, their technical execution, and verification status.

## 🛠 Features & Implementation

### 1. Custom Skill Unlock Costs
Allows players to configure how many points must be spent in a branch to unlock higher-tier skills.
- **Implementation**: Wraps `W3PlayerAbilityManager.Init` to call `SetSkillUnlockCosts()`, which pulls values from the mod menu and updates the `skills` array.

### 2. Column-Based Unlocks
Optional logic where a skill is unlocked if its direct precursor in the same column is fully mastered, regardless of total points spent.
- **Implementation**: Wraps `CanLearnSkill` and `HasSpentEnoughPoints` in `W3PlayerAbilityManager`. Logic resides in `IsColumnRequirementMet`.

### 3. Slot & Mutagen Level Unlocks
Customizable level requirements for unlocking all 12 skill slots and 4 mutagen slots.
- **Implementation**: Wraps `InitSkillSlots` and `LoadMutagenSlotsDataFromXML` to override vanilla `unlockedOnLevel` values.

### 4. Mutation Color Borders
Dynamic UI feedback for mutation skill slots. When "Mutation Colour Locked" is disabled, slots show combined color borders (e.g., Red+Blue) based on the equipped mutation.
- **Implementation**: Wraps `UpdateAppliedSkills` in `CR4CharacterMenu` to modify Flash data objects before they are sent to the UI.

### 5. Confirm Purchase
Adds a confirmation step when buying a skill to prevent accidental spending.
- **Implementation**: Wraps `OnUpgradeSkill` in `CR4CharacterMenu`.

---

## 🚦 Status & Testing

| Feature | Status | Notes |
| :--- | :--- | :--- |
| **Confirm Buy** | ✅ Working | Tested and verified. |
| **Column Unlock** | ✅ Working | Tested and verified. |
| **Vanilla Reset (Menu)** | ✅ Working | Tested and verified. |
| **Skill Unlock Costs** | ✅ Working | Tested and verified. |
| **Slot Level Unlocks** | 🧪 Needs Test | Needs verification in-game across different levels. |
| **Mutagen Level Unlocks**| 🧪 Needs Test | Needs verification in-game. |
| **Mutation Color Borders**| 🧪 Needs Test | Recently refactored to fix compiler errors. |
| **NG+ Support** | ❌ Untested | Potential issues with level scaling or XML overrides. Perhaps does not touch unlock logic? |

---

## 📅 Roadmap & Future Ideas

### Planned Improvements
- [✅] **Dynamic Cost Updates**: Find a way to apply new skill unlock costs instantly without requiring a character reset.
- [ ] **UI Cleanup**: Remove the padlock icon and the "requirement number" from skill rows in the menu to match custom logic.

### Known Limitations
- Currently requires a progression reset (via menu toggle) to apply changes to skill tier requirements if they have already been initialized.
