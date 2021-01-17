-----------------------------------
-- Ability: Sharpshot
-- Increases ranged accuracy.
-- Obtained: Ranger Level 1
-- Recast Time: 5:00
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
    local power = 40 + player:getMod(tpz.mod.SHARPSHOT)
    player:addStatusEffect(tpz.effect.SHARPSHOT, power, 0, 60)
end

return ability_object
