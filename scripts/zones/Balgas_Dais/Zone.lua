-----------------------------------
--
-- Zone: Balgas_Dais (146)
--
-----------------------------------
local ID = require("scripts/zones/Balgas_Dais/IDs")
require("scripts/globals/settings")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(317.842, -126.158, 380.143, 127)
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
    -- print("Player: ", player)
    -- print("RESULT: ", regionID)
end

function onEventUpdate(player, csid, option)
    -- print("zone CSID: ", csid)
    -- print("zone RESULT: ", option)
end

function onEventFinish(player, csid, option)
end
