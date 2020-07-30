-----------------------------------------
-- Spell: Jubaku: Ichi
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and INT.
-- taken from paralyze
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.PARALYSIS
    -- Base Stats
    local dINT = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    --Duration Calculation
    local duration = 180
    local params = {}
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.NINJUTSU
    params.bonus = 0
    duration = duration * applyResistance(caster, target, spell, params)
    --Paralyze base power is 20 and is not affected by resistaces.
    local power = 20

    --Calculates resist chanve from Reist Blind
    if (math.random(0, 100) >= target:getMod(tpz.mod.PARALYZERES)) then
        if (duration >= 80) then
            -- Erases a weaker blind and applies the stronger one
            local paralysis = target:getStatusEffect(effect)
            if (paralysis ~= nil) then
                if (paralysis:getPower() < power) then
                    target:delStatusEffect(effect)
                    target:addStatusEffect(effect, power, 0, duration)
                    spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB)
                else
                    -- no effect
                    spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
                end
            else
                target:addStatusEffect(effect, power, 0, duration)
                spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB)
            end
        else
            spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST_2)
    end
    return effect
end
