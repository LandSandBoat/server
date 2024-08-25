-----------------------------------
-- Ability: Double Shot
-- Occasionally uses two units of ammunition to deal double damage.
-- Obtained: Ranger Level 79
-- Recast Time: 3:00
-- Duration: 1:30
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.ranger.checkDoubleShot(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.ranger.useDoubleShot(player, target, ability, action)
end

return abilityObject
