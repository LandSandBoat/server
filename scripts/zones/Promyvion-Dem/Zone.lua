-----------------------------------
-- Zone: Promyvion-Dem (18)
-----------------------------------
local ID = zones[xi.zone.PROMYVION_DEM]
-----------------------------------
local zoneObject = {}

local function handleTeleport(player, npcId, eventId)
    if
        player:getAnimation() == xi.anim.NONE and
        GetNPCByID(npcId):getAnimation() == xi.anim.OPEN_DOOR
    then
        player:startOptionalCutscene(eventId)
    end
end

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1,   160, 3,  -80, 0, 0, 0) -- Floor 1 return
    zone:registerTriggerArea(2,  -280, 3,    0, 0, 0, 0) -- Floor 2 return
    zone:registerTriggerArea(3,  -160, 3,  440, 0, 0, 0) -- Floor 3 (North) return
    zone:registerTriggerArea(4,     0, 3, -320, 0, 0, 0) -- Floor 3 (South) return
    zone:registerTriggerArea(5,   360, 3,  240, 0, 0, 0) -- Floor 4 return
    zone:registerTriggerArea(6,   120, 3, -280, 0, 0, 0) -- Floor 1 MR
    zone:registerTriggerArea(7,   -80, 3,  -80, 0, 0, 0) -- Floor 2 MR SE - Destination: North
    zone:registerTriggerArea(8,   -80, 3,   80, 0, 0, 0) -- Floor 2 MR NE - Destination: South
    zone:registerTriggerArea(9,  -280, 3, -200, 0, 0, 0) -- Floor 2 MR SW - Destination: South
    zone:registerTriggerArea(10, -360, 3,   40, 0, 0, 0) -- floor 2 MR NW - Destination: North
    zone:registerTriggerArea(11,   40, 3, -200, 0, 0, 0) -- Floor 3 (South) MR NE
    zone:registerTriggerArea(12, -120, 3, -240, 0, 0, 0) -- Floor 3 (South) MR NW
    zone:registerTriggerArea(13, -120, 3, -400, 0, 0, 0) -- Floor 3 (South) MR SW
    zone:registerTriggerArea(14, -320, 3,  160, 0, 0, 0) -- Floor 3 (North) MR SW
    zone:registerTriggerArea(15,  -40, 3,  320, 0, 0, 0) -- Floor 3 (North) MR NE
    zone:registerTriggerArea(16, -120, 3,  160, 0, 0, 0) -- Floor 3 (North) MR SE

--    UpdateNMSpawnPoint(ID.mob.SATIATOR)
--    GetMobByID(ID.mob.SATIATOR):setRespawnTime(math.random(3600, 21600))
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(185.891, 0, -52.331, 128)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:GetTriggerAreaID()

    switch (triggerAreaID) : caseof {
        [1] = function()
            player:startOptionalCutscene(46)
        end,

        [2] = function()
            player:startOptionalCutscene(41)
        end,

        [3] = function()
            player:startOptionalCutscene(43)
        end,

        [4] = function()
            player:startOptionalCutscene(42)
        end,

        [5] = function()
            -- Event 44 -> Return to floor 3 South
            -- Event 45 -> Return to floor 3 North
            player:startOptionalCutscene(44 + player:getCharVar('[Dem]ReturnNorth'))
        end,

        [6] = function()
            handleTeleport(player, ID.npc.MEMORY_STREAM_OFFSET, 30)
        end,

        [7] = function()
            player:setCharVar('[Dem]ReturnNorth', 1)
            handleTeleport(player, ID.npc.MEMORY_STREAM_OFFSET + 4, 36)
        end,

        [8] = function()
            player:setCharVar('[Dem]ReturnNorth', 0)
            handleTeleport(player, ID.npc.MEMORY_STREAM_OFFSET + 5, 37)
        end,

        [9] = function()
            player:setCharVar('[Dem]ReturnNorth', 0)
            handleTeleport(player, ID.npc.MEMORY_STREAM_OFFSET + 6, 34)
        end,

        [10] = function()
            player:setCharVar('[Dem]ReturnNorth', 1)
            handleTeleport(player, ID.npc.MEMORY_STREAM_OFFSET + 7, 35)
        end,

        [11] = function()
            handleTeleport(player, ID.npc.MEMORY_STREAM_OFFSET + 1, 31)
        end,

        [12] = function()
            handleTeleport(player, ID.npc.MEMORY_STREAM_OFFSET + 2, 32)
        end,

        [13] = function()
            handleTeleport(player, ID.npc.MEMORY_STREAM_OFFSET + 3, 33)
        end,

        [14] = function()
            handleTeleport(player, ID.npc.MEMORY_STREAM_OFFSET + 8, 38)
        end,

        [15] = function()
            handleTeleport(player, ID.npc.MEMORY_STREAM_OFFSET + 9, 39)
        end,

        [16] = function()
            handleTeleport(player, ID.npc.MEMORY_STREAM_OFFSET + 10, 40)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 46 and option == 1 then
        player:setCharVar('[Dem]ReturnNorth', 0)
        player:setPos(-226.193, -46.459, -280.046, 127, 14) -- To Hall of Transference (R)
    end
end

return zoneObject
