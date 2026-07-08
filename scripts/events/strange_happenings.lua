-----------------------------------
-- Strange Happenings in Vana'diel
-- https://www.playonline.com/pcd2/topics/ff11us/detail/40250/detail.html
-----------------------------------
xi = xi or {}
xi.events = xi.events or {}
xi.events.strangeHappenings = xi.events.strangeHappenings or {}

local event = SeasonalEvent:new('StrangeHappenings')

local chestDurationMinutes = 10

local function getEncounters()
    local result = {}
    local ID

    ID = zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
    if ID then
        result[xi.zone.ALZADAAL_UNDERSEA_RUINS] =
        {
            mob     = ID.mob.ALEXANDER,
            chest   = ID.npc.STRANGE_HAPPENINGS_CHEST,
            rewards = { xi.item.IRON_GIANT_SHARD, xi.item.LUNGO_NANGOS_THESIS },
        }
    end

    ID = zones[xi.zone.RUAUN_GARDENS]
    if ID then
        result[xi.zone.RUAUN_GARDENS] =
        {
            mob     = ID.mob.KIRIN,
            chest   = ID.npc.STRANGE_HAPPENINGS_CHEST,
            rewards = { xi.item.KIRINS_MANE, xi.item.LUNGO_NANGOS_THESIS },
        }
    end

    ID = zones[xi.zone.THE_BOYAHDA_TREE]
    if ID then
        result[xi.zone.THE_BOYAHDA_TREE] =
        {
            mob     = ID.mob.FAFNIR,
            chest   = ID.npc.STRANGE_HAPPENINGS_CHEST,
            rewards = { xi.item.FAFNIRS_SCALE, xi.item.LUNGO_NANGOS_THESIS },
        }
    end

    return result
end

local chestData = {}

local function removeChest(chest)
    chestData[chest:getID()] = nil
    npcUtil.disappearCrate(chest)
end

xi.events.strangeHappenings.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.GIL_BONUS, -100)
    mob:setMobMod(xi.mobMod.CLAIM_TYPE, xi.claimType.NON_EXCLUSIVE)
end

xi.events.strangeHappenings.onMobDeath = function(mob)
    local enc = getEncounters()[mob:getZoneID()]
    if not enc or mob:getID() ~= enc.mob then
        return
    end

    local chest = GetNPCByID(enc.chest)
    if not chest then
        return
    end

    chestData[enc.chest] =
    {
        items   = enc.rewards,
        claimed = {},
    }

    chest:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
    npcUtil.showCrate(chest)

    chest:timer(chestDurationMinutes * 60 * 1000, function(chestArg)
        if chestArg:getStatus() == xi.status.NORMAL then
            removeChest(chestArg)
        end
    end)
end

xi.events.strangeHappenings.hasClaimed = function(player, npc)
    local data = chestData[npc:getID()]
    return data and data.claimed[player:getID()] == true
end

xi.events.strangeHappenings.onChestTrigger = function(player, npc)
    local data = chestData[npc:getID()]
    if not data then
        return
    end

    local playerId = player:getID()
    if data.claimed[playerId] then
        return
    end

    local anyGiven = false
    for _, itemId in ipairs(data.items) do
        if npcUtil.giveItem(player, itemId) then
            anyGiven = true
        end
    end

    if anyGiven then
        data.claimed[playerId] = true
    end
end

event:setEnableCheck(function()
    return xi.settings.main.ENABLE_STRANGE_HAPPENINGS == 1
end)

event:setStartFunction(function()
    for _, enc in pairs(getEncounters()) do
        local mob = GetMobByID(enc.mob)
        if mob and not mob:isSpawned() then
            DisallowRespawn(enc.mob, false)
            SpawnMob(enc.mob)
        end
    end
end)

event:setEndFunction(function()
    for _, enc in pairs(getEncounters()) do
        local mob = GetMobByID(enc.mob)
        if mob and mob:isSpawned() then
            DisallowRespawn(enc.mob, true)
            DespawnMob(enc.mob)
        end

        local chest = GetNPCByID(enc.chest)
        if chest and chest:getStatus() == xi.status.NORMAL then
            removeChest(chest)
        end
    end
end)

return event
