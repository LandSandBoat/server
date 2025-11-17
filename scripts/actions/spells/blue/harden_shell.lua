-----------------------------------
-- Spell: Harden Shell
-- Enhances defense
-- Spell cost: 20 MP
-- Monster Type: Aquan
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 1
-- Stat Bonus: None
-- Level: 95
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 180 seconds
-----------------------------------
-- Combos: None
-----------------------------------
-- Notes: Requires Unbridled Learning. Functionally identical to Cocoon.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    -- Requires Unbridled Learning
    if not caster:hasStatusEffect(xi.effect.UNBRIDLED_LEARNING) then
        return xi.msg.basic.STATUS_PREVENTS
    end

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local power = 50 -- 50% defense boost
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 180)

    if not target:addStatusEffect(xi.effect.DEFENSE_BOOST, power, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.DEFENSE_BOOST
end

return spellObject
