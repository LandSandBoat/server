-----------------------------------
-- Area: Ru'Aun Gardens
--  NPC: Pincerstone
-- NPCs which activates the blue teleports in sky
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

local pincerstoneTable =
{
    -- [Pincerstone NPC ID] = Portal NPC ID
    [ID.npc.PINCERSTONE_OFFSET     ] = ID.npc.PORTAL_OFFSET,      -- Main Island to SE Island
    [ID.npc.PINCERSTONE_OFFSET + 2 ] = ID.npc.PORTAL_OFFSET + 1,  -- SE Island to Main Island
    [ID.npc.PINCERSTONE_OFFSET + 4 ] = ID.npc.PORTAL_OFFSET + 3,  -- SE Island to NE Island
    [ID.npc.PINCERSTONE_OFFSET + 6 ] = ID.npc.PORTAL_OFFSET + 4,  -- NE Island to SE Island
    [ID.npc.PINCERSTONE_OFFSET + 8 ] = ID.npc.PORTAL_OFFSET + 6,  -- NE Island to NW Island
    [ID.npc.PINCERSTONE_OFFSET + 10] = ID.npc.PORTAL_OFFSET + 7,  -- NW Island to NE Island
    [ID.npc.PINCERSTONE_OFFSET + 12] = ID.npc.PORTAL_OFFSET + 9,  -- NW Island to SW Island
    [ID.npc.PINCERSTONE_OFFSET + 14] = ID.npc.PORTAL_OFFSET + 10, -- SW Island to NW Island
    [ID.npc.PINCERSTONE_OFFSET + 16] = ID.npc.PORTAL_OFFSET + 12, -- SW Island to Main Island
    [ID.npc.PINCERSTONE_OFFSET + 18] = ID.npc.PORTAL_OFFSET + 13, -- Main Island to SW Island
}

entity.onTrigger = function(player, npc)
    local npcId    = npc:getID()
    local portalId = pincerstoneTable[npcId]

    if portalId ~= nil then
        local portal = GetNPCByID(portalId)

        if portal and portal:getAnimation() == xi.anim.CLOSE_DOOR then
            GetNPCByID(npcId - 1):openDoor(120)
            portal:openDoor(120)
        else
            player:messageSpecial(ID.text.IT_IS_ALREADY_FUNCTIONING)
        end
    end
end

return entity
