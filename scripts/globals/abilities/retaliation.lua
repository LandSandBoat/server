-----------------------------------
-- Ability: Retaliation
-- Allows you to counterattack but reduces movement speed.
-- Obtained: Warrior Level 60
-- Recast Time: 3:00
-- Duration: 3:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(tpz.effect.RETALIATION, 1, 0, 180)
end

return ability_object
