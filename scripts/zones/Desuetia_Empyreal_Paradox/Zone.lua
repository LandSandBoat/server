-----------------------------------
--
-- Zone: Desuetia Empyreal Paradox (290)
--
-----------------------------------
local ID = require("scripts/zones/Desuetia_Empyreal_Paradox/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        -- player:setPos(x, y, z, rot)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
