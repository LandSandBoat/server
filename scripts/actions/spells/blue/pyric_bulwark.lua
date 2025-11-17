-----------------------------------
-- Spell: Pyric Bulwark
-- Grants a Stoneskin effect that absorbs one physical attack
-- Spell cost: 50 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 3
-- Stat Bonus: None
-- Level: 98
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 180 seconds (or until hit)
-----------------------------------
-- Combos: None
-----------------------------------
-- Notes: Requires Unbridled Learning. 1-shadow Blink effect for physical attacks only.
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
    local power = 1  -- 1 hit absorbed
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 180)

    if not target:addStatusEffect(xi.effect.STONESKIN, power, 0, duration, 0, 0, 1) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.STONESKIN
end

return spellObject
