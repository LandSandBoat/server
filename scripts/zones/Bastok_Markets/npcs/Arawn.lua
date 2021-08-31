-----------------------------------
-- Area: Bastok Markets
--  NPC: Arawn
-- Starts & Finishes Quest: Stamp Hunt
-- !pos -121.492 -4.000 -123.923 235
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local WildcatBastok = player:getCharVar("WildcatBastok")

    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatBastok, 11) then
        player:startEvent(429)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 429 then
        player:setCharVar("WildcatBastok", utils.mask.setBit(player:getCharVar("WildcatBastok"), 11, true))
    end
end

return entity
