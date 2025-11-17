-----------------------------------
-- Spell: Demoralizing Roar
-- Lowers targets' attack within area of effect
-- Spell cost: 46 MP
-- Monster Type: Dragon
-- Spell Type: Magical (Water)
-- Blue Magic Points: 4
-- Stat Bonus: STR-2, VIT+3
-- Level: 80
-- Casting Time: 3 seconds
-- Recast Time: 30 seconds
-- Duration: 30 seconds
-----------------------------------
-- Combos: Double Attack, Triple Attack
-----------------------------------
-- Notes: Attack Down -20%
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local duration = 30
    local power = 20  -- -20% Attack
    local resist = applyResistanceEffect(caster, target, spell, { xi.element.WATER }, xi.skill.BLUE_MAGIC)

    if resist > 0.125 then
        if target:addStatusEffect(xi.effect.ATTACK_DOWN, power, 0, duration) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return xi.effect.ATTACK_DOWN
end

return spellObject
