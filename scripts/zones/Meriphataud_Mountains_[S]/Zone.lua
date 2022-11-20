-----------------------------------
-- Zone: Meriphataud_Mountains_[S] (97)
-----------------------------------
local ID = require('scripts/zones/Meriphataud_Mountains_[S]/IDs')
require('scripts/globals/chocobo')
require('scripts/globals/status')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.chocobo.initZone(zone)
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-454.135, 28.409, 657.79, 49)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameHour = function(zone)
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

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
