-----------------------------------
-- Spell: Barrier Tusk
-- Reduces damage taken
-- Spell cost: 41 MP
-- Monster Type: Beast
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 3
-- Stat Bonus: HP+15, MP-15, VIT+3
-- Level: 91
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 180 seconds
-----------------------------------
-- Combos: None
-----------------------------------
-- Notes: This is a unique 15% damage reduction buff that bypasses the 50% DT cap
-- It is NOT Phalanx, but uses PHALANX effect as a placeholder
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- 15% damage reduction (using PHALANX effect as placeholder)
    -- Note: This should bypass the 50% DT cap, but current implementation
    -- uses PHALANX which may not perfectly match retail behavior
    local power = 15  -- 15% damage reduction
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 180)

    if not target:addStatusEffect(xi.effect.PHALANX, power, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.PHALANX
end

return spellObject
