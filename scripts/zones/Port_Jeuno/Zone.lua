-----------------------------------
--
-- Zone: Port_Jeuno (246)
--
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/chocobo")
require("scripts/globals/quests")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.chocobo.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))
    -- Retail start/end dates vary, I am going with Dec 5th through Jan 5th.
    if ((month == 12 and day >= 5) or (month == 1 and day <= 5)) then
        player:ChangeMusic(0, 239)
        player:ChangeMusic(1, 239)
        -- No need for an 'else' to change it back outside these dates as a re-zone will handle that.
    end

    if
        xi.settings.ENABLE_ABYSSEA == 1 and player:getMainLvl() >= 30
        and player:getQuestStatus(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_JOURNEY_BEGINS) == QUEST_AVAILABLE
    then
        cs = 324
    end

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        if (prevZone == xi.zone.SAN_DORIA_JEUNO_AIRSHIP) then
            cs = 10018
            player:setPos(-87.000, 12.000, 116.000, 128)
        elseif (prevZone == xi.zone.BASTOK_JEUNO_AIRSHIP) then
            cs = 10020
            player:setPos(-50.000, 12.000, -116.000, 0)
        elseif (prevZone == xi.zone.WINDURST_JEUNO_AIRSHIP) then
            cs = 10019
            player:setPos(16.000, 12.000, -117.000, 0)
        elseif (prevZone == xi.zone.KAZHAM_JEUNO_AIRSHIP) then
            cs = 10021
            player:setPos(-24.000, 12.000, 116.000, 128)
        else
            local position = math.random(1, 3) - 2
            player:setPos(-192.5 , -5, position, 0)
        end
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onTransportEvent = function(player, transport)
    if (transport == 223) then
        player:startEvent(10010)
    elseif (transport == 224) then
        player:startEvent(10012)
    elseif (transport == 225) then
        player:startEvent(10011)
    elseif (transport == 226) then
        player:startEvent(10013)
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 10010) then
        player:setPos(0, 0, 0, 0, 223)
    elseif (csid == 10011) then
        player:setPos(0, 0, 0, 0, 225)
    elseif (csid == 10012) then
        player:setPos(0, 0, 0, 0, 224)
    elseif (csid == 10013) then
        player:setPos(0, 0, 0, 0, 226)
    elseif (csid == 324) then
        player:addQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_JOURNEY_BEGINS)
    end
end

return zone_object
