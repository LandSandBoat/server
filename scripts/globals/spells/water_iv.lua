-----------------------------------
-- Spell: Water IV
-- Deals water damage to an enemy.
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
    spellParams.V = 410
    spellParams.V0 = 440
    spellParams.V50 = 675
    spellParams.V100 = 870
    spellParams.V200 = 1165
    spellParams.M = 2
    spellParams.M0 = 4.7
    spellParams.M50 = 3.9
    spellParams.M100 = 2.95
    spellParams.M200 = 2
    spellParams.I = 440

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
