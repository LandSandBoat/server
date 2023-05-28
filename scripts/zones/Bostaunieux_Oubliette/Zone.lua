-----------------------------------
-- Zone: Bostaunieux_Oubliette (167)
-----------------------------------
local ID = require('scripts/zones/Bostaunieux_Oubliette/IDs')
require('scripts/globals/conquest')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.DREXERION_THE_CONDEMNED)
    xi.mob.nmTODPersistCache(zone, ID.mob.PHANDURON_THE_CONDEMNED)
    xi.mob.nmTODPersistCache(zone, ID.mob.BLOODSUCKER)

    -- Trapdoor triggers
    zone:registerTriggerArea(1,  -66,  -2, -136, -64,  2, -134)
    zone:registerTriggerArea(2,  -68,  -2, -146, -66,  2, -144)
    zone:registerTriggerArea(3,  -56,  -2, -142, -54,  2, -140)
    zone:registerTriggerArea(4,  -18,  -2, -140, -20,  2, -138)
    zone:registerTriggerArea(5,   14,  -2, -140,  16,  2, -138)
    zone:registerTriggerArea(6,   22,  -2, -144,  24,  2, -142)
    zone:registerTriggerArea(7,  -22,  -2, -150, -20,  2, -148)
    zone:registerTriggerArea(8,  -22,  -2, -172, -20,  2, -170)
    zone:registerTriggerArea(9,  -20,  -2, -182, -18,  2, -180)
    zone:registerTriggerArea(10, -102, -2, -180, -99,  2, -178)
    zone:registerTriggerArea(11, -92,  -2, -182, -90,  2, -180)
    zone:registerTriggerArea(12, -142, -2, -220, -140, 2, -218)
    zone:registerTriggerArea(13, -140, -2, -230, -138, 2, -228)
    zone:registerTriggerArea(14, -22,  -2, -220, -20,  2, -218)
    zone:registerTriggerArea(15, -20,  -2, -230, -18,  2, -228)
    zone:registerTriggerArea(16,  18,  -2, -222,  20,  2, -220)
    zone:registerTriggerArea(17,  28,  -2, -220,  30,  2, -218)
    zone:registerTriggerArea(18,  50,  -2, -220,  52,  2, -218)
    zone:registerTriggerArea(19,  60,  -2, -222,  62,  2, -220)
    zone:registerTriggerArea(20, -20,  -2, -252, -18,  2, -250)
    zone:registerTriggerArea(21, -22,  -2, -262, -20,  2, -260)
    zone:registerTriggerArea(22, -182, -2, -260, -180, 2, -258)
    zone:registerTriggerArea(23, -173, -2, -262, -171, 2, -260)
    zone:registerTriggerArea(24, -150, -2, -260, -148, 2, -258)
    zone:registerTriggerArea(25, -140, -2, -262, -138, 2, -260)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(99.978, -25.647, 72.867, 61)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:GetTriggerAreaID()): caseof
    {
        [1] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[1]):openDoor(15)
        end,

        [2] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[2]):openDoor(15)
        end,

        [3] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[3]):openDoor(15)
        end,

        [4] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[4]):openDoor(15)
        end,

        [5] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[5]):openDoor(15)
        end,

        [6] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[6]):openDoor(15)
        end,

        [7] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[7]):openDoor(15)
        end,

        [8] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[8]):openDoor(15)
        end,

        [9] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[9]):openDoor(15)
        end,

        [10] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[10]):openDoor(15)
        end,

        [11] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[11]):openDoor(15)
        end,

        [12] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[12]):openDoor(15)
        end,

        [13] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[13]):openDoor(15)
        end,

        [14] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[14]):openDoor(15)
        end,

        [15] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[15]):openDoor(15)
        end,

        [16] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[16]):openDoor(15)
        end,

        [17] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[17]):openDoor(15)
        end,

        [18] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[18]):openDoor(15)
        end,

        [19] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[19]):openDoor(15)
        end,

        [20] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[20]):openDoor(15)
        end,

        [21] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[21]):openDoor(15)
        end,

        [22] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[22]):openDoor(15)
        end,

        [23] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[23]):openDoor(15)
        end,

        [24] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[24]):openDoor(15)
        end,

        [25] = function(x)
            GetNPCByID(ID.npc.TRAPDOOR[25]):openDoor(15)
        end,
    }
end

zoneObject.onEventFinish = function(player, csid, option)
end

zoneObject.onGameHour = function(zone)
    -- Don't allow Manes or Shii to spawn outside of night
    if VanadielHour() >= 6 and VanadielHour() < 18 then
        DisallowRespawn(ID.mob.MANES, true)
        DisallowRespawn(ID.mob.SHII, true)
    else
        DisallowRespawn(ID.mob.MANES, false)
        DisallowRespawn(ID.mob.SHII, false)
    end
end

return zoneObject
