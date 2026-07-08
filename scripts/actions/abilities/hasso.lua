-----------------------------------
-- Ability: Hasso
-- Grants a bonus to attack speed, accuracy, and Strength when using two-handed weapons, but increases recast and casting times.
-- Obtained: Samurai Level 25
-- Recast Time: 1:00
-- Duration: 5:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.samurai.checkHasso(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.samurai.useHasso(player, target, ability)
end

return abilityObject
