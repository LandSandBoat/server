-----------------------------------
-- Area: Metalworks
--  NPC: Hungry Wolf
-- Type: Quest Giver
-- !pos -25.861 -11 -30.172 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN) ~= QUEST_AVAILABLE and
        trade:hasItemQty(4395, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(429)
    end
end

entity.onTrigger = function(player, npc)
    local smokeOnTheMountain = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN)

    if smokeOnTheMountain == QUEST_AVAILABLE then
        player:startEvent(428)
    else
        player:startEvent(421)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 428) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN)
    elseif (csid == 429) then
        player:tradeComplete()
        player:addGil(xi.settings.main.GIL_RATE * 300)
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.main.GIL_RATE * 300)
        player:addTitle(xi.title.HOT_DOG)
        if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN) == QUEST_ACCEPTED) then
            player:addFame(xi.quest.fame_area.BASTOK, 30)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN)
        else
            player:addFame(xi.quest.fame_area.BASTOK, 5)
        end
    end
end

return entity
