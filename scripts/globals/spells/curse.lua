-----------------------------------
-- Spell: Curse
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
    dINT = (caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))

    power = 50

    -- Duration, including resistance.  Unconfirmed.
    duration = 300
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = xi.effect.CURSE_I
    duration = duration * applyResistanceEffect(caster, target, spell, params)

    if (duration >= 150) then --Do it!
        if (target:addStatusEffect(xi.effect.CURSE_I, power, 0, duration)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return xi.effect.CURSE_I
end

return spell_object
