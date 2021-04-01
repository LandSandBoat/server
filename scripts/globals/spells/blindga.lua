-----------------------------------
-- Spell: Blind
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)

    -- Pull base stats.
    local dINT = (caster:getStat(xi.mod.INT) - target:getStat(xi.mod.MND)) --blind uses caster INT vs target MND

    -- Base power.  May need more research.
    local power = math.floor(dINT * 9/40) + 23

    if (power < 5) then
        power = 5
    end

    if (power > 50) then
        power = 50
    end


    -- Duration, including resistance.  Unconfirmed.
    local duration = 180
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = 35
    params.bonus = 0
    params.effect = xi.effect.BLINDNESS
    duration = duration * applyResistanceEffect(caster, target, spell, params)

    if (duration >= 60) then --Do it!

        if (target:addStatusEffect(xi.effect.BLINDNESS, power, 0, duration)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end
    return xi.effect.BLINDNESS
end

return spell_object
