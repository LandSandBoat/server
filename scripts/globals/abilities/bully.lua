-----------------------------------
-- Ability: Bully
-- Intimidates target. (About 15% proc rate)
-- Removes the direction requirement from Sneak Attack for main job Thieves when active.
-- Obtained: Thief Level 93
-- Recast Time: 3:00
-- Duration: 0:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local jpValue = player:getJobPointLevel(xi.jp.BULLY_EFFECT)

    target:addStatusEffectEx(xi.effect.DOUBT, xi.effect.INTIMIDATE, 15 + jpValue, 0, 30)
    return xi.effect.INTIMIDATE
end

return ability_object
