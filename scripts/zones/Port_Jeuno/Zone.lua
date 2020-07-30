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

function onInitialize(zone)
    tpz.chocobo.initZone(zone)
end

function onZoneIn(player, prevZone)
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
        ENABLE_ABYSSEA == 1 and player:getMainLvl() >= 30
        and player:getQuestStatus(ABYSSEA, tpz.quest.id.abyssea.A_JOURNEY_BEGINS) == QUEST_AVAILABLE
    then
        cs = 324
    end

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        if (prevZone == tpz.zone.SAN_DORIA_JEUNO_AIRSHIP) then
            cs = 10018
            player:setPos(-87.000, 12.000, 116.000, 128)
        elseif (prevZone == tpz.zone.BASTOK_JEUNO_AIRSHIP) then
            cs = 10020
            player:setPos(-50.000, 12.000, -116.000, 0)
        elseif (prevZone == tpz.zone.WINDURST_JEUNO_AIRSHIP) then
            cs = 10019
            player:setPos(16.000, 12.000, -117.000, 0)
        elseif (prevZone == tpz.zone.KAZHAM_JEUNO_AIRSHIP) then
            cs = 10021
            player:setPos(-24.000, 12.000, 116.000, 128)
        else
            local position = math.random(1, 3) - 2
            player:setPos(-192.5 , -5, position, 0)
        end
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onTransportEvent(player, transport)
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

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10010) then
        player:setPos(0, 0, 0, 0, 223)
    elseif (csid == 10011) then
        player:setPos(0, 0, 0, 0, 225)
    elseif (csid == 10012) then
        player:setPos(0, 0, 0, 0, 224)
    elseif (csid == 10013) then
        player:setPos(0, 0, 0, 0, 226)
    elseif (csid == 324) then
        player:addQuest(ABYSSEA, tpz.quest.id.abyssea.A_JOURNEY_BEGINS)
    end
end
