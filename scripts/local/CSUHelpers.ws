function CSUCheckMenuResetToggle() {
    var resetEnabled : bool = CSUMenuBool('CSUReset', 'ResetProgression');
    var player : W3PlayerWitcher = GetWitcherPlayer();

    if (resetEnabled) //Check toggle
    {
        if (!CSUHasModCleardevelop())
        {
            player.CSUPlayerReset();
            CSUMenuSet('CSUReset', 'ResetProgression', false); //Revert toggle to false
        } 
        else
        {
            player.Debug_ClearCharacterDevelopment(); //Reset Progression using modified function
            CSUMenuSet('CSUReset', 'ResetProgression', false); //Revert toggle to false
        }
    }
}

@addMethod(W3PlayerWitcher) public final function CSUPlayerReset() {
		// Vanilla cleardevelop without any inventory logic
		var i : int;
		var abs : array<name>;
		var playerLevel: int = this.GetLevel();
	
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

		CSUSetLevel(playerLevel);		//Restore player level			
}

// Give player a specific level
function CSUSetLevel(targetLvl: int) {
	// Identical to exec function in temp.ws
	var lm : W3PlayerWitcher;
	var exp, prevLvl, currLvl : int;
	
	lm = GetWitcherPlayer();
	prevLvl = lm.GetLevel();
	currLvl = lm.GetLevel();
		
	while(currLvl < targetLvl)
	{
		exp = lm.GetTotalExpForNextLevel() - lm.GetPointsTotal(EExperiencePoint);
		lm.AddPoints(EExperiencePoint, exp, false);
		currLvl = lm.GetLevel();
		
		if(prevLvl == currLvl)
			break;				
		
		prevLvl = currLvl;
	}	
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

