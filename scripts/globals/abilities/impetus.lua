-----------------------------------
-- Ability: Impetus
-- Description: Enhances attack and critical hit rate with each successive melee attack you land.
-- Obtained: MNK Level 88
-- Recast Time: 00:05:00
-- Duration: 0:03:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.IMPETUS, 2, 0, 180)
end

return ability_object
