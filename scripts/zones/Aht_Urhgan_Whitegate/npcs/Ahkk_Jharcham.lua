-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ahkk Jharcham
-- Quest 'Keeping Notes'
-- !pos 0.1 -1 -76 50
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    local keepingNotes = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.KEEPING_NOTES)

    if keepingNotes == QUEST_ACCEPTED and npcUtil.tradeHas(trade, {917, 929}) then -- parchment + black ink
        player:startEvent(11)
    elseif keepingNotes == QUEST_COMPLETED and npcUtil.tradeHas(trade, 917) then -- parchment
        player:startEvent(13) -- Doesn't need any more parchment.
    end
end

function onTrigger(player, npc)
    local keepingNotes = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.KEEPING_NOTES)

    if keepingNotes == QUEST_AVAILABLE then
        player:startEvent(9)
    elseif keepingNotes == QUEST_ACCEPTED then
        player:startEvent(14)
    elseif keepingNotes == QUEST_COMPLETED then
        player:startEvent(12)
    else
        player:startEvent(10)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 9 then
        player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.KEEPING_NOTES)
    elseif csid == 11 then
        player:confirmTrade()
        player:moghouseFlag(16)
        player:completeQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.KEEPING_NOTES)
    end
end
