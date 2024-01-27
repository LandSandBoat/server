-----------------------------------
-- Mog Garden Global
-----------------------------------
require('scripts/globals/utils')
local ID = zones[xi.zone.MOG_GARDEN]
-----------------------------------
xi = xi or {}
xi.mog_garden = xi.mog_garden or {}

xi.mog_garden.onInitialize = function(zone)
    -- Hide all NPCs by default
    local npcs = zone:getNPCs()
    if next(npcs) ~= nil then -- Check to see if table is empty
        for _, npc in ipairs(npcs) do
            npc:setStatus(xi.status.DISAPPEAR)
        end

        -- Un-hide default NPCS
        GetNPCByID(ID.npc.GREEN_THUMB_MOOGLE):setStatus(xi.status.NORMAL)
        GetNPCByID(ID.npc.MOG_DINGHY):setStatus(xi.status.NORMAL)
        GetNPCByID(ID.npc.PORTER_MOOGLE):setStatus(xi.status.NORMAL)
    end
end

xi.mog_garden.onZoneIn = function(player, prevZone)
    -- TODO: Announcement about GPS Crystals etc.
    -- TODO: System to un-hide specific NPCs for specific players
end

xi.mog_garden.onTriggerAreaEnter = function(player, triggerArea)
end

xi.mog_garden.onEventUpdate = function(player, csid, option, npc)
end

xi.mog_garden.onEventFinish = function(player, csid, option, npc)
end
