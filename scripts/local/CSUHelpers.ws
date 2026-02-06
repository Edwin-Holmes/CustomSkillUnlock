@addMethod(W3PlayerAbilityManager) private function CSUFindSkillIndex(target: ESkill, skillList: array<SSkill>): int {
    var i: int;
    for (i = 0; i < skillList.Size(); i += 1) {
        if (skillList[i].skillType == target) { 		//Loook thorugh SSkill array for an ESkill	
            return i;									//Return index of skill if found
        }
    }
    return -1;
}

//Shorthand to set/get values from menu
function CSUMenuInt(group: name, key: name, defaultValue: int): int {
    return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue(group, key), defaultValue);
}

function CSUMenuFloat(group: name, key: name, defaultValue: float): float {
    return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue(group, key), defaultValue);
}

function CSUMenuBool(group: name, key: name): bool {
	return theGame.GetInGameConfigWrapper().GetVarValue(group, key);
}

function CSUMenuSet(groupName : name, varName : name, varValue : string) {
    theGame.GetInGameConfigWrapper().SetVarValue(groupName, varName, varValue);
}

//For character reset
@addMethod(W3PlayerAbilityManager) public function CSUGetMutations(): array<SMutation> { 
    return mutations; 
}

//Menu toggle checks
function CSUGetConfirmBuy(): bool {
    return CSUMenuBool('SkillUnlockCost', 'ConfirmBuy');
}

function CSUGetMutationsColourLocked(): bool {
    return CSUMenuBool('SlotUnlock', 'MutationsColourLocked');
}

function CSUShouldPerkRowsUnlock(): bool {
	return CSUMenuBool('SkillUnlockCost', 'EnablePerkRowUnlocks');
}

function CSUShouldPerkColumnsUnlock(): bool {
	return CSUMenuBool('SkillUnlockCost', 'EnablePerkColumnUnlocks');
}

function CSUShouldColumnsUnlock(): bool {
    return CSUMenuBool('SkillUnlockCost', 'EnableColumnUnlocks');
}

function CSUShouldRowsUnlock(): bool {
    return CSUMenuBool('SkillUnlockCost', 'EnableRowUnlocks');
}

function CSUShouldAltColumnsUnlock(): bool {
    return CSUMenuBool('SkillUnlockCost', 'EnableAltColumnUnlocks');
}

@addMethod(CR4IngameMenu) private function CSUCheckMenuResetToggle() {
    var resetEnabled: bool = CSUMenuBool('CSUReset', 'ResetProgression');
    var wp: W3PlayerWitcher = GetWitcherPlayer();

    if (resetEnabled) { 										//Check menu toggle
        wp.CSUPlayerReset();
        CSUMenuSet('CSUReset', 'ResetProgression', false); 		//Revert menu toggle to false 
    }
}
