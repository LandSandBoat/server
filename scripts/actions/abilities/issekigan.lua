-----------------------------------
-- Ability: Issekigan
-- Increases Chance of parrying and gives an enmity bonus upon a successful parry attempt.
-- Obtained: Ninja Level 95
-- Recast Time: 5:00
-- Duration: 1:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.ninja.checkIssekigan(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.ninja.useIssekigan(player, target, ability, action)
end

return abilityObject
