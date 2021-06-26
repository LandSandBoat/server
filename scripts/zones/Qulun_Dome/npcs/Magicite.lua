-----------------------------------
-- Area: Qulun Dome
--  NPC: Magicite
-- Involved in Mission: Magicite
-- !pos 11 25 -81 148
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
local ID = require("scripts/zones/Qulun_Dome/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- To be deprecated by M4-1 Interaction Conversions
    if player:getNation() ~= xi.nation.SANDORIA then
        if player:getCurrentMission(player:getNation()) == xi.mission.id.nation.MAGICITE and not player:hasKeyItem(xi.ki.MAGICITE_AURASTONE) then
            if player:getCharVar("Magicite") == 2 then
                player:startEvent(0, 1) -- play Lion part of the CS (this is last magicite)
            else
                player:startEvent(0) -- don't play Lion part of the CS
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- To be deprecated by M4-1 Interaction Conversions
    if csid == 0 and player:getNation() ~= xi.nation.SANDORIA then
        if player:getCharVar("Magicite") == 2 then
            player:setCharVar("Magicite", 0)
        else
            player:setCharVar("Magicite", player:getCharVar("Magicite")+1)
        end
        player:setMissionStatus(player:getNation(), 4)
        player:addKeyItem(xi.ki.MAGICITE_AURASTONE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MAGICITE_AURASTONE)
    end
end

return entity
