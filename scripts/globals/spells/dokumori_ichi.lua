-----------------------------------------
-- Spell: Dokumori: Ichi
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.POISON
    -- Base Stats
    local dINT = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    --Duration Calculation
    local duration = 60
    local params = {}
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.NINJUTSU
    params.bonus = 0
    duration = duration * applyResistance(caster, target, spell, params)
    local power = 3

    --Calculates resist chanve from Reist Blind
    if (target:hasStatusEffect(effect)) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
        return effect
    end

    if (math.random(0, 100) >= target:getMod(tpz.mod.POISONRES)) then
        if (duration >= 30) then
            if (target:addStatusEffect(effect, power, 3, duration)) then
                spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
            else
                spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
            end
        else
            spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST_2)
    end
    return effect
end
