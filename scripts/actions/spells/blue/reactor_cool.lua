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
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 120)

    -- Reactor Cool Will Overwrite Ice Spikes and Def Boost regardless of Power
    if
        target:hasStatusEffect(xi.effect.DEFENSE_BOOST) or
        target:hasStatusEffect(xi.effect.ICE_SPIKES)
    then
        target:delStatusEffectSilent(xi.effect.DEFENSE_BOOST)
        target:delStatusEffectSilent(xi.effect.ICE_SPIKES)
    end

    target:addStatusEffect(xi.effect.DEFENSE_BOOST, 12, 0, duration)
    target:addStatusEffect(xi.effect.ICE_SPIKES, 5, 0, duration)
    spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)

    return xi.effect.DEFENSE_BOOST
end

return spellObject
