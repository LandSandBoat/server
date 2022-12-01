-----------------------------------
-- Zone: Korroloka Tunnel (173)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Korroloka_Tunnel/IDs")
require("scripts/globals/status")
-----------------------------------

local korrolokaGlobal = {}

-- Move Morion Worm QM
local moveMorionWormQM
moveMorionWormQM = function()
    local npc            = GetNPCByID(ID.npc.MORION_WORM_QM)
    local morionQmPoints =
    {
        [1] = { 254.652,   -6.039,  20.878 },
        [2] = { 273.350,   -7.567,  95.349 },
        [3] = { -43.004,   -5.579,  96.528 },
        [4] = { -96.798,   -5.679,  94.728 },
        [5] = { -373.924, -10.548, -27.850 },
        [6] = { -376.787,  -8.574, -54.842 },
    }

    npc:setPos(unpack(morionQmPoints[math.random(1, 6)]))
    npc:timer(900000, function()
        moveMorionWormQM()
    end)
end

korrolokaGlobal.moveMorionWormQM = moveMorionWormQM

return korrolokaGlobal
