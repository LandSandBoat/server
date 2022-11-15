-----------------------------------
-- Area: Mount Zhayolm
--  NPC: Runic Portal
-- Mount Zhayolm Teleporter Back to Aht Urhgan Whitegate
-- !pos 688.994 -23.960 351.496 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
-----------------------------------
require("scripts/globals/besieged")
require('scripts/globals/keyitems')
require("scripts/globals/missions")
require("scripts/globals/teleports")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.IMMORTAL_SENTRIES and
        not player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE)
    then
        if xi.besieged.hasRunicPortal(player, xi.teleport.runic_portal.HALVUNG) then
            player:startEvent(109)
        else
            player:startEvent(111)
        end
    else
        player:messageSpecial(ID.text.RESPONSE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if option == 1 then
        if csid == 111 then
            xi.besieged.addRunicPortal(player, xi.teleport.runic_portal.HALVUNG)
        end

        xi.teleport.toChamberOfPassage(player)
    end
end

return entity
