-----------------------------------
-- Spell: Feather Barrier
-- Enhances evasion
-- Spell cost: 29 MP
-- Monster Type: Birds
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 2
-- Stat Bonus: None
-- Level: 56
-- Casting Time: 2 seconds
-- Recast Time: 120 seconds
-- Duration: 30 Seconds
-----------------------------------
-- Combos: Resist Gravity
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local power = 20
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 30)

    if not target:addStatusEffect(xi.effect.EVASION_BOOST, power, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.EVASION_BOOST
end

return spellObject
