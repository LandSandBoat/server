-----------------------------------
-- Area: West Ronfaure
--  NPC: Palcomondau
-- Type: Patrol
-- !pos -178.395 -61.500 382.350 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -178.395, y = -61.500, z = 382.350, wait = 1500 },
    { x = -280.621, y = -60.000, z = 380.759 },
    { x = -306.209, y = -50.000, z = 382.177 },
    { x = -310.592, y = -50.000, z = 378.911 },
    { x = -325.599, y = -50.000, z = 379.166 },
    { x = -336.040, y = -50.000, z = 373.035 },
    { x = -340.107, y = -50.000, z = 361.551 },
    { x = -342.623, y = -50.000, z = 348.619 },
    { x = -356.562, y = -50.000, z = 339.439 },
    { x = -384.803, y = -50.000, z = 337.778 },
    { x = -393.606, y = -50.000, z = 340.603 },
    { x = -413.819, y = -47.000, z = 339.224 },
    { x = -424.934, y = -47.000, z = 338.093 },
    { x = -435.132, y = -47.000, z = 340.438 },
    { x = -466.105, y = -47.000, z = 338.695 },
    { x = -473.789, y = -47.000, z = 340.620 },
    { x = -500.143, y = -47.000, z = 341.110 },
    { x = -497.122, y = -47.000, z = 379.426 },
    { x = -499.746, y = -50.000, z = 409.323 },
    { x = -503.804, y = -55.000, z = 418.130 },
    { x = -497.760, y = -58.000, z = 441.367 },
    { x = -510.489, y = -57.000, z = 458.158 },
    { x = -533.636, y = -57.000, z = 464.914 },
    { x = -540.559, y = -57.000, z = 477.537 },
    { x = -540.352, y = -57.000, z = 485.542 },
    { x = -549.353, y = -57.000, z = 498.221 },
    { x = -585.218, y = -59.000, z = 501.524 },
    { x = -611.579, y = -59.650, z = 515.234, rotation = 180, wait = 1500 },
    { x = -611.579, y = -59.650, z = 515.234, rotation = 40, wait = 1500 },
    { x = -611.579, y = -59.650, z = 515.234, rotation = 90, wait = 1500 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.COORDS)
end

entity.onPath = function(npc)
    if not npc:isFollowingPath() then
        if npc:atPoint(xi.path.last(pathNodes)) then
            npc:setLocalVar("scouted", 1)
            npc:pathThrough(pathNodes, bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
        elseif npc:atPoint(xi.path.first(pathNodes)) then
            npc:setLocalVar("scouted", 0)
            npc:showText(npc, ID.text.PALCOMONDAU_REPORT)
            npc:pathThrough(pathNodes, xi.path.flag.COORDS)
        end
    end
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local scoutStatus = npc:getLocalVar("scouted")
    if scoutStatus ~= 0 then
        player:showText(npc, ID.text.PALCOMONDAU_RETURN)
    else
        player:showText(npc, ID.text.PALCOMONDAU_ENROUTE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
