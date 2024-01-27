-----------------------------------
-- Area: Cloister of Gales
--  NPC: Wind Protocrystal
-- Involved in Quests: Trial by Wind, Trial Size Trial By Wind
-- !pos -361 1 -381 201
-----------------------------------
local ID = zones[xi.zone.CLOISTER_OF_GALES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.SUGAR_COATED_DIRECTIVE and
        player:getCharVar('ASA4_Emerald') == 1
    then
        player:startEvent(2)
    elseif not xi.bcnm.onTrigger(player, npc) then
        player:messageSpecial(ID.text.PROTOCRYSTAL)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    xi.bcnm.onEventUpdate(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 2 then
        player:delKeyItem(xi.ki.DOMINAS_EMERALD_SEAL)
        player:addKeyItem(xi.ki.EMERALD_COUNTERSEAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.EMERALD_COUNTERSEAL)
        player:setCharVar('ASA4_Emerald', 2)
    else
        xi.bcnm.onEventFinish(player, csid, option, npc)
    end
end

return entity
