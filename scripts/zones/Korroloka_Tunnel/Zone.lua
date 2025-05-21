-----------------------------------
-- Zone: Korroloka Tunnel (173)
-----------------------------------
local ID = zones[xi.zone.KORROLOKA_TUNNEL]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Waterfalls (ID, X, Radius, Z)
    zone:registerCylindricalTriggerArea(1, -87, -105, 4) -- Left pool
    zone:registerCylindricalTriggerArea(2, -101, -114, 7) -- Center Pool
    zone:registerCylindricalTriggerArea(3, -112, -103, 3) -- Right Pool

    xi.helm.initZone(zone, xi.helmType.EXCAVATION)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(459, -39, 162, 172)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    if player:getCharVar('BathedInScent') == 1 then  -- pollen scent from touching all 3 Blue Rafflesias in Yuhtunga
        switch (triggerArea:getTriggerAreaID()): caseof
        {
            [1] = function()  -- Left Pool
                player:messageSpecial(ID.text.ENTERED_SPRING)
                player:setLocalVar('POOL_TIME', os.time())
            end,

            [2] = function()  -- Center Pool
                player:messageSpecial(ID.text.ENTERED_SPRING)
                player:setLocalVar('POOL_TIME', os.time())
            end,

            [3] = function()  -- Right pool
                player:messageSpecial(ID.text.ENTERED_SPRING)
                player:setLocalVar('POOL_TIME', os.time())
            end,
        }
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()
    local pooltime = os.time() - player:getLocalVar('POOL_TIME')

    if triggerAreaID <= 3 and player:getCharVar('BathedInScent') == 1 then
        if pooltime >= 300 then
            player:messageSpecial(ID.text.LEFT_SPRING_CLEAN)
            player:setLocalVar('POOL_TIME', 0)
            player:setCharVar('BathedInScent', 0)
        else
            player:messageSpecial(ID.text.LEFT_SPRING_EARLY)
            player:setLocalVar('POOL_TIME', 0)
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
