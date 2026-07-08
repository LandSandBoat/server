-----------------------------------
-- Ability: Stealth Shot
-- Your next attack will generate less enmity.
-- Obtained: Ranger Level 75
-- Recast Time: 5:00
-- Duration: 1:00
-- Target: Self Only
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.ranger.checkStealthShot(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.ranger.useStealthShot(player, target, ability, action)
end

return abilityObject
