-----------------------------------
-- Spell: Blizzaga III
-- Deals ice damage to enemies within area of effect.
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
    spellParams.V = 642
    spellParams.V0 = 660
    spellParams.V50 = 855
    spellParams.V100 = 1035
    spellParams.V200 = 1315
    spellParams.M = 1.5
    spellParams.M0 = 3.9
    spellParams.M50 = 3.6
    spellParams.M100 = 2.8
    spellParams.M200 = 2
    spellParams.I = 697

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
