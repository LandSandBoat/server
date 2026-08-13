-----------------------------------
-- Zone: Sauromugue_Champaign_[S] (98)
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN_S]
-----------------------------------
---@type TZone
local zoneObject = {}

local rampartTable =
{
    [1] = ID.npc.RAMPART_GATE_OFFSET,
    [2] = ID.npc.RAMPART_GATE_OFFSET + 1,
    [3] = ID.npc.RAMPART_GATE_OFFSET + 2,
}

zoneObject.onInitialize = function(zone)
    zone:registerCylindricalTriggerArea(1, -358.799, 334.000, 15)
    zone:registerCylindricalTriggerArea(2,   39.999, 180.000, 15)
    zone:registerCylindricalTriggerArea(3,  -48.696, -48.697, 15)

    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-104, -25.36, -410, 195)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    if not player:hasStatusEffect(xi.effect.MOUNTED) then
        return
    end

    local gate = GetNPCByID(rampartTable[triggerArea:getTriggerAreaID()])
    if gate then
        gate:openDoor(9)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
