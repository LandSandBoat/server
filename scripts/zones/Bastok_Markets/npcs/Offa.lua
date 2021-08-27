-----------------------------------
-- Area: Bastok Markets
--  NPC: Offa
-- Type: Quest NPC
-- !pos -281.628 -16.971 -140.607 235
-----------------------------------
-- Auto-Script: Requires Verification. Verified standard dialog - thrydwolf 12/18/2011
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local SmokeOnTheMountain = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN)
    if (SmokeOnTheMountain == QUEST_ACCEPTED) then
        player:startEvent(222)
    else
        player:startEvent(124)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
