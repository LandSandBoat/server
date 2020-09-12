-----------------------------------
-- Ability: Efflux
-- Description If the next spell you cast is a "physical" Blue magic spell, a TP bonus will be granted.
-- Obtained: BLU Level 83
-- Recast Time: 00:03:00
-- Duration: 00:01:00 or first blue magic cast
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.EFFLUX,16,1,60)
end