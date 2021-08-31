-----------------------------------
-- Spell: Aero V
-- Deals wind damage to an enemy.
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
    spellParams.V0 = 750
    spellParams.V50 = 1010
    spellParams.V100 = 1235
    spellParams.V200 = 1625
    spellParams.M0 = 5.2
    spellParams.M50 = 4.5
    spellParams.M100 = 3.9
    spellParams.M200 = 3

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
