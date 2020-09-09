-----------------------------------------
-- Spell: Poisonga III
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

    local duration = 180

    local pINT = caster:getStat(tpz.mod.INT)
    local mINT = target:getStat(tpz.mod.INT)

    local dINT = (pINT - mINT)
    local power = caster:getSkillLevel(tpz.skill.ENFEEBLING_MAGIC) / 10 + 1
    if power > 25 then
        power = 25
    end

    local params = {}

    params.diff = nil

    params.attribute = tpz.mod.INT

    params.skillType = tpz.skill.ENFEEBLING_MAGIC

    params.bonus = 0

    params.effect = effect

    local resist = applyResistanceEffect(caster, target, spell, params)
    if (resist == 1 or resist == 0.5) then -- effect taken
        duration = duration * resist

        if (target:addStatusEffect(effect, power, 3, duration)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end

    else -- resist entirely.
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return effect
end
