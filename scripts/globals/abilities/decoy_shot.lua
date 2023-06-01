-----------------------------------
-- Ability: Decoy Shot
-- Description: Diverts enmity when launching a ranged attack from behind a party member.
-- Obtained: RNG Level 95
-- Recast Time: 00:05:00
-- Duration: 00:03:00
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    target:addStatusEffect(xi.effect.DECOY_SHOT, 11, 1, 30)
end

return abilityObject
