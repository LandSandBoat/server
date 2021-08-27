-----------------------------------
-- Spell: Phalanx II
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local enhskill = caster:getSkillLevel(xi.skill.ENHANCING_MAGIC)
    local final = 0
    local duration = calculateDuration(240, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 75, target:getMainLvl())

    if enhskill <= 300 then
        final = math.floor(enhskill / 25) + 16
    else
        final = math.floor((enhskill - 300.5) / 28.5) + 28
    end

    if target:addStatusEffect(xi.effect.PHALANX, final, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.PHALANX
end

return spell_object
