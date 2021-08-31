-----------------------------------
-- Spell: Thunder V
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
    spellParams.V0 = 900
    spellParams.V50 = 1100
    spellParams.V100 = 1287
    spellParams.V200 = 1662
    spellParams.M0 = 4
    spellParams.M50 = 3.74
    spellParams.M100 = 3.75
    spellParams.M200 = 3

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
