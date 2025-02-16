-- Zone: Kuftal Tunnel (174)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------

-- Move Phantom Worm
local kuftalGlobal = {}

local movePhantomWormQM
movePhantomWormQM = function()
    local npc = GetNPCByID(ID.npc.PHANTOM_WORM_QM)
    if not npc then
        return
    end

    local phantomQmPoints =
    {
        [1] = { 92.682, 30.545, 123.866 },
        [2] = { 86.510, 29.671, 105.804 },
        [3] = { 75.569, 29.563, 134.547 },
        [4] = { 75.943, 29.969, 110.854 },
        [5] = { 64.485, 24.257,  90.463 },
        [6] = { 59.404, 26.753, 141.246 },
    }

    npc:setStatus(xi.status.DISAPPEAR)
    npc:timer(1000, function(npcArg)
        npcArg:setPos(unpack(phantomQmPoints[math.random(1, 6)]))
        npcArg:setStatus(xi.status.NORMAL)
    end)

    npc:timer(8000, function()
        movePhantomWormQM()
    end)
end

kuftalGlobal.movePhantomWormQM = movePhantomWormQM

return kuftalGlobal
