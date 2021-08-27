-----------------------------------
-- Area: Cloister of Gales
--  NPC: Wind Protocrystal
-- Involved in Quests: Trial by Wind, Trial Size Trial By Wind
-- !pos -361 1 -381 201
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/bcnm")
local ID = require("scripts/zones/Cloister_of_Gales/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(ASA) == xi.mission.id.asa.SUGAR_COATED_DIRECTIVE and player:getCharVar("ASA4_Emerald") == 1) then
        player:startEvent(2)
    elseif (EventTriggerBCNM(player, npc)) then
        return
    else
        player:messageSpecial(ID.text.PROTOCRYSTAL)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    if (csid==2) then
        player:delKeyItem(xi.ki.DOMINAS_EMERALD_SEAL)
        player:addKeyItem(xi.ki.EMERALD_COUNTERSEAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.EMERALD_COUNTERSEAL)
        player:setCharVar("ASA4_Emerald", "2")
    elseif (EventFinishBCNM(player, csid, option)) then
        return
    end

end

return entity
