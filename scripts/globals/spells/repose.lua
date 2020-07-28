-----------------------------------------
-- Spell: Repose
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dMND = (caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND))
    local params = {}
    params.diff = nil
    params.attribute = tpz.mod.MND
    params.skillType = tpz.skill.DIVINE_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.SLEEP_II
    local resist = applyResistanceEffect(caster, target, spell, params)
    if (resist < 0.5) then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST) -- Resist
        return tpz.effect.SLEEP_II
    end

    if (target:addStatusEffect(tpz.effect.SLEEP_II, 2, 0, 90*resist)) then
        spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- No effect
    end

    return tpz.effect.SLEEP_II
end
