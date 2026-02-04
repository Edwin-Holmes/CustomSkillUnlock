struct CSUSkillCost {
    var skill: ESkill;
    var cost: int;
}

@addMethod(W3PlayerAbilityManager) private function GetSkillTierCosts(): array<CSUSkillCost> {
    var masterList: array<CSUSkillCost>;
    var skills: array<ESkill>;
	var swordTier1		: int = CSUMenuInt('SkillUnlockCost', 'SwordTier1', 6);	
	var swordTier2		: int = CSUMenuInt('SkillUnlockCost', 'SwordTier2', 12);
	var swordTier3		: int = CSUMenuInt('SkillUnlockCost', 'SwordTier3', 18);
	var magicTier1		: int = CSUMenuInt('SkillUnlockCost', 'MagicTier1', 6);
	var magicTier2		: int = CSUMenuInt('SkillUnlockCost', 'MagicTier2', 12);
	var magicTier3		: int = CSUMenuInt('SkillUnlockCost', 'MagicTier3', 18);
	var alchemyTier1	: int = CSUMenuInt('SkillUnlockCost', 'AlchemyTier1', 6);
	var alchemyTier2	: int = CSUMenuInt('SkillUnlockCost', 'AlchemyTier2', 12);
	var alchemyTier3	: int = CSUMenuInt('SkillUnlockCost', 'AlchemyTier3', 18);
	
	//Ensure logical progression & force +1 step (avoids skill grid reshuffle)
	if (swordTier2 <= swordTier1) {
		swordTier2 = swordTier1 + 1;
		CSUMenuSet('SkillUnlockCost', 'SwordTier2', IntToString(swordTier2));
		}
	if (swordTier3 <= swordTier2) {
		swordTier3 = swordTier2 + 1;
		CSUMenuSet('SkillUnlockCost', 'SwordTier3', IntToString(swordTier3));
		}
	if (magicTier2 <= magicTier1) {
		magicTier2 = magicTier1 + 1;
		CSUMenuSet('SkillUnlockCost', 'MagicTier2', IntToString(magicTier2));
		}
	if (magicTier3 <= magicTier2) {
		magicTier3 = magicTier2 + 1;
		CSUMenuSet('SkillUnlockCost', 'MagicTier3', IntToString(magicTier3));
		}
	if (alchemyTier2 <= alchemyTier1) {
		alchemyTier2 = alchemyTier1 + 1;
		CSUMenuSet('SkillUnlockCost', 'AlchemyTier2', IntToString(alchemyTier2));
		}
	if (alchemyTier3 <= alchemyTier2) {
		alchemyTier3 = alchemyTier2 + 1;
		CSUMenuSet('SkillUnlockCost', 'AlchemyTier3', IntToString(alchemyTier3));
		}
	
	// Sword Tiers
    skills.Clear();
    skills.PushBack(S_Sword_s08); skills.PushBack(S_Sword_s09); skills.PushBack(S_Sword_s15); 
    skills.PushBack(S_Sword_s17); skills.PushBack(S_Sword_s18);
    AddTierToCostList(masterList, skills, swordTier1);

    skills.Clear();
    skills.PushBack(S_Sword_s01); skills.PushBack(S_Sword_s02); skills.PushBack(S_Sword_s07);
    skills.PushBack(S_Sword_s11); skills.PushBack(S_Sword_s20);
    AddTierToCostList(masterList, skills, swordTier2);

	skills.Clear();
    skills.PushBack(S_Sword_s03); skills.PushBack(S_Sword_s05); skills.PushBack(S_Sword_s06);
    skills.PushBack(S_Sword_s12); skills.PushBack(S_Sword_s19);
    AddTierToCostList(masterList, skills, swordTier3);

    // Magic Tiers
    skills.Clear();
    skills.PushBack(S_Magic_s01); skills.PushBack(S_Magic_s02); skills.PushBack(S_Magic_s03);
    skills.PushBack(S_Magic_s04); skills.PushBack(S_Magic_s05);
    AddTierToCostList(masterList, skills, magicTier1);

	skills.Clear();
    skills.PushBack(S_Magic_s07); skills.PushBack(S_Magic_s12); skills.PushBack(S_Magic_s15);
    skills.PushBack(S_Magic_s16); skills.PushBack(S_Magic_s18);
    AddTierToCostList(masterList, skills, magicTier2);

	skills.Clear();
    skills.PushBack(S_Magic_s06); skills.PushBack(S_Magic_s09); skills.PushBack(S_Magic_s11);
    skills.PushBack(S_Magic_s14); skills.PushBack(S_Magic_s19);
    AddTierToCostList(masterList, skills, magicTier3);

	// Alchemy Tiers
    skills.Clear();
    skills.PushBack(S_Alchemy_s02); skills.PushBack(S_Alchemy_s05); skills.PushBack(S_Alchemy_s10);
    skills.PushBack(S_Alchemy_s13); skills.PushBack(S_Alchemy_s20);
    AddTierToCostList(masterList, skills, alchemyTier1);

	skills.Clear();
    skills.PushBack(S_Alchemy_s03); skills.PushBack(S_Alchemy_s06); skills.PushBack(S_Alchemy_s08);
    skills.PushBack(S_Alchemy_s15); skills.PushBack(S_Alchemy_s19);
    AddTierToCostList(masterList, skills, alchemyTier2);

	skills.Clear();
    skills.PushBack(S_Alchemy_s04); skills.PushBack(S_Alchemy_s07); skills.PushBack(S_Alchemy_s11);
    skills.PushBack(S_Alchemy_s14); skills.PushBack(S_Alchemy_s17);
    AddTierToCostList(masterList, skills, alchemyTier3);

	return masterList;
}

@addMethod(W3PlayerAbilityManager) private function AddTierToCostList(out masterList: array<CSUSkillCost>, skillsToTier: array<ESkill>, cost: int) {
    var i: int;
    var pair: CSUSkillCost;

    pair.cost = cost; 													//Set this tier's cost	
    for (i = 0; i < skillsToTier.Size(); i += 1) {
        pair.skill = skillsToTier[i];									//Get skills included in this tier	
        masterList.PushBack(pair);										//Add tier to master list
    }
}

@addMethod(W3PlayerAbilityManager) public function SetSkillUnlockCosts() {
    var skillCosts: array<CSUSkillCost>;
    var i, j: int;
    
    skillCosts = GetSkillTierCosts();

    for( i = 0; i < skills.Size(); i += 1 ) {  							//Look thorugh Geralt skills list
        for (j = 0; j < skillCosts.Size(); j += 1) {					//Look thorugh costs list
            if (skillCosts[j].skill == skills[i].skillType) {			//Find matching skill
                skills[i].requiredPointsSpent = skillCosts[j].cost;		//Apply cost
                break; 													//Stop j and back out to i
            }
        }
    }
}

@addMethod(W3PlayerAbilityManager) private function GetSlotUnlocks(out unlockLevel : array<int>) {
	var i: int;
	var slotName: name;

	//Populate array
    unlockLevel.Clear();

    unlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Slot1Lvl', 0));
	unlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Slot2Lvl', 2));
	unlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Slot3Lvl', 4));
	unlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Slot4Lvl', 6));
	unlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Slot5Lvl', 8));
	unlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Slot6Lvl', 10));
	unlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Slot7Lvl', 12));
	unlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Slot8Lvl', 15));
	unlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Slot9Lvl', 18));
	unlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Slot10Lvl', 22));
	unlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Slot11Lvl', 26));
	unlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Slot12Lvl', 30));

	//Ensure logical progression
	for (i = 1; i < unlockLevel.Size(); i += 1) {
	    if (unlockLevel[i] < unlockLevel[i-1]) {
	        unlockLevel[i] = unlockLevel[i-1];

			switch(i) {
            case 1:  slotName = 'Slot2Lvl';  break;
            case 2:  slotName = 'Slot3Lvl';  break;
            case 3:  slotName = 'Slot4Lvl';  break;
            case 4:  slotName = 'Slot5Lvl';  break;
            case 5:  slotName = 'Slot6Lvl';  break;
            case 6:  slotName = 'Slot7Lvl';  break;
            case 7:  slotName = 'Slot8Lvl';  break;
            case 8:  slotName = 'Slot9Lvl';  break;
            case 9:  slotName = 'Slot10Lvl'; break;
            case 10: slotName = 'Slot11Lvl'; break;
            case 11: slotName = 'Slot12Lvl'; break;
        	}

            CSUMenuSet('SlotUnlock', slotName, IntToString(unlockLevel[i]));
	    }
	}
}

@addMethod(W3PlayerAbilityManager) private function GetMutagenUnlocks(out mutagenUnlockLevel : array<int>) {
	var i: int;
	var mutagenName: name;
	
	//Populate array
	mutagenUnlockLevel.Clear();

    mutagenUnlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Mutagen1Lvl', 2)); 
    mutagenUnlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Mutagen2Lvl', 9)); 
    mutagenUnlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Mutagen3Lvl', 16)); 
    mutagenUnlockLevel.PushBack(CSUMenuInt('SlotUnlock', 'Mutagen4Lvl', 28)); 

	//Ensure logical progression
	for (i = 1; i < mutagenUnlockLevel.Size(); i += 1) {
	    if (mutagenUnlockLevel[i] < mutagenUnlockLevel[i-1]) {
	        mutagenUnlockLevel[i] = mutagenUnlockLevel[i-1];

			switch(i) {
                case 1: mutagenName = 'Mutagen2Lvl'; break;
                case 2: mutagenName = 'Mutagen3Lvl'; break;
                case 3: mutagenName = 'Mutagen4Lvl'; break;
            }

            CSUMenuSet('SlotUnlock', mutagenName, IntToString(mutagenUnlockLevel[i]));
	    }
	}
}

@addMethod(W3PlayerAbilityManager) public function UpdateSlotUnlocks() {
	var unlockLevel : array<int>;
	var mutagenUnlockLevel : array<int>;
	var i : int;

	this.GetSlotUnlocks(unlockLevel);									//Get user unlock levels	
	for (i = 0; i < skillSlots.Size(); i += 1) {
		if (i < unlockLevel.Size()) {
			skillSlots[i].unlockedOnLevel = unlockLevel[i];				//Replace vanilla unlock
		}
	}

	this.GetMutagenUnlocks(mutagenUnlockLevel); 						//Get user unlock levels
	for (i = 0; i < mutagenSlots.Size(); i += 1) {
		if (i < mutagenUnlockLevel.Size()) {
			mutagenSlots[i].unlockedAtLevel = mutagenUnlockLevel[i];	//Replace vanilla unlock
		}
	}
}

@addMethod(W3PlayerAbilityManager) private function GetCustomMutationsForUnlock(stage : int): int {
    var costSlot1: int = CSUMenuInt('SlotUnlock', 'MutationCostSlot1', 2);
    var costSlot2: int = CSUMenuInt('SlotUnlock', 'MutationCostSlot2', 4);
    var costSlot3: int = CSUMenuInt('SlotUnlock', 'MutationCostSlot3', 8);
    var costSlot4: int = CSUMenuInt('SlotUnlock', 'MutationCostSlot4', 12);

    //Ensure logical progression
    if (costSlot2 < costSlot1) {
        costSlot2 = costSlot1;
        CSUMenuSet('SlotUnlock', 'MutationCostSlot2', IntToString(costSlot2));
    }
    if (costSlot3 < costSlot2) {
        costSlot3 = costSlot2;
        CSUMenuSet('SlotUnlock', 'MutationCostSlot3', IntToString(costSlot3));
    }
    if (costSlot4 < costSlot3) {
        costSlot4 = costSlot3;
        CSUMenuSet('SlotUnlock', 'MutationCostSlot4', IntToString(costSlot4));
    }

    //Mirror vanilla logic using modified values
    switch(stage) {
        case 1:  return costSlot1;
        case 2:  return costSlot2;
        case 3:  return costSlot3;
        case 4:  return costSlot4;
        default:
            LogChannel('MutationUnlockCost', "Invalid stage value: " + stage);
            return costSlot1;
    }
}

@wrapMethod(CR4IngameMenu) function OnClosingMenu() {
	var am : W3PlayerAbilityManager;
	var retVal: bool;

	retVal = wrappedMethod();											//Store vanilla bool return value
	CSUCheckMenuResetToggle();											//Check reset progression toggle
	
	am = (W3PlayerAbilityManager)GetWitcherPlayer().abilityManager;
	if (am) {
		am.SetSkillUnlockCosts();										//Update skill costs
		am.UpdateSlotUnlocks();											//Update slot unlock levels
	}

	if (!CSUShouldRowsUnlock() && !CSUShouldColumnsUnlock()) {			//If both paths disabled set vanilla behaviour
		CSUMenuSet('SkillUnlockCost', 'EnableRowUnlocks', true);
	}

	return retVal;
}

//Overide vanilla values with the custom ones
@wrapMethod(W3PlayerAbilityManager) function Init(ownr : CActor, cStats : CCharacterStats, isFromLoad : bool, diff : EDifficultyMode): bool {
    var retVal : bool;
    retVal = wrappedMethod(ownr, cStats, isFromLoad, diff);

    if (retVal && ownr == thePlayer) {
        this.SetSkillUnlockCosts();
    }
    return retVal;
}

@wrapMethod(W3PlayerAbilityManager) function CanLearnSkill(skill : ESkill): bool {
    var columnMet : bool = this.IsColumnRequirementMet(skill); 	//Is parent skill max?
    var rowMet : bool = false;
    
    if (CSUShouldRowsUnlock()) {
        rowMet = wrappedMethod(skill);							//Would vanilla unlock the skill?
    }
    
    return columnMet || rowMet;
}

@wrapMethod(W3PlayerAbilityManager) function HasSpentEnoughPoints(skill : ESkill): bool {
    var columnMet : bool = this.IsColumnRequirementMet(skill); 		//Is parent skill max?	
    var rowMet : bool = false;
    
    if (CSUShouldRowsUnlock()) {
        rowMet = wrappedMethod(skill);								//Would vanilla unlock the skill?
    }
    
    return columnMet || rowMet;
}

@wrapMethod(W3PlayerAbilityManager) function InitSkillSlots( isFromLoad : bool ) {
    wrappedMethod(isFromLoad);
    this.UpdateSlotUnlocks();
}

@wrapMethod(W3PlayerAbilityManager) function LoadMutagenSlotsDataFromXML() {
    wrappedMethod();
    this.UpdateSlotUnlocks();
}

@wrapMethod(W3PlayerAbilityManager) function GetMutationsRequiredForMasterStage( stage : int ): int {
    var customMutationsReq: int = this.GetCustomMutationsForUnlock(stage);

    if (customMutationsReq >= 0) {
		return customMutationsReq;
	}

    return wrappedMethod(stage);
}

@wrapMethod(W3PlayerAbilityManager) function GetMutationColors( mutationType : EPlayerMutationType ): array< ESkillColor > {
    var allColors : array< ESkillColor >;
    if (!CSUGetMutationsColourLocked()) {	//Menu allows all colours
        allColors.PushBack(SC_Blue);
        allColors.PushBack(SC_Red);
        allColors.PushBack(SC_Green);
        allColors.PushBack(SC_Yellow); 		//Add General skills
        return allColors;					//Unlocked
    }

    return wrappedMethod(mutationType);		//Locked to mutation colour
}

//Effectively replaceMethod :(
@wrapMethod(CR4CharacterMenu) function UpdateAppliedSkills(): void {
	var csu_i, csu_slotsCount : int;
	var csu_curSlot      : SSkillSlot;
	var csu_skillSlots   : array<SSkillSlot>;
	var csu_equipedSkill : SSkill;
	var csu_gfxSlots     : CScriptedFlashObject;
	var csu_gfxSlotsList : CScriptedFlashArray;
	
	var csu_equippedMutationId : EPlayerMutationType;
	var csu_equippedMutation   : SMutation;
	var csu_colorsList		   : array< ESkillColor >;
	var csu_colorBorderId      : string;
	
	wrappedMethod();

	csu_skillSlots = thePlayer.GetSkillSlots();
	csu_slotsCount = csu_skillSlots.Size();
	csu_gfxSlotsList = m_flashValueStorage.CreateTempFlashArray();
	csu_equippedMutationId = GetWitcherPlayer().GetEquippedMutationType();
	
	if( csu_equippedMutationId != EPMT_None ) 
	{
		csu_equippedMutation = GetWitcherPlayer().GetMutation( csu_equippedMutationId );
	}
	
	for( csu_i=0; csu_i < csu_slotsCount; csu_i+=1 ) 
	{
		csu_curSlot = csu_skillSlots[csu_i];
		csu_equipedSkill = thePlayer.GetPlayerSkill( csu_curSlot.socketedSkill );
		
		csu_gfxSlots = m_flashValueStorage.CreateTempFlashObject();
		GetSkillGFxObject( csu_equipedSkill, false, csu_gfxSlots );
		
		csu_gfxSlots.SetMemberFlashInt( 'tabId', GetTabForSkill( csu_curSlot.socketedSkill ) );
		csu_gfxSlots.SetMemberFlashInt( 'slotId', csu_curSlot.id );
		csu_gfxSlots.SetMemberFlashInt( 'unlockedOnLevel', csu_curSlot.unlockedOnLevel );
		csu_gfxSlots.SetMemberFlashInt( 'groupID', csu_curSlot.groupID );
		csu_gfxSlots.SetMemberFlashBool( 'unlocked', csu_curSlot.unlocked );
		
		csu_colorBorderId = "";
		if( csu_curSlot.id >= BSS_SkillSlot1 ) 
		{
			csu_gfxSlots.SetMemberFlashBool( 'isMutationSkill', true );
			csu_gfxSlots.SetMemberFlashInt( 'unlockedOnLevel', ( csu_curSlot.id - BSS_SkillSlot1 + 1 ) );
			
			if (csu_equippedMutationId != EPMT_None) 
			{
				csu_colorsList = ((W3PlayerAbilityManager)thePlayer.abilityManager).GetMutationColors( csu_equippedMutationId ); //Use our logic
				
				if( csu_colorsList.Contains(SC_Red) )
				{
					csu_colorBorderId += "Red";
				}
				
				if( csu_colorsList.Contains(SC_Green) )
				{
					csu_colorBorderId += "Green";
				}
				
				if( csu_colorsList.Contains(SC_Blue) )
				{
					csu_colorBorderId += "Blue";
				}
				
				if( csu_colorsList.Contains(SC_Yellow) )	//Yellow border for general skills
				{
					csu_colorBorderId += "Yellow";
				}
			}
			
			csu_gfxSlots.SetMemberFlashString( 'colorBorder', csu_colorBorderId );
		}
		else 
		{
			csu_gfxSlots.SetMemberFlashInt( 'unlockedOnLevel', csu_curSlot.unlockedOnLevel );
		}
	
		csu_gfxSlotsList.PushBackFlashObject( csu_gfxSlots );
	}
	
	m_flashValueStorage.SetFlashArray( "character.skills.slots", csu_gfxSlotsList );
}

//Toggle skill purchase confirmation popup
@wrapMethod(CR4CharacterMenu) function OnUpgradeSkill(skillID : ESkill) {
	var csu_skill: SSkill;
	csu_skill = thePlayer.GetPlayerSkill(skillID);
	
	if (thePlayer.IsInCombat()) {					//Vanilla safety
		showNotification(GetLocStringByKeyExt("menu_cannot_perform_action_combat"));
		OnPlaySoundEvent("gui_global_denied");
		return false;

	} else {	
		if(!CSUGetConfirmBuy()) {
			handleBuySkillConfirmation(skillID);
			return true;							//Skip to the end
		} else {
			return wrappedMethod(skillID);			//Confirm popup
		}
	}
}

//Clear perchases and activations; refresh character panel
@addMethod(W3PlayerWitcher) public final function CSUPlayerReset() {
		// Vanilla cleardevelop without the inventory logic
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
