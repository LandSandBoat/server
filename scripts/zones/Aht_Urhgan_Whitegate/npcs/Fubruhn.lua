-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Fubruhn
-- Mog Locker NPC
-----------------------------------
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
-----------------------------------
-- 601 = Lease increased
-- 1st arg = number of seconds from 2001/12/31 15:00:00 it is valid till.
-----------------------------------
-- 602 = Expansion increased
-- 4th arg = new size of locker
-----------------------------------
---@type TNpcEntity
local entity = {}

local function getNumberOfCoinsToUpgradeSize(size)
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

entity.onTrade = function(player, npc, trade)
    local numBronze = trade:getItemQty(xi.item.IMPERIAL_BRONZE_PIECE)
    local numMythril = trade:getItemQty(xi.item.IMPERIAL_MYTHRIL_PIECE)
    local numGold = trade:getItemQty(xi.item.IMPERIAL_GOLD_PIECE)
    if player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.PRESIDENT_SALAHEEM then
        if numBronze > 0 and numMythril == 0 and numGold == 0 then
            if xi.moghouse.addMogLockerExpiryTime(player, numBronze) then
                -- remove bronze
                player:tradeComplete()
                -- send event
                player:startEvent(601, xi.moghouse.getMogLockerExpiryTimestamp(player))
            end
        elseif numGold > 0 or numMythril > 0 then
            -- see if we can expand the size
            local slotSize = player:getContainerSize(xi.inv.MOGLOCKER)
            if slotSize == 30 and numMythril == 4 and numGold == 0 then
                player:changeContainerSize(xi.inv.MOGLOCKER, 10)
                player:tradeComplete()
                player:startEvent(602, 0, 0, 0, 40)
            elseif slotSize == 40 and numMythril == 0 and numGold == 2 then
                player:changeContainerSize(xi.inv.MOGLOCKER, 10)
                player:tradeComplete()
                player:startEvent(602, 0, 0, 0, 50)
            elseif slotSize == 50 and numMythril == 0 and numGold == 3 then
                player:changeContainerSize(xi.inv.MOGLOCKER, 10)
                player:tradeComplete()
                player:startEvent(602, 0, 0, 0, 60)
            elseif slotSize == 60 and numMythril == 0 and numGold == 5 then
                player:changeContainerSize(xi.inv.MOGLOCKER, 10)
                player:tradeComplete()
                player:startEvent(602, 0, 0, 0, 70)
            elseif slotSize == 70 and numMythril == 0 and numGold == 10 then
                player:changeContainerSize(xi.inv.MOGLOCKER, 10)
                player:tradeComplete()
                player:startEvent(602, 0, 0, 0, 80)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.PRESIDENT_SALAHEEM then
        local accessType = xi.moghouse.getMogLockerAccessType(player)
        local mogLockerExpiryTimestamp = xi.moghouse.getMogLockerExpiryTimestamp(player)

        if mogLockerExpiryTimestamp == nil then
            -- a nil timestamp means they haven't unlocked it yet. We're going to unlock it by merely talking to this NPC.
            mogLockerExpiryTimestamp = xi.moghouse.unlockMogLocker(player)
            accessType = xi.moghouse.setMogLockerAccessType(player, xi.moghouse.lockerAccessType.ALLAREAS)
        end

        player:startEvent(600, mogLockerExpiryTimestamp, accessType, xi.moghouse.MOGLOCKER_ALZAHBI_VALID_DAYS, player:getContainerSize(xi.inv.MOGLOCKER),
            getNumberOfCoinsToUpgradeSize(player:getContainerSize(xi.inv.MOGLOCKER)), 2, 3, xi.moghouse.MOGLOCKER_ALLAREAS_VALID_DAYS)
    else
        player:startEvent(600)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 600 and option == 3 then
        local accessType = player:getCharVar(xi.moghouse.MOGLOCKER_PLAYERVAR_ACCESS_TYPE)
        if accessType == xi.moghouse.lockerAccessType.ALLAREAS then
            -- they want to restrict their access to alzahbi only
            xi.moghouse.setMogLockerAccessType(player, xi.moghouse.lockerAccessType.ALZAHBI)
        elseif accessType == xi.moghouse.lockerAccessType.ALZAHBI then
            -- they want to expand their access to all areas.
            xi.moghouse.setMogLockerAccessType(player, xi.moghouse.lockerAccessType.ALLAREAS)
        else
            print('Unknown mog locker access type: '..accessType)
        end
    end
end

return entity
