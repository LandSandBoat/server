-----------------------------------
-- Prelate Door
--  This listener will open the prelate door when a mob is engaged and near it.
-----------------------------------
require("scripts/globals/mixins")
local ID = require('scripts/zones/Temple_of_Uggalepih/IDs')
-----------------------------------

xi = xi or {}
xi.mix = xi.mix or {}
g_mixins = g_mixins or {}

g_mixins.prelate_door = function(uggalepihMob)
    uggalepihMob:addListener("COMBAT_TICK", "UGGALEPIH_COMBAT_TICK", function(mob)
        local door = GetNPCByID(ID.npc.PRELATE_DOOR)
        if mob:checkDistance(door) < 3 then
            door:openDoor()
        end
    end)
end

return g_mixins.prelate_door
