-----------------------------------------
-- Spell: Impact
-- Deals dark damage to an enemy and
-- decreases all 7 base stats by 20%
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.attribute = tpz.mod.INT
    params.bonus = 1.0
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.dmg = 939
    params.effect = nil
    params.hasMultipleTargetReduction = false
    params.multiplier = 2.335
    params.resistBonus = 1.0
    params.skillType = 37
    params.skillType = tpz.skill.ELEMENTAL_MAGIC

    local resist = applyResistance(caster, target, spell, params)
    local duration = 180 * resist -- BG wiki suggests only duration gets effected by resist, not stat amount.

    -- Todo: loop to avoid repeatedly doing same thing for each stat
    local STR_Loss = ((target:getStat(tpz.mod.STR) / 100) * 20) -- Should be 20%
    local DEX_Loss = ((target:getStat(tpz.mod.DEX) / 100) * 20)
    local VIT_Loss = ((target:getStat(tpz.mod.VIT) / 100) * 20)
    local AGI_Loss = ((target:getStat(tpz.mod.AGI) / 100) * 20)
    local INT_Loss = ((target:getStat(tpz.mod.INT) / 100) * 20)
    local MND_Loss = ((target:getStat(tpz.mod.MND) / 100) * 20)
    local CHR_Loss = ((target:getStat(tpz.mod.CHR) / 100) * 20)
    if (target:hasStatusEffect(tpz.effect.STR_DOWN) == false) then
        target:addStatusEffect(tpz.effect.STR_DOWN, STR_Loss, 0, duration)
    end
    if (target:hasStatusEffect(tpz.effect.DEX_DOWN) == false) then
        target:addStatusEffect(tpz.effect.DEX_DOWN, DEX_Loss, 0, duration)
    end
    if (target:hasStatusEffect(tpz.effect.VIT_DOWN) == false) then
        target:addStatusEffect(tpz.effect.VIT_DOWN, VIT_Loss, 0, duration)
    end
    if (target:hasStatusEffect(tpz.effect.AGI_DOWN) == false) then
        target:addStatusEffect(tpz.effect.AGI_DOWN, AGI_Loss, 0, duration)
    end
    if (target:hasStatusEffect(tpz.effect.INT_DOWN) == false) then
        target:addStatusEffect(tpz.effect.INT_DOWN, INT_Loss, 0, duration)
    end
    if (target:hasStatusEffect(tpz.effect.MND_DOWN) == false) then
        target:addStatusEffect(tpz.effect.MND_DOWN, MND_Loss, 0, duration)
    end
    if (target:hasStatusEffect(tpz.effect.CHR_DOWN) == false) then
        target:addStatusEffect(tpz.effect.CHR_DOWN, CHR_Loss, 0, duration)
    end

    -- Diverting use of doElementalNuke till spellParams is implemented for this spell
    -- local dmg = doElementalNuke(caster, target, spell, params)

    -- Calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    -- Get the resisted damage
    dmg = dmg*resist
    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)
    -- Add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
    -- Add in final adjustments
    dmg = finalMagicAdjustments(caster, target, spell, dmg)

    return dmg
end
