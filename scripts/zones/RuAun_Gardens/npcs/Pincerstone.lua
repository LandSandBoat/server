-----------------------------------
-- Area: Ru'Aun Gardens
--  NPC: Pincerstone
-- NPCs which activates the blue teleports in sky
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local npcId = npc:getID()
    local portalId = ID.npc.PINCERSTONES[npcId]
    if (portalId ~= nil) then
        local portal = GetNPCByID(portalId)
        if (portal:getAnimation() == xi.anim.CLOSE_DOOR) then
            GetNPCByID(npcId - 1):openDoor(120)
            portal:openDoor(120)
        else
            player:messageSpecial(ID.text.IT_IS_ALREADY_FUNCTIONING)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
