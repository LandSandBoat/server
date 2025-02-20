-----------------------------------
-- Zone: The_Garden_of_RuHmet (35)
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
local gardenGlobal = require('scripts/zones/The_Garden_of_RuHmet/globals')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1,  -421, -2,  377, -417, 0,  381) -- RDC
    zone:registerCuboidTriggerArea(2,  -422, -2, -422, -418, 0, -418) -- +1
    zone:registerCuboidTriggerArea(3,   418, -2,  378,  422, 0,  382) -- +2

    zone:registerCuboidTriggerArea(4,  -506, -4,  697, -500, 4,  703) -- Hume niv 0  150   vers niv 1
    zone:registerCuboidTriggerArea(5,  -507, -4, -103, -501, 4,  -97) -- Hume niv 1  158   vers niv 0
    zone:registerCuboidTriggerArea(6,  -339, -4, -103, -332, 4,  -97) -- Hume niv 1  159   vers niv 2
    zone:registerCuboidTriggerArea(7,   501, -4,  697,  507, 4,  702) -- Hume niv 2  169   vers niv 1
    zone:registerCuboidTriggerArea(8,   332, -4,  696,  339, 4,  702) -- Hume niv 2  168   vers niv 3
    zone:registerCuboidTriggerArea(9,   332, -4, -102,  338, 4,  -97) -- Hume niv 3  178   vers niv 2

    zone:registerCuboidTriggerArea(10, -102, -4,  541,  -96, 4,  546) -- Elvaan: niv 0 151 vers niv 1
    zone:registerCuboidTriggerArea(11, -103, -4, -259,  -96, 4, -252) -- Elvaan: niv 1 160 vers niv 0
    zone:registerCuboidTriggerArea(12, -103, -4, -427,  -67, 4, -420) -- Elvaan: niv 1 161 vers niv 2
    zone:registerCuboidTriggerArea(13,  736, -4,  372,  742, 4,  379) -- Elvaan: niv 2 171 vers niv 1
    zone:registerCuboidTriggerArea(14,  736, -4,  540,  743, 4,  546) -- Elvaan: niv 2 170 vers niv 3
    zone:registerCuboidTriggerArea(15,  737, -4, -259,  743, 4, -252) -- Elvaan: niv 3 179 vers niv 2

    zone:registerCuboidTriggerArea(16, -178, -4,   97, -173, 4,  103) -- Galka:  niv 0 152 vers niv 1
    zone:registerCuboidTriggerArea(17, -178, -4, -703, -173, 4, -697) -- Galka:  niv 1 162 vers niv 0
    zone:registerCuboidTriggerArea(18, -347, -4, -703, -340, 4, -696) -- Galka:  niv 1 163 vers niv 2
    zone:registerCuboidTriggerArea(19,  492, -4,   96,  499, 4,  103) -- Galka:  niv 2 173 vers niv 1
    zone:registerCuboidTriggerArea(20,  660, -4,   96,  667, 4,  102) -- Galka:  niv 2 172 vers niv 3
    zone:registerCuboidTriggerArea(21,  660, -4, -702,  667, 4, -697) -- Galka:  niv 3 180 vers niv 2

    zone:registerCuboidTriggerArea(22, -498, -4,   97, -492, 4,  102) -- Taru:   niv 0 153 vers niv 1
    zone:registerCuboidTriggerArea(23, -499, -4, -703, -492, 4, -697) -- Taru:   niv 1 164 vers niv 0
    zone:registerCuboidTriggerArea(24, -667, -4, -703, -661, 4, -696) -- Taru:   niv 1 165 vers niv 2
    zone:registerCuboidTriggerArea(25,  172, -4,   96,  178, 4,  102) -- Taru:   niv 2 175 vers niv 1
    zone:registerCuboidTriggerArea(26,  340, -4,   97,  347, 4,  102) -- Taru:   niv 2 174 vers niv 3
    zone:registerCuboidTriggerArea(27,  340, -4, -703,  347, 4, -697) -- Taru:   niv 3 181 vers niv 2

    zone:registerCuboidTriggerArea(28, -742, -4,  373, -736, 4,  379) -- Mithra: niv 0 154 vers niv 1
    zone:registerCuboidTriggerArea(29, -743, -4, -427, -736, 4, -421) -- Mithra: niv 1 166 vers niv 0
    zone:registerCuboidTriggerArea(30, -742, -4, -259, -737, 4, -252) -- Mithra: niv 1 167 vers niv 2
    zone:registerCuboidTriggerArea(31,   97, -4,  541,  102, 4,  547) -- Mithra: niv 2 177 vers niv 1
    zone:registerCuboidTriggerArea(32,   97, -4,  372,  102, 4,  379) -- Mithra: niv 2 176 vers niv 3
    zone:registerCuboidTriggerArea(33,   97, -4, -427,  102, 4, -421) -- Mithra: niv 3 182 vers niv 2

    -- Give the Fortitude ??? a random spawn
    local qmFort = GetNPCByID(ID.npc.QM_JAILER_OF_FORTITUDE)
    if qmFort then
        qmFort:setPos(unpack(gardenGlobal.qmPosFortTable[math.random(1, 5)]))
    end

    -- Give the Ix'Aern DRK ??? a random spawn
    local qmDrk    = GetNPCByID(ID.npc.QM_IXAERN_DRK)
    local qmDrkPos = math.random(1, 4)

    if qmDrk then
        qmDrk:setLocalVar('position', qmDrkPos)
        qmDrk:setPos(unpack(gardenGlobal.qmPosDRKTable[qmDrkPos]))
        qmDrk:setLocalVar('hatedPlayer', 0)
    end

    -- Give the Faith ??? a random spawn
    local qmFaith = GetNPCByID(ID.npc.QM_JAILER_OF_FAITH)
    if qmFaith then
        qmFaith:setPos(unpack(gardenGlobal.qmPosFaithTable[math.random(1, 5)]))
    end

    -- Give Ix'DRG a random placeholder by picking one of the four groups at random, then adding a random number of 0-2 for the specific mob.
    local groups = ID.mob.AWAERN_DRG_GROUPS
    SetServerVariable('[SEA]IxAernDRG_PH', groups[math.random(1, #groups)] + math.random(0, 2))
end

zoneObject.afterZoneIn = function(player)
    player:entityVisualPacket('door')
    player:entityVisualPacket('lst1')
    player:entityVisualPacket('lst2')
    player:entityVisualPacket('lst3')
    player:entityVisualPacket('lop1')
    player:entityVisualPacket('lop2')
    player:entityVisualPacket('lop3')
    player:entityVisualPacket('lpmy')
    player:entityVisualPacket('clop')
    player:entityVisualPacket('slp1')
    player:entityVisualPacket('slp2')
    player:entityVisualPacket('slp3')
end

zoneObject.onGameHour = function(zone)
    local vanadielHour = VanadielHour()
    local qmDrk        = GetNPCByID(ID.npc.QM_IXAERN_DRK) -- Ix'aern drk

    -- Jailer of Faith spawn randomiser
    local qmFaith = GetNPCByID(ID.npc.QM_JAILER_OF_FAITH) -- Jailer of Faith
    if
        qmFaith and
        vanadielHour % math.random(6, 12) == 0
    then
        qmFaith:hideNPC(60) -- Hide it for 60 seconds
        qmFaith:setPos(unpack(gardenGlobal.qmPosFaithTable[math.random(1, 5)])) -- Set the new position
    end

    -- Ix'DRK spawn randomiser
    if
        qmDrk and
        vanadielHour % 12 == 0 and
        qmDrk:getStatus() ~= xi.status.DISAPPEAR
    then
        -- Change ??? position every 12 hours Vana'diel time (30 mins)
        local qmDrkPos = math.random(1, 4)

        qmDrk:hideNPC(30)
        qmDrk:setLocalVar('position', qmDrkPos)
        qmDrk:setPos(unpack(gardenGlobal.qmPosDRKTable[qmDrkPos]))
    end
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
        player:setPos(-351.136, -2.25, -380, 253)
    end

    return cs
end

local teleportEventsByArea =
{
    [ 3] = 103,
    [ 4] = 150, -- Hume Floor 0 to Floor 1
    [ 5] = 158, -- Hume Floor 1 to Floor 0
    [ 6] = 159, -- Hume Floor 1 to Floor 2
    [ 7] = 169, -- Hume Floor 2 to Floor 1
    [ 8] = 168, -- Hume Floor 2 to Floor 3
    [ 9] = 178, -- Hume Floor 3 to Floor 2
    [10] = 151, -- Elvaan Floor 0 to Floor 1
    [11] = 160, -- Elvaan Floor 1 to Floor 0
    [12] = 161, -- Elvaan Floor 1 to Floor 2
    [13] = 171, -- Elvaan Floor 2 to Floor 1
    [14] = 170, -- Elvaan Floor 2 to Floor 3
    [15] = 179, -- Elvaan Floor 3 to Floor 2
    [16] = 152, -- Galka Floor 0 to Floor 1
    [17] = 162, -- Galka Floor 1 to Floor 0
    [18] = 163, -- Galka Floor 1 to Floor 2
    [19] = 173, -- Galka Floor 2 to Floor 1
    [20] = 172, -- Galka Floor 2 to Floor 3
    [21] = 180, -- Galka Floor 3 to Floor 2
    [22] = 153, -- Taru Floor 0 to Floor 1
    [23] = 164, -- Taru Floor 1 to Floor 0
    [24] = 165, -- Taru Floor 1 to Floor 2
    [25] = 175, -- Taru Floor 2 to Floor 1
    [26] = 174, -- Taru Floor 2 to Floor 3
    [27] = 181, -- Taru Floor 3 to Floor 2
    [28] = 154, -- Mithra Floor 0 to Floor 1
    [29] = 166, -- Mithra Floor 1 to Floor 0
    [30] = 167, -- Mithra Floor 1 to Floor 2
    [31] = 177, -- Mithra Floor 2 to Floor 1
    [32] = 176, -- Mithra Floor 2 to Floor 3
    [33] = 182, -- Mithra Floor 3 to Floor 2
}

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    if player:getLocalVar('TeleportAntiTrigger') == 0 and player:getAnimation() == 0 then
        local areaId = triggerArea:getTriggerAreaID()

        if areaId == 1 then
            if
                areaId == 1 and
                (player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN or
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN) or
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE))
            then
                player:startEvent(101)
            else
                player:startEvent(155)
            end
        elseif areaId == 2 then
            if
                player:hasKeyItem(xi.ki.BRAND_OF_DAWN) and
                player:hasKeyItem(xi.ki.BRAND_OF_TWILIGHT)
            then
                player:startEvent(156)
            else
                player:startEvent(183)
            end
        elseif teleportEventsByArea[areaId] then
            player:startOptionalCutscene(teleportEventsByArea[areaId])
        end
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if
        csid == 101 or
        csid == 102 or
        csid == 103 or
        (csid > 149 and csid < 184)
    then
        player:setLocalVar('TeleportAntiTrigger', 1)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 101 and option == 1 then
        player:setPos(540, -1, -499.900, 62, 36)
    end

    player:setLocalVar('TeleportAntiTrigger', 0)
end

return zoneObject
