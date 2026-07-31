-----------------------------------
-- Zone: Bostaunieux_Oubliette (167)
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    local doorCount = 25 -- _mn0 to _mns
    local trapRadius = 1.5
    for i = 1, doorCount do
        local door = GetNPCByID(ID.npc.TRAP_DOOR_OFFSET + i - 1)
        if door ~= nil then
            zone:registerCylindricalTriggerArea(i, door:getXPos(), door:getZPos(), trapRadius)
        end
    end
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(99.978, -25.647, 72.867, 61)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local doorCount = 25
    local triggerAreaID = triggerArea:getTriggerAreaID()
    if triggerAreaID >= 1 and triggerAreaID <= doorCount then
        local door = GetNPCByID(ID.npc.TRAP_DOOR_OFFSET + triggerAreaID - 1)
        if door ~= nil then
            door:timer(800, function(doorArg)
                doorArg:openDoor(6) -- opens for 6s, then auto-closes
            end)
        end
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
