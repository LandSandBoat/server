-----------------------------------
-- Ability: Trance
-- While in effect, lowers TP cost of dances and steps to 0.
-- Obtained: Dancer Level 1
-- Recast Time: 1:00:00
-- Duration: 1:00
-----------------------------------
local ability_object = {}

require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(tpz.effect.TRANCE, 1, 0, 60)
end

return ability_object
