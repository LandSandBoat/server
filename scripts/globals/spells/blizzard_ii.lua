-----------------------------------
-- Spell: Blizzard II
-- Deals ice damage to an enemy.
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
    spellParams.V = 155
    spellParams.V0 = 180
    spellParams.V50 = 290
    spellParams.V100 = 370
    spellParams.V200 = 470
    spellParams.M = 1
    spellParams.M0 = 2.2
    spellParams.M50 = 1.6
    spellParams.M100 = 1
    spellParams.M200 = 0
    spellParams.I = 178

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
