-----------------------------------
-- Spell: Silence
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
    local effectType = xi.effect.SILENCE

    if (target:hasStatusEffect(effectType)) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
        return effectType
    end

    --Pull base stats.
    local dMND = (caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND))

    --Duration, including resistance.  May need more research.
    local duration = 120

    --Resist
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.MND
    params.skillType = 35
    params.bonus = 0
    params.effect = xi.effect.SILENCE
    local resist = applyResistanceEffect(caster, target, spell, params)

    if (resist >= 0.5) then --Do it!
        if (target:addStatusEffect(effectType, 1, 0, duration * resist)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return effectType

end

return spell_object
