-----------------------------------
-- Ability: Camouflage
-- Become hidden from enemies.
-- Obtained: Ranger Level 20
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
    local duration = math.random(30, 300) * (1 + 0.01 * player:getMod(tpz.mod.CAMOUFLAGE_DURATION))
    player:addStatusEffect(tpz.effect.CAMOUFLAGE, 1 , 0, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
end
