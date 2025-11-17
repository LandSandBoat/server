-----------------------------------
-- Spell: Nature's Meditation
-- Increases attack
-- Spell cost: 60 MP
-- Monster Type: Beast
-- Spell Type: Magical (Light)
-- Blue Magic Points: 8
-- Stat Bonus: STR+5
-- Level: 99
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 60 seconds
-----------------------------------
-- Combos: Accuracy Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local power = 2000 -- 20% attack boost (stored as 2000 = 20%)
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 60)

    if not target:addStatusEffect(xi.effect.ATTACK_BOOST, power, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.ATTACK_BOOST
end

return spellObject
