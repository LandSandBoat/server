-----------------------------------
-- Spell: Firaga IV
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
    spellParams.V0 = 930
    spellParams.V50 = 1200
    spellParams.V100 = 1400
    spellParams.V200 = 1800
    spellParams.M0 = 5.2
    spellParams.M50 = 4.7
    spellParams.M100 = 3.85
    spellParams.M200 = 3

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
