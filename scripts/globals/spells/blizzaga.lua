-----------------------------------
-- Spell: Blizzaga
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
    spellParams.V = 145
    spellParams.V0 = 160
    spellParams.V50 = 270
    spellParams.V100 = 350
    spellParams.V200 = 450
    spellParams.M = 1
    spellParams.M0 = 2.2
    spellParams.M50 = 1.6
    spellParams.M100 = 1
    spellParams.M200 = 0
    spellParams.I = 172

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
