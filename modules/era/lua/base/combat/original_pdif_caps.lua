-----------------------------------
-- Original pDIF caps for the base game.
-- Date : 2007-08-27 (One day before the ToAU 2H update)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('original_pdif_caps')

xi.combat.physical.pDifWeaponCapTable[xi.skill.HAND_TO_HAND    ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.DAGGER          ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.SWORD           ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.GREAT_SWORD     ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.AXE             ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.GREAT_AXE       ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.SCYTHE          ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.POLEARM         ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.KATANA          ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.GREAT_KATANA    ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.CLUB            ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.STAFF           ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.AUTOMATON_MELEE ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.AUTOMATON_RANGED] = { 3, 3 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.AUTOMATON_MAGIC ] = { 2, 2 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.ARCHERY         ] = { 3, 3 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.MARKSMANSHIP    ] = { 3, 3 }
xi.combat.physical.pDifWeaponCapTable[xi.skill.THROWING        ] = { 3, 3 }

return m
