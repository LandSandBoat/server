-----------------------------------
-- Ability: Azure Lore
-- Enhances the effect of blue magic spells.
-- Obtained: Blue Mage Level 1
-- Recast Time: 1:00:00
-- Duration: 0:00:30
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.AZURE_LORE, 1, 0, 30)
end

return abilityObject
