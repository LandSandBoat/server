-----------------------------------
--
-- Zone: Meriphataud_Mountains_[S] (97)
--
-----------------------------------
local ID = require("scripts/zones/Meriphataud_Mountains_[S]/IDs")
require("scripts/globals/chocobo")
require("scripts/globals/status")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.chocobo.initZone(zone)
    xi.voidwalker.zoneOnInit(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-454.135, 28.409, 657.79, 49)
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onGameHour = function(zone)
    local npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS)
    local hour = VanadielHour()

    if npc then
        if hour == 17 then
            npc:setStatus(xi.status.DISAPPEAR)
        elseif hour == 7 then
            npc:setStatus(xi.status.NORMAL)
        end
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
