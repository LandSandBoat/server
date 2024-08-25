-----------------------------------
-- Ability: Sange
-- Daken will always activate but consumes shuriken while active.
-- Obtained: Ninja Level 75 Merits
-- Recast Time: 3 minutes
-- Duration: 1 minute
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.ninja.checkSange(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.ninja.useSange(player, target, ability, action)
end

return abilityObject
