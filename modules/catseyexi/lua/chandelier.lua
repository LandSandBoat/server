------------------------------------
-- Prevent Chandelier (THF AF NM) 
-- from blowing up senselessly
------------------------------------
require("modules/module_utils")
------------------------------------
local m = Module:new("chandelier")

m:addOverride("xi.zones.Garlaige_Citadel.mobs.Chandelier.onMobEngaged", function(player, npc)
    local ID = require("scripts/zones/Garlaige_Citadel/IDs")
    require("scripts/globals/status")

    local ce = mob:getCE(target)
    local ve = mob:getVE(target)
    if (ce==0 and ve==0) then
        mob:useMobAbility(511) -- self-destruct
    end
end)