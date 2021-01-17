-----------------------------------
-- Spell: Aeroja
-- Deals wind damage to enemies within area of effect.
-- successive use enhances spell potency.
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
    spellParams.V0 = 850
    spellParams.V50 = 1110
    spellParams.V100 = 1335
    spellParams.V200 = 1725
    spellParams.M0 = 5.2
    spellParams.M50 = 4.5
    spellParams.M100 = 3.9
    spellParams.M200 = 3

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
