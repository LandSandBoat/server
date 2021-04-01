-----------------------------------
-- Spell: Flurry II
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
    local duration = calculateDuration(150, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 96, target:getMainLvl())

    if target:addStatusEffect(xi.effect.FLURRY_II, 30, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.FLURRY_II
end

return spell_object
