-----------------------------------
-- Original pDIF caps for the base game.
-- Date : 2007-08-27 (One day before the ToAU 2H update)
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('original_pdif_caps', xi.pre(xi.expansion.WOTG))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.combat.physical.pDifWeaponCapTable[xi.skill.HAND_TO_HAND    ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.DAGGER          ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.SWORD           ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.GREAT_SWORD     ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.AXE             ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.GREAT_AXE       ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.SCYTHE          ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.POLEARM         ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.KATANA          ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.GREAT_KATANA    ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.CLUB            ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.STAFF           ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.AUTOMATON_MELEE ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.AUTOMATON_RANGED] = 3
    xi.combat.physical.pDifWeaponCapTable[xi.skill.AUTOMATON_MAGIC ] = 2
    xi.combat.physical.pDifWeaponCapTable[xi.skill.ARCHERY         ] = 3
    xi.combat.physical.pDifWeaponCapTable[xi.skill.MARKSMANSHIP    ] = 3
    xi.combat.physical.pDifWeaponCapTable[xi.skill.THROWING        ] = 3
    xi.combat.physical.pDifWeaponCapTable[xi.skill.BLUE_MAGIC      ] = 2
end)

m:addOverride('xi.combat.physical.wRatioCapPC', function(wRatio, pDifFinalCap)
    local pDifUpperCap = 0
    local pDifLowerCap = 0

    if wRatio < 0.5 then
        pDifUpperCap = wRatio + 0.5
    elseif wRatio < 0.7 then
        pDifUpperCap = 1
    elseif wRatio < 1.2 then
        pDifUpperCap = wRatio + 0.3
    elseif wRatio < 1.5 then
        pDifUpperCap = wRatio + wRatio * 0.25
    else
        pDifUpperCap = math.min(wRatio, pDifFinalCap) + 0.375
    end

    if wRatio < 0.38 then
        pDifLowerCap = 0
    elseif wRatio < 1.25 then
        pDifLowerCap = wRatio * 1176 / 1024 - 448 / 1024
    elseif wRatio < 1.51 then
        pDifLowerCap = 1
    elseif wRatio < 2.44 then
        pDifLowerCap = wRatio * 1176 / 1024 - 775 / 1024
    else
        pDifLowerCap = math.min(wRatio, pDifFinalCap) - 0.375
    end

    return pDifLowerCap, pDifUpperCap
end)
