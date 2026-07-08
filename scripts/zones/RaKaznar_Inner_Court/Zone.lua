-----------------------------------
-- Zone: Ra'Kaznar Inner Court (276)
-- Map 1: https://www.bg-wiki.com/images/b/b2/Updated_marked_map_ra%27kaznar_inner_court_map_1.jpeg
-- Map 2: https://www.bg-wiki.com/images/d/d7/Updated_marked_map_ra%27kaznar_inner_court_map_2.jpeg
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- "Floor" Type teleporters.
    zone:registerSphericalTriggerArea(1,  -180, -481.196,  260, 5) -- Telepad: A (Map 1), event 10
    zone:registerSphericalTriggerArea(2,  1060,   98.875,  260, 5) -- Telepad: A (Map 2), event 11
    zone:registerSphericalTriggerArea(3,  -340, -431.196,  300, 5) -- Telepad: B (Map 1), event 12
    zone:registerSphericalTriggerArea(4,   900,  118.875,  300, 5) -- Telepad: B (Map 2), event 13
    zone:registerSphericalTriggerArea(5,  -900, -511.196,  300, 5) -- Telepad: C (Map 1), event 14
    zone:registerSphericalTriggerArea(6,   340,   78.875,  300, 5) -- Telepad: C (Map 2), event 15
    zone:registerSphericalTriggerArea(7,  -740, -481.196, -260, 5) -- Telepad: G (Map 1), event 16
    zone:registerSphericalTriggerArea(8,   500,   78.875, -260, 5) -- Telepad: G (Map 2), event 17
    zone:registerSphericalTriggerArea(9,  -220, -501.196, -260, 5) -- Telepad: H (Map 1), event 18
    zone:registerSphericalTriggerArea(10, 1020,   78.875, -260, 5) -- Telepad: H (Map 2), event 19
    zone:registerSphericalTriggerArea(11, -300, -471.196,  -60, 5) -- Telepad: J (Map 1), event 20
    zone:registerSphericalTriggerArea(12,  940,   78.875,  -60, 5) -- Telepad: J (Map 2), event 21

    -- "Door" Type teleporters.
    zone:registerCuboidTriggerArea(13, -913.5, -430.5,   96.00, -911.5, -430.0,  104.00) -- Teleportal: D (Map 1), event 22
    zone:registerCuboidTriggerArea(14,  351.5,   89.5,   96.00,  353.5,   90.5,  104.00) -- Teleportal: D (Map 2), event 23
    zone:registerCuboidTriggerArea(15, -944.0, -460.5, -153.60, -936.0, -460.0, -151.60) -- Teleportal: E (Map 1), event 24
    zone:registerCuboidTriggerArea(16,  296.0,   79.5, -124.20,  304.0,   80.5, -126.20) -- Teleportal: E (Map 2), event 25
    zone:registerCuboidTriggerArea(17, -823.5, -450.5, -273.50, -816.0, -450.0, -271.50) -- Teleportal: F (Map 1), event 26
    zone:registerCuboidTriggerArea(18,  416.0,   79.5, -248.25,  424.0,   80.5, -246.25) -- Teleportal: F (Map 2), event 27
    zone:registerCuboidTriggerArea(19, -288.0, -440.5, -144.00, -286.0, -440.0, -136.00) -- Teleportal: I (Map 1), event 28
    zone:registerCuboidTriggerArea(20,  926.2,   89.5, -144.00,  928.2,   90.5, -136.00) -- Teleportal: I (Map 2), event 29

    -- Setup reives.
    xi.reives.setupZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-476, -520.5, 20, 0)
    end

    return cs
end

local regionEventTable =
{
    [ 1] = 10,
    [ 2] = 11,
    [ 3] = 12,
    [ 4] = 13,
    [ 5] = 14,
    [ 6] = 15,
    [ 7] = 16,
    [ 8] = 17,
    [ 9] = 18,
    [10] = 19,
    [11] = 20,
    [12] = 21,
    [13] = 22,
    [14] = 23,
    [15] = 24,
    [16] = 25,
    [17] = 26,
    [18] = 27,
    [19] = 28,
    [20] = 29,
}

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local regionId = triggerArea:getTriggerAreaID()
    local eventId  = regionEventTable[regionId]

    if eventId then
        player:startCutscene(eventId) -- Wipes enmity.
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
