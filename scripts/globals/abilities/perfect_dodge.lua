-----------------------------------
-- Ability: Perfect Dodge
-- Allows you to dodge all melee attacks.
-- Obtained: Thief Level 1
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
    local duration = 30 + player:getMod(xi.mod.PERFECT_DODGE)
    player:addStatusEffect(xi.effect.PERFECT_DODGE, 1, 0, duration)
end

return ability_object
