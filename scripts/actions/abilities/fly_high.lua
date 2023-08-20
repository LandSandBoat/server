-----------------------------------
-- Ability: Fly High
-- Description: Decreases the recast time of jumps.
-- Obtained: DRG Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dragoon.useFlyHigh(player, target, ability)
end

return abilityObject
