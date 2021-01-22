-----------------------------------
-- Spell: Thundaga III
-- Deals lightning damage to enemies within area of effect.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local spellParams = {}
    spellParams.hasMultipleTargetReduction = true
    spellParams.resistBonus = 1.0
    spellParams.V = 697
    spellParams.V0 = 700
    spellParams.V50 = 880
    spellParams.V100 = 1055
    spellParams.V200 = 1330
    spellParams.M = 1.5
    spellParams.M0 = 3.6
    spellParams.M50 = 3.5
    spellParams.M100 = 2.75
    spellParams.M200 = 2
    spellParams.I = 719

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
