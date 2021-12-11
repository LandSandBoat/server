-----------------------------------
-- Spell: Reactor Cool
-- Enhances defense and covers you with magical ice spikes. Enemies that hit you take ice damage
-- Spell cost: 28 MP
-- Monster Type: Luminions
-- Spell Type: Magical (Ice)
-- Blue Magic Points: 5
-- Stat Bonus: INT+3 MND+3
-- Level: 74
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 120 seconds (2 minutes)
-----------------------------------
-- Combos: Magic Attack Bonus
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/bluemagic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local typeEffectOne = xi.effect.ICE_SPIKES
    local typeEffectTwo = xi.effect.DEFENSE_BOOST
    local powerOne = 5
    local powerTwo = 12
    local duration = 120
    local returnEffect = typeEffectOne

    if (caster:hasStatusEffect(xi.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(xi.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit
        end

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    if (target:addStatusEffect(typeEffectOne, powerOne, 0, duration) == false and target:addStatusEffect(typeEffectTwo, powerTwo, 0, duration) == false) then -- both statuses fail to apply
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    elseif (target:addStatusEffect(typeEffectOne, powerOne, 0, duration) == false) then -- the first status fails to apply
        target:addStatusEffect(typeEffectTwo, powerTwo, 0, duration)
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
        returnEffect = typeEffectTwo
    else
        target:addStatusEffect(typeEffectOne, powerOne, 0, duration)
        target:addStatusEffect(typeEffectTwo, powerTwo, 0, duration)
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    end

    return returnEffect
end

return spell_object
