-----------------------------------
-- Spell: Haste II
-- Composure increases duration 3x
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
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 96, target:getMainLvl())

    local power = 2998 -- 307/1024 ~29.98%

    if not target:addStatusEffect(tpz.effect.HASTE, power, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.HASTE
end

return spell_object
