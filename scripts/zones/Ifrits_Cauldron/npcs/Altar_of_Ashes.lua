-----------------------------------
-- Area: Ifrit's Cauldron
--  NPC: Altar of Ashes
-- Involved in Quest: Greetings to the Guardian
-- !pos 16 .1 -58 205
-----------------------------------
local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local guardian = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.GREETINGS_TO_THE_GUARDIAN)

    if guardian == QUEST_ACCEPTED and trade:hasItemQty(4596, 1) then
        player:messageSpecial(ID.text.ALTAR_OFFERING, 0, 4596)
        player:setCharVar("PamamaVar", 1) -- Set variable to reflect first completion of quest
        player:tradeComplete()
    elseif guardian == QUEST_COMPLETED and trade:hasItemQty(4596, 1) then
        player:messageSpecial(ID.text.ALTAR_OFFERING, 0, 4596)
        player:setCharVar("PamamaVar", 2) -- Set variable to reflect repeat of quest, not first time
        player:tradeComplete()
    end
end

entity.onTrigger = function(player, npc)
    local guardian = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.GREETINGS_TO_THE_GUARDIAN)

    if
        guardian == QUEST_ACCEPTED and
        (player:getCharVar("PamamaVar") == 1 or player:getCharVar("PamamaVar") == 2)
    then
        player:messageSpecial(ID.text.ALTAR_COMPLETED)
    elseif guardian == QUEST_ACCEPTED and player:getCharVar("PamamaVar") == 0 then
        player:messageSpecial(ID.text.ALTAR_INSPECT)
    else
        player:messageSpecial(ID.text.ALTAR_STANDARD)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
