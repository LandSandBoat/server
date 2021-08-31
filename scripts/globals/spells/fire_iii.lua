-----------------------------------
-- Spell: Fire III
-- Deals fire damage to an enemy.
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
    spellParams.hasMultipleTargetReduction = false
    spellParams.resistBonus = 1.0
    spellParams.V = 295
    spellParams.V0 = 290
    spellParams.V50 = 445
    spellParams.V100 = 580
    spellParams.V200 = 765
    spellParams.M = 1.5
    spellParams.M0 = 3.1
    spellParams.M50 = 2.7
    spellParams.M100 = 1.85
    spellParams.M200 = 1
    spellParams.I = 320

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
