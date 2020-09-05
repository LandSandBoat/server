-----------------------------------
--
-- Zone: Throne_Room (165)
--
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(114.308, -7.639, 0.022, 126)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 7) then
        -- You will be transported back to the entrance of Castle Zvahl Baileys
        player:setPos(378.222, -12, -20.299, 125, 161)
    end
end
