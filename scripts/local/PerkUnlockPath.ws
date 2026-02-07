@addMethod(W3PlayerAbilityManager) public function GetPerkColumns(): array<CSUAltColumn> {
    var columns: array<CSUAltColumn>;
    var col: CSUAltColumn;

    col.columnName = 'PerkCol1'; col.s1 = S_Perk_01; col.s2 = S_Perk_02; col.s3 = S_Perk_13; col.s4 = S_Perk_14; columns.PushBack(col);
    col.columnName = 'PerkCol2'; col.s1 = S_Perk_04; col.s2 = S_Perk_09; col.s3 = S_Perk_17; col.s4 = S_Perk_15; columns.PushBack(col);
    col.columnName = 'PerkCol3'; col.s1 = S_Perk_05; col.s2 = S_Perk_10; col.s3 = S_Perk_18; col.s4 = S_Perk_16; columns.PushBack(col);
    col.columnName = 'PerkCol4'; col.s1 = S_Perk_06; col.s2 = S_Perk_11; col.s3 = S_Perk_19; col.s4 = S_Perk_20; columns.PushBack(col);
    col.columnName = 'PerkCol5'; col.s1 = S_Perk_07; col.s2 = S_Perk_12; col.s3 = S_Perk_22; col.s4 = S_Perk_21; columns.PushBack(col);

    return columns;
}

@addMethod(W3PlayerAbilityManager) public function FindSkillInPerkColumn(skill: ESkill, out columnIndex: int, out rowIndex: int): bool {
    var columns: array<CSUAltColumn>;
    var i: int;

    columns = this.GetPerkColumns();

    for (i = 0; i < columns.Size(); i += 1) {
        if      (columns[i].s1 == skill) {columnIndex = i; rowIndex = 1; return true;}
        else if (columns[i].s2 == skill) {columnIndex = i; rowIndex = 2; return true;}
        else if (columns[i].s3 == skill) {columnIndex = i; rowIndex = 3; return true;}
        else if (columns[i].s4 == skill) {columnIndex = i; rowIndex = 4; return true;}
        else if (columns[i].s5 == skill) {columnIndex = i; rowIndex = 5; return true;}
    }

    return false;
}

@addMethod(W3PlayerAbilityManager) public function IsPerkRequirementMet(skill: ESkill): bool {
    var columns: array<CSUAltColumn>;
    var columnIndex, rowIndex: int;
    var totalSpentBranch: int;
    var rowMet, colMet: bool;
    var rowActive: bool = CSUShouldPerkRowsUnlock();
    var colActive: bool = CSUShouldPerkColumnsUnlock();
    
    if (skill < S_Perk_01 || skill > S_Perk_MAX) {
        return true;
    }

    if (!rowActive && !colActive) {
        return true;                        //Both disabled = all unlocked (Vanilla)
    }

    if (!this.FindSkillInPerkColumn(skill, columnIndex, rowIndex)) {    //Better safe than sorry
        if (!rowActive) {
            return true;
        }
        return (this.GetPathPointsSpent(ESP_Perks) >= 1);
    }

    columns = this.GetPerkColumns();

    if (rowActive) {
        totalSpentBranch = this.GetPathPointsSpent(ESP_Perks);
        rowMet = (totalSpentBranch >= this.CSUGetPerkThreshold(rowIndex));
    }

    if (colActive) {
        switch(rowIndex) {
            case 1:  colMet = true; break;
            case 2:  colMet = (this.GetSkillLevel(columns[columnIndex].s1) > 0); break;
            case 3:  colMet = (this.GetSkillLevel(columns[columnIndex].s2) > 0); break;
            case 4:  colMet = (this.GetSkillLevel(columns[columnIndex].s3) > 0); break;
            case 5:  colMet = (this.GetSkillLevel(columns[columnIndex].s4) > 0); break;
            default: colMet = true;
        }
    }

    return rowMet || colMet;
}

@addMethod(W3PlayerAbilityManager) public function CSUGetPerkThreshold(row: int): int {
    switch(row) {
        case 1:  
            return 0;      //Tier 1: Always open
        case 2:  
            return 1;      //Tier 2: 1 point
        case 3:  
            return 3;      //Tier 3: 3 points
        case 4:  
            return 6;      //Tier 4: 6 points
        case 5:  
            return 9;      //Tier 5: 9 points
        default: 
            return 0;
    }
}

