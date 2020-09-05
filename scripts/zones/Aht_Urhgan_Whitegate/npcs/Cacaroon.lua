-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Cacaroon
-- Standard Info NPC
-- !pos -72.026 0.000 -82.337 50
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.RAT_RACE) == QUEST_ACCEPTED and player:getCharVar("ratraceCS") == 2 then
        if npcUtil.tradeHas(trade, 2184) then
            player:startEvent(850)
        end
    elseif player:getCurrentMission(TOAU) == tpz.mission.id.toau.KNIGHT_OF_GOLD and player:getCharVar("AhtUrganStatus") == 1 then
        if npcUtil.tradeHas(trade, {{"gil", 1000}}) or npcUtil.tradeHas(trade, 2184) then
            player:startEvent(3022, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        end
    end
end

function onTrigger(player, npc)
    if player:getCharVar("ratraceCS") == 2 then
        player:startEvent(853)
    elseif player:getCharVar("ratraceCS") >= 3 then
        player:startEvent(854)
    elseif player:getCurrentMission(TOAU) == tpz.mission.id.toau.KNIGHT_OF_GOLD and player:getCharVar("AhtUrganStatus") == 0 then
        player:startEvent(3035, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif player:getCharVar("AhtUrganStatus") == 1 then
        player:startEvent(3036, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    else
        player:startEvent(248)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 3035 and option == 1 then
        player:setCharVar("AhtUrganStatus", 1)
    elseif csid == 3022 then
        player:confirmTrade()
        player:setCharVar("AhtUrganStatus", 2)
    elseif csid == 850 then
        player:confirmTrade()
        player:setCharVar("ratraceCS", 3)
    end
end
