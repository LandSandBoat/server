-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  NPC: Cermet Headstone
-- Involved in Mission: ZM5 Headstone Pilgrimage (Light Headstone)
-- !pos 235 0 280 121
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- SOUL SEARCHING
    if player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CHAMBER_OF_ORACLES) and not player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.SOUL_SEARCHING) then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.SOUL_SEARCHING)
        player:startEvent(202, xi.ki.PRISMATIC_FRAGMENT)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- SOUL SEARCHING
    if csid == 202 then
        npcUtil.completeQuest(player, OUTLANDS, xi.quest.id.outlands.SOUL_SEARCHING, {item = 13416, title = xi.title.GUIDER_OF_SOULS_TO_THE_SANCTUARY})
    end
end

return entity
