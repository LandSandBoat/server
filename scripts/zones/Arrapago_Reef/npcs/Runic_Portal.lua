-----------------------------------
-- Area: Arrapago Reef
--  NPC: Runic Portal
-- Arrapago Reef Teleporter Back to Aht Urgan Whitegate
-- !pos 15 -7 627 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
-----------------------------------
require("scripts/globals/besieged")
require("scripts/globals/missions")
require("scripts/globals/teleports")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(TOAU) == xi.mission.id.toau.IMMORTAL_SENTRIES and player:getCharVar("AhtUrganStatus") == 1 then
        player:startEvent(111)
    elseif player:getCurrentMission(TOAU) > xi.mission.id.toau.IMMORTAL_SENTRIES then
        if xi.besieged.hasRunicPortal(player, xi.teleport.runic_portal.ILRUSI) then
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
            xi.besieged.addRunicPortal(player, xi.teleport.runic_portal.ILRUSI)
        end
        xi.teleport.toChamberOfPassage(player)
    end
end

return entity
