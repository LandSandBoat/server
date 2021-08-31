-----------------------------------
-- Spell: Stonega III
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
    spellParams.V = 434
    spellParams.V0 = 500
    spellParams.V50 = 750
    spellParams.V100 = 950
    spellParams.V200 = 1250
    spellParams.M = 1.5
    spellParams.M0 = 5
    spellParams.M50 = 4
    spellParams.M100 = 3
    spellParams.M200 = 2
    spellParams.I = 480

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
