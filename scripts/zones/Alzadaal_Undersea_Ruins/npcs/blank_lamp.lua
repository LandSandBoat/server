-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: 19 (no name)
-----------------------------------
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(TOAU) == xi.mission.id.toau.PATH_OF_DARKNESS and player:getCharVar("AhtUrganStatus") == 0) then
        player:startEvent(6)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.NASHMEIRAS_PLEA and player:getCharVar("AhtUrganStatus") == 0) then
        player:startEvent(8)
    else
        player:messageSpecial(ID.text.DEVICE_MALFUNCTIONING)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 6) then
        player:setCharVar("AhtUrganStatus", 1)
    elseif (csid == 8) then
        player:setCharVar("AhtUrganStatus", 1)
    end
end

return entity
