-----------------------------------
-- Zone: Apollyon
-----------------------------------
local ID = zones[xi.zone.APOLLYON]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    SetServerVariable('[CENTRAL_APOLLYON]Time', 0)
    SetServerVariable('[CS_Apollyon]Time', 0)
    SetServerVariable('[NE_Apollyon]Time', 0)
    SetServerVariable('[NW_Apollyon]Time', 0)
    SetServerVariable('[SE_APOLLYON]Time', 0)
    SetServerVariable('[SW_APOLLYON]Time', 0)

    zone:registerCuboidTriggerArea(1,  637, -4, -642,  642, 4, -637) -- SE Apollyon NE exit
    zone:registerCuboidTriggerArea(2, -642, -4, -642, -637, 4, -637) -- APOLLYON_NW_SW exit

    zone:registerCuboidTriggerArea(20, 396, -4, -522, 403, 4, -516) -- Apollyon SE telporter floor 1 to floor 2
    zone:registerCuboidTriggerArea(21, 116, -4, -443, 123, 4, -436) -- Apollyon SE telporter floor 2 to floor 3
    zone:registerCuboidTriggerArea(22, 276, -4, -283, 283, 4, -276) -- Apollyon SE telporter floor 3 to floor 4

    zone:registerCuboidTriggerArea(24, 396, -4,  76, 403, 4,  83) -- Apollyon NE telporter floor 1 to floor 2
    zone:registerCuboidTriggerArea(25, 276, -4, 356, 283, 4, 363) -- Apollyon NE telporter floor 2 to floor 3
    zone:registerCuboidTriggerArea(26, 236, -4, 517, 243, 4, 523) -- Apollyon NE telporter floor 3 to floor 4
    zone:registerCuboidTriggerArea(27, 517, -4, 637, 523, 4, 643) -- Apollyon NE telporter floor 4 to floor 5

    zone:registerCuboidTriggerArea(29, -403, -4, -523, -396, 4, -516) -- Apollyon SW telporter floor 1 to floor 2
    zone:registerCuboidTriggerArea(30, -123, -4, -443, -116, 4, -436) -- Apollyon SW telporter floor 2 to floor 3
    zone:registerCuboidTriggerArea(31, -283, -4, -283, -276, 4, -276) -- Apollyon SW telporter floor 3 to floor 4

    zone:registerCuboidTriggerArea(33, -403, -4,  76, -396, 4,  83) -- Apollyon NW telporter floor 1 to floor 2
    zone:registerCuboidTriggerArea(34, -283, -4, 356, -276, 4, 363) -- Apollyon NW telporter floor 2 to floor 3
    zone:registerCuboidTriggerArea(35, -243, -4, 516, -236, 4, 523) -- Apollyon NW telporter floor 3 to floor 4
    zone:registerCuboidTriggerArea(36, -523, -4, 636, -516, 4, 643) -- Apollyon NW telporter floor 4 to floor 5
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
        player:setPos(643, 0.1, -600)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()

    switch (triggerAreaID): caseof
    {
        -- Apollyon: SE_NE exit
        [1] = function()
            player:startEvent(100)
        end,

        -- Apollyon: NW_SW exit
        [2] = function()
            player:startEvent(101)
        end,

        -- Apollyon: SE Teleporters
        [20] = function()
            if GetNPCByID(ID.SE_APOLLYON.npc.PORTAL[1]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(219)
            end
        end,

        [21] = function()
            if GetNPCByID(ID.SE_APOLLYON.npc.PORTAL[2]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(218)
            end
        end,

        [22] = function()
            if GetNPCByID(ID.SE_APOLLYON.npc.PORTAL[3]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(216)
            end
        end,

        -- Apollyon: NE Teleporters
        [24] = function()
            if GetNPCByID(ID.NE_APOLLYON.npc.PORTAL[1]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(214)
            end
        end,

        [25] = function()
            if GetNPCByID(ID.NE_APOLLYON.npc.PORTAL[2]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(212)
            end
        end,

        [26] = function()
            if GetNPCByID(ID.NE_APOLLYON.npc.PORTAL[3]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(210)
            end
        end,

        [27] = function()
            if GetNPCByID(ID.NE_APOLLYON.npc.PORTAL[4]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(215)
            end
        end,

        -- Apollyon: SW Teleporters
        [29] = function()
            if GetNPCByID(ID.SW_APOLLYON.npc.PORTAL[1]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(208)
            end
        end,

        [30] = function()
            if GetNPCByID(ID.SW_APOLLYON.npc.PORTAL[2]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(209)
            end
        end,

        [31] = function()
            if GetNPCByID(ID.SW_APOLLYON.npc.PORTAL[3]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(207)
            end
        end,

        -- Apollyon: NW Teleporters
        [33] = function()
            if GetNPCByID(ID.NW_APOLLYON.npc.PORTAL[1]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(205)
            end
        end,

        [34] = function()
            if GetNPCByID(ID.NW_APOLLYON.npc.PORTAL[2]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(203)
            end
        end,

        [35] = function()
            if GetNPCByID(ID.NW_APOLLYON.npc.PORTAL[3]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(201)
            end
        end,

        [36] = function()
            if GetNPCByID(ID.NW_APOLLYON.npc.PORTAL[4]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(200)
            end
        end,

    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 100 and option == 1 then
        player:setPos(557, -1, 441, 128, 33) -- Apollyon: SE_NE exit
    elseif csid == 101 and option == 1 then
        player:setPos(-561, 0, 443, 242, 33) -- Apollyon: NW_SW exit
    end
end

return zoneObject
