-----------------------------------
-- Ability: Asylum
-- Description: Grants party members a powerful resistance to enfeebling magic and Dispel effects.
-- Obtained: WHM Level 96
-- Recast Time: 01:00:00
-- Duration: 0:00:30
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.ASYLUM, 3, 0, 30)
end

return ability_object
