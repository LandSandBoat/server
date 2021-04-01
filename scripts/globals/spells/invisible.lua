-----------------------------------
-- Spell: Invisible
-- Lessens chance of being detected by sight.
-- Duration is random number between 30 seconds and 5 minutes.
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
    if not target:hasStatusEffect(xi.effect.INVISIBLE) then

        local duration = calculateDuration(math.random(420, 540), spell:getSkillType(), spell:getSpellGroup(), caster, target)

        duration = duration + target:getMod(xi.mod.INVISIBLE_DURATION)

        duration = calculateDurationForLvl(duration, 20, target:getMainLvl())

        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
        target:addStatusEffect(xi.effect.INVISIBLE, 0, 10, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.INVISIBLE
end

return spell_object
