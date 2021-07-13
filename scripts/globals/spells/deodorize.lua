-----------------------------------
-- Spell: Deodorize
-- Lessens chance of being detected by smell.
-- Duration is random number between 30 seconds and 5 minutes
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    if not target:hasStatusEffect(xi.effect.DEODORIZE) then
        local duration = calculateDuration(math.random(420, 540), spell:getSkillType(), spell:getSpellGroup(), caster, target)
        duration = calculateDurationForLvl(duration, 15, target:getMainLvl())

        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
        target:addStatusEffect(xi.effect.DEODORIZE, 0, 10, math.floor(duration * xi.settings.SNEAK_INVIS_DURATION_MULTIPLIER))
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.DEODORIZE
end

return spell_object
