-----------------------------------
--
-- Zone: Heavens_Tower
--
-----------------------------------
local ID = require("scripts/zones/Heavens_Tower/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1, -1, -1, -35, 1, 1, -33)
    zone:registerRegion(2, 6, -46, -30, 8, -44, -28)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(0, 0, 22, 192)
    end

    if player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.JOURNEY_TO_WINDURST and player:getCharVar("MissionStatus") == 3 then
        cs = 42
    elseif player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_EMISSARY_WINDURST and player:getCharVar("MissionStatus") == 2 then
        cs = 42
    elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.DOLL_OF_THE_DEAD and player:getCharVar("MissionStatus") == 1 then
        cs = 335
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
    switch (region:GetRegionID()): caseof
    {
        ---------------------------------
        [1] = function (x)  -- Heaven's Tower exit portal
            player:startEvent(41)
        end,
        ---------------------------------
        [2] = function (x)  -- Warp directly back to the first floor.
            player:startEvent(83)
        end,
        ---------------------------------
    }
end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 41 then
        player:setPos(0, -17, 135, 60, 239)
    elseif csid == 335 then
        player:setCharVar("MissionStatus", 2)
    elseif csid == 42 then
        -- This cs should only play if you visit Windurst first.
        if player:getNation() == tpz.nation.SANDORIA then
            player:setCharVar("MissionStatus", 4)
        else
            player:setCharVar("MissionStatus", 3)
        end
    end
end
