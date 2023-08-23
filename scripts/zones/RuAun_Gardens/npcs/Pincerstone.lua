-----------------------------------
-- Area: Ru'Aun Gardens
--  NPC: Pincerstone
-- NPCs which activates the blue teleports in sky
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local npcId    = npc:getID()
    local portalId = ID.npc.PINCERSTONES[npcId]

    if portalId ~= nil then
        local portal = GetNPCByID(portalId)

        if portal:getAnimation() == xi.anim.CLOSE_DOOR then
            GetNPCByID(npcId - 1):openDoor(120)
            portal:openDoor(120)
        else
            player:messageSpecial(ID.text.IT_IS_ALREADY_FUNCTIONING)
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
