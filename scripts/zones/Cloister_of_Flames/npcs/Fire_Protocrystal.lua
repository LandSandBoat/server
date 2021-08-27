-----------------------------------
-- Area: Cloister of Flames
--  NPC: Fire Protocrystal
-- Involved in Quests: Trial by Fire, Trial Size Trial by Fire
-- !pos -721 0 -598 207
-----------------------------------
local entity = {}

require("scripts/globals/keyitems")
require("scripts/globals/bcnm")
local ID = require("scripts/zones/Cloister_of_Flames/IDs")

entity.onTrade = function(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(ASA) == xi.mission.id.asa.SUGAR_COATED_DIRECTIVE and player:getCharVar("ASA4_Scarlet") == 1) then
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
    --printf("onFinish CSID: %u", csid)
    --printf("onFinish RESULT: %u", option)

    if (csid==2) then
        player:delKeyItem(xi.ki.DOMINAS_SCARLET_SEAL)
        player:addKeyItem(xi.ki.SCARLET_COUNTERSEAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SCARLET_COUNTERSEAL)
        player:setCharVar("ASA4_Scarlet", "2")
    elseif (EventFinishBCNM(player, csid, option)) then
        return
    end

end

return entity
