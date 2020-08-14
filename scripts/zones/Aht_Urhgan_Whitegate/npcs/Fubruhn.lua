-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Fubruhn
-- Mog Locker NPC
--
-- Event IDs:
-- 600 = Not a mercenary + mog locker options
-- 1st arg = Amount of time left on lease, as seconds past 2001/12/31 15:00:00.
--          If this is 0, it shows the not a mecenary message instead.
--          If this is -1, it shows the lease as expired.
-- 2nd arg = Valid areas, 0=alzahbi only, 1=all areas
-- 3rd arg = The number of earth days a lease extension is valid for (7)
-- 4th arg = How big your locker is
-- 5th arg =
-- 6th arg =
-- 7th arg =
-- 8th arg = The number of days your lease is currently valid for
--
-- 601 = Lease increased
-- 1st arg = number of seconds from 2001/12/31 15:00:00 it is valid till.
--
-- 602 = Expansion increased
-- 4th arg = new size of locker
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/missions")
require("scripts/globals/moghouse")

function getNumberOfCoinsToUpgradeSize(size)
    if size == 30 then
        return 4
    elseif size == 40 then
        return 2
    elseif size == 50 then
        return 3
    elseif size == 60 then
        return 5
    elseif size == 70 then
        return 10
    elseif size == 80 then
        return 0
    end
end

function onTrade(player, npc, trade)
    local numBronze = trade:getItemQty(2184)
    local numMythril = trade:getItemQty(2186)
    local numGold = trade:getItemQty(2187)
    if player:getCurrentMission(TOAU) >= tpz.mission.id.toau.PRESIDENT_SALAHEEM then
        if numBronze > 0 and numMythril == 0 and numGold == 0 then
            if addMogLockerExpiryTime(player, numBronze) then
                -- remove bronze
                player:tradeComplete()
                -- send event
                player:startEvent(601, getMogLockerExpiryTimestamp(player))
                -- print("Expanded lease with "..numBronze.." bronze.")
            end
        elseif numGold > 0 or numMythril > 0 then
            -- see if we can expand the size
            local slotSize = player:getContainerSize(tpz.inv.MOGLOCKER)
            if slotSize == 30 and numMythril == 4 and numGold == 0 then
                player:changeContainerSize(tpz.inv.MOGLOCKER, 10)
                player:tradeComplete()
                player:startEvent(602, 0, 0, 0, 40)
            elseif slotSize == 40 and numMythril == 0 and numGold == 2 then
                player:changeContainerSize(tpz.inv.MOGLOCKER, 10)
                player:tradeComplete()
                player:startEvent(602, 0, 0, 0, 50)
            elseif slotSize == 50 and numMythril == 0 and numGold == 3 then
                player:changeContainerSize(tpz.inv.MOGLOCKER, 10)
                player:tradeComplete()
                player:startEvent(602, 0, 0, 0, 60)
            elseif slotSize == 60 and numMythril == 0 and numGold == 5 then
                player:changeContainerSize(tpz.inv.MOGLOCKER, 10)
                player:tradeComplete()
                player:startEvent(602, 0, 0, 0, 70)
            elseif slotSize == 70 and numMythril == 0 and numGold == 10 then
                player:changeContainerSize(tpz.inv.MOGLOCKER, 10)
                player:tradeComplete()
                player:startEvent(602, 0, 0, 0, 80)
            end
        end
    end
end

function onTrigger(player, npc)
    -- TODO: Check if they are >= Mission 2
    -- if < mission 2 then
    --      player:startEvent(600)
    -- else
    if player:getCurrentMission(TOAU) >= tpz.mission.id.toau.PRESIDENT_SALAHEEM then
        local accessType = getMogLockerAccessType(player)
        local mogLockerExpiryTimestamp = getMogLockerExpiryTimestamp(player)

        if mogLockerExpiryTimestamp == nil then
            -- a nil timestamp means they haven't unlocked it yet. We're going to unlock it by merely talking to this NPC.
            --print("Unlocking mog locker for "..player:getName())
            mogLockerExpiryTimestamp = unlockMogLocker(player)
            accessType = setMogLockerAccessType(player, MOGLOCKER_ACCESS_TYPE_ALLAREAS)
        end
        player:startEvent(600, mogLockerExpiryTimestamp, accessType,
        MOGLOCKER_ALZAHBI_VALID_DAYS, player:getContainerSize(tpz.inv.MOGLOCKER),
        getNumberOfCoinsToUpgradeSize(player:getContainerSize(tpz.inv.MOGLOCKER)), 2, 3,
        MOGLOCKER_ALLAREAS_VALID_DAYS)
    else
        player:startEvent(600)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- printf("fCSID: %u", csid)
    -- printf("fRESULT: %u", option)
    if csid == 600 and option == 3 then
        local accessType = player:getCharVar(MOGLOCKER_PLAYERVAR_ACCESS_TYPE)
        if accessType == MOGLOCKER_ACCESS_TYPE_ALLAREAS then
            -- they want to restrict their access to alzahbi only
            setMogLockerAccessType(player, MOGLOCKER_ACCESS_TYPE_ALZAHBI)
        elseif accessType == MOGLOCKER_ACCESS_TYPE_ALZAHBI then
            -- they want to expand their access to all areas.
            setMogLockerAccessType(player, MOGLOCKER_ACCESS_TYPE_ALLAREAS)
        else
            print("Unknown mog locker access type: "..accessType)
        end
    end
end
