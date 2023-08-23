-----------------------------------
-- Spell: Impact
-- Deals dark damage to an enemy and
-- decreases all 7 base stats by 20%
-----------------------------------
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

    local resist = applyResistance(caster, target, spell, params)
    local duration = 180 * resist -- BG wiki suggests only duration gets effected by resist, not stat amount.

    -- Todo: loop to avoid repeatedly doing same thing for each stat
    local strLoss = ((target:getStat(xi.mod.STR) / 100) * 20) -- Should be 20%
    local dexLoss = ((target:getStat(xi.mod.DEX) / 100) * 20)
    local vitLoss = ((target:getStat(xi.mod.VIT) / 100) * 20)
    local agiLoss = ((target:getStat(xi.mod.AGI) / 100) * 20)
    local intLoss = ((target:getStat(xi.mod.INT) / 100) * 20)
    local mndLoss = ((target:getStat(xi.mod.MND) / 100) * 20)
    local chrLoss = ((target:getStat(xi.mod.CHR) / 100) * 20)

    if not target:hasStatusEffect(xi.effect.STR_DOWN) then
        target:addStatusEffect(xi.effect.STR_DOWN, strLoss, 0, duration)
    end

    if not target:hasStatusEffect(xi.effect.DEX_DOWN) then
        target:addStatusEffect(xi.effect.DEX_DOWN, dexLoss, 0, duration)
    end

    if not target:hasStatusEffect(xi.effect.VIT_DOWN) then
        target:addStatusEffect(xi.effect.VIT_DOWN, vitLoss, 0, duration)
    end

    if not target:hasStatusEffect(xi.effect.AGI_DOWN) then
        target:addStatusEffect(xi.effect.AGI_DOWN, agiLoss, 0, duration)
    end

    if not target:hasStatusEffect(xi.effect.INT_DOWN) then
        target:addStatusEffect(xi.effect.INT_DOWN, intLoss, 0, duration)
    end

    if not target:hasStatusEffect(xi.effect.MND_DOWN) then
        target:addStatusEffect(xi.effect.MND_DOWN, mndLoss, 0, duration)
    end

    if not target:hasStatusEffect(xi.effect.CHR_DOWN) then
        target:addStatusEffect(xi.effect.CHR_DOWN, chrLoss, 0, duration)
    end

    -- Calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    -- Get the resisted damage
    dmg = dmg * resist
    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)
    -- Add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
    -- Add in final adjustments
    dmg = finalMagicAdjustments(caster, target, spell, dmg)

    return dmg
end

return spellObject
