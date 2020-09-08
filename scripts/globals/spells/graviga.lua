-----------------------------------------
-- Spell: Gravity
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    -- Pull base stats.
    local dINT = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    local power = 50 -- 50% reduction

    -- Duration, including resistance.  Unconfirmed.
    local duration = 120
    local params = {}
    params.diff = nil
    params.attribute = tpz.mod.INT
    params.skillType = 35
    params.bonus = 0
    params.effect = tpz.effect.WEIGHT
    duration = duration * applyResistanceEffect(caster, target, spell, params)

    if (duration >= 30) then --Do it!
        if (target:addStatusEffect(tpz.effect.WEIGHT, power, 0, duration)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST_2)
    end

    return tpz.effect.WEIGHT
end
