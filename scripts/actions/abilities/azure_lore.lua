-----------------------------------
-- Ability: Azure Lore
-- Enhances the effect of blue magic spells.
-- Obtained: Blue Mage Level 1
-- Recast Time: 1:00:00
-- Duration: 0:00:30
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.blue_mage.checkAzureLore(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.blue_mage.useAzureLore(player, target, ability, action)
end

return abilityObject
