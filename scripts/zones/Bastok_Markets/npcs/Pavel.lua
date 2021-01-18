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
    local StampHunt = player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.STAMP_HUNT)

    if (player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatBastok, 14)) then
        player:startEvent(431)
    elseif (StampHunt == QUEST_ACCEPTED and not utils.mask.getBit(player:getCharVar("StampHunt_Mask"), 2)) then
        player:startEvent(227)
    else
        player:startEvent(128)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 431) then
        player:setCharVar("WildcatBastok", utils.mask.setBit(player:getCharVar("WildcatBastok"), 14, true))
    elseif (csid == 227) then
        player:setCharVar("StampHunt_Mask", utils.mask.setBit(player:getCharVar("StampHunt_Mask"), 2, true))
    end

end

return entity
