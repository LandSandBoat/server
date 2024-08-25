-----------------------------------
-- Ability: Unlimited Shot
-- Allows you to perform your next ranged attack without using ammunition.
-- Obtained: Ranger Level 51
-- Recast Time: 3:00
-- Duration: 1:00 or One Successful Ranged Attack.
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.ranger.checkUnlimitedShot(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.ranger.useUnlimitedShot(player, target, ability, action)
end

return abilityObject
