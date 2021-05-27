-----------------------------------
-- Area: Bastok Markets
--  NPC: Pavel
-- Involved in Quest: Stamp Hunt
-- !pos -349.798 -10.002 -181.296 235
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local WildcatBastok = player:getCharVar("WildcatBastok")

    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatBastok, 14) then
        player:startEvent(431)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 431 then
        player:setCharVar("WildcatBastok", utils.mask.setBit(player:getCharVar("WildcatBastok"), 14, true))
    end
end

return entity
