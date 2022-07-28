-----------------------------------
-- Ability: Larceny
-- Description: Steals one beneficial effect from the target enemy.
-- Obtained: THF Level 96
-- Recast Time: 01:00:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    -- player:addStatusEffect(xi.effect.LARCENY, 6, 0, 5) -- TODO: implement xi.effect.LARCENY
end

return ability_object
