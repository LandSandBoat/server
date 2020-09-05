-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Olbergieut
-- Type: Quest NPC
-- !pos 91 0 121 231
--
-- Starts and Finishes Quest: Gates of Paradise
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    gates = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.GATES_TO_PARADISE)
    if (player:hasKeyItem(tpz.ki.SCRIPTURE_OF_WATER) == true) then
        player:startEvent(620)
    elseif (gates == QUEST_ACCEPTED) then
        player:showText(npc, ID.text.OLBERGIEUT_DIALOG, tpz.ki.SCRIPTURE_OF_WIND)
    elseif (player:getFameLevel(SANDORIA) >= 2 and gates == QUEST_AVAILABLE) then
        player:startEvent(619)
    else
        player:startEvent(612)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 619 and option == 0) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.GATES_TO_PARADISE)
        player:addKeyItem(tpz.ki.SCRIPTURE_OF_WIND)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SCRIPTURE_OF_WIND)
    elseif (csid == 620) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13584)
        else
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.GATES_TO_PARADISE)
            player:addFame(SANDORIA, 30)
            player:addTitle(tpz.title.THE_PIOUS_ONE)
            player:delKeyItem(tpz.ki.SCRIPTURE_OF_WATER)
            player:addItem(13584, 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13584)
        end
    end

end
