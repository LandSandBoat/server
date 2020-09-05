-----------------------------------
-- Area: Metalworks
--  NPC: Grohm
-- Involved In Mission: Journey Abroad
-- !pos -18 -11 -27 237
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.JOURNEY_TO_BASTOK) then
        if (player:getCharVar("notReceivePickaxe") == 1) then
            player:startEvent(425)
        elseif (player:getCharVar("MissionStatus") == 4) then
            player:startEvent(423)
        elseif (player:getCharVar("MissionStatus") == 5 and player:hasItem(599) == false) then
            player:startEvent(424)
        else
            player:startEvent(422)
        end
    elseif (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.JOURNEY_TO_BASTOK2) then
        if (player:getCharVar("MissionStatus") == 9) then
            player:startEvent(426)
        else
            player:startEvent(427)
        end
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK) then
        if (player:getCharVar("notReceivePickaxe") == 1) then
            player:startEvent(425, 1)
        elseif (player:getCharVar("MissionStatus") == 4) then
            player:startEvent(423, 1)
        elseif (player:getCharVar("MissionStatus") == 5 and player:hasItem(599) == false) then
            player:startEvent(424, 1)
        else
            player:startEvent(422)
        end
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2) then
        if (player:getCharVar("MissionStatus") == 9) then
            player:startEvent(426, 1)
        else
            player:startEvent(427, 1)
        end
    else
        player:startEvent(427)--422
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 423 or csid == 425) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 605) -- Pickaxes
            player:setCharVar("notReceivePickaxe", 1)
        else
            player:addItem(605, 5)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 605) -- Pickaxes
            player:setCharVar("MissionStatus", 5)
            player:setCharVar("notReceivePickaxe", 0)
        end
    elseif (csid == 426) then
        player:setCharVar("MissionStatus", 10)
    end

end
