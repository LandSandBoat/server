-----------------------------------
-- Spell: Stonaga
-- Deals earth damage to enemies within area of effect.
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
    spellParams.V = 56
    spellParams.V0 = 60
    spellParams.V50 = 210
    spellParams.V100 = 310
    spellParams.V200 = 410
    spellParams.M = 1
    spellParams.M0 = 3
    spellParams.M50 = 2
    spellParams.M100 = 1
    spellParams.M200 = 0
    spellParams.I = 74

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
