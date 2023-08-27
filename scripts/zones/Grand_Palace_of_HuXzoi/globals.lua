-- Zone: Grand Palace of Hu'Xzoi (34)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
-----------------------------------

local huxzoiGlobal = {}

local pickTemperancePH
pickTemperancePH = function()
        local nm      = GetMobByID(ID.mob.JAILER_OF_TEMPERANCE)
        local phTable = ID.mob.JAILER_OF_TEMPERANCE_PH

        if not nm:isSpawned() then
            nm:setLocalVar("ph", phTable[math.random(1, #phTable)])
            nm:timer(900000, function(mob)
                if not mob:isSpawned() then
                    pickTemperancePH()
                end
            end)
        end
    end

huxzoiGlobal.pickTemperancePH = pickTemperancePH

return huxzoiGlobal
