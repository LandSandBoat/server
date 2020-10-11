-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Abioleget
-- Type: Quest Giver (Her Memories: The Faux Pas and The Vicasque's Sermon) / Merchant
-- !pos 128.771 0.000 118.538 231
--
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (sermonQuest == QUEST_ACCEPTED) then
        gil = trade:getGil()
        count = trade:getItemCount()
        if (gil == 70 and count == 1) then
            player:tradeComplete()
            player:startEvent(591)
        end
    end
end

function onTrigger(player, npc)
    sermonQuest = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_VICASQUE_S_SERMON)

    if (sermonQuest == QUEST_AVAILABLE) then
        player:startEvent(589)
    elseif (sermonQuest == QUEST_ACCEPTED) then
        if (player:getCharVar("sermonQuestVar") == 1) then
            player:tradeComplete()
            player:startEvent(600)
        else
            player:showText(npc, 11103, 618, 70)
        end
    else
        player:showText(npc, ID.text.ABIOLEGET_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 600) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13465)
        else
            player:addItem(13465)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13465)
            player:addFame(SANDORIA, 30)
            player:addTitle(tpz.title.THE_BENEVOLENT_ONE)
            player:setCharVar("sermonQuestVar", 0)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.THE_VICASQUE_S_SERMON )
        end
    elseif (csid == 589) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.THE_VICASQUE_S_SERMON )
    elseif (csid == 591) then
        player:addItem(618)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 618)
    end
end
