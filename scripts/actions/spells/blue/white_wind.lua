-----------------------------------
-- Spell: White Wind
-- Restores HP for party members within area of effect.
-- Healing amount is based on caster's maximum HP.
-- Formula: floor(CasterMaxHP / 7) * 2
-----------------------------------
-- Research confirmed from BG-Wiki:
-- - Based on caster's MAXIMUM HP, not current HP
-- - NOT affected by MND or Healing Magic Skill
-- - IS affected by Cure Potency equipment
-- - Can be boosted by Divine Seal
-- - Affected by weather and obis
-----------------------------------
require('scripts/globals/magic')
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Base healing formula: floor(MaxHP / 7) * 2
    local baseHealing = math.floor(caster:getMaxHP() / 7) * 2

    -- Apply Cure Potency modifiers
    local curePotency = 1 + (caster:getMod(xi.mod.CURE_POTENCY) / 100)
    local healingAmount = baseHealing * curePotency

    -- Apply weather/day bonuses (same as other cure spells)
    healingAmount = healingAmount * xi.magic.getWeatherDayBonus(caster, spell)

    -- Apply Divine Seal if active
    if caster:hasStatusEffect(xi.effect.DIVINE_SEAL) then
        healingAmount = healingAmount * 2
    end

    -- Apply target's Cure Potency Received
    healingAmount = healingAmount + (healingAmount * (target:getMod(xi.mod.CURE_POTENCY_RCVD) / 100))

    -- Cap healing at target's missing HP
    local missingHP = target:getMaxHP() - target:getHP()
    if healingAmount > missingHP then
        healingAmount = missingHP
    end

    -- Final healing amount
    local final = math.floor(healingAmount)

    -- Restore HP
    target:addHP(final)

    -- Generate enmity from healing
    caster:updateEnmityFromCure(target, final)

    return final
end

return spellObject
