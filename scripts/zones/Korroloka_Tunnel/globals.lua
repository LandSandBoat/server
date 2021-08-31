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
    local npc = GetNPCByID(ID.npc.MORION_WORM_QM)
    switch (math.random(1, 6)): caseof
    {
        [1] = function (x) npc:setPos(254.652, -6.039, 20.878) end,
        [2] = function (x) npc:setPos(273.350, -7.567, 95.349) end,
        [3] = function (x) npc:setPos(-43.004, -5.579, 96.528) end,
        [4] = function (x) npc:setPos(-96.798, -5.679, 94.728) end,
        [5] = function (x) npc:setPos(-373.924, -10.548, -27.850) end,
        [6] = function (x) npc:setPos(-376.787, -8.574, -54.842) end,
    }
    npc:timer(900000, function() moveMorionWormQM() end)
end

korrolokaGlobal.moveMorionWormQM = moveMorionWormQM

return korrolokaGlobal
