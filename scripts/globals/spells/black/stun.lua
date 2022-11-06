-----------------------------------
-- Spell: Stun
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local duration = 5

    -- local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.DARK_MAGIC
    params.bonus = 0
    params.effect = xi.effect.STUN
    local resist = applyResistanceEffect(caster, target, spell, params)
    if (resist <= (1/16)) then
        -- resisted!
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return 0
    end

    if (target:hasStatusEffect(xi.effect.STUN)) then
        -- no effect
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    else
        if (target:addStatusEffect(xi.effect.STUN, 1, 0, duration*resist)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    end

    return xi.effect.STUN
end

return spellObject
