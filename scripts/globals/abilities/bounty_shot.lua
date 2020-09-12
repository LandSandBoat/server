-----------------------------------
-- Ability: Bounty Shot
-- Description Increases the rate at which the target yields treasure.
-- Obtained: RNG Level 87
-- Recast Time: 00:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    target:addStatusEffect(tpz.effect.BOUNTY_SHOT,11,1,30)
end