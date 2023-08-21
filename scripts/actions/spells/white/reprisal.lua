-----------------------------------
-- Spell: Reprisal
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local duration         = calculateDuration(60, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local reflectedPercent = 33
    local typeEffect       = xi.effect.REPRISAL

    if target:addStatusEffect(typeEffect, reflectedPercent, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spellObject
