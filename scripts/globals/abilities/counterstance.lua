-----------------------------------
-- Ability: Counterstance
-- Increases chance to counter but lowers defense.
-- Obtained: Monk Level 45
-- Recast Time: 5:00
-- Duration: 5:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local power = 45 + player:getMod(tpz.mod.COUNTERSTANCE_EFFECT)

    target:delStatusEffect(tpz.effect.COUNTERSTANCE) --if not found this will do nothing
    target:addStatusEffect(tpz.effect.COUNTERSTANCE, power, 0, 300)
end
