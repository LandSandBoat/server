-----------------------------------
-- Ability: Contradance
-- Description Increases the amount of HP restored by your next Waltz.
-- Obtained: DNC Level 50
-- Recast Time: 00:05:00
-- Duration: 00:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.CONTRADANCE,19,1,60)
end