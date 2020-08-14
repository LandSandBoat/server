-----------------------------------
-- Ability: Last Resort
-- Increases user's attack, but lowers defense.
-- Obtained: Dark Knight Level 15
-- Recast Time: 5:00
-- Duration: 3:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.LAST_RESORT, 0, 0, 180)
end
