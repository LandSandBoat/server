-----------------------------------
-- Ability: Azure Lore
-- Enhances the effect of blue magic spells.
-- Obtained: Blue Mage Level 1
-- Recast Time: 1:00:00
-- Duration: 0:00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(tpz.effect.AZURE_LORE, 1, 0, 30)
end

return ability_object
