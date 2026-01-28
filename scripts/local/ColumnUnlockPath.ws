struct ColumnUnlockPair {
    var parentSkill: ESkill;
    var childSkill: ESkill;
};

// Initialize and return skill dependencies
@addMethod(W3PlayerAbilityManager) private function GetColumnUnlockPairs() : array<ColumnUnlockPair> {
    var columnPairs: array<ColumnUnlockPair>;
    var columnUnlock: ColumnUnlockPair;
    
    // Sword Branch
    columnUnlock.parentSkill = S_Sword_s21; columnUnlock.childSkill = S_Sword_s17; columnPairs.PushBack(columnUnlock); // Fast column
    columnUnlock.parentSkill = S_Sword_s17; columnUnlock.childSkill = S_Sword_s01; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Sword_s01; columnUnlock.childSkill = S_Sword_s05; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Sword_s04; columnUnlock.childSkill = S_Sword_s08; columnPairs.PushBack(columnUnlock); // Strong column
    columnUnlock.parentSkill = S_Sword_s08; columnUnlock.childSkill = S_Sword_s02; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Sword_s02; columnUnlock.childSkill = S_Sword_s06; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Sword_s10; columnUnlock.childSkill = S_Sword_s09; columnPairs.PushBack(columnUnlock); // Defense column
    columnUnlock.parentSkill = S_Sword_s09; columnUnlock.childSkill = S_Sword_s11; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Sword_s11; columnUnlock.childSkill = S_Sword_s03; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Sword_s13; columnUnlock.childSkill = S_Sword_s15; columnPairs.PushBack(columnUnlock); // Marksmanship column
    columnUnlock.parentSkill = S_Sword_s15; columnUnlock.childSkill = S_Sword_s07; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Sword_s07; columnUnlock.childSkill = S_Sword_s12; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Sword_s16; columnUnlock.childSkill = S_Sword_s18; columnPairs.PushBack(columnUnlock); // Battle Trance column
    columnUnlock.parentSkill = S_Sword_s18; columnUnlock.childSkill = S_Sword_s20; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Sword_s20; columnUnlock.childSkill = S_Sword_s19; columnPairs.PushBack(columnUnlock);
    
    // Signs Branch
    columnUnlock.parentSkill = S_Magic_s20; columnUnlock.childSkill = S_Magic_s01; columnPairs.PushBack(columnUnlock); // Aard column
    columnUnlock.parentSkill = S_Magic_s01; columnUnlock.childSkill = S_Magic_s12; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Magic_s12; columnUnlock.childSkill = S_Magic_s06; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Magic_s08; columnUnlock.childSkill = S_Magic_s02; columnPairs.PushBack(columnUnlock); // Igni column
    columnUnlock.parentSkill = S_Magic_s02; columnUnlock.childSkill = S_Magic_s07; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Magic_s07; columnUnlock.childSkill = S_Magic_s09; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Magic_s10; columnUnlock.childSkill = S_Magic_s03; columnPairs.PushBack(columnUnlock); // Yrden column
    columnUnlock.parentSkill = S_Magic_s03; columnUnlock.childSkill = S_Magic_s16; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Magic_s16; columnUnlock.childSkill = S_Magic_s11; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Magic_s13; columnUnlock.childSkill = S_Magic_s04; columnPairs.PushBack(columnUnlock); // Quen column
    columnUnlock.parentSkill = S_Magic_s04; columnUnlock.childSkill = S_Magic_s15; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Magic_s15; columnUnlock.childSkill = S_Magic_s14; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Magic_s17; columnUnlock.childSkill = S_Magic_s05; columnPairs.PushBack(columnUnlock); // Axii column
    columnUnlock.parentSkill = S_Magic_s05; columnUnlock.childSkill = S_Magic_s18; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Magic_s18; columnUnlock.childSkill = S_Magic_s19; columnPairs.PushBack(columnUnlock);
    
    // Alchemy Branch  
    columnUnlock.parentSkill = S_Alchemy_s01; columnUnlock.childSkill = S_Alchemy_s02; columnPairs.PushBack(columnUnlock);  // Potions column  
    columnUnlock.parentSkill = S_Alchemy_s02; columnUnlock.childSkill = S_Alchemy_s03; columnPairs.PushBack(columnUnlock);  
    columnUnlock.parentSkill = S_Alchemy_s03; columnUnlock.childSkill = S_Alchemy_s04; columnPairs.PushBack(columnUnlock);  
    columnUnlock.parentSkill = S_Alchemy_s12; columnUnlock.childSkill = S_Alchemy_s05; columnPairs.PushBack(columnUnlock);  // Oils column  
    columnUnlock.parentSkill = S_Alchemy_s05; columnUnlock.childSkill = S_Alchemy_s06; columnPairs.PushBack(columnUnlock);  
    columnUnlock.parentSkill = S_Alchemy_s06; columnUnlock.childSkill = S_Alchemy_s07; columnPairs.PushBack(columnUnlock);  
    columnUnlock.parentSkill = S_Alchemy_s09; columnUnlock.childSkill = S_Alchemy_s10; columnPairs.PushBack(columnUnlock);  // Bombs column  
    columnUnlock.parentSkill = S_Alchemy_s10; columnUnlock.childSkill = S_Alchemy_s08; columnPairs.PushBack(columnUnlock);  
    columnUnlock.parentSkill = S_Alchemy_s08; columnUnlock.childSkill = S_Alchemy_s11; columnPairs.PushBack(columnUnlock);  
    columnUnlock.parentSkill = S_Alchemy_s18; columnUnlock.childSkill = S_Alchemy_s13; columnPairs.PushBack(columnUnlock);  // Mutagens column  
    columnUnlock.parentSkill = S_Alchemy_s13; columnUnlock.childSkill = S_Alchemy_s19; columnPairs.PushBack(columnUnlock);  
    columnUnlock.parentSkill = S_Alchemy_s19; columnUnlock.childSkill = S_Alchemy_s14; columnPairs.PushBack(columnUnlock);  
    columnUnlock.parentSkill = S_Alchemy_s16; columnUnlock.childSkill = S_Alchemy_s20; columnPairs.PushBack(columnUnlock);  // Trial of the Grasses column  
    columnUnlock.parentSkill = S_Alchemy_s20; columnUnlock.childSkill = S_Alchemy_s15; columnPairs.PushBack(columnUnlock);
    columnUnlock.parentSkill = S_Alchemy_s15; columnUnlock.childSkill = S_Alchemy_s17; columnPairs.PushBack(columnUnlock);
    
    return columnPairs;
}

@addMethod(W3PlayerAbilityManager)
public function IsColumnRequirementMet(skill : ESkill) : bool {
    var pairs : array<ColumnUnlockPair>;
    var i : int;
    var skills : array<SSkill>;
    var parentIndex : int;

    if (!CSUShouldColumnsUnlock()) return false;

    pairs = this.GetColumnUnlockPairs();
    skills = thePlayer.GetPlayerSkills();

    for (i = 0; i < pairs.Size(); i += 1) {
        if (pairs[i].childSkill == skill) {
            parentIndex = CSUFindSkillIndex(pairs[i].parentSkill, skills);
            if (parentIndex != -1 && skills[parentIndex].level == skills[parentIndex].maxLevel) {
                return true;
            }
        }
    }
    return false;
}
