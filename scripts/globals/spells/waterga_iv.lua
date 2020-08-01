-----------------------------------------
-- Spell: Waterga IV
-- Deals water damage to enemies within area of effect.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local spellParams = {}
    spellParams.hasMultipleTargetReduction = true
    spellParams.resistBonus = 1.0
    spellParams.V0 = 850
    spellParams.V50 = 1130
    spellParams.V100 = 1367
    spellParams.V200 = 1762
    spellParams.M0 = 5.6
    spellParams.M50 = 4.74
    spellParams.M100 = 3.95
    spellParams.M200 = 3

    return doElementalNuke(caster, spell, target, spellParams)
end
