-----------------------------------
-- Area: Northern San d'Oria
--   NPC: Vamorcote
-- Starts and Finishes Quest: The Setting Sun
-- !pos -137.070 10.999 161.855 231
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    -- "The Setting Sun" conditional script
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_SETTING_SUN) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(535, 1) and trade:getItemCount() == 1) then
            player:startEvent (658)
        end
    end
end

function onTrigger(player, npc)
    -- Look at the "The Setting Sun" quest status and San d'Oria player's fame
    theSettingSun = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_SETTING_SUN)

    if (theSettingSun == QUEST_AVAILABLE  and
        player:getFameLevel(SANDORIA) >= 5 and
        player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.BLACKMAIL) ~= QUEST_COMPLETED)
    then
        player:startEvent(654, 0, 535, 535) --The quest is offered to the player.
    elseif (theSettingSun == QUEST_ACCEPTED) then
        player:startEvent(655, 0, 0, 535) --The NPC asks if the player got the key.'
    elseif (theSettingSun == QUEST_COMPLETED and player:needToZone()) then
        player:startEvent(659) --The quest is already done by the player and the NPC does small talks.
    else
        player:startEvent(651)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 654 and option == 1) then --Player accepts the quest
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.THE_SETTING_SUN)
    elseif (csid == 658) then --The player trades the Engraved Key to the NPC. Here come the rewards!
        player:tradeComplete()
        player:addGil(GIL_RATE*10000)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*10000)
        player:addFame(SANDORIA, 30)
        player:completeQuest(SANDORIA, tpz.quest.id.sandoria.THE_SETTING_SUN)
    end
end
