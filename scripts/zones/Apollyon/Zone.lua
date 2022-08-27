-----------------------------------
-- Zone: Apollyon
-----------------------------------
local ID = require('scripts/zones/Apollyon/IDs')
require('scripts/globals/conquest')
require('scripts/globals/zone')
require('scripts/globals/status')
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    SetServerVariable("[Central_Apollyon]Time", 0)
    SetServerVariable("[CS_Apollyon]Time", 0)
    SetServerVariable("[NE_Apollyon]Time", 0)
    SetServerVariable("[NW_Apollyon]Time", 0)
    SetServerVariable("[SE_Apollyon]Time", 0)
    SetServerVariable("[SW_Apollyon]Time", 0)

    zone:registerRegion(1,  637, -4, -642,  642, 4, -637) -- APOLLYON_SE_NE exit
    zone:registerRegion(2, -642, -4, -642, -637, 4, -637) -- APOLLYON_NW_SW exit

    zone:registerRegion(20, 396, -4, -522, 403, 4, -516) -- appolyon SE telporter floor 1 to floor 2
    zone:registerRegion(21, 116, -4, -443, 123, 4, -436) -- appolyon SE telporter floor 2 to floor 3
    zone:registerRegion(22, 276, -4, -283, 283, 4, -276) -- appolyon SE telporter floor 3 to floor 4

    zone:registerRegion(24, 396, -4,  76, 403, 4,  83) -- appolyon NE telporter floor 1 to floor 2
    zone:registerRegion(25, 276, -4, 356, 283, 4, 363) -- appolyon NE telporter floor 2 to floor 3
    zone:registerRegion(26, 236, -4, 517, 243, 4, 523) -- appolyon NE telporter floor 3 to floor 4
    zone:registerRegion(27, 517, -4, 637, 523, 4, 643) -- appolyon NE telporter floor 4 to floor 5

    zone:registerRegion(29, -403, -4, -523, -396, 4, -516) -- appolyon SW telporter floor 1 to floor 2
    zone:registerRegion(30, -123, -4, -443, -116, 4, -436) -- appolyon SW telporter floor 2 to floor 3
    zone:registerRegion(31, -283, -4, -283, -276, 4, -276) -- appolyon SW telporter floor 3 to floor 4

    zone:registerRegion(33, -403, -4,  76, -396, 4,  83) -- appolyon NW telporter floor 1 to floor 2
    zone:registerRegion(34, -283, -4, 356, -276, 4, 363) -- appolyon NW telporter floor 2 to floor 3
    zone:registerRegion(35, -243, -4, 516, -236, 4, 523) -- appolyon NW telporter floor 3 to floor 4
    zone:registerRegion(36, -523, -4, 636, -516, 4, 643) -- appolyon NW telporter floor 4 to floor 5
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
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

zone_object.onRegionEnter = function(player,region)
    local regionID = region:GetRegionID()

    switch (regionID): caseof
    {
        -- Apollyon: SE_NE exit
        [1] = function ()
            player:startEvent(100)
        end,

        -- Apollyon: NW_SW exit
        [2] = function ()
            player:startEvent(101)
        end,

        -- Apollyon: SE Teleporters
        [20] = function()
            if GetNPCByID(ID.npc.APOLLYON_SE_PORTAL[1]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(219)
            end
        end,

        [21] = function()
            if GetNPCByID(ID.npc.APOLLYON_SE_PORTAL[2]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(218)
            end
        end,

        [22] = function()
            if GetNPCByID(ID.npc.APOLLYON_SE_PORTAL[3]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(216)
            end
        end,

        -- Apollyon: NE Teleporters
        [24] = function()
            if GetNPCByID(ID.npc.APOLLYON_NE_PORTAL[1]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(214)
            end
        end,

        [25] = function()
            if GetNPCByID(ID.npc.APOLLYON_NE_PORTAL[2]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(212)
            end
        end,

        [26] = function()
            if GetNPCByID(ID.npc.APOLLYON_NE_PORTAL[3]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(210)
            end
        end,

        [27] = function()
            if GetNPCByID(ID.npc.APOLLYON_NE_PORTAL[4]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(215)
            end
        end,

        -- Apollyon: SW Teleporters
        [29] = function()
            if GetNPCByID(ID.npc.APOLLYON_SW_PORTAL[1]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(208)
            end
        end,

        [30] = function()
            if GetNPCByID(ID.npc.APOLLYON_SW_PORTAL[2]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(209)
            end
        end,

        [31] = function()
            if GetNPCByID(ID.npc.APOLLYON_SW_PORTAL[3]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(207)
            end
        end,

        -- Apollyon: NW Teleporters
        [33] = function()
            if GetNPCByID(ID.npc.APOLLYON_NW_PORTAL[1]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(205)
            end
        end,

        [34] = function()
            if GetNPCByID(ID.npc.APOLLYON_NW_PORTAL[2]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(203)
            end
        end,

        [35] = function()
            if GetNPCByID(ID.npc.APOLLYON_NW_PORTAL[3]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(201)
            end
        end,

        [36] = function()
            if GetNPCByID(ID.npc.APOLLYON_NW_PORTAL[4]):getAnimation() == xi.animation.OPEN_DOOR then
                player:startOptionalCutscene(200)
            end
        end,

    }
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player,csid,option)
end

zone_object.onEventFinish = function(player,csid,option)
    if csid == 100 and option == 1 then
        player:setPos(557, -1, 441, 128, 33) -- Apollyon: SE_NE exit
    elseif csid == 101 and option == 1 then
        player:setPos(-561, 0, 443, 242, 33) -- Apollyon: NW_SW exit
    end

    if
        (csid == 32001 or csid == 32002) and
        player:getCharVar("ApollyonEntrance") == 1
    then
        player:setPos(638.099, 0.000, -610.997) -- East
        player:setCharVar("ApollyonEntrance", 0)
    elseif
        (csid == 32001 or csid == 32002) and
        player:getCharVar("ApollyonEntrance") == 0
    then
        player:setPos(-646.000, 0.000, -616.000) -- West
    end
end

return zone_object
