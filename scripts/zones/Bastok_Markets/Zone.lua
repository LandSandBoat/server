-----------------------------------
-- Zone: Bastok_Markets (235)
-----------------------------------
require('scripts/globals/events/harvest_festivals')
require('scripts/globals/cutscenes')
require('scripts/globals/settings')
require('scripts/globals/zone')
local ID = require('scripts/zones/Bastok_Markets/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    applyHalloweenNpcCostumes(zone:getID())
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = { -1 }

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if xi.settings.main.NEW_CHARACTER_CUTSCENE == 1 then
            cs = { 0, -1, xi.cutscenes.params.NO_OTHER_ENTITY } -- (cs, textTable, Flags)
        end

        player:setPos(-280, -12, -91, 15)
        player:setHomePoint()
    end

    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.random(1, 5) - 33
        player:setPos(-177, -8, position, 127)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone,  updatetype)
    xi.conq.onConquestUpdate(zone,  updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameDay = function()
    -- Removes daily the bit mask that tracks the treats traded for Harvest Festival.
    if isHalloweenEnabled() ~= 0 then
        clearVarFromAll("harvestFestTreats")
        clearVarFromAll("harvestFestTreats2")
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 0 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    end
end

return zoneObject
