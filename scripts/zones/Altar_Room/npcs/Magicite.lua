-----------------------------------
-- Area: Altar Room
--  NPC: Magicite
-- Involved in Mission: Magicite
-- !pos -344 25 43 152
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
local ID = require("scripts/zones/Altar_Room/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- To be deprecated by M4-1 Interaction Conversions
    if player:getNation() ~= xi.nation.SANDORIA then
        if player:getCurrentMission(player:getNation()) == xi.mission.id.nation.MAGICITE and
            not player:hasKeyItem(xi.ki.MAGICITE_ORASTONE) then
            if player:getCharVar("Magicite") == 2 then
                player:startEvent(44, 152, 3, 1743, 3) -- play Lion part of the CS (this is last magicite)
            else
                player:startEvent(44) -- don't play Lion part of the CS
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- To be deprecated by M4-1 Interaction Conversions
    if csid == 44 and player:getNation() ~= xi.nation.SANDORIA then
        if player:getCharVar("Magicite") == 2 then
            player:setCharVar("Magicite", 0)
        else
            player:setCharVar("Magicite", player:getCharVar("Magicite") + 1)
        end
        player:setMissionStatus(player:getNation(), 4)
        player:addKeyItem(xi.ki.MAGICITE_ORASTONE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MAGICITE_ORASTONE)
    end
end

return entity
