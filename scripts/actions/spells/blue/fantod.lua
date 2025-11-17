-----------------------------------
-- Spell: Fantod
-- Increases the rate at which TP is gained
-- Spell cost: 40 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Light)
-- Blue Magic Points: 4
-- Stat Bonus: STR+2, MND+2
-- Level: 85
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 180 seconds
-----------------------------------
-- Combos: Store TP
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local power = 15 -- +15 Store TP
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 180)

    if not target:addStatusEffect(xi.effect.STORE_TP, power, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.STORE_TP
end

return spellObject
