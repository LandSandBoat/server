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
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 90)
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
