-----------------------------------------
-- Spell: Bind
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    --Pull base stats.
    local dINT = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))

    --Duration, including resistance.  May need more research.
    local duration = 60

    --Resist
    local params = {}
    params.diff = nil
    params.attribute = tpz.mod.INT
    params.skillType = 35
    params.bonus = 0
    params.effect = tpz.effect.BIND
    local resist = applyResistanceEffect(caster, target, spell, params)

    if (resist >= 0.5) then --Do it!
        --Try to erase a weaker bind.
        if (target:addStatusEffect(tpz.effect.BIND, target:speed(), 0, duration*resist)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return tpz.effect.BIND

end
