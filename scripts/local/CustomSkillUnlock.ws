@addMethod(W3PlayerAbilityManager) private function GetSkillTierCosts(out playerSkills: array<ESkill>, out tierCosts: array<int>) {
	//Get values from menu
	var swordTier1		: int = CSUMenuInt('SkillUnlockCost', 'SwordTier1', 6);
	var swordTier2		: int = CSUMenuInt('SkillUnlockCost', 'SwordTier2', 12);
	var swordTier3		: int = CSUMenuInt('SkillUnlockCost', 'SwordTier3', 18);
	var magicTier1		: int = CSUMenuInt('SkillUnlockCost', 'MagicTier1', 6);
	var magicTier2		: int = CSUMenuInt('SkillUnlockCost', 'MagicTier2', 12);
	var magicTier3		: int = CSUMenuInt('SkillUnlockCost', 'MagicTier3', 18);
	var alchemyTier1	: int = CSUMenuInt('SkillUnlockCost', 'AlchemyTier1', 6);
	var alchemyTier2	: int = CSUMenuInt('SkillUnlockCost', 'AlchemyTier2', 12);
	var alchemyTier3	: int = CSUMenuInt('SkillUnlockCost', 'AlchemyTier3', 18);
	
	//Ensure logical progression
	if (swordTier2 < swordTier1)	 {swordTier2 = swordTier1;}
	if (swordTier3 < swordTier2)	 {swordTier3 = swordTier2;}
	if (magicTier2 < magicTier1)	 {magicTier2 = magicTier1;}
	if (magicTier3 < magicTier2)	 {magicTier3 = magicTier2;}
	if (alchemyTier2 < alchemyTier1) {alchemyTier2 = alchemyTier1;}
	if (alchemyTier3 < alchemyTier2) {alchemyTier3 = alchemyTier2;}
	
	// Sword Tier
	playerSkills.PushBack(S_Sword_s08);   tierCosts.PushBack(swordTier1);
	playerSkills.PushBack(S_Sword_s09);   tierCosts.PushBack(swordTier1);
	playerSkills.PushBack(S_Sword_s15);   tierCosts.PushBack(swordTier1);
	playerSkills.PushBack(S_Sword_s17);   tierCosts.PushBack(swordTier1);
	playerSkills.PushBack(S_Sword_s18);   tierCosts.PushBack(swordTier1);

	playerSkills.PushBack(S_Sword_s01);   tierCosts.PushBack(swordTier2);
	playerSkills.PushBack(S_Sword_s02);   tierCosts.PushBack(swordTier2);
	playerSkills.PushBack(S_Sword_s07);   tierCosts.PushBack(swordTier2);
	playerSkills.PushBack(S_Sword_s11);   tierCosts.PushBack(swordTier2);
	playerSkills.PushBack(S_Sword_s20);   tierCosts.PushBack(swordTier2);

	playerSkills.PushBack(S_Sword_s03);   tierCosts.PushBack(swordTier3);
	playerSkills.PushBack(S_Sword_s05);   tierCosts.PushBack(swordTier3);
	playerSkills.PushBack(S_Sword_s06);   tierCosts.PushBack(swordTier3);
	playerSkills.PushBack(S_Sword_s12);   tierCosts.PushBack(swordTier3);
	playerSkills.PushBack(S_Sword_s19);   tierCosts.PushBack(swordTier3);
	
	// Magic Tier
	playerSkills.PushBack(S_Magic_s01);   tierCosts.PushBack(magicTier1);
	playerSkills.PushBack(S_Magic_s02);   tierCosts.PushBack(magicTier1);
	playerSkills.PushBack(S_Magic_s03);   tierCosts.PushBack(magicTier1);
	playerSkills.PushBack(S_Magic_s04);   tierCosts.PushBack(magicTier1);
	playerSkills.PushBack(S_Magic_s05);   tierCosts.PushBack(magicTier1);

	playerSkills.PushBack(S_Magic_s07);   tierCosts.PushBack(magicTier2);
	playerSkills.PushBack(S_Magic_s12);   tierCosts.PushBack(magicTier2);
	playerSkills.PushBack(S_Magic_s15);   tierCosts.PushBack(magicTier2);
	playerSkills.PushBack(S_Magic_s16);   tierCosts.PushBack(magicTier2);
	playerSkills.PushBack(S_Magic_s18);   tierCosts.PushBack(magicTier2);

	playerSkills.PushBack(S_Magic_s06);   tierCosts.PushBack(magicTier3);
	playerSkills.PushBack(S_Magic_s09);   tierCosts.PushBack(magicTier3);
	playerSkills.PushBack(S_Magic_s11);   tierCosts.PushBack(magicTier3);
	playerSkills.PushBack(S_Magic_s14);   tierCosts.PushBack(magicTier3);
	playerSkills.PushBack(S_Magic_s19);   tierCosts.PushBack(magicTier3);
	
	// Alchemy Tier 
	playerSkills.PushBack(S_Alchemy_s02);   tierCosts.PushBack(alchemyTier1);
	playerSkills.PushBack(S_Alchemy_s05);   tierCosts.PushBack(alchemyTier1);
	playerSkills.PushBack(S_Alchemy_s10);   tierCosts.PushBack(alchemyTier1);
	playerSkills.PushBack(S_Alchemy_s13);   tierCosts.PushBack(alchemyTier1);
	playerSkills.PushBack(S_Alchemy_s20);   tierCosts.PushBack(alchemyTier1);

	playerSkills.PushBack(S_Alchemy_s03);   tierCosts.PushBack(alchemyTier2);
	playerSkills.PushBack(S_Alchemy_s06);   tierCosts.PushBack(alchemyTier2);
	playerSkills.PushBack(S_Alchemy_s08);   tierCosts.PushBack(alchemyTier2);
	playerSkills.PushBack(S_Alchemy_s15);   tierCosts.PushBack(alchemyTier2);
	playerSkills.PushBack(S_Alchemy_s19);   tierCosts.PushBack(alchemyTier2);
	
	playerSkills.PushBack(S_Alchemy_s04);   tierCosts.PushBack(alchemyTier3);
	playerSkills.PushBack(S_Alchemy_s07);   tierCosts.PushBack(alchemyTier3);
	playerSkills.PushBack(S_Alchemy_s11);   tierCosts.PushBack(alchemyTier3);
	playerSkills.PushBack(S_Alchemy_s14);   tierCosts.PushBack(alchemyTier3);
	playerSkills.PushBack(S_Alchemy_s17);   tierCosts.PushBack(alchemyTier3);
}

@addMethod(W3PlayerAbilityManager) private function SetSkillUnlockCosts() {
	var playerSkills	: array<ESkill>;
	var tierCosts		: array<int>;  
	var costIndex		: int; 
	var skill			: ESkill;
    var i 				: int;
	
	GetSkillTierCosts(playerSkills, tierCosts);

	for( i = 0; i < skills.Size(); i += 1 )
	{
        skill = skills[i].skillType;
        costIndex = CSUFindSkillIndex(skill, playerSkills);
        if (costIndex != -1) 
        {
            skills[i].requiredPointsSpent = tierCosts[costIndex];
        }
    }

}

@addMethod(W3PlayerAbilityManager) private function GetSlotUnlocks(out unlockLevel : array<int>) {
	//Get values from menu
	var slot1	: int = CSUMenuInt('SlotUnlock', 'Slot1Lvl', 0);
	var slot2	: int = CSUMenuInt('SlotUnlock', 'Slot2Lvl', 2);
	var slot3	: int = CSUMenuInt('SlotUnlock', 'Slot3Lvl', 4);
	var slot4	: int = CSUMenuInt('SlotUnlock', 'Slot4Lvl', 6);
	var slot5	: int = CSUMenuInt('SlotUnlock', 'Slot5Lvl', 8);
	var slot6	: int = CSUMenuInt('SlotUnlock', 'Slot6Lvl', 10);
	var slot7	: int = CSUMenuInt('SlotUnlock', 'Slot7Lvl', 12);
	var slot8	: int = CSUMenuInt('SlotUnlock', 'Slot8Lvl', 15);
	var slot9	: int = CSUMenuInt('SlotUnlock', 'Slot9Lvl', 18);
	var slot10	: int = CSUMenuInt('SlotUnlock', 'Slot10Lvl', 22);
	var slot11	: int = CSUMenuInt('SlotUnlock', 'Slot11Lvl', 26);
	var slot12	: int = CSUMenuInt('SlotUnlock', 'Slot12Lvl', 30);
	var i		: int;

	//Populate array
    unlockLevel.Clear();

    unlockLevel.PushBack(slot1);
	unlockLevel.PushBack(slot2);
	unlockLevel.PushBack(slot3);
	unlockLevel.PushBack(slot4);
	unlockLevel.PushBack(slot5);
	unlockLevel.PushBack(slot6);
	unlockLevel.PushBack(slot7);
	unlockLevel.PushBack(slot8);
	unlockLevel.PushBack(slot9);
	unlockLevel.PushBack(slot10);
	unlockLevel.PushBack(slot11);
	unlockLevel.PushBack(slot12);

	//Ensure logical progression
	for (i = 1; i < unlockLevel.Size(); i += 1)
	{
	    if (unlockLevel[i] < unlockLevel[i-1])
	    {
	        unlockLevel[i] = unlockLevel[i-1];
	    }
	}
}

@addMethod(W3PlayerAbilityManager) private function GetMutagenUnlocks(out mutagenUnlockLevel : array<int>) {
	//Fetch variables from menu
	var mutagen1: int = CSUMenuInt('SlotUnlock', 'Mutagen1Lvl', 2);
	var mutagen2: int = CSUMenuInt('SlotUnlock', 'Mutagen2Lvl', 9);
	var mutagen3: int = CSUMenuInt('SlotUnlock', 'Mutagen3Lvl', 16);
	var mutagen4: int = CSUMenuInt('SlotUnlock', 'Mutagen4Lvl', 28);
	var i		: int;
	
	//Populate array
	mutagenUnlockLevel.Clear();

    mutagenUnlockLevel.PushBack(mutagen1); 
    mutagenUnlockLevel.PushBack(mutagen2); 
    mutagenUnlockLevel.PushBack(mutagen3); 
    mutagenUnlockLevel.PushBack(mutagen4); 

	//Ensure logical progression
	for (i = 1; i < mutagenUnlockLevel.Size(); i += 1)
	{
	    if (mutagenUnlockLevel[i] < mutagenUnlockLevel[i-1])
	    {
	        mutagenUnlockLevel[i] = mutagenUnlockLevel[i-1];
	    }
	}
}

@addMethod(W3PlayerAbilityManager) private function GetCustomMutationsForUnlock(stage : int): int {
	//Get variables from menu
	var costSlot1: int = CSUMenuInt('SlotUnlock', 'MutationCostSlot1', 2);
	var costSlot2: int = CSUMenuInt('SlotUnlock', 'MutationCostSlot2', 4);
	var costSlot3: int = CSUMenuInt('SlotUnlock', 'MutationCostSlot3', 8);
	var costSlot4: int = CSUMenuInt('SlotUnlock', 'MutationCostSlot4', 12);

	//Ensure logical progression
	if (costSlot2 < costSlot1) {costSlot2 = costSlot1;}
	if (costSlot3 < costSlot2) {costSlot3 = costSlot2;}
	if (costSlot4 < costSlot3) {costSlot4 = costSlot3;}

	//Replicate vanilla logic substituting custom values
	if 		(stage == 1) return costSlot1;
	else if (stage == 2) return costSlot2;
	else if (stage == 3) return costSlot3;
	else if (stage == 4) return costSlot4;
	else
	{
	    LogChannel('MutationUnlockCost', "Invalid stage value: " + stage);
	    return costSlot1;
	}
}

@wrapMethod(CR4IngameMenu) function OnClosingMenu() {
	wrappedMethod();
	CSUCheckMenuResetToggle();
}
