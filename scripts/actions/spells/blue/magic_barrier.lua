-----------------------------------
-- Spell: Magic Barrier
-- Reduces magic damage taken
-- Spell cost: 76 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: MND+4
-- Level: 82
-- Casting Time: 3 seconds
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
    local power = 1500 -- 15% magic damage reduction
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 180)

    if not target:addStatusEffect(xi.effect.SHELL, power, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.SHELL
end

return spellObject
