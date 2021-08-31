-----------------------------------
-- Spell: Blizzaga II
-- Deals ice damage to enemies within area of effect.
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
    spellParams.hasMultipleTargetReduction = true
    spellParams.resistBonus = 1.0
    spellParams.V = 350
    spellParams.V0 = 370
    spellParams.V50 = 510
    spellParams.V100 = 640
    spellParams.V200 = 820
    spellParams.M = 1
    spellParams.M0 = 2.8
    spellParams.M50 = 2.6
    spellParams.M100 = 1.8
    spellParams.M200 = 1
    spellParams.I = 392

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
