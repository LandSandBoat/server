-----------------------------------
-- Spell: Regen IV
-- Gradually restores target's HP.
-----------------------------------
-- Scale down duration based on level
-- Composure increases duration 3x
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local hp = math.ceil(30 * (1 + 0.01 * caster:getMod(xi.mod.REGEN_MULTIPLIER))) -- spell base times gear multipliers
    hp = hp + caster:getMerit(xi.merit.REGEN_EFFECT) -- bonus hp from merits
    hp = hp + caster:getMod(xi.mod.LIGHT_ARTS_REGEN) -- bonus hp from light arts
    hp = hp + caster:getMod(xi.mod.REGEN_BONUS)      -- bonus hp from jobpoint gift

    local duration = calculateDuration(60 + caster:getMod(xi.mod.REGEN_DURATION), spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 86, target:getMainLvl())
    duration = duration + (caster:getJobPointLevel(xi.jp.REGEN_DURATION) * 3)

    if target:addStatusEffect(xi.effect.REGEN, hp, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    end

    return xi.effect.REGEN
end

return spell_object
