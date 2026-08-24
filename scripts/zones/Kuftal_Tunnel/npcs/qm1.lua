-----------------------------------
-- Area: Kuftal Tunnel
--  NPC: ??? (qm1)
-- Note: Spawns Phantom Worm
-- Position changes every 8 seconds
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TNpcEntity
local entity = {}

local qmPoints =
{
    { 92.682, 30.545, 123.866 },
    { 86.510, 29.671, 105.804 },
    { 75.569, 29.563, 134.547 },
    { 75.943, 29.969, 110.854 },
    { 64.485, 24.257,  90.463 },
    { 59.404, 26.753, 141.246 },
}

local function movePhantomWormQm(npc)
    if npc:getStatus() == xi.status.NORMAL then
        npc:setStatus(xi.status.DISAPPEAR)
        npc:timer(1000, function(npcArg)
            npcArg:setPos(unpack(qmPoints[math.randomInt(1, #qmPoints)]))
            npcArg:setStatus(xi.status.NORMAL)
        end)
    end

    npc:timer(8000, movePhantomWormQm)
end

entity.onSpawn = function(npc)
    npc:timer(8000, movePhantomWormQm)
end

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeMatches(trade, { { xi.item.CHUNK_OF_DARKSTEEL_ORE, 1 } }) and
        npcUtil.popFromQM(player, npc, ID.mob.PHANTOM_WORM, { radius = 1, hide = 900 })
    then
        player:tradeComplete()
    end
end

return entity
