-----------------------------------
-- Ability: Marcato
-- Enhances the effect of your next song.
-- Obtained: Bard Level 95
-- Recast Time: 10:00
-- Duration: 1:00, or until next song is cast.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(tpz.effect.MARCATO, 0, 0, 60)
end

return ability_object
