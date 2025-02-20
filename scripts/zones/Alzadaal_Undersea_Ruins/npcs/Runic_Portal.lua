-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: Runic Portal
-- Arrapago Reef Teleporter Back to Aht Urhgan Whitegate
-- !pos 206.500 -1.220 33.500 72
-- !pos 206.500 -1.220 6.500 72
-----------------------------------
local ID = zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local npcid = npc:getID()
    local event = nil

    if
        player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.IMMORTAL_SENTRIES and
        not player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE)
    then
        if xi.besieged.hasRunicPortal(player, xi.teleport.runic_portal.NYZUL) then
            event = npcid == ID.npc.RUNIC_PORTAL_OFFSET and 117 or 118
        else
            event = npcid == ID.npc.RUNIC_PORTAL_OFFSET and 121 or 122
        end
    else
        player:messageSpecial(ID.text.RESPONSE)
    end

    if event then
        player:startEvent(event)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if option == 1 then
        if csid == 121 or csid == 122 then
            xi.besieged.addRunicPortal(player, xi.teleport.runic_portal.NYZUL)
        end

        xi.teleport.toChamberOfPassage(player)
    end
end

return entity
