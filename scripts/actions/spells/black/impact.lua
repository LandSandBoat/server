-----------------------------------
-- Spell: Impact
-- Deals dark damage to an enemy and
-- decreases all 7 base stats by 20%
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.attribute = xi.mod.INT
    params.bonus = 1.0
    params.diff = caster:getStat(xi.mod.INT)-target:getStat(xi.mod.INT)
    params.dmg = 939
    params.effect = nil
    params.hasMultipleTargetReduction = false
    params.multiplier = 2.335
    params.resistBonus = 1.0
    params.skillType = xi.skill.ELEMENTAL_MAGIC

    local resist = xi.combat.magicHitRate.calculateResistRate(caster, target, spell:getSpellGroup(), xi.skill.ELEMENTAL_MAGIC, 0, xi.element.DARK, xi.mod.INT, 0, 0)

    -- Calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    -- Get the resisted damage
    dmg = dmg * resist
    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)
    -- Add in target adjustment
    dmg = dmg * xi.spells.damage.calculateNukeAbsorbOrNullify(target, spell:getElement())
    -- Add in final adjustments
    dmg = finalMagicAdjustments(caster, target, spell, dmg)

    -- Apply effects.
    local effectTable =
    {
        [1] = { xi.effect.STR_DOWN, xi.mod.STR },
        [2] = { xi.effect.DEX_DOWN, xi.mod.DEX },
        [3] = { xi.effect.VIT_DOWN, xi.mod.VIT },
        [4] = { xi.effect.AGI_DOWN, xi.mod.AGI },
        [5] = { xi.effect.INT_DOWN, xi.mod.INT },
        [6] = { xi.effect.MND_DOWN, xi.mod.MND },
        [7] = { xi.effect.CHR_DOWN, xi.mod.CHR },
    }

    for i = 1, 7 do
        local effectId = effectTable[i][1]
        if not target:hasStatusEffect(effectId) then
            local power    = math.floor(target:getStat(effectTable[i][2]) * 20 / 100)
            local duration = math.floor(180 * resist)
            target:addStatusEffect(xi.effect.STR_DOWN, power, 0, duration)
        end
    end

    return dmg
end

return spellObject
