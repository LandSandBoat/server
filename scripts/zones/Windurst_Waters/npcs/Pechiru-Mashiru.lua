-----------------------------------
-- Area: Windurst Waters
--  NPC: Pechiru-Mashiru
-- Involved in Quests: Hat in Hand
-- !pos 162 -2 159 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local makingTheGrade = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE)

    if player:hasKeyItem(xi.ki.NEW_MODEL_HAT) and not utils.mask.getBit(player:getCharVar("QuestHatInHand_var"), 6) then
        player:messageSpecial(ID.text.YOU_SHOW_OFF_THE, 0, xi.ki.NEW_MODEL_HAT)
        player:startEvent(54)
    elseif makingTheGrade == QUEST_ACCEPTED then
        player:startEvent(445)
    else
        player:startEvent(421) -- Standard Conversation
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 54 then
        player:setCharVar("QuestHatInHand_var", utils.mask.setBit(player:getCharVar("QuestHatInHand_var"), 6, true))
        player:addCharVar("QuestHatInHand_count", 1)
    end
end

return entity
