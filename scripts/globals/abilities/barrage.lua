-----------------------------------
-- Ability: Barrage
-- Fires multiple shots at once.
-- Obtained: Ranger Level 30
-- Recast Time: 5:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.BARRAGE, 0, 0, 60)
end

return abilityObject
