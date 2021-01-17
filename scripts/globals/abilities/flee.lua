-----------------------------------
-- Ability: Flee
-- Increases movement speed.
-- Obtained: Thief Level 25
-- Recast Time: 5:00
-- Duration: 0:30
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local duration = 30 + player:getMod(tpz.mod.FLEE_DURATION)
    player:addStatusEffect(tpz.effect.FLEE, 100, 0, duration)
end

return ability_object
