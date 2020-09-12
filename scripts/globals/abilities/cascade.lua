-----------------------------------
-- Ability: Cascade
-- Description	Grants a damage bonus to the next elemental magic spell cast based on TP consumed.
-- Obtained: BLM Level 	85
-- Recast Time: 00:01:00
-- Duration: 0:01:00 or the next spell cast
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.CASCADE,4,0,60 or the next spell cast)
end