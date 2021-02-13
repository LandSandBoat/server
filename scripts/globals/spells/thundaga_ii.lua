-----------------------------------
-- Spell: Thundaga II
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
    spellParams.V = 392
    spellParams.V0 = 400
    spellParams.V50 = 525
    spellParams.V100 = 650
    spellParams.V200 = 825
    spellParams.M = 1.5
    spellParams.M0 = 2.5
    spellParams.M50 = 2.5
    spellParams.M100 = 1.75
    spellParams.M200 = 1
    spellParams.I = 434

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
