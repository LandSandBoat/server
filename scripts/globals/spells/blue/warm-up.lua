-----------------------------------
-- Spell: Warm-Up
-- Enhances accuracy and evasion
-- Spell cost: 59 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 4
-- Stat Bonus: VIT+1
-- Level: 68
-- Casting Time: 7 seconds
-- Recast Time: 120 seconds
-- Duration: 180 seconds
-----------------------------------
-- Combos: Clear Mind
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local typeEffectOne = xi.effect.ACCURACY_BOOST
    local typeEffectTwo = xi.effect.EVASION_BOOST
    local power = 10
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 180)
    local returnEffect = typeEffectOne

    local actionOne = target:addStatusEffect(typeEffectOne, power, 0, duration)
    local actionTwo = target:addStatusEffect(typeEffectTwo, power, 0, duration)

    if not actionOne and not actionTwo then -- both statuses fail to apply
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    elseif not actionOne and actionTwo then -- the first status fails to apply
        returnEffect = typeEffectTwo
    elseif actionOne and not actionTwo then -- the second status fails to apply
        returnEffect = typeEffectOne
    end

    return returnEffect
end

return spellObject
