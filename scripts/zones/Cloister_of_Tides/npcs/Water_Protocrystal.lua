-----------------------------------
-- Area: Cloister of Tides
--  NPC: Water Protocrystal
-- Involved in Quests: Trial by Water, Trial Size Trial by Water
-- !pos 560 36 560 211
-----------------------------------
require("scripts/globals/bcnm")
local ID = require("scripts/zones/Cloister_of_Tides/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.SUGAR_COATED_DIRECTIVE and
        player:getCharVar("ASA4_Cerulean") == 1
    then
        player:startEvent(2)
    elseif not xi.bcnm.onTrigger(player, npc) then
        player:messageSpecial(ID.text.PROTOCRYSTAL)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    xi.bcnm.onEventUpdate(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 2 then
        player:delKeyItem(xi.ki.DOMINAS_CERULEAN_SEAL)
        player:addKeyItem(xi.ki.CERULEAN_COUNTERSEAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CERULEAN_COUNTERSEAL)
        player:setCharVar("ASA4_Cerulean", "2")
    else
        xi.bcnm.onEventFinish(player, csid, option)
    end
end

return entity
