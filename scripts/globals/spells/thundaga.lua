-----------------------------------
-- Spell: Thundaga
-- Deals thunder damage to enemies within area of effect.
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
    spellParams.V = 172
    spellParams.V0 = 200
    spellParams.V50 = 300
    spellParams.V100 = 375
    spellParams.V200 = 475
    spellParams.M = 1
    spellParams.M0 = 2
    spellParams.M50 = 1.5
    spellParams.M100 = 1
    spellParams.M200 = 0
    spellParams.I = 201

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
