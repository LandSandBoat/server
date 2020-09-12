-----------------------------------
-- Ability: Sepulcher
-- Description	Lowers accuracy, evasion, magic accuracy, magic evasion and TP gain for undead.
-- Obtained: PLD Level 	87
-- Recast Time: 00:05:00
-- Duration: 00:03:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    target:addStatusEffect(tpz.effect.SEPULCHER,7,0,180)
end