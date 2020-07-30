-----------------------------------
--
-- Zone: Metalworks (237)
--
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-9.168, 0, 0.001, 128)
    end
    return cs
end

function afterZoneIn(player)
    if player:hasKeyItem(tpz.ki.MESSAGE_TO_JEUNO_BASTOK) then
        player:ChangeMusic(0, 161)   --  Despair
        player:ChangeMusic(1, 161)   --  Despair
    end
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
