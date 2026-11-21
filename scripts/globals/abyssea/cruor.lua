-----------------------------------
-- Abyssea Cruor Rewards
-----------------------------------
require('scripts/globals/abyssea')
xi = xi or {}
xi.abyssea = xi.abyssea or {}
xi.abyssea.cruor = xi.abyssea.cruor or {}

local function getConfig(name, default)
    local value = xi.settings.main[name]
    if value == nil then
        return default
    end

    return value
end

local function getLightBonus(player)
    local silverCap      = getConfig('ABYSSEA_CRUOR_SILVER_CAP', 200)
    local ebonCap        = getConfig('ABYSSEA_CRUOR_EBON_CAP', 200)
    local silver         = math.min(xi.abyssea.getLightValue(player, xi.abyssea.lightType.SILVERY) or 0, silverCap)
    local ebon           = math.min(xi.abyssea.getLightValue(player, xi.abyssea.lightType.EBON) or 0, ebonCap)

    local silverMaxBonus = getConfig('ABYSSEA_CRUOR_SILVER_MAX_BONUS', 0.6)
    local ebonAmplifier  = getConfig('ABYSSEA_CRUOR_EBON_SILVER_AMPLIFIER', 1.0)

    local silverRatio    = silver / silverCap
    local ebonRatio      = ebon / ebonCap

    return 1 + silverRatio * silverMaxBonus * (1 + ebonRatio * ebonAmplifier)
end

local function getIdentity(mob)
    local identityMode = getConfig('ABYSSEA_CRUOR_CHAIN_IDENTITY_MODE', 'pool')

    if identityMode == 'name' then
        return mob:getName()
    end

    return mob:getPool()
end

local function getFamilyModifier(mob)
    local modifier = 1.0

    -- Ephemeral mobs are documented by community resources as high Cruor/EXP outliers.
    if string.find(mob:getName(), 'Ephemeral_', 1, true) then
        modifier = modifier * getConfig('ABYSSEA_CRUOR_EPHEMERAL_MULTIPLIER', 3.0)
    end

    return modifier
end

local function getBaseCruor(mob)
    if mob:isNM() then
        local size            = mob:getModelSize() or 0
        local smallThreshold  = getConfig('ABYSSEA_CRUOR_NM_SMALL_SIZE', 4)
        local mediumThreshold = getConfig('ABYSSEA_CRUOR_NM_MEDIUM_SIZE', 7)

        if size <= smallThreshold then
            return getConfig('ABYSSEA_CRUOR_NM_BASE_T1', 50)
        elseif size <= mediumThreshold then
            return getConfig('ABYSSEA_CRUOR_NM_BASE_T2', 65)
        end

        return getConfig('ABYSSEA_CRUOR_NM_BASE_T3', 80)
    end

    local levelStep = getConfig('ABYSSEA_CRUOR_LEVEL_STEP', 0)
    local minBase   = getConfig('ABYSSEA_CRUOR_KILL_BASE_MIN', 10)
    local maxBase   = getConfig('ABYSSEA_CRUOR_KILL_BASE_MAX', 20)

    if maxBase < minBase then
        maxBase = minBase
    end

    local randomizedBase = math.random(minBase, maxBase)

    return math.max(1, math.floor((randomizedBase + mob:getMainLvl() * levelStep) * getFamilyModifier(mob)))
end

local function getEligibleMembers(killer)
    local members = {}

    for _, member in pairs(killer:getAlliance()) do
        local visitantEffect = member:getStatusEffect(xi.effect.VISITANT)
        if
            member:isPC() and
            member:getZoneID() == killer:getZoneID() and
            visitantEffect and
            visitantEffect:getIcon() == xi.effect.VISITANT
        then
            table.insert(members, member)
        end
    end

    return members
end

local function getKiller(player)
    if player and not player:isPC() and player:getAllegiance() == 1 then
        local master = player:getMaster()
        if master then
            return master
        end
    end

    return player
end

xi.abyssea.cruor.onMobDefeat = function(killer, mob)
    killer = getKiller(killer)
    if not killer or not killer:isPC() then
        return
    end

    local timeout    = getConfig('ABYSSEA_CRUOR_CHAIN_TIMEOUT_SEC', 0)
    local chainStep  = getConfig('ABYSSEA_CRUOR_CHAIN_STEP', 9)
    local chainCap   = getConfig('ABYSSEA_CRUOR_CHAIN_CAP', 180)
    local reaperStep = getConfig('ABYSSEA_CRUOR_REAPER_BONUS_STEP', 0.2)

    local now = GetSystemTime()
    local identity = tostring(getIdentity(mob))

    for _, member in pairs(getEligibleMembers(killer)) do
        local lastIdentity = tostring(member:getCharVar('AbysseaCruorLastIdentity'))
        local lastKillTime = member:getCharVar('AbysseaCruorLastKillTime')
        local chainCount   = member:getCharVar('AbysseaCruorChainCount')

        if timeout > 0 and lastKillTime > 0 and now - lastKillTime > timeout then
            chainCount = 0
        end

        if lastIdentity == identity then
            chainCount = 0
        else
            chainCount = chainCount + 1
        end

        local baseCruor   = getBaseCruor(mob)
        local chainBonus  = math.min(chainCount * chainStep, chainCap)
        local reaperBonus = 1 + xi.abyssea.getAbyssiteTotal(member, xi.abyssea.abyssiteType.THE_REAPER) * reaperStep
        local lightBonus  = getLightBonus(member)
        local cruorReward = math.floor((baseCruor + chainBonus) * reaperBonus * lightBonus)

        member:addCurrency('cruor', cruorReward)
        member:messageSpecial(zones[member:getZoneID()].text.CRUOR_OBTAINED, cruorReward)

        member:setCharVar('AbysseaCruorChainCount', chainCount)
        member:setCharVar('AbysseaCruorLastIdentity', identity)
        member:setCharVar('AbysseaCruorLastKillTime', now)
    end
end

return xi.abyssea.cruor
