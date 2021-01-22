-----------------------------------
-- Spell: Flash
-- Temporarily blinds an enemy, greatly lowering its accuracy.
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
    local dINT = (caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND))

    local params = {}

    params.diff = nil

    params.attribute = tpz.mod.INT

    params.skillType = tpz.skill.DIVINE_MAGIC

    params.bonus =  150

    params.effect = nil

    local resist = applyResistance(caster, target, spell, params)
    local duration = 12 * resist

    if (resist > 0.0625) then
        if (target:addStatusEffect(tpz.effect.FLASH, 200, 0, duration)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end
    return tpz.effect.FLASH
end

return spell_object
