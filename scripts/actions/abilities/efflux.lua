-----------------------------------
-- Ability: Efflux
-- Description: If the next spell you cast is a "physical" Blue magic spell, a TP bonus will be granted.
-- Obtained: BLU Level 83
-- Recast Time: 00:03:00
-- Duration: 00:01:00 or first blue magic cast
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.blue_mage.checkEfflux(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.blue_mage.useEfflux(player, target, ability, action)
end

return abilityObject
