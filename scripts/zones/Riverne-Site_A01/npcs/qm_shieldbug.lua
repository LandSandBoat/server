-----------------------------------
-- Area: Riverne Site #A01
--  NPC: ??? (Gives Shield Bug)
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

local points =
{
    [1]  = { 184.50, 1.00, 359.50 },
    [2]  = { 273.82, 2.62, 269.04 },
    [3]  = { 578.67, 2.99, 345.70 },
    [4]  = { 390.80, 1.83, 309.77 },
    [5]  = { 130.72, 0.53, 433.06 },
    [6]  = {   8.21, 2.36, 309.08 },
    [7]  = { -54.12, 0.40, 367.57 },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    npcUtil.giveItem(player, xi.items.SHIELD_BUG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

local function moveQM(npc)
    local currentPoint = npc:getLocalVar("currentPoint")
    local nextPoint = math.random(1, 17)

    if nextPoint == currentPoint then
        nextPoint = nextPoint + 1
        if nextPoint == 8 then
            nextPoint = 1
        end
    end

    local nextPointLoc = points[nextPoint]
    npc:setLocalVar("currentPoint", nextPoint)
    npc:setStatus(xi.status.NORMAL)
    npcUtil.queueMove(npc, nextPointLoc, 10000)
end

entity.onTimeTrigger = function(npc, triggerID)
    if os.time() > npc:getLocalVar("moveTime") then
        moveQM(npc)
        npc:setLocalVar("moveTime", os.time()+7200)
    end
end

return entity
