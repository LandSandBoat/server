-----------------------------------
-- Ability: Double Shot
-- Occasionally uses two units of ammunition to deal double damage.
-- Obtained: Ranger Level 79
-- Recast Time: 3:00
-- Duration: 1:30
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.DOUBLE_SHOT, 40, 0, 90)
end

return ability_object
