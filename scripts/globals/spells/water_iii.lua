-----------------------------------
-- Spell: Water III
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
    spellParams.V = 236
    spellParams.V0 = 230
    spellParams.V50 = 415
    spellParams.V100 = 560
    spellParams.V200 = 755
    spellParams.M = 1.5
    spellParams.M0 = 3.7
    spellParams.M50 = 2.9
    spellParams.M100 = 1.95
    spellParams.M200 = 1
    spellParams.I = 265

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
