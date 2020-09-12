-----------------------------------
-- Ability: Sacrosanctity
-- Description	Enhances magic defense for party members within area of effect.
-- Obtained: WHM Level 95
-- Recast Time: 00:10:00
-- Duration: 0:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.SACROSANCTITY,3,0,60)
end