-----------------------------------
-- Spell: Orcish Counterstance
-- Increases counter rate
-- Spell cost: 18 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Light)
-- Blue Magic Points: 5
-- Stat Bonus: STR+3, VIT+3, HP+10, DEX-2, AGI-2
-- Level: 98
-- Casting Time: 1 second
-- Recast Time: 60 seconds
-- Duration: 60 seconds
-----------------------------------
-- Combos: Counter
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local power = 20 -- +20% counter rate
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 60)

    if not target:addStatusEffect(xi.effect.COUNTERSTANCE, power, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.COUNTERSTANCE
end

return spellObject
