-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Door:Lion Springs
-- !pos 96 0 106 80
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/missions")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(WOTG) == tpz.mission.id.wotg.THE_QUEEN_OF_THE_DANCE) then
        if (player:getCharVar("QueenOfTheDance") == 0) then
            player:startEvent(68)
        elseif (player:getCharVar("QueenOfTheDance") == 2) then
            player:startEvent(70)
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 68) then
        player:setCharVar("QueenOfTheDance", 1)
    elseif (csid == 70) then
        player:startEvent(152)
    elseif (csid == 152) then
        player:startEvent(153)
    elseif (csid == 153) then
        player:completeMission(WOTG, tpz.mission.id.wotg.THE_QUEEN_OF_THE_DANCE)
        player:addMission(WOTG, tpz.mission.id.wotg.WHILE_THE_CAT_IS_AWAY)
        player:delKeyItem(tpz.ki.MAYAKOV_SHOW_TICKET)
        player:setCharVar("QueenOfTheDance", 0)
    end
end
