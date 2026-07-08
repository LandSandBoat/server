-----------------------------------
-- Area: Sacrarium
-- NPC: qm_tavnazian_cookbook
-- Notes: Quest Secrets of Ovens Lost
-----------------------------------
---@type TNpcEntity
local entity = {}

local points =
{
    [0] = { 011.720, -3.999, -99.957 }, -- SW
    [1] = { 108.485, -3.999,  99.267 }, -- NE
    [2] = { 011.722, -3.999,  99.221 }, -- NW
    [3] = { 091.581, -3.999, -99.250 }, -- SE
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
