-----------------------------------
-- Spell: Amplification
-- Enhances magic attack and magic defense
-- Spell cost: 48 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Water)
-- Blue Magic Points: 3
-- Stat Bonus: HP-5, MP+5
-- Level: 70
-- Casting Time: 7 seconds
-- Recast Time: 120 seconds
-- Duration: 90 seconds
-----------------------------------
-- Combos: None
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local typeEffectOne = xi.effect.MAGIC_ATK_BOOST
    local typeEffectTwo = xi.effect.MAGIC_DEF_BOOST
    local power = 10
    local duration = 90
    local returnEffect = typeEffectOne

    if caster:hasStatusEffect(xi.effect.DIFFUSION) then
        local diffMerit = caster:getMerit(xi.merit.DIFFUSION)

        if diffMerit > 0 then
            duration = duration + (duration / 100) * diffMerit
        end

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    if
        not target:addStatusEffect(typeEffectOne, power, 0, duration) and
        not target:addStatusEffect(typeEffectTwo, power, 0, duration)
    then
        -- both statuses fail to apply
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    elseif not target:addStatusEffect(typeEffectOne, power, 0, duration) then -- the first status fails to apply
        target:addStatusEffect(typeEffectTwo, power, 0, duration)
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
        returnEffect = typeEffectTwo
    else
        target:addStatusEffect(typeEffectOne, power, 0, duration)
        target:addStatusEffect(typeEffectTwo, power, 0, duration)
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    end

    return returnEffect
end

return spellObject
