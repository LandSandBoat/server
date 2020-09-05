-----------------------------------------
-- Spell: Banishga 2
-- Deals light damage to an enemy.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    --doDivineBanishNuke(V, M, caster, spell, target, hasMultipleTargetReduction, resistBonus)
    local params = {}
    params.dmg = 180
    params.multiplier = 1
    params.hasMultipleTargetReduction = false
    params.resistBonus = 1.0
    dmg = doDivineBanishNuke(caster, target, spell, params)
    return dmg
end
