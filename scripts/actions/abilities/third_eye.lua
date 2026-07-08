-----------------------------------
-- Ability: Third Eye
-- Anticipates and dodges the next attack directed at you.
-- Obtained: Samurai Level 15
-- Recast Time: 1:00
-- Duration: 0:30
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.samurai.checkThirdEye(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.samurai.useThirdEye(player, target, ability)
end

return abilityObject
