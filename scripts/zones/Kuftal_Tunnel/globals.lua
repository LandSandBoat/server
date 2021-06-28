-- Zone: Kuftal Tunnel (174)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Kuftal_Tunnel/IDs")
require("scripts/globals/status")
-----------------------------------

-- Move Phantom Worm
local kuftalGlobal = {}

local movePhantomWormQM
movePhantomWormQM = function()
    local npc = GetNPCByID(ID.npc.PHANTOM_WORM_QM)

    switch (math.random(1, 16)): caseof
    {
        [1] = function (x) npc:setPos(75.943, 29.969, 118.854) end,
        [2] = function (x) npc:setPos(75.758, 30.000, 125.815) end,
        [3] = function (x) npc:setPos(65.222, 29.364, 131.645) end,
        [4] = function (x) npc:setPos(53.088, 25.033, 138.725) end,
        [5] = function (x) npc:setPos(85.658, 30.155, 123.941) end,
        [6] = function (x) npc:setPos(91.153, 30.146, 113.657) end,
        [7] = function (x) npc:setPos(86.549, 29.875, 107.232) end,
        [8] = function (x) npc:setPos(94.763, 29.054, 105.138) end,
        [9] = function (x) npc:setPos(102.719, 26.751, 102.816) end,
        [10] = function (x) npc:setPos(71.571, 30.241, 110.704) end,
        [11] = function (x) npc:setPos(65.642, 28.018, 99.2442) end,
        [12] = function (x) npc:setPos(62.090, 25.421, 93.4702) end,
        [13] = function (x) npc:setPos(60.740, 22.638, 86.1781) end,
        [14] = function (x) npc:setPos(80.460, 30.293, 112.721) end,
        [15] = function (x) npc:setPos(76.929, 30.050, 127.630) end,
        [16] = function (x) npc:setPos(68.810, 30.175, 123.516) end,
    }
    npc:timer(5000, function(npc) movePhantomWormQM() end)
end

kuftalGlobal.movePhantomWormQM = movePhantomWormQM

return kuftalGlobal
