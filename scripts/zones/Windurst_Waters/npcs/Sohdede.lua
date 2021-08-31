-----------------------------------
-- Area: Windurst Waters
--  NPC: Sohdede
-- Type: Standard NPC
-- !pos -60.601 -7.499 111.639 238
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
        player:startEvent(384)
    else
        player:startEvent(374)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
