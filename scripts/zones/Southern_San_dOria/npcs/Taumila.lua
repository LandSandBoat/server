-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Taumila
-- Starts and Finishes Quest: Tiger's Teeth (R)
-- !pos -140 -5 -8 230
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.TIGER_S_TEETH) ~= QUEST_AVAILABLE) then
        if (trade:hasItemQty(884, 3) and trade:getItemCount() == 3) then
            player:startEvent(572)
        end
    end

end

function onTrigger(player, npc)

    local tigersTeeth = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.TIGER_S_TEETH)

    if (player:getFameLevel(SANDORIA) >= 3 and tigersTeeth == QUEST_AVAILABLE) then
        player:startEvent(574)
    elseif (tigersTeeth == QUEST_ACCEPTED) then
        player:startEvent(575)
    elseif (tigersTeeth == QUEST_COMPLETED) then
        player:startEvent(573)
    else
        player:startEvent(571)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 574 and option == 0) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.TIGER_S_TEETH)
    elseif (csid == 572) then
        player:tradeComplete()
        player:addTitle(tpz.title.FANG_FINDER)
        player:addGil(GIL_RATE*2100)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*2100)
        if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.TIGER_S_TEETH) == QUEST_ACCEPTED) then
            player:addFame(SANDORIA, 30)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.TIGER_S_TEETH)
        else
            player:addFame(SANDORIA, 5)
        end
    end

end
