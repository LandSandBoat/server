-----------------------------------
-- Ability: Elemental Sforzo
-- Grants immunity to all magic attacks.
-- Obtained: Rune Fencer Level 1
-- Recast Time: 1:00:00
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.ELEMENTAL_SFORZO, 1, 0, 30)
    return tpz.effect.ELEMENTAL_SFORZO
end
