-----------------------------------
-- Ability: Chainspell
-- Allows rapid spellcasting.
-- Obtained: Red Mage Level 1
-- Recast Time: 1:00:00
-- Duration: 0:01:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.red_mage.checkChainspell(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.red_mage.useChainspell(player, target, ability)
end

return abilityObject
