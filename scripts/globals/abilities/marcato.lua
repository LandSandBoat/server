-----------------------------------
-- Ability: Marcato
-- Enhances the effect of your next song.
-- Obtained: Bard Level 95
-- Recast Time: 10:00
-- Duration: 1:00, or until next song is cast.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.MARCATO, 0, 0, 60)
end

return abilityObject
