@wrapMethod(CR4Game) function PopulateMenuQueueMainAlways(out menus: array<name>) {
    wrappedMethod(menus);
    CSU_Initialize();
}

function CSU_Initialize() {
    var currentVersion: float = 2.0;
    var userVersion: float = CSUMenuFloat('SkillUnlockCost', 'CSUVersion', 0.0);

    if (userVersion == currentVersion) {                                            // Up to date = early exit
        return;
    }
    
    // Skill Unlock Cost Init
    if (userVersion < 1.0) {                                                        // Apply default settings   
        CSUMenuSet('SkillUnlockCost', 'ConfirmBuy', true);                
        CSUMenuSet('SkillUnlockCost', 'SwordTier1', 6);
        CSUMenuSet('SkillUnlockCost', 'SwordTier2', 12);
        CSUMenuSet('SkillUnlockCost', 'SwordTier3', 18);
        CSUMenuSet('SkillUnlockCost', 'MagicTier1', 6);
        CSUMenuSet('SkillUnlockCost', 'MagicTier2', 12);
        CSUMenuSet('SkillUnlockCost', 'MagicTier3', 18);
        CSUMenuSet('SkillUnlockCost', 'AlchemyTier1', 6);
        CSUMenuSet('SkillUnlockCost', 'AlchemyTier2', 12);
        CSUMenuSet('SkillUnlockCost', 'AlchemyTier3', 18);
    // Slot Unlock Level Init
        CSUMenuSet('SlotUnlock', 'Slot1Lvl', 1);
        CSUMenuSet('SlotUnlock', 'Slot2Lvl', 2);
        CSUMenuSet('SlotUnlock', 'Slot3Lvl', 4);
        CSUMenuSet('SlotUnlock', 'Slot4Lvl', 6);
        CSUMenuSet('SlotUnlock', 'Slot5Lvl', 8);
        CSUMenuSet('SlotUnlock', 'Slot6Lvl', 10);
        CSUMenuSet('SlotUnlock', 'Slot7Lvl', 12);
        CSUMenuSet('SlotUnlock', 'Slot8Lvl', 15);
        CSUMenuSet('SlotUnlock', 'Slot9Lvl', 18);
        CSUMenuSet('SlotUnlock', 'Slot10Lvl',22);
        CSUMenuSet('SlotUnlock', 'Slot11Lvl', 26);
        CSUMenuSet('SlotUnlock', 'Slot12Lvl', 30);
        CSUMenuSet('SlotUnlock', 'Mutagen1Lvl', 2);
        CSUMenuSet('SlotUnlock', 'Mutagen2Lvl', 9);
        CSUMenuSet('SlotUnlock', 'Mutagen3Lvl', 16);
        CSUMenuSet('SlotUnlock', 'Mutagen4Lvl', 28);
        CSUMenuSet('SlotUnlock', 'MutationCostSlot1', 2);
        CSUMenuSet('SlotUnlock', 'MutationCostSlot2', 4);
        CSUMenuSet('SlotUnlock', 'MutationCostSlot3', 8);
        CSUMenuSet('SlotUnlock', 'MutationCostSlot4', 12);
        CSUMenuSet('SlotUnlock', 'MutationsColourLocked', true);
    // Reset Toggle Init
        CSUMenuSet('CSUReset', 'ResetProgression', false);
    }

    if(userVersion < 2.0) {
        CSUMenuSet('UnlockMethods', 'EnableColumnUnlocks', false);
        CSUMenuSet('UnlockMethods', 'EnableAltColumnUnlocks', false);
        CSUMenuSet('UnlockMethods', 'EnableRowUnlocks', true);
        CSUMenuSet('UnlockMethods', 'EnablePerkRowUnlocks', false);
        CSUMenuSet('UnlockMethods', 'EnablePerkColumnUnlocks', false);
    }

    if (userVersion < currentVersion) {
        CSUMenuSet('SkillUnlockCost', 'CSUVersion', currentVersion);
    }   

}