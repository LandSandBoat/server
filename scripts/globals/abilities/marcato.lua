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

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.MARCATO, 0, 0, 60)
end
