-----------------------------------
-- Ability: Double Shot
-- Occasionally uses two units of ammunition to deal double damage.
-- Obtained: Ranger Level 79
-- Recast Time: 3:00
-- Duration: 1:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)

    local chance = 40

    player:addStatusEffect(tpz.effect.DOUBLE_SHOT, chance, 0, 90)
end
