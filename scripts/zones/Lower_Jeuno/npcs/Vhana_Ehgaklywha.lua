-----------------------------------
-- Area: Lower Jeuno
--  NPC: Vhana Ehgaklywha
-- Lights lamps in Lower Jeuno if nobody accepts Community Service by 1AM.
-- !pos -122.853 0.000 -195.605 245
-----------------------------------
local lowerJeunoGlobal = require('scripts/zones/Lower_Jeuno/globals')
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onPath = function(npc)
    if not npc:isFollowingPath() then
        local path = npc:getLocalVar('path')
        local currentPath = lowerJeunoGlobal.lampPath[path]
        local newPath = lowerJeunoGlobal.lampPath[path + 1]

        if npc:atPoint(xi.path.last(currentPath)) then
            if path ~= 13 then
                local lampId = ID.npc.STREETLAMP_OFFSET + (12 - path)
                GetNPCByID(lampId):setAnimation(xi.anim.OPEN_DOOR)
                npc:setLocalVar('path', path + 1)
                npc:pathThrough(newPath, xi.path.flag.COORDS)
            else
                npc:clearPath()
                npc:setLocalVar('path', 1)
                npc:setStatus(2)
            end
        end
    end
end

return entity
