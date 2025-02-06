-----------------------------------
-- Zone: RuAun_Gardens (130)
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
-----------------------------------
---@type TZone
local zoneObject = {}

local function handleClosingPortal(player, eventId, npcId)
    if GetNPCByID(npcId):getAnimation() == xi.anim.OPEN_DOOR then
        player:startOptionalCutscene(eventId)
    end
end

local function handleGreenPortal(player)
    if player:getCharVar('skyShortcut') == 1 then
        player:startEvent(42)
    else
        local title = player:getTitle()

        if title == xi.title.WARRIOR_OF_THE_CRYSTAL then
            player:startEvent(41, title)
        else
            player:startEvent(43, title)
        end
    end
end

zoneObject.onInitialize = function(zone)
    -- Blue portals (Regular)
    zone:registerCylindricalTriggerArea(1, 1.125, -581.300, 3) -- Entrance to Main Island
    zone:registerCylindricalTriggerArea(2, 149.875, -447.275, 3) -- Main Island to Entrance (East)
    zone:registerCylindricalTriggerArea(3, -149.875, -447.275, 3) -- Main Island to Entrance (West)

    -- Blue portals (Pincerstones)
    zone:registerCylindricalTriggerArea(4, 165.880, -350.782, 3) -- Main Island to SE Island
    zone:registerCylindricalTriggerArea(5, 267.662, -274.356, 3) -- SE Island to Main Island
    zone:registerCylindricalTriggerArea(6, 377.808, 64.638, 3) -- SE Island to NE Island
    zone:registerCylindricalTriggerArea(7, 343.641, 169.781, 3) -- NE Island to SE Island
    zone:registerCylindricalTriggerArea(8, 55.273, 379.291, 3) -- NE Island to NW Island
    zone:registerCylindricalTriggerArea(9, -55.280, 379.287, 3) -- NW Island to NE Island
    zone:registerCylindricalTriggerArea(10, -343.647, 169.776, 3) -- NW Island to SW Island
    zone:registerCylindricalTriggerArea(11, -377.806, 64.631, 3) -- SW Island to NW Island
    zone:registerCylindricalTriggerArea(12, -267.659, -274.364, 3) -- SW Island to Main Island
    zone:registerCylindricalTriggerArea(13, -165.880, -350.782, 3) -- Main Island to SW Island

    -- Red portals (To Laloff)
    zone:registerCuboidTriggerArea(14,  186, -43, -405,  190, -39, -401) -- Main Island to Laloff (SE / AA Galka)
    zone:registerCuboidTriggerArea(15,  306, -39, -317,  310, -35, -313) -- SE Island to Laloff (SE / AA Galka)
    zone:registerCuboidTriggerArea(16,  432, -39,   71,  436, -35,   75) -- SE Island to Laloff (NE / AA Elvaan)
    zone:registerCuboidTriggerArea(17,  393, -39,  193,  397, -35,  197) -- NE Island to Laloff (NE / AA Elvaan)
    zone:registerCuboidTriggerArea(18,   62, -39,  434,   66, -35,  438) -- NE Island to Laloff (North / AA Hume)
    zone:registerCuboidTriggerArea(19,  -65, -39,  434,  -61, -35,  438) -- NW Island to Laloff (North / AA Hume)
    zone:registerCuboidTriggerArea(20, -397, -39,  193, -393, -35,  197) -- NW Island to Laloff (NW / AA Mithra)
    zone:registerCuboidTriggerArea(21, -436, -39,   71, -432, -35,   75) -- SW Island to Laloff (NW / AA Mithra)
    zone:registerCuboidTriggerArea(22, -310, -39, -317, -306, -35, -313) -- SW Island to Laloff (NW / AA Taru)
    zone:registerCuboidTriggerArea(23, -191, -43, -405, -187, -39, -401) -- Main Island to Laloff (SW / AA Taru)

    -- Red portals (From Laloff)
    zone:registerCuboidTriggerArea(24,  272, -42, -379,  276, -38, -375) -- Laloff (SE / AA Galka)
    zone:registerCuboidTriggerArea(25,  441, -42,  142,  445, -38,  146) -- Laloff (NE / AA Elvaan)
    zone:registerCuboidTriggerArea(26,   -2, -42,  464,    2, -38,  468) -- Laloff (North / AA Hume)
    zone:registerCuboidTriggerArea(27, -445, -42,  142, -441, -38,  146) -- Laloff (NW / AA Mithra)
    zone:registerCuboidTriggerArea(28, -276, -42, -379, -272, -38, -375) -- Laloff (SW / AA Taru)

    -- Yellow portals (To Sky Gods)
    zone:registerCylindricalTriggerArea(29, 455.288, -147.932, 3) -- SE Island to Seiryu Island
    zone:registerCylindricalTriggerArea(30, 279.603, 384.841, 3) -- NE Island to Genbu Island
    zone:registerCylindricalTriggerArea(31, -281.383, 387.291, 3) -- NW Island to Byakko Island
    zone:registerCylindricalTriggerArea(32, -455.288, -147.932, 3) -- SW Island to Suzaku Island

    -- Yellow portals (From Sky Gods)
    zone:registerCuboidTriggerArea(33,  543, -73,  -19,  547, -69,  -15) -- Seiryu Island to SE Island
    zone:registerCuboidTriggerArea(34,  182, -73,  511,  186, -69,  515) -- Genbu Island to NE Island
    zone:registerCuboidTriggerArea(35, -432, -73,  332, -428, -69,  336) -- Byakko Island to NW Island
    zone:registerCuboidTriggerArea(36, -453, -73, -308, -449, -69, -304) -- Suzaku Island to SW Island

    -- Green portals
    zone:registerCuboidTriggerArea(37,  142, -41, -156,  145, -39, -153) -- Main Island (NE)
    zone:registerCuboidTriggerArea(38, -145, -41, -156, -142, -39, -153) -- Main Island (NW)

    xi.treasure.initZone(zone)
    xi.conquest.setRegionalConquestOverseers(zone:getRegionID())
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
        player:setPos(-1, -55, -637, 193)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()

    switch (triggerAreaID) : caseof {
        [1] = function()
            player:startOptionalCutscene(0)
        end,

        [2] = function()
            player:startOptionalCutscene(1)
        end,

        [3] = function()
            player:startOptionalCutscene(36)
        end,

        [4] = function()
            handleClosingPortal(player, 3, ID.npc.PORTAL_OFFSET)
        end,

        [5] = function()
            handleClosingPortal(player, 7, ID.npc.PORTAL_OFFSET + 1)
        end,

        [6] = function()
            handleClosingPortal(player, 10, ID.npc.PORTAL_OFFSET + 3)
        end,

        [7] = function()
            handleClosingPortal(player, 14, ID.npc.PORTAL_OFFSET + 4)
        end,

        [8] = function()
            handleClosingPortal(player, 17, ID.npc.PORTAL_OFFSET + 6)
        end,

        [9] = function()
            handleClosingPortal(player, 21, ID.npc.PORTAL_OFFSET + 7)
        end,

        [10] = function()
            handleClosingPortal(player, 24, ID.npc.PORTAL_OFFSET + 9)
        end,

        [11] = function()
            handleClosingPortal(player, 28, ID.npc.PORTAL_OFFSET + 10)
        end,

        [12] = function()
            handleClosingPortal(player, 31, ID.npc.PORTAL_OFFSET + 12)
        end,

        [13] = function()
            handleClosingPortal(player, 35, ID.npc.PORTAL_OFFSET + 13)
        end,

        [14] = function()
            player:startOptionalCutscene(2)
        end,

        [15] = function()
            player:startOptionalCutscene(6)
        end,

        [16] = function()
            player:startOptionalCutscene(9)
        end,

        [17] = function()
            player:startOptionalCutscene(13)
        end,

        [18] = function()
            player:startOptionalCutscene(16)
        end,

        [19] = function()
            player:startOptionalCutscene(20)
        end,

        [20] = function()
            player:startOptionalCutscene(23)
        end,

        [21] = function()
            player:startOptionalCutscene(27)
        end,

        [22] = function()
            player:startOptionalCutscene(30)
        end,

        [23] = function()
            player:startOptionalCutscene(34)
        end,

        [24] = function()
            player:startOptionalCutscene(4 + math.random(0, 1))
        end,

        [25] = function()
            player:startOptionalCutscene(11 + math.random(0, 1))
        end,

        [26] = function()
            player:startOptionalCutscene(18 + math.random(0, 1))
        end,

        [27] = function()
            player:startOptionalCutscene(25 + math.random(0, 1))
        end,

        [28] = function()
            player:startOptionalCutscene(32 + math.random(0, 1))
        end,

        [29] = function()
            handleClosingPortal(player, 8, ID.npc.PORTAL_OFFSET + 2)
        end,

        [30] = function()
            handleClosingPortal(player, 15, ID.npc.PORTAL_OFFSET + 5)
        end,

        [31] = function()
            handleClosingPortal(player, 22, ID.npc.PORTAL_OFFSET + 8)
        end,

        [32] = function()
            handleClosingPortal(player, 29, ID.npc.PORTAL_OFFSET + 11)
        end,

        [33] = function()
            player:startOptionalCutscene(37)
        end,

        [34] = function()
            player:startOptionalCutscene(38)
        end,

        [35] = function()
            player:startOptionalCutscene(39)
        end,

        [36] = function()
            player:startOptionalCutscene(40)
        end,

        [37] = function()
            handleGreenPortal(player)
        end,

        [38] = function()
            handleGreenPortal(player)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 41 and option ~= 0 then
        player:setCharVar('skyShortcut', 1)
    end
end

return zoneObject
