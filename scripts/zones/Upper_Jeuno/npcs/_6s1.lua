-----------------------------------
-- Area: Upper Jeuno
--  NPC: Marble Bridge Eatery (Door)
-- !pos -96.6 -0.2 92.3 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

local ring =
{
    15543, -- Rajas Ring
    15544, -- Sattva Ring
    15545  -- Tamas Ring
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local status = player:getCharVar("PromathiaStatus")
    local mission = player:getCurrentMission(xi.mission.log_id.COP)

    if
        mission == xi.mission.id.cop.DAWN and
        status == 4
    then
        player:startEvent(129)

    elseif
        (mission == xi.mission.id.cop.DAWN and status > 4) or
        player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
    then
        local hasRing = false

        for key, value in pairs(ring) do
            if player:hasItem(value) then
                hasRing = true
            end
        end

        if not hasRing then
            local currentDay = tonumber(os.date("%j"))
            local ringsTaken = player:getCharVar("COP-ringsTakenbr")
            local dateObtained = player:getCharVar("COP-lastRingday")

            if ringsTaken == 0 then
                player:startEvent(84, ring[1], ring[2], ring[3])

            -- First time you throw away, no wait
            elseif ringsTaken == 1 then
                player:startEvent(204, ring[1], ring[2], ring[3])

            -- Wait time is >= 28 days, not 26
            elseif
                ringsTaken > 1 and
                (currentDay - dateObtained) >= 28
            then
                player:startEvent(204, ring[1], ring[2], ring[3])
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
    if
        (csid == 84 or csid == 204) and
        option == 4
    then
        player:updateEvent(ring[1], ring[2], ring[3])
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 129 then
        player:setCharVar("PromathiaStatus", 5)
    elseif
        (csid == 84 or csid == 204) and
        option >= 5 and
        option <= 7
    then
        if player:getFreeSlotsCount() ~= 0 then
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

return entity
