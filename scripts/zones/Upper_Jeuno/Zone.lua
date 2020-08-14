-----------------------------------
--
-- Zone: Upper_Jeuno (244)
--
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/chocobo")
-----------------------------------

function onInitialize(zone)
    tpz.chocobo.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))
    -- Retail start/end dates vary, I am going with Dec 5th through Jan 5th.
    if (month == 12 and day >= 5) or (month == 1 and day <= 5) then
        player:ChangeMusic(0, 239)
        player:ChangeMusic(1, 239)
        -- No need for an 'else' to change it back outside these dates as a re-zone will handle that.
    end

    -- COP mission 1-1
    if player:getCurrentMission(COP) == tpz.mission.id.cop.THE_RITES_OF_LIFE and player:getCharVar("PromathiaStatus") == 0 then
        cs = 2
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(46.2, -5, -78, 172)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 2 then
        player:setCharVar("PromathiaStatus", 1)
    end
end
