-----------------------------------
-- Area: Uleguerand Range
--  MOB: Black Coney
-- Note: uses normal rabbit attacks. has double/triple attack.
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.RABBIT_FOOTPRINT):setLocalVar("activeTime", os.time() + math.random(60 * 9, 60 * 15))
end

return entity
