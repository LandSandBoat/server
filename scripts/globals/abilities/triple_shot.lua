-----------------------------------
-- Ability: Triple Shot
-- Description: Occasionally uses three units of ammunition to deal extra damage.
-- Obtained: COR Level 87
-- Recast Time: 00:05:00
-- Duration: 0:01:30
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
    player:addStatusEffect(xi.effect.TRIPLE_SHOT, 40, 0, 90)
end

return ability_object
