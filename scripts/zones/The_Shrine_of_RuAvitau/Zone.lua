-----------------------------------
-- Zone: The_Shrine_of_RuAvitau (178)
-----------------------------------
local ID = require('scripts/zones/The_Shrine_of_RuAvitau/IDs')
require('scripts/globals/conquest')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- MAP 1
    zone:registerTriggerArea(1, -21, 29, -61, -16, 31, -57)      --> F (H-10)
    zone:registerTriggerArea(2, 16, 29, 57, 21, 31, 61)          --> E (H-7)

    -- MAP 3
    zone:registerTriggerArea(3, -89, -19, 83, -83, -15, 89)      --> L (F-5)
    zone:registerTriggerArea(3, -143, -19, -22, -137, -15, -16)  --> L (D-8)
    zone:registerTriggerArea(4, -143, -19, 55, -137, -15, 62)    --> G (D-6)
    zone:registerTriggerArea(4, 83, -19, -89, 89, -15, -83)      --> G (J-10)
    zone:registerTriggerArea(5, -89, -19, -89, -83, -15, -83)    --> J (F-10)
    zone:registerTriggerArea(6, 137, -19, -22, 143, -15, -16)    --> H (L-8)
    zone:registerTriggerArea(7, 136, -19, 56, 142, -15, 62)      --> I (L-6)
    zone:registerTriggerArea(8, 83, -19, 83, 89, -15, 89)        --> K (J-5)

    -- MAP 4
    zone:registerTriggerArea(9, 723, 96, 723, 729, 100, 729)     --> L'(F-5)
    zone:registerTriggerArea(10, 870, 96, 723, 876, 100, 729)    --> O (J-5)
    zone:registerTriggerArea(6, 870, 96, 470, 876, 100, 476)     --> H (J-11)
    zone:registerTriggerArea(11, 723, 96, 470, 729, 100, 476)    --> N (F-11)

    -- MAP 5
    zone:registerTriggerArea(12, 817, -3, 57, 823, 1, 63)        --> D (I-7)
    zone:registerTriggerArea(13, 736, -3, 16, 742, 1, 22)        --> P (F-8)
    zone:registerTriggerArea(14, 857, -3, -23, 863, 1, -17)      --> M (J-9)
    zone:registerTriggerArea(15, 776, -3, -63, 782, 1, -57)      --> C (G-10)

    -- MAP 6
    zone:registerTriggerArea(2, 777, -103, -503, 783, -99, -497) --> E (G-6)
    zone:registerTriggerArea(1, 816, -103, -503, 822, -99, -497) --> F (I-6)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-3.38, 46.326, 60, 122)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

local teleportEventsByArea =
{
    [ 1] = 17, -- To F
    [ 2] = 16, -- To E
    [ 3] =  5, -- To L (Kirin)
    [ 4] =  4, -- To G
    [ 5] =  1, -- To J
    [ 6] =  3, -- To H
    [ 7] =  7, -- To I
    [ 8] =  6, -- To K
    [ 9] = 10, -- To L'
    [10] = 11,
    [11] =  8,
    [12] = 15, -- To D
    [13] = 14, -- To P
    [14] = 13, -- To M
    [15] = 12, -- To C
}

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local areaId = triggerArea:GetTriggerAreaID()

    if teleportEventsByArea[areaId] then
        player:startOptionalCutscene(teleportEventsByArea[areaId])
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
