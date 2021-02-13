-----------------------------------
-- Ability: Perfect Counter
-- Description: Allows you to counter the next attack directed at you.
-- Obtained: MNK Level 79
-- Recast Time: 00:01:00
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
    player:addStatusEffect(tpz.effect.PERFECT_COUNTER, 2, 0, 30)
end

return ability_object
