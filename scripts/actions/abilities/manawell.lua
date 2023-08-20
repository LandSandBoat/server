-----------------------------------
-- Ability: Manawell
-- Description: Eliminates the cost of the next magic spell the target casts.
-- Obtained: BLM Level 95
-- Recast Time: 00:10:00 or the next spell cast
-- Duration: 0:01:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.black_mage.useManawell(player, target, ability)
end

return abilityObject
