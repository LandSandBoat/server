-----------------------------------
-- Area: Windurst Waters
--  NPC: Serukoko
-- Type: Standard NPC
-- !pos -54.916 -7.499 114.855 238
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local glyphHanger = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.GLYPH_HANGER)

    if glyphHanger == QUEST_ACCEPTED and not player:hasKeyItem(xi.ki.NOTES_FROM_IPUPU) then
        player:startEvent(383)
    else
        player:startEvent(373)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
