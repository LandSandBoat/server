-----------------------------------
-- Spell: Phalanx
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
    local enhskill = caster:getSkillLevel(tpz.skill.ENHANCING_MAGIC)
    local final = 0
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 33, target:getMainLvl())

    if enhskill <= 300 then
        final = math.max(math.floor(enhskill / 10) - 2, 0)
    else
        final = math.floor((enhskill - 300.5) / 28.5) + 28
    end

    -- Cap at 35
    final = math.min(final, 35)

    if target:addStatusEffect(tpz.effect.PHALANX, final, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.PHALANX
end

return spell_object
