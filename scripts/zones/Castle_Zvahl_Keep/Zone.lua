-----------------------------------
-- Zone: Castle_Zvahl_Keep (162)
-----------------------------------
local ID = require('scripts/zones/Castle_Zvahl_Keep/IDs')
require("scripts/globals/teleports")
require('scripts/globals/conquest')
require('scripts/globals/treasure')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- TODO: Change these trigger areas to radials.
    zone:registerTriggerArea(1, -301, -50, -22, -297, -49, -17) -- central porter on map 3
    zone:registerTriggerArea(2, -275, -54,   3, -271, -53,   7) -- NE porter on map 3
    zone:registerTriggerArea(3, -275, -54, -47, -271, -53, -42) -- SE porter on map 3
    zone:registerTriggerArea(4, -330, -54,   3, -326, -53,   7) -- NW porter on map 3
    zone:registerTriggerArea(5, -328, -54, -47, -324, -53, -42) -- SW porter on map 3
    zone:registerTriggerArea(6, -528, -74,  84, -526, -73,  89) -- N porter on map 4
    zone:registerTriggerArea(7, -528, -74,  30, -526, -73,  36) -- S porter on map 4

    xi.treasure.initZone(zone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-555.996, -71.691, 59.989, 254)
    end

    return cs
end

local teleportEventsByArea =
{
    [1] = 0, -- Teleports player to far NE corner
    [2] = 2, -- Teleports player to ??
    [3] = 1, -- Teleports player to far SE corner
    [4] = 1, -- Teleports player to far SE corner
    [5] = 5, -- Teleports player to H-7 on map 4 (south or north part, randomly)
    [6] = 6, -- Teleports player to position "A" on map 2
    [7] = 7, -- Teleports player to position G-8 on map 2
}

local teleportPortalByArea =
{
    [1] = 17441070, -- Center
    [2] = 17441073, -- NE
    [3] = 17441074, -- SE
    [4] = 17441071, -- NW
    [5] = 17441072, -- SW
    [6] = 17441076, -- N
    [7] = 17441077, -- S
}

zoneObject.onZoneTick = function(zone)
    if zone:getLocalVar("tele_timer") < os.time() then
        local randTele = math.random(1, #ID.npc.TELEPORTERS)

        -- Ensure the same portal isn't selected twice in a row
        while randTele == zone:getLocalVar("last_tele") do
            randTele = math.random(1, #ID.npc.TELEPORTERS)
        end

        zone:setLocalVar("last_tele", randTele)

        local tele = GetNPCByID(ID.npc.TELEPORTERS[randTele])

        tele:openDoor(10)
        tele:setLocalVar("isOpen", 1)
        tele:timer(10000, function(teleArg)
            teleArg:setLocalVar("isOpen", 0)
        end)

        zone:setLocalVar("tele_timer", os.time() + 5)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local areaId = triggerArea:GetTriggerAreaID()

    if
        GetNPCByID(teleportPortalByArea[areaId]):getLocalVar("isOpen") == 1 and
        teleportEventsByArea[areaId]
    then
        player:startCutscene(teleportEventsByArea[areaId])
        xi.teleport.clearEnmityList(player)
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
