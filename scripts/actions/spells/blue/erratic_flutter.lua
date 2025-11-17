-----------------------------------
-- Spell: Erratic Flutter
-- Increases attack speed
-- Spell cost: 48 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 6
-- Stat Bonus: AGI+5
-- Level: 99
-- Casting Time: 2 seconds
-- Recast Time: 60 seconds
-- Duration: 180 seconds
-----------------------------------
-- Combos: None
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local power = 1500 -- 15%
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 180)

    if not target:addStatusEffect(xi.effect.HASTE, power, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.HASTE
end

return spellObject
