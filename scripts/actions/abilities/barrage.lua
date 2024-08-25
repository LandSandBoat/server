-----------------------------------
-- Ability: Barrage
-- Fires multiple shots at once.
-- Obtained: Ranger Level 30
-- Recast Time: 5:00
-- Duration: 1:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.ranger.checkBarrage(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.ranger.useBarrage(player, target, ability, action)
end

return abilityObject
