-----------------------------------
-- Area: Cloister of Flames
--  NPC: Fire Protocrystal
-- Involved in Quests: Trial by Fire, Trial Size Trial by Fire
-- !pos -721 0 -598 207
-----------------------------------
local ID = zones[xi.zone.CLOISTER_OF_FLAMES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.SUGAR_COATED_DIRECTIVE and
        player:getCharVar('ASA4_Scarlet') == 1
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
        player:delKeyItem(xi.ki.DOMINAS_SCARLET_SEAL)
        player:addKeyItem(xi.ki.SCARLET_COUNTERSEAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SCARLET_COUNTERSEAL)
        player:setCharVar('ASA4_Scarlet', 2)
    else
        xi.bcnm.onEventFinish(player, csid, option, npc)
    end
end

return entity
