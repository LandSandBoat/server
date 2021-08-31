-----------------------------------
-- Spell: Stone III
-- Deals earth damage to an enemy.
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
    spellParams.V = 210
    spellParams.V0 = 200
    spellParams.V50 = 400
    spellParams.V100 = 550
    spellParams.V200 = 750
    spellParams.M = 1.5
    spellParams.M0 = 4
    spellParams.M50 = 3
    spellParams.M100 = 2
    spellParams.M200 = 1
    spellParams.I = 236

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
