-----------------------------------
-- Zone: The_Shrine_of_RuAvitau (178)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Map 1
    zone:registerCuboidTriggerArea(1, -21, 29, -61, -16, 31, -57)       --> F (H-10)
    zone:registerCuboidTriggerArea(2, 16, 29, 57, 21, 31, 61)           --> E (H-7)

    -- Map 3
    zone:registerCuboidTriggerArea(3, -89, -19, 83, -83, -15, 89)       --> L (F-5)
    zone:registerCuboidTriggerArea(4, -143, -19, -22, -137, -15, -16)   --> L (D-8)
    zone:registerCuboidTriggerArea(5, -143, -19, 55, -137, -15, 62)     --> G (D-6)
    zone:registerCuboidTriggerArea(6, 83, -19, -89, 89, -15, -83)       --> G (J-10)
    zone:registerCuboidTriggerArea(7, -89, -19, -89, -83, -15, -83)     --> J (F-10)
    zone:registerCuboidTriggerArea(8, 137, -19, -22, 143, -15, -16)     --> H (L-8)
    zone:registerCuboidTriggerArea(9, 136, -19, 56, 142, -15, 62)       --> I (L-6)
    zone:registerCuboidTriggerArea(10, 83, -19, 83, 89, -15, 89)        --> K (J-5)

    -- Map 4
    zone:registerCuboidTriggerArea(11, 723, 96, 723, 729, 100, 729)     --> L (F-5)
    zone:registerCuboidTriggerArea(12, 870, 96, 723, 876, 100, 729)     --> O (J-5)
    zone:registerCuboidTriggerArea(13, 870, 96, 470, 876, 100, 476)     --> H (J-11)
    zone:registerCuboidTriggerArea(14, 723, 96, 470, 729, 100, 476)     --> N (F-11)

    -- Map 5
    zone:registerCuboidTriggerArea(15, 817, -3, 57, 823, 1, 63)         --> D (I-7)
    zone:registerCuboidTriggerArea(16, 736, -3, 16, 742, 1, 22)         --> P (F-8)
    zone:registerCuboidTriggerArea(17, 857, -3, -23, 863, 1, -17)       --> M (J-9)
    zone:registerCuboidTriggerArea(18, 776, -3, -63, 782, 1, -57)       --> C (G-10)

    -- Map 6
    zone:registerCuboidTriggerArea(19, 777, -103, -503, 783, -99, -497) --> E (G-6)
    zone:registerCuboidTriggerArea(20, 816, -103, -503, 822, -99, -497) --> F (I-6)
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
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

local teleportEventsByArea =
{
    [ 1] = 17, -- To F
    [ 2] = 16, -- To E
    [ 3] =  5, -- To L (Kirin)
    [ 4] =  5, -- To L (Kirin)
    [ 5] =  4, -- To G
    [ 6] =  4, -- To G
    [ 7] =  1, -- To J
    [ 8] =  3, -- To H
    [ 9] =  7, -- To I
    [10] =  6, -- To K
    [11] = 10, -- To L'
    [12] = 11, -- To O
    [13] =  3, -- To H
    [14] =  8, -- To N
    [15] = 15, -- To D
    [16] = 14, -- To P
    [17] = 13, -- To M
    [18] = 12, -- To C
    [19] = 16, -- To E
    [20] = 17, -- To F
}

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local areaId = triggerArea:getTriggerAreaID()

    if teleportEventsByArea[areaId] then
        player:startOptionalCutscene(teleportEventsByArea[areaId], { cs_option = 0, canSkip = true })
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
