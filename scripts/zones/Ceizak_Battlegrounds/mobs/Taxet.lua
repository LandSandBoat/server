-----------------------------------
-- Area: Ceizak Battlegrounds
-- NM: Tax'et
-- !pos -279 0 -289 261
-- !additem 6015
-----------------------------------

local entity = {}

local initialUDMG = -9900
local maxUDMG = 0

local removables = {
    xi.effect.FLASH, xi.effect.BLINDNESS, xi.effect.PARALYSIS, xi.effect.POISON,
    xi.effect.DISEASE, xi.effect.PLAGUE, xi.effect.WEIGHT, xi.effect.BIND, xi.effect.BIO,
    xi.effect.DIA, xi.effect.BURN, xi.effect.FROST, xi.effect.CHOKE, xi.effect.RASP, xi.effect.SILENCE,
    xi.effect.SHOCK, xi.effect.DROWN, xi.effect.STR_DOWN, xi.effect.DEX_DOWN, xi.effect.VIT_DOWN,
    xi.effect.AGI_DOWN, xi.effect.INT_DOWN, xi.effect.MND_DOWN, xi.effect.CHR_DOWN, xi.effect.SLOW,
    xi.effect.ADDLE, xi.effect.HELIX, xi.effect.ACCURACY_DOWN, xi.effect.ATTACK_DOWN, xi.effect.INHIBIT_TP,
    xi.effect.EVASION_DOWN, xi.effect.DEFENSE_DOWN, xi.effect.MAGIC_ACC_DOWN, xi.effect.MAGIC_ATK_DOWN,
    xi.effect.MAGIC_EVASION_DOWN, xi.effect.MAGIC_DEF_DOWN, xi.effect.MAX_TP_DOWN, xi.effect.MAX_MP_DOWN
}

local function hasDebuff(mob)
    for _, effect in ipairs(removables) do
        if mob:hasStatusEffect(effect) then
            return true
        end
    end

    return false
end

local function checkExuviationUse(mob)
    local wasDebuffed = mob:getLocalVar('wasDebuffed')
    local nowDebuffed = hasDebuff(mob) and 1 or 0

    local removed = mob:getLocalVar('debuffsRemoved') or 0
    local totalRemoved = mob:getLocalVar('totalDebuffsRemoved') or 0

    if totalRemoved >= 100 then
        return
    end

    if wasDebuffed == 1 and nowDebuffed == 0 then
        local newUDMG = math.min(mob:getMod(xi.mod.UDMGPHYS) + (removed * 100), maxUDMG)

        mob:setMod(xi.mod.UDMGPHYS, newUDMG)
        mob:setMod(xi.mod.UDMGMAGIC, newUDMG)
        mob:setMod(xi.mod.UDMGRANGE, newUDMG)
        mob:setMod(xi.mod.UDMGBREATH, newUDMG)

        mob:setLocalVar('debuffsRemoved', 0)
    end

    mob:setLocalVar('debuffsRemoved', 0)
    mob:setLocalVar('wasDebuffed', nowDebuffed)
    mob:setLocalVar('totalDebuffsRemoved', totalRemoved + removed)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('wasDebuffed', 0)
    mob:setLocalVar('totalDebuffsRemoved', 0)
    mob:setLocalVar('debuffsRemoved', 0)

    mob:setMod(xi.mod.UDMGPHYS, initialUDMG)
    mob:setMod(xi.mod.UDMGMAGIC, initialUDMG)
    mob:setMod(xi.mod.UDMGRANGE, initialUDMG)
    mob:setMod(xi.mod.UDMGBREATH, initialUDMG)

    mob:setMobMod(xi.mobMod.SKILL_LIST, 2023)

    mob:addListener('COMBAT_TICK', 'DEBUFF_AND_UDMG_HANDLER', function(mobArg)
        local debuffCount = 0

        for _, effect in ipairs(removables) do
            if mobArg:hasStatusEffect(effect) then
                debuffCount = debuffCount + 1
            end
        end

        local totalRemoved = mobArg:getLocalVar('totalDebuffsRemoved') or 0

        if totalRemoved < 100 then
            if debuffCount >= 3 and mobArg:getHPP() > 50 then
                mobArg:setMobMod(xi.mobMod.SKILL_LIST, 2025)
            elseif debuffCount >= 3 and math.random(1, 100) <= 15 then
                mobArg:setMobMod(xi.mobMod.SKILL_LIST, 2025)
            else
                mobArg:setMobMod(xi.mobMod.SKILL_LIST, mobArg:getHPP() <= 50 and 2024 or 2023)
            end
        else
            mobArg:setMobMod(xi.mobMod.SKILL_LIST, mobArg:getHPP() <= 50 and 2024 or 2023)
        end

        checkExuviationUse(mobArg)
    end)
end

entity.onMobDeath = function(mob)
    for _, mod in ipairs({ xi.mod.UDMGPHYS, xi.mod.UDMGMAGIC, xi.mod.UDMGRANGE, xi.mod.UDMGBREATH }) do
        mob:setMod(mod, 0)
    end

    mob:removeListener('DEBUFF_AND_UDMG_HANDLER')
end

return entity
