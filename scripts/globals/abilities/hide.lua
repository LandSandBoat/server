-----------------------------------
-- Ability: Hide
-- User becomes invisible.
-- Obtained: Thief Level 45
-- Recast Time: 5:00
-- Duration: Random
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local duration = math.random(30, 300)
    duration = duration * (1 + player:getMod(xi.mod.HIDE_DURATION)/100)
    player:addStatusEffect(xi.effect.HIDE, 1, 0, math.floor(duration * xi.settings.SNEAK_INVIS_DURATION_MULTIPLIER))
end

return ability_object
