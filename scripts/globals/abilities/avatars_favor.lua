---------------------------------------------
-- Avatars Favor - Ability
---------------------------------------------
require("scripts/globals/status")
---------------------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.AVATARS_FAVOR, 1, 10, 7200)
end

return abilityObject
