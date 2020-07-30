-----------------------------------
-- Ability: Hide
-- User becomes invisible.
-- Obtained: Thief Level 45
-- Recast Time: 5:00
-- Duration: Random
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local duration = math.random(30, 300)
    duration = duration * (1 + player:getMod(tpz.mod.HIDE_DURATION)/100)
    player:addStatusEffect(tpz.effect.HIDE, 1, 0, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
end
