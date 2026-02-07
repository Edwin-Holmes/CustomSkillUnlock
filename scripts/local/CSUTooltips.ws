@addMethod(CR4CharacterMenu) function CSUUpdateSkillUnlockCosts() {
    var data: CScriptedFlashObject;
    var swordArr, magicArr, alchArr: CScriptedFlashArray;
    var groupName: name = 'SkillUnlockCost';

    data = m_flashValueStorage.CreateTempFlashObject();

    swordArr = m_flashValueStorage.CreateTempFlashArray();
    magicArr = m_flashValueStorage.CreateTempFlashArray();
    alchArr = m_flashValueStorage.CreateTempFlashArray();

    swordArr.PushBackFlashInt(CSUMenuInt(groupName, 'SwordTier1', 6));
    swordArr.PushBackFlashInt(CSUMenuInt(groupName, 'SwordTier2', 12));
    swordArr.PushBackFlashInt(CSUMenuInt(groupName, 'SwordTier3', 18));

    magicArr.PushBackFlashInt(CSUMenuInt(groupName, 'MagicTier1', 6));
    magicArr.PushBackFlashInt(CSUMenuInt(groupName, 'MagicTier2', 12));
    magicArr.PushBackFlashInt(CSUMenuInt(groupName, 'MagicTier3', 18));

    alchArr.PushBackFlashInt(CSUMenuInt(groupName, 'AlchemyTier1', 6));
    alchArr.PushBackFlashInt(CSUMenuInt(groupName, 'AlchemyTier2', 12));
    alchArr.PushBackFlashInt(CSUMenuInt(groupName, 'AlchemyTier3', 18));

    data.SetMemberFlashArray("sword", swordArr);
    data.SetMemberFlashArray("magic", magicArr);
    data.SetMemberFlashArray("alchemy", alchArr);

    m_flashValueStorage.SetFlashObject("character.skills.unlockCosts", data);
    
    m_flashValueStorage.SetFlashBool("character.skills.columnOnlyUnlock", CSUShouldColumnsUnlock() && !CSUShouldRowsUnlock());
}

@wrapMethod(CR4CharacterMenu) function UpdateData(tabs : bool) : void {
    this.CSUUpdateSkillUnlockCosts();
    wrappedMethod(tabs);
}

//Another effective replace due to flash
@wrapMethod(CR4CharacterMenu) function GetSkillTooltipData(targetSkill : ESkill, compareItemType : int, isGridView : bool) {
    var abilityMgr 			  : W3PlayerAbilityManager;
    var resultGFxData 	      : CScriptedFlashObject;
    var targetSkillData       : SSkill;
    var targetSubPathLocName  : string;
    var skillCurrentLevelDesc : string;
    var skillNextLevelDesc    : string;
    var skillLevelString	  : string;
    var skillNumPoitnsNeeded  : int;
    var pathPointsSpent		  : int;
    
    var originSkillLevel : int;
    var boostedSkillLevel : int;

    //CSU +++
    var altPointsRequired, vanillaPointsRequired, threshold, spentInBranch : int;
    var altColumns : array<CSUAltColumn>;
    var i, currentSkillRow : int;
    var found : bool;
    var pointsRequired : int;
    

    //If Vanilla settings, run vanilla
    if (CSUShouldRowsUnlock() && !CSUShouldAltColumnsUnlock() && !CSUShouldPerkRowsUnlock() && !CSUShouldPerkColumnsUnlock()) {
        wrappedMethod(targetSkill, compareItemType, isGridView);
        return;
    }
    //CSU ---
    
    resultGFxData = m_flashValueStorage.CreateTempFlashObject();
    targetSkillData = thePlayer.GetPlayerSkill(targetSkill);
    
    if (targetSkillData.isCoreSkill)
    {
        targetSubPathLocName = "";
    }
    else
    {
        targetSubPathLocName = GetLocStringByKeyExt(SkillSubPathToLocalisationKey(targetSkillData.skillSubPath));
    }
    
    resultGFxData.SetMemberFlashString('skillSubCategory', targetSubPathLocName);
    resultGFxData.SetMemberFlashString('skillName', GetLocStringByKeyExt(targetSkillData.localisationNameKey));
    
    GetSkillTooltipDescription(targetSkillData, isGridView, skillCurrentLevelDesc, skillNextLevelDesc);
    
    
    resultGFxData.SetMemberFlashString('nextLevelDescription', skillNextLevelDesc);
    resultGFxData.SetMemberFlashString('isCoreSkill', targetSkillData.isCoreSkill);
    
    if (targetSkillData.isCoreSkill)
    {
        skillLevelString = "<font color=\"#ecdda8\">" +GetLocStringByKeyExt("tooltip_skill_core_category") + "</font>&#10;";
        skillCurrentLevelDesc = "<font color=\"#ecdda8\">" +GetLocStringByKeyExt("tooltip_skill_core_desc") + "</font>&#10;" + skillCurrentLevelDesc;
    }
    else
    {
        originSkillLevel = GetWitcherPlayer().GetBoughtSkillLevel(targetSkillData.skillType);
        
        if ( isGridView )
        {
            skillLevelString = " " + originSkillLevel + "/" + targetSkillData.maxLevel;
        }
        else
        {
            boostedSkillLevel = GetWitcherPlayer().GetSkillLevel(targetSkillData.skillType);
            
            if (boostedSkillLevel > originSkillLevel)
            {
                skillLevelString = " <font color = '#f68104'>" + boostedSkillLevel + "</font>/" + targetSkillData.maxLevel;
            }
            else
            {
                skillLevelString = " " + boostedSkillLevel + "/" + targetSkillData.maxLevel;
            }
        }
    }
    
    resultGFxData.SetMemberFlashString('currentLevelDescription', skillCurrentLevelDesc);
    resultGFxData.SetMemberFlashString('skillLevelString', skillLevelString);
    
    if ( isGridView )
    {
        resultGFxData.SetMemberFlashInt('level', GetWitcherPlayer().GetBoughtSkillLevel(targetSkillData.skillType));
    }
    else
    {
        resultGFxData.SetMemberFlashInt('level', GetWitcherPlayer().GetSkillLevel(targetSkillData.skillType));
    }
    resultGFxData.SetMemberFlashInt('maxLevel', targetSkillData.maxLevel);
    
    if (targetSkillData.isCoreSkill || CheckIfLocked(targetSkillData))
    {
        skillNumPoitnsNeeded = -1;
    }
    else if (abilityMgr.HasSpentEnoughPoints(targetSkill)) 
    {
        skillNumPoitnsNeeded = 0; 
    }
    else
    {
        abilityMgr = (W3PlayerAbilityManager)thePlayer.abilityManager;
        if( abilityMgr )        
        { 
    //CSU +++      
            vanillaPointsRequired = targetSkillData.requiredPointsSpent - abilityMgr.GetPathPointsSpent(targetSkillData.skillPath);
            if (vanillaPointsRequired < 0) vanillaPointsRequired = 0;
            pointsRequired = vanillaPointsRequired;
        }
        
        //Alt Columns
        if (CSUShouldAltColumnsUnlock()) {
            altColumns = abilityMgr.GetAltColumns();
            found = false;
            for (i = 0; i < altColumns.Size(); i += 1) {
                if      (altColumns[i].s1 == targetSkill) {currentSkillRow = 1; found = true;}
                else if (altColumns[i].s2 == targetSkill) {currentSkillRow = 2; found = true;}
                else if (altColumns[i].s3 == targetSkill) {currentSkillRow = 3; found = true;}
                else if (altColumns[i].s4 == targetSkill) {currentSkillRow = 4; found = true;}
                
                if (found) {
                    threshold = abilityMgr.CSUGetAltColumnThreshold(currentSkillRow);
                    spentInBranch = abilityMgr.GetSkillLevel(altColumns[i].s1) + abilityMgr.GetSkillLevel(altColumns[i].s2) + 
                                    abilityMgr.GetSkillLevel(altColumns[i].s3) + abilityMgr.GetSkillLevel(altColumns[i].s4);
                    altPointsRequired = threshold - spentInBranch;
                    if (altPointsRequired < 0) altPointsRequired = 0;
                    
                    if (!CSUShouldRowsUnlock() || altPointsRequired < pointsRequired || (pointsRequired == 0 && altPointsRequired > 0)) {
                        pointsRequired = altPointsRequired;
                    }
                    break;
                }
            }
        }

        //Perks
        if (targetSkill >= S_Perk_01 && targetSkill <= S_Perk_MAX) {
            if (CSUShouldPerkRowsUnlock() || CSUShouldPerkColumnsUnlock()) {
                 altColumns = abilityMgr.GetPerkColumns();
                 found = false;
                 for (i = 0; i < altColumns.Size(); i += 1) {
                    if      (altColumns[i].s1 == targetSkill) {currentSkillRow = 1; found = true;}
                    else if (altColumns[i].s2 == targetSkill) {currentSkillRow = 2; found = true;}
                    else if (altColumns[i].s3 == targetSkill) {currentSkillRow = 3; found = true;}
                    else if (altColumns[i].s4 == targetSkill) {currentSkillRow = 4; found = true;}
                    else if (altColumns[i].s5 == targetSkill) {currentSkillRow = 5; found = true;}
                    
                    if (found) {
                        threshold = abilityMgr.CSUGetPerkThreshold(currentSkillRow);
                        spentInBranch = abilityMgr.GetPathPointsSpent(ESP_Perks);
                        altPointsRequired = threshold - spentInBranch;
                        if (altPointsRequired < 0) altPointsRequired = 0;
                        
                        if (CSUShouldPerkRowsUnlock()) {
                             if (altPointsRequired > pointsRequired) {
                                 pointsRequired = altPointsRequired;
                             }
                        }
                        else if (!CSUShouldPerkRowsUnlock() && pointsRequired == 0 && altPointsRequired > 0) {
                             pointsRequired = altPointsRequired;
                        }
                        break;
                    }
                 }
            }
        }
    //CSU ---
        skillNumPoitnsNeeded = pointsRequired;
    }
    
    resultGFxData.SetMemberFlashNumber('requiredPointsSpent', skillNumPoitnsNeeded);
    resultGFxData.SetMemberFlashString('IconPath', targetSkillData.iconPath);
    resultGFxData.SetMemberFlashBool('hasEnoughPoints', CheckIfLocked(targetSkillData));
    resultGFxData.SetMemberFlashInt( 'curSkillPoints', GetCurrentSkillPoints() );
    
    m_flashValueStorage.SetFlashObject("context.tooltip.data", resultGFxData);
}
