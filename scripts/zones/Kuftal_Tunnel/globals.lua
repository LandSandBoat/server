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
    local npc             = GetNPCByID(ID.npc.PHANTOM_WORM_QM)
    local phantomQmPoints =
    {
        [ 1] = {  75.943, 29.969, 118.854 },
        [ 2] = {  75.758, 30.000, 125.815 },
        [ 3] = {  65.222, 29.364, 131.645 },
        [ 4] = {  53.088, 25.033, 138.725 },
        [ 5] = {  85.658, 30.155, 123.941 },
        [ 6] = {  91.153, 30.146, 113.657 },
        [ 7] = {  86.549, 29.875, 107.232 },
        [ 8] = {  94.763, 29.054, 105.138 },
        [ 9] = { 102.719, 26.751, 102.816 },
        [10] = {  71.571, 30.241, 110.704 },
        [11] = {  65.642, 28.018, 99.2442 },
        [12] = {  62.090, 25.421, 93.4702 },
        [13] = {  60.740, 22.638, 86.1781 },
        [14] = {  80.460, 30.293, 112.721 },
        [15] = {  76.929, 30.050, 127.630 },
        [16] = {  68.810, 30.175, 123.516 },
    }

    npc:setPos(unpack(phantomQmPoints[math.random(1, 16)]))
    npc:timer(5000, function()
        movePhantomWormQM()
    end)
end

kuftalGlobal.movePhantomWormQM = movePhantomWormQM

return kuftalGlobal
