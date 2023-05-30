-----------------------------------
-- Zone: Norg (252)
-----------------------------------
local ID = require('scripts/zones/Norg/IDs')
require('scripts/globals/conquest')
require('scripts/globals/chocobo')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.chocobo.initZone(zone)
    zone:registerTriggerArea(1, -24, 0, -59, -15, 1, -50)  -- Near the SSG exit
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-19.238, -2.163, -63.964, 187)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:GetTriggerAreaID()): caseof
    {
        [1] = function()  -- An Undying Pledge cs trigger
            if player:getCharVar("anUndyingPledgeCS") == 1 then
                player:startEvent(226)
            end
        end,
    }
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 226 then
        player:setCharVar("anUndyingPledgeCS", 2)
    end
end

return zoneObject
