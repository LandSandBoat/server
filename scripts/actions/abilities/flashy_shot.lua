-----------------------------------
-- Ability: Flashy Shot
-- Next attack will generate more enmity and ignore level difference penalties.
-- Obtained: Ranger Level 75
-- Recast Time: 10:00
-- Duration: 1:00
-- Target: Self Only
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.ranger.checkFlashyShot(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.ranger.useFlashyShot(player, target, ability, action)
end

return abilityObject
