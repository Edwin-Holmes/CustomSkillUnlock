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
    
    var originSkillLevel      : int;
    var boostedSkillLevel     : int;

    //CSU +++
    var altPointsRequired, vanillaPointsRequired, threshold, spentInBranch: int;
    var columnIndex, rowIndex: int;
    var pointsRequired: int;
    
    //If vanilla settings, give me two scoops of vanilla
    if ( !CSUShouldAltColumnsUnlock() && !CSUShouldColumnsUnlock() 
        && !CSUShouldPerkRowsUnlock() && !CSUShouldPerkColumnsUnlock() ) {
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

        //Simple column alone
        if (CSUShouldColumnsUnlock() && !CSUShouldRowsUnlock()) { 
            pointsRequired = -1; 
        }
        
        //Alt column
        if (CSUShouldAltColumnsUnlock() && abilityMgr.FindSkillInAltColumn(targetSkill, columnIndex, rowIndex)) {
            threshold = abilityMgr.CSUGetAltColumnThreshold(rowIndex);
            spentInBranch = abilityMgr.GetAltColumnTotalSpent(columnIndex);
            altPointsRequired = threshold - spentInBranch;
            if (altPointsRequired < 0) altPointsRequired = 0;
            
            if (!CSUShouldRowsUnlock() || altPointsRequired < pointsRequired) {     //Alt column alone or Alt column < vanilla rows
                pointsRequired = altPointsRequired;                                 //Show column requirement
            }
        }

        //Perks
        if (targetSkill >= S_Perk_01 && targetSkill <= S_Perk_MAX) {
            if ((CSUShouldPerkRowsUnlock() || CSUShouldPerkColumnsUnlock()) && abilityMgr.FindSkillInPerkColumn(targetSkill, columnIndex, rowIndex)) {
                threshold = abilityMgr.CSUGetPerkThreshold(rowIndex);
                spentInBranch = abilityMgr.GetPathPointsSpent(ESP_Perks);
                altPointsRequired = threshold - spentInBranch;
                if (altPointsRequired < 0) altPointsRequired = 0;

                if (CSUShouldPerkColumnsUnlock() && !CSUShouldPerkRowsUnlock()) {   //hide for column
                    altPointsRequired = -1;
                }
                
                if (CSUShouldPerkRowsUnlock() || altPointsRequired == -1) {         //If it's rows, it shows
                         pointsRequired = altPointsRequired;
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
