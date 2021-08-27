-----------------------------------
-- Spell: Aeroga II
-- Deals wind damage to enemies within area of effect.
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
    spellParams.V = 266
    spellParams.V0 = 310
    spellParams.V50 = 480
    spellParams.V100 = 620
    spellParams.V200 = 810
    spellParams.M = 1
    spellParams.M0 = 3.4
    spellParams.M50 = 2.8
    spellParams.M100 = 1.9
    spellParams.M200 = 1
    spellParams.I = 312

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
