-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Mirror Pond
-- Involved In Quest: Love And Ice
-- !zone 223
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (npc:getID() == ID.npc.MIRROR_POND_J8) then
        if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVE_AND_ICE) == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.CARMELOS_SONG_SHEET)) then
            player:startEvent(100)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 100) then
        player:setCharVar("LoveAndIceProgress", 1)
        player:delKeyItem(xi.ki.CARMELOS_SONG_SHEET)
    end
end

return entity
