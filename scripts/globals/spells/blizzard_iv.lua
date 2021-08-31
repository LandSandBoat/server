-----------------------------------
-- Spell: Blizzard IV
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
    spellParams.V = 506
    spellParams.V0 = 560
    spellParams.V50 = 755
    spellParams.V100 = 935
    spellParams.V200 = 1215
    spellParams.M = 2
    spellParams.M0 = 3.9
    spellParams.M50 = 3.6
    spellParams.M100 = 2.8
    spellParams.M200 = 2
    spellParams.I = 541

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
