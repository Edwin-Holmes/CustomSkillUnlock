// Track unlocked skills in columns
@addField(W3PlayerAbilityManager) 
private var columnUnlockedSkills: array<ESkill>;

@addMethod(W3PlayerAbilityManager) private function InitColumnArray() {
    columnUnlockedSkills.Clear(); // Initialize empty list
}

// Initialize and return skill dependencies
@addMethod(W3PlayerAbilityManager) private function GetSkillDependencies(out childSkills: array<ESkill>, out parentSkills: array<ESkill>) {
    // Sword Branch
    childSkills.PushBack(S_Sword_s17); parentSkills.PushBack(S_Sword_s21); // Fast column
    childSkills.PushBack(S_Sword_s01); parentSkills.PushBack(S_Sword_s17);
    childSkills.PushBack(S_Sword_s05); parentSkills.PushBack(S_Sword_s01);
    childSkills.PushBack(S_Sword_s08); parentSkills.PushBack(S_Sword_s04); // Strong column
    childSkills.PushBack(S_Sword_s02); parentSkills.PushBack(S_Sword_s08);
    childSkills.PushBack(S_Sword_s06); parentSkills.PushBack(S_Sword_s02);
    childSkills.PushBack(S_Sword_s09); parentSkills.PushBack(S_Sword_s10); // Defense column
    childSkills.PushBack(S_Sword_s11); parentSkills.PushBack(S_Sword_s09);
    childSkills.PushBack(S_Sword_s03); parentSkills.PushBack(S_Sword_s11);
    childSkills.PushBack(S_Sword_s15); parentSkills.PushBack(S_Sword_s13); // Marksmanship column
    childSkills.PushBack(S_Sword_s07); parentSkills.PushBack(S_Sword_s15);
    childSkills.PushBack(S_Sword_s12); parentSkills.PushBack(S_Sword_s07);
    childSkills.PushBack(S_Sword_s18); parentSkills.PushBack(S_Sword_s16); // Battle Trance column
    childSkills.PushBack(S_Sword_s20); parentSkills.PushBack(S_Sword_s18);
    childSkills.PushBack(S_Sword_s19); parentSkills.PushBack(S_Sword_s20);
    
    // Signs Branch
    childSkills.PushBack(S_Magic_s01); parentSkills.PushBack(S_Magic_s20); // Aard column
    childSkills.PushBack(S_Magic_s12); parentSkills.PushBack(S_Magic_s01);
    childSkills.PushBack(S_Magic_s06); parentSkills.PushBack(S_Magic_s12);
    childSkills.PushBack(S_Magic_s02); parentSkills.PushBack(S_Magic_s08); // Igni column
    childSkills.PushBack(S_Magic_s07); parentSkills.PushBack(S_Magic_s02);
    childSkills.PushBack(S_Magic_s09); parentSkills.PushBack(S_Magic_s07);
    childSkills.PushBack(S_Magic_s03); parentSkills.PushBack(S_Magic_s10); // Yrden column
    childSkills.PushBack(S_Magic_s16); parentSkills.PushBack(S_Magic_s03);
    childSkills.PushBack(S_Magic_s11); parentSkills.PushBack(S_Magic_s16);
    childSkills.PushBack(S_Magic_s04); parentSkills.PushBack(S_Magic_s13); // Quen column
    childSkills.PushBack(S_Magic_s15); parentSkills.PushBack(S_Magic_s04);
    childSkills.PushBack(S_Magic_s14); parentSkills.PushBack(S_Magic_s15);
    childSkills.PushBack(S_Magic_s05); parentSkills.PushBack(S_Magic_s17); // Axii column
    childSkills.PushBack(S_Magic_s18); parentSkills.PushBack(S_Magic_s05);
    childSkills.PushBack(S_Magic_s19); parentSkills.PushBack(S_Magic_s18);
    
    // Alchemy Branch  
    childSkills.PushBack(S_Alchemy_s02); parentSkills.PushBack(S_Alchemy_s01);  // Potions column  
    childSkills.PushBack(S_Alchemy_s03); parentSkills.PushBack(S_Alchemy_s02);  
    childSkills.PushBack(S_Alchemy_s04); parentSkills.PushBack(S_Alchemy_s03);  
    childSkills.PushBack(S_Alchemy_s05); parentSkills.PushBack(S_Alchemy_s12);  // Oils column  
    childSkills.PushBack(S_Alchemy_s06); parentSkills.PushBack(S_Alchemy_s05);  
    childSkills.PushBack(S_Alchemy_s07); parentSkills.PushBack(S_Alchemy_s06);  
    childSkills.PushBack(S_Alchemy_s10); parentSkills.PushBack(S_Alchemy_s09);  // Bombs column  
    childSkills.PushBack(S_Alchemy_s08); parentSkills.PushBack(S_Alchemy_s10);  
    childSkills.PushBack(S_Alchemy_s11); parentSkills.PushBack(S_Alchemy_s08);  
    childSkills.PushBack(S_Alchemy_s13); parentSkills.PushBack(S_Alchemy_s18);  // Mutagens column  
    childSkills.PushBack(S_Alchemy_s19); parentSkills.PushBack(S_Alchemy_s13);  
    childSkills.PushBack(S_Alchemy_s14); parentSkills.PushBack(S_Alchemy_s19);  
    childSkills.PushBack(S_Alchemy_s20); parentSkills.PushBack(S_Alchemy_s16);  // Trial of the Grasses column  
    childSkills.PushBack(S_Alchemy_s15); parentSkills.PushBack(S_Alchemy_s20);
    childSkills.PushBack(S_Alchemy_s17); parentSkills.PushBack(S_Alchemy_s15);
}

// Push unlocked skills to the columnUnlockedSkills array
@addMethod(W3PlayerAbilityManager) public function UpdateColumnUnlocks() {  
    var skills: array<SSkill> = thePlayer.GetPlayerSkills(); // Retrieve the player's skills  
    var childSkills: array<ESkill>;  
    var parentSkills: array<ESkill>;  
    var i: int;  
    var parentSkillIndex: int;  
    var childSkillIndex: int;  
  
    GetSkillDependencies(childSkills, parentSkills);  

    // Check childdskills and find parent skill in player's skills
    for (i = 0; i < childSkills.Size(); i += 1) {
        parentSkillIndex = CSUFindSkillIndex(parentSkills[i], skills);  
        // Check parent is max level
        if (parentSkillIndex != -1 && skills[parentSkillIndex].level == skills[parentSkillIndex].maxLevel) {  
            childSkillIndex = CSUFindSkillIndex(childSkills[i], skills);  

            if (childSkillIndex != -1 && !columnUnlockedSkills.Contains(childSkills[i])) {  
                columnUnlockedSkills.PushBack(childSkills[i]); // Track unlocked skill  
            }  
        }  
    }  
}