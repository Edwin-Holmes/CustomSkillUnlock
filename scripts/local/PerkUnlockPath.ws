struct CSURowThreshold {
    var row: int;
    var threshold: int;
}

@addMethod(W3PlayerAbilityManager) private function GetPerkColumns(): array<CSUAltColumn> {
    var columns: array<CSUAltColumn>;
    var col: CSUAltColumn;

    col.columnName = 'PerkCol1'; col.s1 = S_Perk_01; col.s2 = S_Perk_02; col.s3 = S_Perk_13; col.s4 = S_Perk_14; columns.PushBack(col);
    col.columnName = 'PerkCol2'; col.s1 = S_Perk_04; col.s2 = S_Perk_09; col.s3 = S_Perk_17; col.s4 = S_Perk_15; columns.PushBack(col);
    col.columnName = 'PerkCol3'; col.s1 = S_Perk_05; col.s2 = S_Perk_10; col.s3 = S_Perk_18; col.s4 = S_Perk_16; columns.PushBack(col);
    col.columnName = 'PerkCol4'; col.s1 = S_Perk_06; col.s2 = S_Perk_11; col.s3 = S_Perk_19; col.s4 = S_Perk_20; columns.PushBack(col);
    col.columnName = 'PerkCol5'; col.s1 = S_Perk_07; col.s2 = S_Perk_12; col.s3 = S_Perk_22; col.s4 = S_Perk_21; columns.PushBack(col);

    return columns;
}

@addMethod(W3PlayerAbilityManager) public function IsPerkRequirementMet(skill: ESkill): bool {
    var columns: array<CSUAltColumn>;
    var i, currentSkillRow, totalSpentCol, totalSpentBranch: int;
    var foundInGrid: bool = false;
    var rowMet: bool = false;
    var colMet: bool = false;
    var rowActive: bool = CSUShouldPerkRowsUnlock();
    var colActive: bool = CSUShouldPerkColumnsUnlock();
    
    if (skill < S_Perk_01 || skill > S_Perk_MAX) {
        return true;
    }

    // Both disabled = all perks unlocked (No requirements)
    if (!rowActive && !colActive) {
        return true;
    }

    // Determine position in the grid once
    columns = this.GetPerkColumns();
    for (i = 0; i < columns.Size(); i += 1) {
        if      (columns[i].s1 == skill) { currentSkillRow = 1; foundInGrid = true; }
        else if (columns[i].s2 == skill) { currentSkillRow = 2; foundInGrid = true; }
        else if (columns[i].s3 == skill) { currentSkillRow = 3; foundInGrid = true; }
        else if (columns[i].s4 == skill) { currentSkillRow = 4; foundInGrid = true; }

        if (foundInGrid) {
            break;
        }
    }

    // Skills not in our grid are not restricted by column logic, but follow Row logic if active
    if (!foundInGrid) {
        if (!rowActive) return true;
        totalSpentBranch = this.GetPathPointsSpent(ESP_Perks);
        return (totalSpentBranch >= 1);
    }

    // --- Row Unlock Logic (Global branch spending) ---
    if (rowActive) {
        totalSpentBranch = this.GetPathPointsSpent(ESP_Perks);
        switch(currentSkillRow) {
            case 1:  rowMet = true; break;
            case 2:  rowMet = (totalSpentBranch >= 1); break;
            case 3:  rowMet = (totalSpentBranch >= 3); break;
            case 4:  rowMet = (totalSpentBranch >= 6); break;
            default: rowMet = true;
        }
    }

    // --- Column Unlock Logic (Immediate parent chain) ---
    if (colActive) {
        switch(currentSkillRow) {
            case 1:  colMet = true; break;
            case 2:  colMet = (this.GetSkillLevel(columns[i].s1) > 0); break; // Parent in grid
            case 3:  colMet = (this.GetSkillLevel(columns[i].s2) > 0); break;
            case 4:  colMet = (this.GetSkillLevel(columns[i].s3) > 0); break;
            default: colMet = true;
        }
    }

    return rowMet || colMet;
}
