-----------------------------------
-- Ability: Libra
-- Description: Examines the target's enmity level.
-- Obtained: SCH Level 76
-- Recast Time: 00:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    -- player:addStatusEffect(xi.effect.LIBRA, 20, 1, 1) -- TODO: implement xi.effect.LIBRA
end

return ability_object
