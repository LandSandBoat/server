-----------------------------------
-- Ability: Manafont
-- Eliminates the cost of magic spells.
-- Obtained: Black Mage Level 1
-- Recast Time: 1:00:00
-- Duration: 0:01:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.black_mage.checkManafont(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.black_mage.useManafont(player, target, ability)
end

return abilityObject
