-----------------------------------
-- Ability: Efflux
-- Description: If the next spell you cast is a "physical" Blue magic spell, a TP bonus will be granted.
-- Obtained: BLU Level 83
-- Recast Time: 00:03:00
-- Duration: 00:01:00 or first blue magic cast
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.EFFLUX, 16, 1, 60)
end

return abilityObject
