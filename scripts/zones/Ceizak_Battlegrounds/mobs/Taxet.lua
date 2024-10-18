-----------------------------------
-- Area: Ceizak Battlegrounds
-- NM: Tax'et
-- !pos -280 0 -290 261
-- !additem 6015
-----------------------------------
---@type TMobEntity
local entity = {}

local removables = {
    xi.effect.FLASH, xi.effect.BLINDNESS, xi.effect.ELEGY, xi.effect.REQUIEM, xi.effect.PARALYSIS, xi.effect.POISON,
    xi.effect.CURSE_I, xi.effect.CURSE_II, xi.effect.DISEASE, xi.effect.PLAGUE, xi.effect.WEIGHT, xi.effect.BIND,
    xi.effect.BIO, xi.effect.DIA, xi.effect.BURN, xi.effect.FROST, xi.effect.CHOKE, xi.effect.RASP, xi.effect.SHOCK, xi.effect.DROWN,
    xi.effect.STR_DOWN, xi.effect.DEX_DOWN, xi.effect.VIT_DOWN, xi.effect.AGI_DOWN, xi.effect.INT_DOWN, xi.effect.MND_DOWN,
    xi.effect.CHR_DOWN, xi.effect.ADDLE, xi.effect.SLOW, xi.effect.HELIX, xi.effect.ACCURACY_DOWN, xi.effect.ATTACK_DOWN,
    xi.effect.EVASION_DOWN, xi.effect.DEFENSE_DOWN, xi.effect.MAGIC_ACC_DOWN, xi.effect.MAGIC_ATK_DOWN, xi.effect.MAGIC_EVASION_DOWN,
    xi.effect.MAGIC_DEF_DOWN, xi.effect.MAX_TP_DOWN, xi.effect.MAX_MP_DOWN, xi.effect.MAX_HP_DOWN
}

local exuviationSkillID = 1955
local initialDamage = -9900
local damageIncrease = 494
local exuviationCD = 10

-- Create a local table for storing variables
local exuviationVars = {
    usageCount = 'exuviationUsageCount',
    lastTime = 'lastExuviationTime'
}

local function hasNegativeEffect(mob)
    for _, effect in ipairs(removables) do
        if mob:hasStatusEffect(effect) then
            return true
        end
    end

    return false
end

local function updateDamageReduction(mob)
    local exuviationUsageCount = mob:getLocalVar(exuviationVars.usageCount) or 0
    local reduction = initialDamage + (exuviationUsageCount * damageIncrease)
    reduction = math.min(reduction, 0)

    mob:setMod(xi.mod.UDMGPHYS, reduction)
    mob:setMod(xi.mod.UDMGMAGIC, reduction)
    mob:setMod(xi.mod.UDMGRANGE, reduction)
    mob:setMod(xi.mod.UDMGBREATH, reduction)
end

local function handleExuviationUsage(mob)
    local exuviationUsageCount = mob:getLocalVar(exuviationVars.usageCount) or 0
    exuviationUsageCount = exuviationUsageCount + 1
    mob:setLocalVar(exuviationVars.usageCount, exuviationUsageCount)

    updateDamageReduction(mob)
    mob:setLocalVar(exuviationVars.lastTime, os.time())
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar(exuviationVars.usageCount, 0)
    mob:setLocalVar(exuviationVars.lastTime, 0)
    updateDamageReduction(mob)

    mob:addListener('COMBAT_TICK', 'CHECK_NEGATIVE_EFFECTS', function(mobArg)
        local currentTime = os.time()
        local lastExuviationTime = mobArg:getLocalVar(exuviationVars.lastTime) or 0
        local chance = math.random(100)
        local tp = mob:getTP()

        if hasNegativeEffect(mobArg) and mobArg:getHPP() >= 50 then
            if chance <= 75 and (currentTime - lastExuviationTime) >= exuviationCD then
                if tp >= 1000 then
                    mobArg:useMobAbility(exuviationSkillID)
                    handleExuviationUsage(mobArg)
                end
            end
        end

        if mobArg:getHPP() <= 50 then
            mobArg:setMobMod(xi.mobMod.SKILL_LIST, 2020)
            else
            mobArg:setMobMod(xi.mobMod.SKILL_LIST, 2019)
        end
    end)
end

entity.onMobDeath = function(mob)
end

return entity
