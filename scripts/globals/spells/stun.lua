-----------------------------------------
-- Spell: Stun
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 5

    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    local params = {}
    params.diff = nil
    params.attribute = tpz.mod.INT
    params.skillType = 37
    params.bonus = 0
    params.effect = tpz.effect.STUN
    local resist = applyResistanceEffect(caster, target, spell, params)
    if (resist <= (1/16)) then
        -- resisted!
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        return 0
    end

    if (target:hasStatusEffect(tpz.effect.STUN)) then
        -- no effect
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    else
        if (target:addStatusEffect(tpz.effect.STUN, 1, 0, duration*resist)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    end

    return tpz.effect.STUN
end
