-----------------------------------
-- Area: Cape Teriggan
--  NPC: Cermet Headstone
-- Involved in Mission: ZM5 Headstone Pilgrimage (Wind Headstone)
-- !pos -107 -8 450 113
-----------------------------------
local ID = require("scripts/zones/Cape_Teriggan/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    -- WANDERING SOULS
    if (trade:hasItemQty(949, 1) and trade:getItemCount() == 1) then
        if (not player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.WANDERING_SOULS) and (player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE) or player:hasKeyItem(xi.ki.WIND_FRAGMENT))) then
            player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.WANDERING_SOULS)
            player:startEvent(202, 949)
        else
            player:messageSpecial(ID.text.NOTHING_HAPPENS)
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- WANDERING SOULS
    if csid == 202 then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13248)
        else
            player:tradeComplete()
            player:addItem(13248) -- Flagellant's Rope
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13248)
            player:addTitle(xi.title.BEARER_OF_BONDS_BEYOND_TIME)
            player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.WANDERING_SOULS)
        end
    end
end

return entity
