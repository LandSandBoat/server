xi = xi or {}
xi.apkallu = xi.apkallu or {}
xi.apkallu.zones = xi.apkallu.zones or {}

xi.apkallu.fish =
{
    xi.item.AHTAPOT,
    xi.item.VEYDAL_WRASSE,
    xi.item.YAYINBALIGI,
}

xi.apkallu.track = function(mob)
    local zoneID = mob:getZoneID()
    xi.apkallu.zones[zoneID] = xi.apkallu.zones[zoneID] or {}
    table.insert(xi.apkallu.zones[zoneID], mob)
end

xi.apkallu.initialize = function(mob)
    local zoneID = mob:getZoneID()
    local ID     = zones[zoneID]
    local hate   = GetServerVariable('ApkalluHate_'..zoneID)
    local tier   = xi.apkallu.getHateTier(hate)

    if tier == 0 and mob:getID() == ID.mob.APKALLU_NPC then
        -- Convert this Apkallu into an NPC
        mob:setStatus(xi.status.NORMAL)
    elseif tier == 2 then
        -- Apkallu now aggro by sight
        mob:setAggressive(true)
    end

    if tier ~= 3 then
        -- Apkallu should not link
        mob:setLink(0)
    end

    if hate > 25 then
        local reduction = hate - 25
        mob:setMod(xi.mod.DMGPHYS, -reduction)
        mob:setMod(xi.mod.DMGRANGE, -reduction)
        mob:setMod(xi.mod.DMGMAGIC, -reduction)
    end
end

xi.apkallu.updateHate = function(zoneID, amount)
    local ID = zones[zoneID]
    local previousHate = GetServerVariable('ApkalluHate_'..zoneID)
    local hate = previousHate + amount
    local shouldCheckTiers = true
    if hate > 100 then
        hate = 100
        shouldCheckTiers = false
    elseif hate < 0 then
        hate = 0
        shouldCheckTiers = false
    end

    SetServerVariable('ApkalluHate_'..zoneID, hate)

    if not shouldCheckTiers then
        return
    end

    local apkallus = xi.apkallu.zones[zoneID]
    if apkallus == nil then
        return
    end

    local previousTier = xi.apkallu.getHateTier(previousHate)
    local currentTier = xi.apkallu.getHateTier(hate)
    if currentTier ~= previousTier then
        if amount > 0 then
            if currentTier == 1 then
                -- Change NPC Apkallu back to mobs
                GetMobByID(ID.mob.APKALLU_NPC):setStatus(xi.status.UPDATE)
            elseif currentTier == 2 then
                -- Apkallu now aggro by sight
                for _, mob in ipairs(apkallus) do
                    mob:setAggressive(true)
                end
            elseif currentTier == 3 then
                -- Apkallu now link
                for _, mob in ipairs(apkallus) do
                    mob:setLink(1)
                    mob:setLocalVar('RunAway', 1)
                end
            end
        else
            if currentTier == 0 then
                -- Change Apkallu to NPC
                GetMobByID(ID.mob.APKALLU_NPC):setStatus(xi.status.NORMAL)
            elseif currentTier == 1 then
                -- Apkallu no longer aggro by sight
                for _, mob in ipairs(apkallus) do
                    mob:setAggressive(false)
                end
            elseif currentTier == 2 then
                -- Apkallu no longer link
                for _, mob in ipairs(apkallus) do
                    mob:setLink(0)
                    mob:setLocalVar('RunAway', 0)
                end
            end
        end
    end

    local reduction = math.max(0, hate - 25)
    for _, mob in ipairs(apkallus) do
        mob:setMod(xi.mod.DMGPHYS, -reduction)
        mob:setMod(xi.mod.DMGRANGE, -reduction)
        mob:setMod(xi.mod.DMGMAGIC, -reduction)
    end
end

xi.apkallu.getHateTier = function(hate)
    if hate >= 45 then
        return 3
    elseif hate >= 25 then
        return 2
    elseif hate >= 5 then
        return 1
    else
        return 0
    end
end

xi.apkallu.canRunAway = function(mob)
    local zoneID = mob:getZoneID()
    local hate = GetServerVariable('ApkalluHate_'..zoneID)
    return xi.apkallu.getHateTier(hate) >= 3
end

xi.apkallu.canUseAbility = function(mob, threshold)
    if mob:isNM() then
        return 0
    end

    local zoneID = mob:getZoneID()
    if
        (zoneID == xi.zone.ARRAPAGO_REEF or zoneID == xi.zone.MOUNT_ZHAYOLM) and
        GetServerVariable('ApkalluHate_'..zoneID) < threshold
    then
        return 1
    end

    return 0
end
