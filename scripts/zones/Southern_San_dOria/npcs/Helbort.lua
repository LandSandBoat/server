-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Helbort
--  Starts and Finished Quest: A purchase of Arms
-- !pos 71 -1 65 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 2 and
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FATHER_AND_SON) == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS) == QUEST_AVAILABLE
    then
        player:startEvent(594)  -- Start quest A Purchase of Arms
    elseif
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS) == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.WEAPONS_RECEIPT)
    then
        player:startEvent(607) -- Finish A Purchase of Arms quest
    else
        player:startEvent(593)  -- Standard Dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 594 and option == 0 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS)
        player:addKeyItem(xi.ki.WEAPONS_ORDER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WEAPONS_ORDER)
    elseif csid == 607 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17090) -- Elm Staff
        else
            player:addTitle(xi.title.ARMS_TRADER)
            player:delKeyItem(xi.ki.WEAPONS_RECEIPT)
            player:addItem(17090)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17090) -- Elm Staff
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS)
        end
    end
end

return entity
