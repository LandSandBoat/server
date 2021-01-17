-----------------------------------
-- Spell: Water
-- Deals water damage to enemies within area of effect.
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
    spellParams.V = 74
    spellParams.V0 = 80
    spellParams.V50 = 220
    spellParams.V100 = 315
    spellParams.V200 = 415
    spellParams.M = 1
    spellParams.M0 = 2.8
    spellParams.M50 = 1.9
    spellParams.M100 = 1
    spellParams.M200 = 0
    spellParams.I = 96

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
