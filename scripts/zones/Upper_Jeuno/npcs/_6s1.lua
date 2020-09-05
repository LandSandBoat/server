-----------------------------------
-- Area: Upper Jeuno
--  NPC: Marble Bridge Eatery (Door)
-- !pos -96.6 -0.2 92.3 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/missions")
require("scripts/globals/settings")
-----------------------------------

local ring =
{
    15543, -- Rajas Ring
    15544, -- Sattva Ring
    15545  -- Tamas Ring
}

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local status = player:getCharVar("PromathiaStatus")
    local mission = player:getCurrentMission(COP)

    if (mission == tpz.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG and status == 1) then
        player:startEvent(10011)
    elseif (mission == tpz.mission.id.cop.FLAMES_IN_THE_DARKNESS and status == 3) then
        player:startEvent(10012)
    elseif (mission == tpz.mission.id.cop.DAWN and status == 4) then
        player:startEvent(129)
    elseif ((mission == tpz.mission.id.cop.DAWN and status > 4) or player:hasCompletedMission(COP, tpz.mission.id.cop.DAWN)) then
        local hasRing = false

        for key, value in pairs(ring) do
            if (player:hasItem(value)) then
                hasRing = true
            end
        end

        if not (hasRing) then
            local currentDay = tonumber(os.date("%j"))
            local ringsTaken = player:getCharVar("COP-ringsTakenbr")
            local dateObtained = player:getCharVar("COP-lastRingday")

            if (ringsTaken == 0) then
                player:startEvent(84, ring[1], ring[2], ring[3])
            elseif (ringsTaken == 1) then -- First time you throw away, no wait
                player:startEvent(204, ring[1], ring[2], ring[3])
            elseif (ringsTaken > 1 and (currentDay - dateObtained) >= 28) then -- Wait time is >= 28 days, not 26
                player:startEvent(204, ring[1], ring[2], ring[3])
            end
        end
    end
end

function onEventUpdate(player, csid, option)
    if ((csid == 84 or csid == 204) and option == 4) then
        player:updateEvent(ring[1], ring[2], ring[3])
    end
end

function onEventFinish(player, csid, option)
    if (csid == 10011) then
        player:setCharVar("PromathiaStatus", 2)
    elseif (csid == 10012) then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, tpz.mission.id.cop.FLAMES_IN_THE_DARKNESS)
        player:addMission(COP, tpz.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN)
    elseif (csid == 129) then
        player:setCharVar("PromathiaStatus", 5)
    elseif ((csid == 84 or csid == 204) and option >= 5 and option <= 7) then
        if (player:getFreeSlotsCount() ~= 0) then
            local currentDay = tonumber(os.date("%j"))
            local ringsTaken = player:getCharVar("COP-ringsTakenbr")
            player:addItem(ring[option - 4])
            player:messageSpecial(ID.text.ITEM_OBTAINED, ring[option - 4])
            player:setCharVar("COP-ringsTakenbr", ringsTaken + 1)
            player:setCharVar("COP-lastRingday", currentDay)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, ring[option - 4])
        end
    end
end
