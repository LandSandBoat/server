-----------------------------------
-- Spell: Thunder IV
-- Deals lightning damage to an enemy.
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
    spellParams.V = 541
    spellParams.V0 = 600
    spellParams.V50 = 780
    spellParams.V100 = 955
    spellParams.V200 = 1230
    spellParams.M = 2
    spellParams.M0 = 3.6
    spellParams.M50 = 3.5
    spellParams.M100 = 2.75
    spellParams.M200 = 2
    spellParams.I = 626

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
