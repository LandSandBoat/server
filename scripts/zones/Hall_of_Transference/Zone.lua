-----------------------------------
-- Zone: Hall_of_Transference
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -281, -5, 277, -276, 0, 284)      -- Holla
    zone:registerCuboidTriggerArea(2, 276, -84, -82, 283, -80, -75)     -- Mea
    zone:registerCuboidTriggerArea(3, -283, -45, -283, -276, -40, -276) -- Dem
    zone:registerCylindricalTriggerArea(4, 0, 0, 0)

    zone:registerCuboidTriggerArea(5, 288.847, -83.960, -40.693, 291.209, -79.960, -37.510)     -- Mea Sky Teleporter
    zone:registerCuboidTriggerArea(6, -240.181, -3.960, 268.409, -237.671, 1.960, 271.291)      -- Holla Sky Teleporter
    zone:registerCuboidTriggerArea(7, -240.797, -43.960, -291.552, -237.944, -39.960, -288.954) -- Dem Sky Teleporter
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(274, -82, -62 , 180)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:getTriggerAreaID()): caseof
    {
        [1] = function() -- Holla
            player:setCharVar('option', 1)
            player:startEvent(103)
        end,

        [2] = function() -- Mea
            player:setCharVar('option', 1)
            player:startEvent(104)
        end,

        [3] = function() -- Dem
            player:setCharVar('option', 1)
            player:startEvent(105)
        end,

        [4] = function()
            player:setCharVar('option', 2)
            player:startEvent(103)
        end,

        [5] = function()
            if player:getCharVar('MeaChipRegistration') == 1 then
                if
                    math.random(1, 100) <= 95 or
                    player:getCharVar('LastSkyWarpMea') < os.time()
                then
                    -- 5% Chance chip breaks
                    player:startEvent(161) -- To Sky
                else
                    player:startEvent(169) -- Chip Breaks!
                end
            else
                player:startEvent(162) -- Please Register..
            end
        end,

        [6] = function()
            if player:getCharVar('HollaChipRegistration') == 1 then
                if
                    math.random(1, 100) <= 95 or
                    player:getCharVar('LastSkyWarpHolla') < os.time()
                then
                    -- 5% Chance chip breaks
                    player:startEvent(161) -- To Sky
                else
                    player:startEvent(170) -- Chip Breaks!
                end
            else
                player:startEvent(162) -- Please Register..
            end
        end,

        [7] = function()
            if player:getCharVar('DemChipRegistration') == 1 then
                if
                    math.random(1, 100) <= 95 or
                    player:getCharVar('LastSkyWarpDem') < os.time()
                then
                    -- 5% Chance chip breaks
                    player:startEvent(161) -- To Sky
                else
                    player:startEvent(171) -- Chip Breaks!
                end
            else
                player:startEvent(162) -- Please Register..
            end
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 103 and option == 1 then
        player:setPos(340.082, 19.103, -59.979, 127, 102)     -- To La Theine Plateau (R)
    elseif csid == 104 and option == 1 then
        player:setPos(179.92, 35.15, 260.137, 64, 117)        -- To Tahrongi Canyon (R)
    elseif csid == 105 and option == 1 then
        player:setPos(139.974, 19.103, 219.989, 128, 108)     -- To Konschtat Highlands (R)
    elseif csid == 161 and option == 1 then
        local prevZone = player:getPreviousZone()

        if prevZone == xi.zone.LA_THEINE_PLATEAU then
            player:setCharVar('LastSkyWarpHolla', getMidnight())
        elseif prevZone == xi.zone.KONSCHTAT_HIGHLANDS then
            player:setCharVar('LastSkyWarpDem', getMidnight())
        elseif prevZone == xi.zone.TAHRONGI_CANYON then
            player:setCharVar('LastSkyWarpMea', getMidnight())
        end

        xi.teleport.to(player, xi.teleport.id.SKY)
    elseif csid == 169 and option == 1 then
        player:setCharVar('MeaChipRegistration', 0)
        xi.teleport.to(player, xi.teleport.id.SKY)
    elseif csid == 170 and option == 1 then
        player:setCharVar('HollaChipRegistration', 0)
        xi.teleport.to(player, xi.teleport.id.SKY)
    elseif csid == 171 and option == 1 then
        player:setCharVar('DemChipRegistration', 0)
        xi.teleport.to(player, xi.teleport.id.SKY)
    end
end

return zoneObject
