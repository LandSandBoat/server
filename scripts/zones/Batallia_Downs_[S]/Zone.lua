-----------------------------------
-- Zone: Batallia_Downs_[S] (84)
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS_S]
-----------------------------------
---@type TZone
local zoneObject = {}

local rampartTable =
{
    [1] = ID.npc.RAMPART_GATE_OFFSET,
    [2] = ID.npc.RAMPART_GATE_OFFSET + 1,
    [3] = ID.npc.RAMPART_GATE_OFFSET + 2,
    [4] = ID.npc.RAMPART_GATE_OFFSET + 3,
    [5] = ID.npc.RAMPART_GATE_OFFSET + 4,
}

zoneObject.onInitialize = function(zone)
    zone:registerCylindricalTriggerArea(1, 321.762, -194.744, 15)
    zone:registerCylindricalTriggerArea(2, 327.975, -118.794, 15)
    zone:registerCylindricalTriggerArea(3, 156.000,  100.000, 15)
    zone:registerCylindricalTriggerArea(4,  -2.059,  225.000, 15)
    zone:registerCylindricalTriggerArea(5,   0.000, -170.000, 15)

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
        player:setPos(-500.451, -39.71, 504.894, 39)
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
