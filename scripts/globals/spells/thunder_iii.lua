-----------------------------------
-- Spell: Thunder III
-- Deals lightning damage to an enemy.
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
    spellParams.V = 345
    spellParams.V0 = 350
    spellParams.V50 = 475
    spellParams.V100 = 600
    spellParams.V200 = 775
    spellParams.M = 1.5
    spellParams.M0 = 2.5
    spellParams.M50 = 2.5
    spellParams.M100 = 1.75
    spellParams.M200 = 1
    spellParams.I = 381

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
