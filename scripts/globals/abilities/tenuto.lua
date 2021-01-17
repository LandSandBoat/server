-----------------------------------
-- Ability: Tenuto
-- If the next song you cast affects yourself, it will not subsequently be overwritten by other songs.
-- Obtained: Bard Level 83
-- Recast Time: 0:15
-- Duration: 1:00, or until next song is cast.
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
    player:addStatusEffect(tpz.effect.TENUTO, 0, 0, 60)
end

return ability_object
