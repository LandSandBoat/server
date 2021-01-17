-----------------------------------
-- Spell: Fire IV
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
    spellParams.V = 472
    spellParams.V0 = 520
    spellParams.V50 = 730
    spellParams.V100 = 915
    spellParams.V200 = 1200
    spellParams.M = 2
    spellParams.M0 = 4.2
    spellParams.M50 = 3.7
    spellParams.M100 = 2.85
    spellParams.M200 = 2
    spellParams.I = 506

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
