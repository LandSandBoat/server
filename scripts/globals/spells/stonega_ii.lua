-----------------------------------
-- Spell: Stonega II
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
    spellParams.V = 201
    spellParams.V0 = 250
    spellParams.V50 = 450
    spellParams.V100 = 600
    spellParams.V200 = 800
    spellParams.M = 1
    spellParams.M0 = 4
    spellParams.M50 = 3
    spellParams.M100 = 2
    spellParams.M200 = 1
    spellParams.I = 232

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
