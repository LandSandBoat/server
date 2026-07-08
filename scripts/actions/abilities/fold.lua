-----------------------------------
-- Ability: Fold
-- Erases one roll or bust xi.effect. Targets self-cast effect with the longest remaining duration.
-- Obtained: Corsair Level 75
-- Recast Time: 00:05:00
-- Duration: Instant
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.corsair.checkFold(player)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.corsair.useFold(player, action)
end

return abilityObject
