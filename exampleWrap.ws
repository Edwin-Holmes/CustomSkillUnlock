@wrapMethod(CR4CharacterMenu)
function GetSkillTooltipData(targetSkill : ESkill, compareItemType : int, isGridView : bool)
{
    var targetSkillData : SSkill;
    var spentAbove : int;
    var req : int;
    var needed : int;
    var am : W3PlayerAbilityManager;

    wrappedMethod(targetSkill, compareItemType, isGridView);

    if(CSUShouldColumnsUnlock() && !CSUShouldRowsUnlock())
    {
        targetSkillData = thePlayer.GetPlayerSkill(targetSkill);
        
        if(targetSkillData.isCoreSkill)
            return;

        am = (W3PlayerAbilityManager)GetWitcherPlayer().abilityManager;
        
        if(!am)
            return;

        req = am.CSUGetCustomRequiredForSkill(targetSkill);
        spentAbove = am.CSUGetBoughtPointsAboveInColumnChain(targetSkill);
        needed = req - spentAbove;
        
        if(needed < 0) needed = 0;

        m_flashValueStorage.SetFlashNumber("context.tooltip.data.requiredPointsSpent", needed);
    }
}

//In the original CR4CharacterMenu
private function GetSkillTooltipData(targetSkill : ESkill, compareItemType : int, isGridView : bool)
	{
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
		else
		{
			abilityMgr = (W3PlayerAbilityManager)thePlayer.abilityManager;
			
			if(abilityMgr && CSUShouldColumnsUnlock() && !CSUShouldRowsUnlock()) //<- Mod Starts
			{
				pathPointsSpent = abilityMgr.CSUGetCustomRequiredForSkill(targetSkill) - abilityMgr.CSUGetBoughtPointsAboveInColumnChain(targetSkill);
				if(pathPointsSpent < 0) pathPointsSpent = 0;
			}
			else
			{
				if(abilityMgr)
					pathPointsSpent = targetSkillData.requiredPointsSpent - abilityMgr.GetPathPointsSpent(targetSkillData.skillPath);
				else
					pathPointsSpent = targetSkillData.requiredPointsSpent;
			}
			/*if( abilityMgr )
			{
				pathPointsSpent = targetSkillData.requiredPointsSpent - abilityMgr.GetPathPointsSpent( targetSkillData.skillPath );
			}
			else
			{
				pathPointsSpent = targetSkillData.requiredPointsSpent;
			}*/ //<- Mod Ends
			
			skillNumPoitnsNeeded = pathPointsSpent;
		}
		
		resultGFxData.SetMemberFlashNumber('requiredPointsSpent', skillNumPoitnsNeeded);
		resultGFxData.SetMemberFlashString('IconPath', targetSkillData.iconPath);
		resultGFxData.SetMemberFlashBool('hasEnoughPoints', CheckIfLocked(targetSkillData));
		resultGFxData.SetMemberFlashInt( 'curSkillPoints', GetCurrentSkillPoints() );
		
		m_flashValueStorage.SetFlashObject("context.tooltip.data", resultGFxData);
	}