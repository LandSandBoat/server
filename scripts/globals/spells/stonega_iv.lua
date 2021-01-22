-----------------------------------
-- Spell: Stonaga IV
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
    spellParams.V0 = 800
    spellParams.V50 = 1100
    spellParams.V100 = 1350
    spellParams.V200 = 1750
    spellParams.M0 = 6
    spellParams.M50 = 5
    spellParams.M100 = 4
    spellParams.M200 = 3

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
