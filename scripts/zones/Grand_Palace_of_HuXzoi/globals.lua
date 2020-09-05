-- Zone: Grand Palace of Hu'Xzoi (34)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/globals/status")
-----------------------------------

GRAND_PALACE_OF_HUXZOI = {
    --[[..............................................................................................
        pick new Jailer of Temperance placeholder every 15 minutes
        ..............................................................................................]]
    pickTemperancePH = function()
        local nm = GetMobByID(ID.mob.JAILER_OF_TEMPERANCE)
        local phTable = ID.mob.JAILER_OF_TEMPERANCE_PH
        if (not nm:isSpawned()) then
            nm:setLocalVar("ph", phTable[math.random(#phTable)])
            nm:timer(900000, function(mob)
                if (not mob:isSpawned()) then
                    GRAND_PALACE_OF_HUXZOI.pickTemperancePH()
                end
            end)
        end
    end
}

return GRAND_PALACE_OF_HUXZOI
