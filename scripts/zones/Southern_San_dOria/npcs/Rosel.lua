-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Rosel
-- Starts and Finishes Quest: Rosel the Armorer
-- !zone 230
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/quests/flyers_for_regine")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 11) -- FLYERS FOR REGINE
end

function onTrigger(player, npc)

    local RoselTheArmorer = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.ROSEL_THE_ARMORER)
    local receiprForThePrince = player:hasKeyItem(tpz.ki.RECEIPT_FOR_THE_PRINCE)

    if (player:getCharVar("RefuseRoselTheArmorerQuest") == 1 and RoselTheArmorer == QUEST_AVAILABLE) then
        player:startEvent(524)
    elseif (RoselTheArmorer == QUEST_AVAILABLE) then
        player:startEvent(523)
        player:setCharVar("RefuseRoselTheArmorerQuest", 1)
    elseif (RoselTheArmorer == QUEST_ACCEPTED and receiprForThePrince) then
        player:startEvent(524)
    elseif (RoselTheArmorer == QUEST_ACCEPTED and receiprForThePrince == false) then
        player:startEvent(527)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    -- Rosel the Armorer, get quest and receipt for prince
    if ((csid == 523 or csid == 524) and option == 0) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.ROSEL_THE_ARMORER)
        player:setCharVar("RefuseRoselTheArmorerQuest", 0)
        player:addKeyItem(tpz.ki.RECEIPT_FOR_THE_PRINCE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RECEIPT_FOR_THE_PRINCE)
    -- Rosel the Armorer, finished quest, recieve 200gil
    elseif (csid == 527) then
        npcUtil.completeQuest(player, SANDORIA, tpz.quest.id.sandoria.ROSEL_THE_ARMORER, {
            title= tpz.title.ENTRANCE_DENIED,
            gil= 200
            })
    end

end
