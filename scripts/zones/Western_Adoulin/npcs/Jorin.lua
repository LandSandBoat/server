-----------------------------------
-- Area: Western Adoulin
--  NPC: Jorin
-- Type: Standard NPC and Quest Giver
-- Starts, Involved with, and Finishes Quest: 'The Old Man and the Harpoon'
-- !pos 92 32 152 256
-----------------------------------
require("scripts/globals/quests")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local TOMATH = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.THE_OLD_MAN_AND_THE_HARPOON)
    if (TOMATH == QUEST_ACCEPTED) then
        if (player:hasKeyItem(xi.ki.EXTRAVAGANT_HARPOON)) then
            -- Finishing Quest: 'The Old Man and the Harpoon'
            player:startEvent(2542)
        else
            -- Dialgoue during Quest: 'The Old Man and the Harpoon'
            player:startEvent(2541)
        end
    elseif (TOMATH == QUEST_AVAILABLE) then
        -- Starts Quest: 'The Old Man and the Harpoon'
        player:startEvent(2540)
    else
        -- Standard dialogue
        player:startEvent(560)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 2540) then
        -- Starting Quest: 'The Old Man and the Harpoon'
        player:addQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.THE_OLD_MAN_AND_THE_HARPOON)
        player:addKeyItem(xi.ki.BROKEN_HARPOON)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BROKEN_HARPOON)
    elseif (csid == 2542) then
        -- Finishing Quest: 'The Old Man and the Harpoon'
        player:completeQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.THE_OLD_MAN_AND_THE_HARPOON)
        player:addExp(500 * xi.settings.EXP_RATE)
        player:addCurrency('bayld', 300 * xi.settings.BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, 300 * xi.settings.BAYLD_RATE)
        player:delKeyItem(xi.ki.EXTRAVAGANT_HARPOON)
        player:addFame(ADOULIN)
    end
end

return entity
