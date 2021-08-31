-----------------------------------
-- Area: Caedarva Mire
--  NPC: Runic Portal
-- Caedarva Mire Teleporter Back to Aht Urhgan Whitegate
-- !pos -264 -6 -28 79 (Dvucca)
-- !pos 524 -28 -503 79 (Azouph)
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
-----------------------------------
require("scripts/globals/besieged")
require("scripts/globals/missions")
require("scripts/globals/teleports")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local npcid = npc:getID()
    local event = nil

    if player:getCurrentMission(TOAU) == xi.mission.id.toau.IMMORTAL_SENTRIES and player:getCharVar("AhtUrganStatus") == 1 then
        event = npcid == ID.npc.RUNIC_PORTAL_AZOUPH and 124 or 125
    elseif player:getCurrentMission(TOAU) > xi.mission.id.toau.IMMORTAL_SENTRIES then
        local runicPortal = npcid == ID.npc.RUNIC_PORTAL_AZOUPH and xi.teleport.runic_portal.AZOUPH or xi.teleport.runic_portal.DVUCCA
        if xi.besieged.hasRunicPortal(player, runicPortal) then
            event = npcid == ID.npc.RUNIC_PORTAL_AZOUPH and 131 or 134
        else
            event = npcid == ID.npc.RUNIC_PORTAL_AZOUPH and 124 or 125
        end
    else
        player:messageSpecial(ID.text.RESPONSE)
    end

    if event then
        player:startEvent(event)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if option == 1 then
        if csid == 124 then
            xi.besieged.addRunicPortal(player, xi.teleport.runic_portal.AZOUPH)
        elseif csid == 125 then
            xi.besieged.addRunicPortal(player, xi.teleport.runic_portal.DVUCCA)
        end

        xi.teleport.toChamberOfPassage(player)
    end
end

return entity
