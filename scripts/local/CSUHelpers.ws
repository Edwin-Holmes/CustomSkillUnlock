function CSUCheckMenuResetToggle() {
    var resetEnabled: bool = CSUMenuBool('CSUReset', 'ResetProgression');
    var wp: W3PlayerWitcher = GetWitcherPlayer();

    if (resetEnabled) { 										//Check menu toggle
        wp.CSUPlayerReset();
        CSUMenuSet('CSUReset', 'ResetProgression', false); 		//Revert menu toggle to false 
    }
}

@addMethod(W3PlayerWitcher) public final function CSUPlayerReset() {
		// Vanilla cleardevelop without any inventory logic
		var i : int;
		var abs : array<name>;
		var playerXP : int = levelManager.GetPointsTotal(EExperiencePoint);
	
		delete abilityManager;
		delete levelManager;
		delete effectManager;
		
		
		GetCharacterStats().GetAbilities(abs, false);
		for(i=0; i<abs.Size(); i+=1)
			RemoveAbility(abs[i]);
			
		
		abs.Clear();
		GetCharacterStatsParam(abs);		
		for(i=0; i<abs.Size(); i+=1)
			AddAbility(abs[i]);
					
		
		levelManager = new W3LevelManager in this;			
		levelManager.Initialize();
		levelManager.PostInit(this, false, true);		
						
		
		AddAbility('GeraltSkills_Testing');
		SetAbilityManager();		
		abilityManager.Init(this, GetCharacterStats(), false, theGame.GetDifficultyMode());
		
		SetEffectManager();
		
		abilityManager.PostInit();

		this.AddPoints(EExperiencePoint, playerXP, false);		//Restore player level			
}

// Shorthand to get Int from menu
function CSUMenuInt(group: name, key: name, defaultValue: int): int {
    return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue(group, key), defaultValue);
}

// Shorthand to get Int from menu
function CSUMenuFloat(group: name, key: name, defaultValue: float): float {
    return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue(group, key), defaultValue);
}

// Shorthand to get bool from menu
function CSUMenuBool(group: name, key: name): bool {
	return theGame.GetInGameConfigWrapper().GetVarValue(group, key);
}

// Shorthand to set menu values
function CSUMenuSet(groupName : name, varName : name, varValue : string) {
    return theGame.GetInGameConfigWrapper().SetVarValue(groupName, varName, varValue);
}

// Find index of skill in an array
function CSUFindSkillIndex(skillType: ESkill, skills: array<SSkill>): int {
    var i: int;
    for (i = 0; i < skills.Size(); i += 1) {
        if (skills[i].skillType == skillType) 
        {
            return i;
        }
    }
    return -1;
}

function CSUGetConfirmBuy() : bool {
    return CSUMenuBool('SkillUnlockCost', 'ConfirmBuy');
}

function CSUHasModCleardevelop() : bool {
    return CSUMenuBool('CSUReset', 'ModCleardevelop');
}

function CSUGetMutationsColourLocked() : bool {
    return CSUMenuBool('SlotUnlock', 'MutationsColourLocked');
}

function CSUShouldColumnsUnlock() : bool {
    return CSUMenuBool('SkillUnlockCost', 'EnableColumnUnlocks');
}

function CSUShouldRowsUnlock() : bool {
    var rows : bool = CSUMenuBool('SkillUnlockCost', 'EnableRowUnlocks');
    var columns : bool = CSUMenuBool('SkillUnlockCost', 'EnableColumnUnlocks');
    
    if (!rows && !columns) {
		CSUMenuSet('SkillUnlockCost', 'EnableRowUnlocks', true);
        return true;
    }
    
    return rows;
}

