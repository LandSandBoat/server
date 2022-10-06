-----------------------------------
-- Ability: Arcane Circle
-- Grants resistance, defense, and attack against Arcana to party members within the area of effect.
-- Obtained: Dark Knight Level 5
-- Recast Time: 5:00 minutes
-- Duration: 3:00 minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local duration = 180 + player:getMod(xi.mod.ARCANE_CIRCLE_DURATION)
    local power = 5

    if player:getMainJob() == xi.job.DRK then
        power = 15
    end

    target:addStatusEffect(xi.effect.ARCANE_CIRCLE, power, 0, duration)
end

return abilityObject
