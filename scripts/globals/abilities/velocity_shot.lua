-----------------------------------
-- Ability: Velocity Shot
-- Increases attack power and speed of ranged attacks, while reducing attack power and speed of melee attacks.
-- Obtained: Ranger Level 45
-- Recast Time: 5:00 minutes
-- Duration: 2 hours
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(tpz.effect.VELOCITY_SHOT, 1, 0, 7200)
end

return ability_object
