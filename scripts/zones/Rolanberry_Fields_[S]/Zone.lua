-----------------------------------
-- Zone: Rolanberry_Fields_[S] (91)
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS_S]
-----------------------------------
---@type TZone
local zoneObject = {}

local rampartTable =
{
    [1] = ID.npc.RAMPART_GATE_OFFSET,
    [2] = ID.npc.RAMPART_GATE_OFFSET + 4,
    [3] = ID.npc.RAMPART_GATE_OFFSET + 5,
    [4] = ID.npc.RAMPART_GATE_OFFSET + 6,
    [5] = ID.npc.RAMPART_GATE_OFFSET + 7,
}

zoneObject.onInitialize = function(zone)
    zone:registerCylindricalTriggerArea(1, 188.943, 435.986, 15)
    zone:registerCylindricalTriggerArea(2, -43.426, 335.406, 15)
    zone:registerCylindricalTriggerArea(3,   1.749, 240.000, 15)
    zone:registerCylindricalTriggerArea(4, 226.946, 287.264, 15)
    zone:registerCylindricalTriggerArea(5, 460.000, -80.000, 15)

    xi.voidwalker.zoneOnInit(zone)
    xi.darkixion.zoneOnInit(zone)
end

zoneObject.onGameHour = function(zone)
    xi.darkixion.zoneOnGameHour(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-376.179, -30.387, -776.159, 220)
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

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
