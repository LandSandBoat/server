-----------------------------------
--  Area: Bastok Markets
--  NPC:  Horatius
--  Type: Quest Giver
--  Starts and Finishes: Breaking Stones
-- !pos -158 -6 -117 235
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")

function onTrade(player, npc, trade)
    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.BREAKING_STONES) >= QUEST_AVAILABLE and npcUtil.tradeHas(trade, 553)) then
        player:startEvent(101)
    end
end

function onTrigger(player, npc)
    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatBastok, 12) == false) then
        player:startEvent(428)
    elseif (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.BREAKING_STONES) == QUEST_AVAILABLE and player:getFameLevel(BASTOK) >= 2) then
        player:startEvent(100)
    else
        player:startEvent(110)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 100 and option == 0) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.BREAKING_STONES)
    elseif (csid == 101) then
        if (npcUtil.completeQuest(player, BASTOK, tpz.quest.id.bastok.BREAKING_STONES, {gil=400})) then
            player:confirmTrade()
        end
    elseif (csid == 428) then
        player:setMaskBit(player:getCharVar("WildcatBastok"), "WildcatBastok", 12, true)
    end
end
