-----------------------------------
-- Ability: Pianissimo
-- Limits area of effect of next song to a single target.
-- Obtained: Bard Level 20
-- Recast Time: 0:00:15
-- Duration: 00:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.PIANISSIMO, 0, 0, 60)
end

return ability_object
