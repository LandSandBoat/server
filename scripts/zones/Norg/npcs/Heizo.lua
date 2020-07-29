-----------------------------------
-- Area: Norg
--  NPC: Heizo
-- Starts and Ends Quest: Like Shining Leggings
-- !pos -1 -5 25 252
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    ShiningLeggings = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.LIKE_A_SHINING_LEGGINGS)
    Legging = trade:getItemQty(14117)

    if (Legging > 0 and Legging == trade:getItemCount()) then
        TurnedInVar = player:getCharVar("shiningLeggings_nb")
        if (ShiningLeggings == QUEST_ACCEPTED and TurnedInVar + Legging >= 10) then -- complete quest
            player:startEvent(129)
        elseif (ShiningLeggings == QUEST_ACCEPTED and TurnedInVar <= 9) then -- turning in less than the amount needed to finish the quest
            TotalLeggings = Legging + TurnedInVar
            player:tradeComplete()
            player:setCharVar("shiningLeggings_nb", TotalLeggings)
            player:startEvent(128, TotalLeggings) -- Update player on number of leggings turned in
        end
    else
        if (ShiningLeggings == QUEST_ACCEPTED) then
            player:startEvent(128, TotalLeggings) -- Update player on number of leggings turned in, but doesn't accept anything other than leggings
        else
            player:startEvent(126) -- Give standard conversation if items are traded but no quest is accepted
        end
    end
end

function onTrigger(player, npc)

    ShiningLeggings = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.LIKE_A_SHINING_LEGGINGS)

    if (ShiningLeggings == QUEST_AVAILABLE and  player:getFameLevel(NORG) >= 3) then
        player:startEvent(127) -- Start Like Shining Leggings
    elseif (ShiningLeggings == QUEST_ACCEPTED) then
        player:startEvent(128, player:getCharVar("shiningSubligar_nb")) -- Update player on number of Leggings turned in
    else
        player:startEvent(126) -- Standard Conversation
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 127) then
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.LIKE_A_SHINING_LEGGINGS)
    elseif (csid == 129) then
        player:tradeComplete()
        player:addItem(4958) -- Scroll of Dokumori: Ichi
        player:messageSpecial(ID.text.ITEM_OBTAINED, 4958) -- Scroll of Dokumori: Ichi
        player:addFame(NORG, 100)
        player:addTitle(tpz.title.LOOKS_GOOD_IN_LEGGINGS)
        player:setCharVar("shiningLeggings_nb", 0)
        player:completeQuest(OUTLANDS, tpz.quest.id.outlands.LIKE_A_SHINING_LEGGINGS)
    end

end
