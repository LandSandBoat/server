-----------------------------------
-- Area: Caedarva Mire
--  NPC: Runic Portal
-- Caedarva Mire (Dvucca) Teleporter Back to Aht Urhgan Whitegate
-- !pos -264 -6 -28 79
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.IMMORTAL_SENTRIES and
        not player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE)
    then
        if xi.besieged.hasRunicPortal(player, xi.teleport.runic_portal.DVUCCA) then
            player:startEvent(134)
        else
            player:startEvent(125)
        end
    else
        player:messageSpecial(ID.text.RESPONSE)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if option == 1 then
        if csid == 125 then
            xi.besieged.addRunicPortal(player, xi.teleport.runic_portal.DVUCCA)
        end

        xi.teleport.toChamberOfPassage(player)
    end
end

return entity
