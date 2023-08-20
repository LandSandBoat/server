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
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local typeEffectOne = xi.effect.DEFENSE_BOOST
    local typeEffectTwo = xi.effect.ICE_SPIKES
    local powerOne = 12 -- 12%
    local powerTwo = 5 -- 5 dmg
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 120)
    local returnEffect = typeEffectOne

    -- Reactor Cool Will Overwrite Ice Spikes and Def Boost regardless of Power
    if
        target:hasStatusEffect(typeEffectOne) or
        target:hasStatusEffect(typeEffectTwo)
    then
        target:delStatusEffectSilent(typeEffectOne)
        target:delStatusEffectSilent(typeEffectTwo)
    end

    target:addStatusEffect(typeEffectOne, powerOne, 0, duration)
    target:addStatusEffect(typeEffectTwo, powerTwo, 0, duration)
    spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)

    return returnEffect
end

return spellObject
