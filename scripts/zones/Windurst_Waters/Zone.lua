-----------------------------------
--
-- Zone: Windurst_Waters (238)
--
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    -- Check if we are on Windurst Mission 1-3
    zone:registerRegion(1, 23, -12, -208, 31, -8, -197)

    applyHalloweenNpcCostumes(zone:getID())
end

function onZoneIn(player, prevZone)
    local cs = -1

    if ENABLE_ROV == 1 and player:getCurrentMission(ROV) == tpz.mission.id.rov.RHAPSODIES_OF_VANADIEL and player:getMainLvl()>=3 then
        cs = 30035
    end

    if player:getCurrentMission(ROV) == tpz.mission.id.rov.FATES_CALL and player:getCurrentMission(player:getNation()) > 15 then
        cs = 30036
    end

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if NEW_CHARACTER_CUTSCENE == 1 then
            cs = 531
        end
        player:setPos(-40, -5, 80, 64)
        player:setHomePoint()
    elseif player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("MEMORIES_OF_A_MAIDEN_Status") == 1 then -- COP MEMORIES_OF_A_MAIDEN--3-3B: Windurst Route
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 2)
        cs = 871
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        local position = math.random(1, 5) + 157
        player:setPos(position, -5, -62, 192)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)

    switch (region:GetRegionID()): caseof
    {
        [1] = function (x)  -- Windurst Mission 1-3, final cutscene with Leepe-Hoppe
            -- If we're on Windurst Mission 1-3
            if player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_PRICE_OF_PEACE and player:getCharVar("MissionStatus") == 2 then
                player:startEvent(146)
            end
        end,
    }

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 531 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    elseif csid == 146 then -- Returned from Giddeus, Windurst 1-3
        player:setCharVar("MissionStatus", 3)
        player:setCharVar("ghoo_talk", 0)
        player:setCharVar("laa_talk", 0)
    elseif csid == 30035 then
        player:completeMission(ROV, tpz.mission.id.rov.RHAPSODIES_OF_VANADIEL)
        player:addMission(ROV, tpz.mission.id.rov.RESONACE)
    elseif csid == 30036 then
        player:completeMission(ROV, tpz.mission.id.rov.FATES_CALL)
        player:addMission(ROV, tpz.mission.id.rov.WHAT_LIES_BEYOND)
    end
end
