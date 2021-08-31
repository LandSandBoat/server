-----------------------------------
-- Spell: Waterja
-- Deals water damage to enemies within area of effect.
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
    spellParams.V0 = 800
    spellParams.V50 = 1080
    spellParams.V100 = 1317
    spellParams.V200 = 1712
    spellParams.M0 = 5.6
    spellParams.M50 = 4.75
    spellParams.M100 = 3.95
    spellParams.M200 = 3

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
