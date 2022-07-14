
---------------------------------------------
-- Avatars Favor - Ability
---------------------------------------------
require("settings/main")
require("scripts/globals/status")
---------------------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.AVATARS_FAVOR, 1, 10, 7200)
end

return ability_object
