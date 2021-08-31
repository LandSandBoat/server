-----------------------------------
-- Spell: Aero
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
    spellParams.V = 25
    spellParams.V0 = 40
    spellParams.V50 = 120
    spellParams.V100 = 170
    spellParams.V200 = 170
    spellParams.M = 1
    spellParams.M0 = 1.6
    spellParams.M50 = 1
    spellParams.M100 = 0
    spellParams.M200 = 0
    spellParams.I = 35

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
