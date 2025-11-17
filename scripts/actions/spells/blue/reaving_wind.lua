-----------------------------------
-- Spell: Reaving Wind
-- Lowers target's accuracy
-- Spell cost: 38 MP
-- Monster Type: Dragon
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: INT+3, CHR+3
-- Level: 90
-- Casting Time: 2 seconds
-- Recast Time: 20 seconds
-- Duration: 120 seconds
-----------------------------------
-- Combos: Magic Burst Bonus
-----------------------------------
-- Notes: Accuracy Down -50
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local duration = 120
    local power = 50  -- -50 Accuracy
    local resist = applyResistanceEffect(caster, target, spell, { xi.element.WIND }, xi.skill.BLUE_MAGIC)

    if resist > 0.125 then
        if target:addStatusEffect(xi.effect.ACCURACY_DOWN, power, 0, duration) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return xi.effect.ACCURACY_DOWN
end

return spellObject
