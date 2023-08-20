-----------------------------------
-- Ability: Sacrosanctity
-- Description: Enhances magic defense for party members within area of effect.
-- Obtained: WHM Level 95
-- Recast Time: 00:10:00
-- Duration: 0:01:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.white_mage.useSacrosanctity(player, target, ability)
end

return abilityObject
