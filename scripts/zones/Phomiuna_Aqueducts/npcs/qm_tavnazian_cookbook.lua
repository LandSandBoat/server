-----------------------------------
-- Area: Phomiuna Aqueducts
-- NPC: qm_tavnazian_cookbook
-- Notes: Quest Secrets of Ovens Lost
-----------------------------------
---@type TNpcEntity
local entity = {}

local points =
{
    [0] = { -46.545, -25.999, 11.700 }, -- SE Room - SE Corner
    [1] = { 113.474, -26.000, 91.610 }, -- NW Room - SE Corner
    [2] = { -73.495, -25.999, 28.296 }, -- SE Room - NW Corner
    [3] = {  86.898, -26.000, 108.36 }, -- NW Room - NW Corner
}

entity.onTimeTrigger = function(npc, triggerID)
    local currentPoint = npc:getLocalVar('currentPoint')
    local nextPoint = currentPoint + 1

    if nextPoint > 3 then
        nextPoint = 0
    end

    local nextPointLoc = points[nextPoint]
    npc:setLocalVar('currentPoint', nextPoint)
    npcUtil.queueMove(npc, nextPointLoc, 30)
end

return entity
