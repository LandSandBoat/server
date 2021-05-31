-----------------------------------
-- Spell: Holy II
-- Deals light damage to an enemy.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    -- doDivineNuke(V, M, caster, spell, target, hasMultipleTargetReduction, resistBonus)
    local params = {}
    params.dmg = 250
    params.multiplier = 2
    params.hasMultipleTargetReduction = false
    params.resistBonus = 0
    local dmg = doDivineNuke(caster, target, spell, params)
    return dmg
end

return spell_object
