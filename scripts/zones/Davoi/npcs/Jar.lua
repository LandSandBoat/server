-----------------------------------
-- Area: Davoi
--  NPC: Jar
-- Involved in Quest: Test my Mettle
-- Notes: Used to obtain Power Sandals
-- !pos 183, 0, -190 149
-----------------------------------
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local powerSandalsID = 13012

    -- Give Player Power Sandals if they don't have them
    if not player:hasItem(powerSandalsID) then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, powerSandalsID)
        else
            player:addItem(powerSandalsID)
            player:messageSpecial(ID.text.ITEM_OBTAINED, powerSandalsID)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
