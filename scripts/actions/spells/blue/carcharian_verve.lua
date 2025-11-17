-----------------------------------
-- Spell: Carcharian Verve
-- Grants multiple beneficial effects to the caster
-- Spell cost: 65 MP
-- Monster Type: Aquan
-- Spell Type: Magical (Water)
-- Blue Magic Points: 5
-- Stat Bonus: None
-- Level: 99
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-----------------------------------
-- Combos: None
-----------------------------------
-- Notes: Requires Unbridled Learning.
-- Effect 1: Attack Bonus +20%, 60s (does NOT stack with Nature's Meditation)
-- Effect 2: Magic Attack Bonus +20, 60s
-- Effect 3: Aquaveil (10 shadows), 900s
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
    local duration60 = xi.spells.blue.calculateDurationWithDiffusion(caster, 60)
    local duration900 = xi.spells.blue.calculateDurationWithDiffusion(caster, 900)

    -- Effect 1: Attack Bonus +20%
    target:addStatusEffect(xi.effect.ATTACK_BOOST, 2000, 0, duration60)

    -- Effect 2: Magic Attack Bonus +20
    target:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, 20, 0, duration60)

    -- Effect 3: Aquaveil (10 shadows, not affected by gear/skill)
    target:addStatusEffect(xi.effect.AQUAVEIL, 10, 0, duration900)

    return xi.effect.ATTACK_BOOST
end

return spellObject
