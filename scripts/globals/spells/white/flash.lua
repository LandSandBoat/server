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
    -- local dINT = (caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND))

    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.DIVINE_MAGIC
    params.bonus =  150
    params.effect = nil

    local resist = applyResistance(caster, target, spell, params)
    local duration = 12 * resist

    if (resist > 0.0625) then
        if (target:addStatusEffect(xi.effect.FLASH, 200, 0, duration)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end
    return xi.effect.FLASH
end

return spell_object
