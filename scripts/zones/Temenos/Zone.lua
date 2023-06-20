-----------------------------------
-- Zone: Temenos (37)
-----------------------------------
local ID = require('scripts/zones/Temenos/IDs')
require("scripts/globals/teleports")
require('scripts/globals/conquest')
require('scripts/globals/settings')
require('scripts/globals/status')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    SetServerVariable("[TEMENOS_NORTHERN_TOWER]Time", 0)
    SetServerVariable("[TEMENOS_EASTERN_TOWER]Time", 0)
    SetServerVariable("[TEMENOS_WESTERN_TOWER]Time", 0)
    SetServerVariable("[CENTRAL_TEMENOS_4TH_FLOOR]Time", 0)
    SetServerVariable("[CENTRAL_TEMENOS_3RD_FLOOR]Time", 0)
    SetServerVariable("[CENTRAL_TEMENOS_2ND_FLOOR]Time", 0)
    SetServerVariable("[CENTRAL_TEMENOS_1ST_FLOOR]Time", 0)
    SetServerVariable("[CENTRAL_TEMENOS_BASEMENT]Time", 0)

    -- Temenos North Elevators
    zone:registerTriggerArea(1,   340.000, 5,  376.000, 0, 0, 0) -- F1 -> F2
    zone:registerTriggerArea(2,   220.000, 5,  376.000, 0, 0, 0) -- F2 -> F3
    zone:registerTriggerArea(3,    20.000, 5,  376.000, 0, 0, 0) -- F3 -> F4
    zone:registerTriggerArea(4,  -100.000, 5,  376.000, 0, 0, 0) -- F4 -> F5
    zone:registerTriggerArea(5,  -300.000, 5,  376.000, 0, 0, 0) -- F5 -> F6
    zone:registerTriggerArea(6,  -420.000, 5,  376.000, 0, 0, 0) -- F6 -> F7
    zone:registerTriggerArea(7,  -620.000, 5,  376.000, 0, 0, 0) -- F7 -> Entrance

    -- Temenos East Elevators
    zone:registerTriggerArea(8,   340.000, 5,   96.000, 0, 0, 0) -- F1 -> F2
    zone:registerTriggerArea(9,   220.000, 5,   96.000, 0, 0, 0) -- F2 -> F3
    zone:registerTriggerArea(10,   20.000, 5,   96.000, 0, 0, 0) -- F3 -> F4
    zone:registerTriggerArea(11, -100.000, 5,   96.000, 0, 0, 0) -- F4 -> F5
    zone:registerTriggerArea(12, -300.000, 5,   96.000, 0, 0, 0) -- F5 -> F6
    zone:registerTriggerArea(13, -420.000, 5,   96.000, 0, 0, 0) -- F6 -> F7
    zone:registerTriggerArea(14, -620.000, 5,   96.000, 0, 0, 0) -- F7 -> Entrance

    -- Temenos West Elevators
    zone:registerTriggerArea(15,  340.000, 5, -184.000, 0, 0, 0) -- F1 -> F2
    zone:registerTriggerArea(16,  220.000, 5, -184.000, 0, 0, 0) -- F2 -> F3
    zone:registerTriggerArea(17,   20.000, 5, -184.000, 0, 0, 0) -- F3 -> F4
    zone:registerTriggerArea(18, -100.000, 5, -184.000, 0, 0, 0) -- F4 -> F5
    zone:registerTriggerArea(19, -300.000, 5, -184.000, 0, 0, 0) -- F5 -> F6
    zone:registerTriggerArea(20, -420.000, 5, -184.000, 0, 0, 0) -- F6 -> F7
    zone:registerTriggerArea(21, -620.000, 5, -184.000, 0, 0, 0) -- F7 -> Entrance

    -- Temenos Central Elevators
    zone:registerTriggerArea(22,  540.000, 5, -544.000, 0, 0, 0) -- Basement -> Entrance
    zone:registerTriggerArea(23,  300.000, 5, -504.000, 0, 0, 0) -- F1 -> Entrance
    zone:registerTriggerArea(24,  -20.000, 5, -544.000, 0, 0, 0) -- F2 -> Entrance
    zone:registerTriggerArea(25, -264.000, 5, -500.000, 0, 0, 0) -- F3 -> Entrance
    zone:registerTriggerArea(26, -580.000, 5, -584.000, 0, 0, 0) -- F4 -> Entrance
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
        player:setPos(580, -1.5, 4.452, 192)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:GetTriggerAreaID()
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

zoneObject.onEventUpdate = function(player, csid, option)
    if csid == 32001 or csid == 32002 then
        player:messageSpecial(ID.text.HUM + 1)
    end
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid >= 100 and csid <= 120 then
        xi.teleport.clearEnmityList(player)
    end
end

return zoneObject
