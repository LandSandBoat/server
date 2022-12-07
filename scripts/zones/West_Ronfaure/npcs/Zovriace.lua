-----------------------------------
-- Area: West Ronfaure
--  NPC: Zovriace
-- Type: Patrol NPC
-- !pos -135.297 -61.920 270.550 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/pathfind")
-----------------------------------

local entity = {}

pathNodes =
{
    { x = -135.297, y = -61.920, z = 270.550, wait = 1500 },
    { x = -148.493, y = -60.000, z = 256.440 },
    { x = -190.380, y = -60.000, z = 258.792 },
    { x = -196.407, y = -50.000, z = 261.059 },
    { x = -241.533, y = -50.000, z = 260.659 },
    { x = -255.674, y = -50.000, z = 253.843 },
    { x = -269.553, y = -50.000, z = 224.095 },
    { x = -298.102, y = -50.000, z = 210.639 },
    { x = -303.007, y = -60.000, z = 185.572 },
    { x = -300.748, y = -60.000, z = 172.923 },
    { x = -298.373, y = -40.000, z = 160.147 },
    { x = -301.071, y = -40.000, z = 149.744 },
    { x = -285.817, y = -40.000, z = 133.789 },
    { x = -277.743, y = -40.000, z = 118.265 },
    { x = -266.236, y = -40.000, z = 79.793 },
    { x = -275.676, y = -40.000, z = 43.063 },
    { x = -318.622, y = -35.000, z = 33.768 },
    { x = -330.409, y = -35.000, z = 18.677 },
    { x = -350.277, y = -35.000, z = 8.269 },
    { x = -373.543, y = -35.000, z = -50.184 },
    { x = -401.692, y = -25.000, z = -77.988 },
    { x = -456.504, y = -25.000, z = -95.364 },
    { x = -464.502, y = -25.000, z = -124.527 },
    { x = -442.482, y = -20.000, z = -165.002 },
    { x = -421.694, y = -20.000, z = -185.453 },
    { x = -417.894, y = -20.000, z = -218.138 },
    { x = -422.748, y = -20.000, z = -249.696 },
    { x = -445.497, y = -20.000, z = -263.013 },
    { x = -456.835, y = -20.000, z = -267.578 },
    { x = -461.396, y = -16.000, z = -283.307 },
    { x = -464.242, y = -16.000, z = -301.057 },
    { x = -459.184, y = -16.000, z = -308.282 },
    { x = -458.082, y = -8.000, z = -344.361 },
    { x = -462.966, y = -8.000, z = -370.952 },
    { x = -478.438, y = -8.000, z = -380.166 },
    { x = -492.421, y = -8.000, z = -382.946 },
    { x = -500.284, y = -4.000, z = -396.955 },
    { x = -501.390, y = -4.000, z = -412.997 },
    { x = -503.867, y = 0.000, z = -422.576 },
    { x = -497.673, y = 0.000, z = -430.207 },
    { x = -509.835, y = 0.000, z = -446.122 },
    { x = -516.057, y = 0.000, z = -459.793 },
    { x = -535.936, y = 0.000, z = -465.774 },
    { x = -542.545, y = 0.000, z = -490.605 },
    { x = -534.487, y = 0.000, z = -532.732, rotation = 180, wait = 1500 },
    { x = -534.487, y = 0.000, z = -532.732, rotation = 40, wait = 1500 },
    { x = -534.487, y = 0.000, z = -532.732, rotation = 90, wait = 1500 },
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
            npc:showText(npc, ID.text.ZOVRIACE_REPORT)
            npc:pathThrough(pathNodes, xi.path.flag.COORDS)
        end
    end
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local scoutStatus = npc:getLocalVar("scouted")
    if scoutStatus ~= 0 then
        player:showText(npc, ID.text.ZOVRIACE_RETURN)
    else
        player:showText(npc, ID.text.ZOVRIACE_ENROUTE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
