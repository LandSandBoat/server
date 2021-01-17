-----------------------------------
-- Ability: Blood Rage
-- Description: Enhances critical hit rate for party members within area of effect.
-- Obtained: WAR Level 87
-- Recast Time: 00:05:00
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
    player:addStatusEffect(tpz.effect.BLOOD_RAGE, 1, 0, 30)
end

return ability_object
