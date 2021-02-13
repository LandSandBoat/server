-----------------------------------
-- Spell: Firaga III
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
    spellParams.V = 589
    spellParams.V0 = 620
    spellParams.V50 = 830
    spellParams.V100 = 1015
    spellParams.V200 = 1300
    spellParams.M = 1.5
    spellParams.M0 = 4.2
    spellParams.M50 = 3.7
    spellParams.M100 = 2.85
    spellParams.M200 = 2
    spellParams.I = 642

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
