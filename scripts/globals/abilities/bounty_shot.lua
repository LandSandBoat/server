-----------------------------------
-- Ability: Bounty Shot
-- Description: Increases the rate at which the target yields treasure.
-- Obtained: RNG Level 87
-- Recast Time: 00:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    -- target:addStatusEffect(xi.effect.BOUNTY_SHOT, 11, 1, 30) -- TODO: implement xi.effect.BOUNTY_SHOT
end

return ability_object
