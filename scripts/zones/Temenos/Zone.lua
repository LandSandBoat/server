-----------------------------------
-- Zone: Temenos (37)
-----------------------------------
local ID = zones[xi.zone.TEMENOS]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    SetServerVariable('[TEMENOS_NORTHERN_TOWER]Time', 0)
    SetServerVariable('[TEMENOS_EASTERN_TOWER]Time', 0)
    SetServerVariable('[TEMENOS_WESTERN_TOWER]Time', 0)
    SetServerVariable('[CENTRAL_TEMENOS_4TH_FLOOR]Time', 0)
    SetServerVariable('[CENTRAL_TEMENOS_3RD_FLOOR]Time', 0)
    SetServerVariable('[CENTRAL_TEMENOS_2ND_FLOOR]Time', 0)
    SetServerVariable('[CENTRAL_TEMENOS_1ST_FLOOR]Time', 0)
    SetServerVariable('[CENTRAL_TEMENOS_BASEMENT]Time', 0)

    -- Temenos North Elevators
    zone:registerCylindricalTriggerArea(1, 340.000, 376.000, 5) -- F1 -> F2
    zone:registerCylindricalTriggerArea(2, 220.000, 376.000, 5) -- F2 -> F3
    zone:registerCylindricalTriggerArea(3, 20.000, 376.000, 5) -- F3 -> F4
    zone:registerCylindricalTriggerArea(4, -100.000, 376.000, 5) -- F4 -> F5
    zone:registerCylindricalTriggerArea(5, -300.000, 376.000, 5) -- F5 -> F6
    zone:registerCylindricalTriggerArea(6, -420.000, 376.000, 5) -- F6 -> F7
    zone:registerCylindricalTriggerArea(7, -620.000, 376.000, 5) -- F7 -> Entrance

    -- Temenos East Elevators
    zone:registerCylindricalTriggerArea(8, 340.000, 96.000, 5) -- F1 -> F2
    zone:registerCylindricalTriggerArea(9, 220.000, 96.000, 5) -- F2 -> F3
    zone:registerCylindricalTriggerArea(10, 20.000, 96.000, 5) -- F3 -> F4
    zone:registerCylindricalTriggerArea(11, -100.000, 96.000, 5) -- F4 -> F5
    zone:registerCylindricalTriggerArea(12, -300.000, 96.000, 5) -- F5 -> F6
    zone:registerCylindricalTriggerArea(13, -420.000, 96.000, 5) -- F6 -> F7
    zone:registerCylindricalTriggerArea(14, -620.000, 96.000, 5) -- F7 -> Entrance

    -- Temenos West Elevators
    zone:registerCylindricalTriggerArea(15, 340.000, -184.000, 5) -- F1 -> F2
    zone:registerCylindricalTriggerArea(16, 220.000, -184.000, 5) -- F2 -> F3
    zone:registerCylindricalTriggerArea(17, 20.000, -184.000, 5) -- F3 -> F4
    zone:registerCylindricalTriggerArea(18, -100.000, -184.000, 5) -- F4 -> F5
    zone:registerCylindricalTriggerArea(19, -300.000, -184.000, 5) -- F5 -> F6
    zone:registerCylindricalTriggerArea(20, -420.000, -184.000, 5) -- F6 -> F7
    zone:registerCylindricalTriggerArea(21, -620.000, -184.000, 5) -- F7 -> Entrance

    -- Temenos Central Elevators
    zone:registerCylindricalTriggerArea(22, 540.000, -544.000, 5) -- Basement -> Entrance
    zone:registerCylindricalTriggerArea(23, 300.000, -504.000, 5) -- F1 -> Entrance
    zone:registerCylindricalTriggerArea(24, -20.000, -544.000, 5) -- F2 -> Entrance
    zone:registerCylindricalTriggerArea(25, -264.000, -500.000, 5) -- F3 -> Entrance
    zone:registerCylindricalTriggerArea(26, -580.000, -584.000, 5) -- F4 -> Entrance
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
        player:setPos(580, -1.5, 4.452, 192)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()
    local cs

    if GetNPCByID(ID.TEMENOS_NORTHERN_TOWER.npc.PORTAL[1] + (triggerAreaID - 1)):getAnimation() == xi.animation.OPEN_DOOR then
        if triggerAreaID > 20 then
            cs = 120
        else
            cs = triggerAreaID + 99
        end

        player:startOptionalCutscene(cs)
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 32001 or csid == 32002 then
        player:messageSpecial(ID.text.HUM + 1)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
