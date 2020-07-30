-----------------------------------
-- Area: Al Zahbi
--  NPC: Suldiran
-- Type: NPC Quest
-- !pos 42 -7 -43 48
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")

function onTrade(player, npc, trade)
    if player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.FEAR_OF_THE_DARK_II) >= QUEST_AVAILABLE and npcUtil.tradeHas( trade, {{2163, 2}} ) then
        player:startEvent(16)
    end
end

function onTrigger(player, npc)
    if player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.FEAR_OF_THE_DARK_II) == QUEST_AVAILABLE then
        player:startEvent(14)
    else
        player:startEvent(15)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 14 and option == 1 then
        player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.FEAR_OF_THE_DARK_II)
    elseif csid == 16 then
        if npcUtil.completeQuest(player, AHT_URHGAN, tpz.quest.id.ahtUrhgan.FEAR_OF_THE_DARK_II, {title=tpz.title.DARK_RESISTANT, gil=200}) then
            player:confirmTrade()
        end
    end
end
