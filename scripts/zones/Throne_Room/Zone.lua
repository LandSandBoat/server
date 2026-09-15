-----------------------------------
-- Zone: Throne_Room (165)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(114.308, -7.639, 0.022, 126)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 7 then
        -- You will be transported back to the entrance of Castle Zvahl Baileys
        player:setPos(379.877, -12, -20.141, 127, xi.zone.CASTLE_ZVAHL_BAILEYS)
    end
end

return zoneObject
