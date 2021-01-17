-----------------------------------
-- Spell: Aero II
-- Deals wind damage to an enemy.
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
    spellParams.V = 113
    spellParams.V0 = 140
    spellParams.V50 = 270
    spellParams.V100 = 360
    spellParams.V200 = 460
    spellParams.M = 1
    spellParams.M0 = 2.6
    spellParams.M50 = 1.8
    spellParams.M100 = 1
    spellParams.M200 = 0
    spellParams.I = 133

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
