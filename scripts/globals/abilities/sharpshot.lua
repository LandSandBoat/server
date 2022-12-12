-----------------------------------
-- Ability: Sharpshot
-- Increases ranged accuracy.
-- Obtained: Ranger Level 1
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
    local power = 40 + player:getMod(xi.mod.SHARPSHOT)
    player:addStatusEffect(xi.effect.SHARPSHOT, power, 0, 60)
end

return abilityObject
