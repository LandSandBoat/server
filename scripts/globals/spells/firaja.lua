-----------------------------------
-- Spell: Firaja
-- Deals fire damage to enemies within area of effect.
-- Successive use enhances spell potency.
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
    spellParams.V0 = 900
    spellParams.V50 = 1140
    spellParams.V100 = 1352
    spellParams.V200 = 1737
    spellParams.M0 = 4.8
    spellParams.M50 = 4.25
    spellParams.M100 = 3.85
    spellParams.M200 = 3

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
