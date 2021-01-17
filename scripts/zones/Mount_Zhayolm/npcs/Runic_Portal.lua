-----------------------------------
-- Area: Mount Zhayolm
--  NPC: Runic Portal
-- Mount Zhayolm Teleporter Back to Aht Urgan Whitegate
-- !pos 688.994 -23.960 351.496 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/teleports")
require("scripts/globals/besieged")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(TOAU) == tpz.mission.id.toau.IMMORTAL_SENTRIES and player:getCharVar("AhtUrganStatus") == 1 then
        player:startEvent(111)
    elseif player:getCurrentMission(TOAU) > tpz.mission.id.toau.IMMORTAL_SENTRIES then
        if tpz.besieged.hasRunicPortal(player, tpz.teleport.runic_portal.HALVUNG) then
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
            tpz.besieged.addRunicPortal(player, tpz.teleport.runic_portal.HALVUNG)
        end
        tpz.teleport.toChamberOfPassage(player)
    end
end

return entity
