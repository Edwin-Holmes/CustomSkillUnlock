struct CSUAltColumn {
    var columnName: name;
    var s1, s2, s3, s4: ESkill;
}

@addMethod(W3PlayerAbilityManager) private function GetAltColumns(): array<CSUAltColumn> {
    var columns: array<CSUAltColumn>;
    var col: CSUAltColumn;

    // Sword Branch
    col.columnName = 'Fast';         col.s1 = S_Sword_s21; col.s2 = S_Sword_s17; col.s3 = S_Sword_s01; col.s4 = S_Sword_s05; columns.PushBack(col);
    col.columnName = 'Strong';       col.s1 = S_Sword_s04; col.s2 = S_Sword_s08; col.s3 = S_Sword_s02; col.s4 = S_Sword_s06; columns.PushBack(col);
    col.columnName = 'Defense';      col.s1 = S_Sword_s10; col.s2 = S_Sword_s09; col.s3 = S_Sword_s11; col.s4 = S_Sword_s03; columns.PushBack(col);
    col.columnName = 'Marksmanship'; col.s1 = S_Sword_s13; col.s2 = S_Sword_s15; col.s3 = S_Sword_s07; col.s4 = S_Sword_s12; columns.PushBack(col);
    col.columnName = 'BattleTrance'; col.s1 = S_Sword_s16; col.s2 = S_Sword_s18; col.s3 = S_Sword_s20; col.s4 = S_Sword_s19; columns.PushBack(col);

    // Signs Branch
    col.columnName = 'Aard';         col.s1 = S_Magic_s20; col.s2 = S_Magic_s01; col.s3 = S_Magic_s12; col.s4 = S_Magic_s06; columns.PushBack(col);
    col.columnName = 'Igni';         col.s1 = S_Magic_s08; col.s2 = S_Magic_s02; col.s3 = S_Magic_s07; col.s4 = S_Magic_s09; columns.PushBack(col);
    col.columnName = 'Yrden';        col.s1 = S_Magic_s10; col.s2 = S_Magic_s03; col.s3 = S_Magic_s16; col.s4 = S_Magic_s11; columns.PushBack(col);
    col.columnName = 'Quen';         col.s1 = S_Magic_s13; col.s2 = S_Magic_s04; col.s3 = S_Magic_s15; col.s4 = S_Magic_s14; columns.PushBack(col);
    col.columnName = 'Axii';         col.s1 = S_Magic_s17; col.s2 = S_Magic_s05; col.s3 = S_Magic_s18; col.s4 = S_Magic_s19; columns.PushBack(col);

    // Alchemy Branch
    col.columnName = 'Potions';      col.s1 = S_Alchemy_s01; col.s2 = S_Alchemy_s02; col.s3 = S_Alchemy_s03; col.s4 = S_Alchemy_s04; columns.PushBack(col);
    col.columnName = 'Oils';         col.s1 = S_Alchemy_s12; col.s2 = S_Alchemy_s05; col.s3 = S_Alchemy_s06; col.s4 = S_Alchemy_s07; columns.PushBack(col);
    col.columnName = 'Bombs';        col.s1 = S_Alchemy_s09; col.s2 = S_Alchemy_s10; col.s3 = S_Alchemy_s08; col.s4 = S_Alchemy_s11; columns.PushBack(col);
    col.columnName = 'Mutagens';     col.s1 = S_Alchemy_s18; col.s2 = S_Alchemy_s13; col.s3 = S_Alchemy_s19; col.s4 = S_Alchemy_s14; columns.PushBack(col);
    col.columnName = 'Trial';        col.s1 = S_Alchemy_s16; col.s2 = S_Alchemy_s20; col.s3 = S_Alchemy_s15; col.s4 = S_Alchemy_s17; columns.PushBack(col);

    return columns;
}

@addMethod(W3PlayerAbilityManager) public function IsAltColumnRequirementMet(skill: ESkill): bool {
    var columns: array<CSUAltColumn>;
    var i, currentSkillRow, totalSpent: int;
    var found: bool = false;

    if (!CSUShouldAltColumnsUnlock()) {
        return false;
    }

    columns = this.GetAltColumns();

    for (i = 0; i < columns.Size(); i += 1) {
        if      (columns[i].s1 == skill) { currentSkillRow = 1; found = true; }
        else if (columns[i].s2 == skill) { currentSkillRow = 2; found = true; }
        else if (columns[i].s3 == skill) { currentSkillRow = 3; found = true; }
        else if (columns[i].s4 == skill) { currentSkillRow = 4; found = true; }

        if (found) {
            // Calculate total points spent in this specific column
            totalSpent = this.GetSkillLevel(columns[i].s1) + this.GetSkillLevel(columns[i].s2) + 
                         this.GetSkillLevel(columns[i].s3) + this.GetSkillLevel(columns[i].s4);

            // Check thresholds per row
            switch(currentSkillRow) {
                case 1:  return true;            // Row 1: Always unlocked
                case 2:  return totalSpent >= 1; // Row 2: Need 1 point in column
                case 3:  return totalSpent >= 3; // Row 3: Need 3 points in column
                case 4:  return totalSpent >= 6; // Row 4: Need 6 points in column
                default: return true;
            }
        }
    }

    return true; // Not part of the alt unlock system
}
