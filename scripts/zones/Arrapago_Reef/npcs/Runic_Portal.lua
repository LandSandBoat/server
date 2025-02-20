-----------------------------------
-- Area: Arrapago Reef
--  NPC: Runic Portal
-- Arrapago Reef Teleporter Back to Aht Urhgan Whitegate
-- !pos 15 -7 627 54
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REEF]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.IMMORTAL_SENTRIES and
        not player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE)
    then
        if xi.besieged.hasRunicPortal(player, xi.teleport.runic_portal.ILRUSI) then
            player:startEvent(109)
        else
            player:startEvent(111)
        end
    else
        player:messageSpecial(ID.text.RESPONSE)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if option == 1 then
        if csid == 111 then
            xi.besieged.addRunicPortal(player, xi.teleport.runic_portal.ILRUSI)
        end

        xi.teleport.toChamberOfPassage(player)
    end
end

return entity
