-----------------------------------
-- Spell: Stone II
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
    spellParams.V = 78
    spellParams.V0 = 100
    spellParams.V50 = 250
    spellParams.V100 = 350
    spellParams.V200 = 450
    spellParams.M = 1
    spellParams.M0 = 3
    spellParams.M50 = 2
    spellParams.M100 = 1
    spellParams.M200 = 1
    spellParams.I = 95

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
