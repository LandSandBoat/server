-----------------------------------
-- Ability: Unleash
-- Description: Increases the accuracy of Charm and reduces the recast times of Sic and Ready.
-- Obtained: BST Level 96
-- Recast Time: 01:00:00
-- Duration: 0:01:00
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
    player:addStatusEffect(xi.effect.UNLEASH, 9, 0, 60)
end

return ability_object
