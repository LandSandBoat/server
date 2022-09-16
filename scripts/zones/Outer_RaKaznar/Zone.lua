-----------------------------------
-- Zone: Outer Ra’Kanzar (274)
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
-----------------------------------
local ID = require('scripts/zones/Outer_RaKaznar/IDs')
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, -942, -191.6, -22, -937, -191.4, -18)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-40, -180, -20, 128)
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function()
            if not player:hasKeyItem(xi.ki.SILVERY_PLATE) then
                player:startEvent(50)
            end
        end,
    }
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 50 then
        npcUtil.giveKeyItem(player, xi.ki.SILVERY_PLATE)
    end
end

return zone_object
