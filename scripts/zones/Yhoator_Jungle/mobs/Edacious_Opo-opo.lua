-----------------------------------
-- Area: Yhoator Jungle
--   NM: Edacious Opo-opo
-----------------------------------
require("scripts/globals/hunts")
local ID = require("scripts/zones/Yhoator_Jungle/IDs")
-----------------------------------
local entity = {}

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.EDACIOUS_QM):setLocalVar("despawned", os.time() + 900)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 366)
end

return entity
