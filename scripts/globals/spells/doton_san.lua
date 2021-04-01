-----------------------------------
-- Spell: Doton: San
-- Deals earth damage to an enemy and lowers its resistance against wind.
-----------------------------------
local spell_object = {}

require("scripts/globals/status")
require("scripts/globals/magic")

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    --doNinjutsuNuke(V, M, caster, spell, target, hasMultipleTargetReduction, resistBonus)
    local duration = 15 + caster:getMerit(xi.merit.DOTON_EFFECT) -- T1 bonus debuff duration
    local bonusAcc = 0
    local bonusMab = caster:getMerit(xi.merit.DOTON_EFFECT) -- T1 mag atk

    local params = {}

    params.dmg = 134

    params.multiplier = 1.5

    params.hasMultipleTargetReduction = false

    params.resistBonus = bonusAcc

    params.mabBonus = bonusMab

    dmg = doNinjutsuNuke(caster, target, spell, params)
    handleNinjutsuDebuff(caster, target, spell, 30, duration, xi.mod.WINDRES)

    return dmg
end

return spell_object
