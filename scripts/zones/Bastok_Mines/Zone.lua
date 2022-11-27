-----------------------------------
-- Zone: Bastok_Mines (234)
-----------------------------------
local ID = require('scripts/zones/Bastok_Mines/IDs')
require('scripts/globals/events/harvest_festivals')
require('scripts/globals/conquest')
require('scripts/globals/cutscenes')
require('scripts/globals/settings')
require('scripts/globals/chocobo')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    SetExplorerMoogles(ID.npc.EXPLORER_MOOGLE)

    applyHalloweenNpcCostumes(zone:getID())
    xi.chocobo.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = { -1 }

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if xi.settings.main.NEW_CHARACTER_CUTSCENE == 1 then
            cs = { 1, -1, xi.cutscenes.params.NO_OTHER_ENTITY } -- (cs, textTable, Flags)
        end

        player:setPos(-45, -0, 26, 213)
        player:setHomePoint()
    end

    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.random(1, 5) - 75
        player:setPos(116, 0.99, position, 127)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 1 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536) -- adventurer coupon
    end
end

return zoneObject
