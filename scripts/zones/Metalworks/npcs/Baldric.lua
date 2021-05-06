-----------------------------------
-- Area: Metalworks
--  NPC: Baldric
-- Type: Quest Giver
-- !pos -50.858 1.777 -31.141 237
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.STARDUST) ~= QUEST_AVAILABLE) then
        if (trade:hasItemQty(503, 1) and trade:getItemCount() == 1) then
            player:startEvent(555)
        end
    end

end

entity.onTrigger = function(player, npc)

    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.STARDUST) == QUEST_AVAILABLE and player:getFameLevel(BASTOK) >= 2) then
        player:startEvent(554)
    else
        player:startEvent(552)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 554) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.STARDUST)
    elseif (csid == 555) then
        player:tradeComplete()
        player:addGil(300)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*300)
        player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.STARDUST)
    end
end

return entity
