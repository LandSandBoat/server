-----------------------------------
-- Spell: Firaga
-- Deals fire damage to enemies within area of effect.
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
    spellParams.V = 120
    spellParams.V0 = 120
    spellParams.V50 = 240
    spellParams.V100 = 325
    spellParams.V200 = 425
    spellParams.M = 1
    spellParams.M0 = 2.4
    spellParams.M50 = 1.7
    spellParams.M100 = 1
    spellParams.M200 = 0
    spellParams.I = 145

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
