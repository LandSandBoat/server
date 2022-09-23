-----------------------------------
-- Area: Dangruf Wadi
--  NPC: ??? (QM2)
-- Type: Item Giver
-- !pos -120.041 2.621 415.989 191
-- Starts and Finishes: Breaking Stones, An Empty Vessel
-- only spawns if the weather is SUNNY or CLEAR
-----------------------------------
local ID = require("scripts/zones/Dangruf_Wadi/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(110)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 110 and option == 0) then
        if (player:getFreeSlotsCount() > 0) then
            if (player:addItem(553)) then
                player:messageSpecial(ID.text.ITEM_OBTAINED, 553)
            end
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 553)
        end
    end
end

return entity
