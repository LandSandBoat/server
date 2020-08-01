-----------------------------------
-- Ability: Nightingale
-- Game Description: Halves the casting and recast times of songs
-- Obtained: Bard Level 75 Group 2 Meriting
-- Recast Time: 0:10:00
-- Duration: 0:01:00
-----------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.NIGHTINGALE, 0, 0, 60)
end
