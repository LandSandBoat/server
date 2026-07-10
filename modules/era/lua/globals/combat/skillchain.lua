-----------------------------------
-- Era Skillchain Module
-- Adds a resistance check back to skillchain damage calculations.
-- https://wiki.ffo.jp/html/32936.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_skillchain'

if xi.module.isContentEnabled('SOA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

local chainMultipliers =
{
    [1] = { 0.50, 0.60, 0.70, 0.80, 0.90, 1.00 }, -- Level 1
    [2] = { 0.60, 0.75, 1.00, 1.25, 1.50, 1.75 }, -- Level 2
    [3] = { 1.00, 1.50, 1.75, 2.00, 2.25, 2.50 }, -- Level 3
    [4] = { 1.50, 1.80, 2.10, 2.40, 2.70, 3.00 }, -- Level 4 "Radiance/Umbra"
}

local function getSkillchainElementToUse(target, skillchainType)
    -- Build skillchain available elements table.
    local elementTable = {}
    for i = xi.element.FIRE, xi.element.DARK do
        if xi.data.element.skillchainElementTable[i][skillchainType] > 0 then
            table.insert(elementTable, #elementTable + 1, i)
        end
    end

    -- Early return: Single elemental SC. No need to continue.
    if #elementTable == 1 then
        return elementTable[1]
    end

    -- Get lowest resistance rank value.
    local lowestResRank = 11
    local lowestElement = xi.element.FIRE

    for j = #elementTable, 1, -1 do
        local resRankValue = target:getMod(xi.data.element.getElementalResistanceRankModifier(elementTable[j]))
        if resRankValue <= lowestResRank then
            lowestResRank = resRankValue
            lowestElement = elementTable[j]
        end
    end

    return lowestElement
end

m:addOverride('xi.combat.skillchain.calculateSkillchainDamage', function(actor, target, baseDamage)
    local skillchainEffect = target:getStatusEffect(xi.effect.SKILLCHAIN)
    if not skillchainEffect then
        return 0
    end

    local skillchainType = skillchainEffect:getPower()
    if skillchainType == 0 then
        return 0
    end

    local skillchainLevel = skillchainEffect:getTier()
    if skillchainLevel < 1 or skillchainLevel > 4 then
        return 0
    end

    local skillchainCount = skillchainEffect:getSubPower()
    if skillchainCount < 1 or skillchainCount > 6 then
        return 0
    end

    local skillchainElement = getSkillchainElementToUse(target, skillchainType)
    if not skillchainElement then
        return 0
    end

    if xi.spells.damage.calculateNullification(target, skillchainElement, false, true, false, false) == 0 then
        return 0
    end

    -- Calculate resist, base damage and multipliers.
    local finalDamage          = math.abs(baseDamage) -- Damage from skillchain, no matter if absorbed or not.
    local levelMultiplier      = chainMultipliers[skillchainLevel][skillchainCount]
    local bonusMultiplier      = 1 + actor:getMod(xi.mod.SKILLCHAINBONUS) / 100
    local damageMultiplier     = 1 + actor:getMod(xi.mod.SKILLCHAINDMG) / 10000
    local dayWeatherMultiplier = xi.spells.damage.calculateDayAndWeather(actor, skillchainElement, false)
    local staffMultiplier      = xi.spells.damage.calculateElementalStaffBonus(actor, skillchainElement)
    local affinityMultiplier   = xi.spells.damage.calculateElementalAffinityBonus(actor, skillchainElement)
    local resistRate           = xi.combat.magicHitRate.calculateResistRate(actor, target, 0, 0, xi.skillRank.A_PLUS, skillchainElement, 0, 0, 0)
    local magicTakenMultiplier = xi.combat.damage.calculateDamageAdjustment(target, false, true, false, false)

    -- Unconfirmed order.
    local inninMultiplier      = 1 + actor:getMerit(xi.merit.INNIN_EFFECT) / 100
    local sengikoriMultiplier  = 1 + target:getMod(xi.mod.SENGIKORI_SC_DMG_DEBUFF) / 100
    local absorptionMultiplier = xi.spells.damage.calculateAbsorption(target, skillchainElement, false, true, false, false)

    -- Apply multipliers in order and floor after each step.
    finalDamage = math.floor(finalDamage * levelMultiplier)
    finalDamage = math.floor(finalDamage * bonusMultiplier) + actor:getMod(xi.mod.MAGIC_DAMAGE)
    finalDamage = math.floor(finalDamage * damageMultiplier)
    finalDamage = math.floor(finalDamage * dayWeatherMultiplier)
    finalDamage = math.floor(finalDamage * staffMultiplier)
    finalDamage = math.floor(finalDamage * affinityMultiplier)
    finalDamage = math.floor(finalDamage * resistRate)
    finalDamage = math.floor(finalDamage * magicTakenMultiplier)
    finalDamage = math.floor(finalDamage * inninMultiplier)
    finalDamage = math.floor(finalDamage * sengikoriMultiplier)
    finalDamage = math.floor(finalDamage * absorptionMultiplier)

    -- Handle (reset) Sengikori.
    target:setMod(xi.mod.SENGIKORI_SC_DMG_DEBUFF, 0)

    -- Handle other damage alterations.
    if finalDamage > 0 then
        finalDamage = utils.clamp(utils.handlePhalanx(target, finalDamage), 0, 99999)
        finalDamage = utils.clamp(utils.handleOneForAll(target, finalDamage), 0, 99999)
        finalDamage = utils.clamp(utils.handleStoneskin(target, finalDamage), 0, 99999)
        finalDamage = target:checkDamageCap(finalDamage)

        target:takeDamage(finalDamage, actor, xi.attackType.SPECIAL, xi.damageType.ELEMENTAL + skillchainElement)

    -- Handle absorbption.
    else
        target:addHP(-finalDamage)
    end

    return finalDamage
end)

return m
