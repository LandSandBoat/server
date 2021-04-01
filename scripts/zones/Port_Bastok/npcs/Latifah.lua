-----------------------------------
-- Area: Port Bastok
--  NPC: Latifah
-- Involved in Quest: Stamp Hunt
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local StampHunt = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.STAMP_HUNT)

    if (StampHunt == QUEST_ACCEPTED and not utils.mask.getBit(player:getCharVar("StampHunt_Mask"), 6)) then
        player:startEvent(120)
    else
        player:startEvent(13)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 120) then
        player:setCharVar("StampHunt_Mask", utils.mask.setBit(player:getCharVar("StampHunt_Mask"), 6, true))
    end

end

return entity
