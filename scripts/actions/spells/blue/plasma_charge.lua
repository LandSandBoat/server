-----------------------------------
-- Spell: Plasma Charge
-- Covers you with magical lightning spikes. Enemies that hit you take lightning damage
-- Spell cost: 24 MP
-- Monster Type: Luminians
-- Spell Type: Magical (Lightning)
-- Blue Magic Points: 5
-- Stat Bonus: STR+3 DEX+3
-- Level: 75
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 60 seconds
-----------------------------------
-- Combos: Auto Refresh
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local typeEffect = xi.effect.SHOCK_SPIKES
    local power = 5 -- 5 dmg
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 60)

    if not target:addStatusEffect(typeEffect, power, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spellObject
