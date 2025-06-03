-----------------------------------
-- Zone: Eastern Adoulin (257)
-----------------------------------
---@type TZone
local zoneObject = {}

local defineZoneAroundXYZ = function(zone, id, x, y, z, distance)
    zone:registerCuboidTriggerArea(id,
        x - distance, y - distance, z - distance,
        x + distance, y + distance, z + distance)
end

zoneObject.onInitialize = function(zone)
    defineZoneAroundXYZ(zone, 1, 100.580, -40.150, -63.830, 7) -- Area around Ploh Trishbahk (castle gate)
    defineZoneAroundXYZ(zone, 2, -80.214,  -0.150,  30.717, 7) -- Area around Oscairn (Peacekeeper Coalition)
    defineZoneAroundXYZ(zone, 3, -94.478,  -0.650, -51.173, 4) -- Area around Wegellion (Scout's Coalition)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-155, 0, -19, 250)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
