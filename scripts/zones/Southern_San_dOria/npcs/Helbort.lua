-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Helbort
--  Starts and Finished Quest: A purchase of Arms
-- !pos 71 -1 65 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local quest_fas = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FATHER_AND_SON)      -- 1st Quest in Series
    local quest_poa = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS)  -- 2nd Quest in Series

    if (player:getFameLevel(SANDORIA) >= 2 and quest_fas == QUEST_COMPLETED and quest_poa == QUEST_AVAILABLE) then
        player:startEvent(594)  -- Start quest A Purchase of Arms
    elseif (quest_poa == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.WEAPONS_RECEIPT) == true) then
        player:startEvent(607) -- Finish A Purchase of Arms quest
    else
        player:startEvent(593)  -- Standard Dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 594 and option == 0) then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS)
        player:addKeyItem(xi.ki.WEAPONS_ORDER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WEAPONS_ORDER)
    elseif (csid == 607) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17090) -- Elm Staff
        else
            player:addTitle(xi.title.ARMS_TRADER)
            player:delKeyItem(xi.ki.WEAPONS_RECEIPT)
            player:addItem(17090)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17090) -- Elm Staff
            player:addFame(SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_PURCHASE_OF_ARMS)
        end
    end

end

return entity
