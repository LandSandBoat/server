-----------------------------------
-- Spell: Stone IV
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
    spellParams.V = 381
    spellParams.V0 = 400
    spellParams.V50 = 650
    spellParams.V100 = 850
    spellParams.V200 = 1150
    spellParams.M = 2
    spellParams.M0 = 5
    spellParams.M50 = 4
    spellParams.M100 = 3
    spellParams.M200 = 2
    spellParams.I = 410

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
