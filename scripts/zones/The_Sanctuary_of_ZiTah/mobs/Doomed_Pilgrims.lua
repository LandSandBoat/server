-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--   NM: Doomed Pilgrims
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
-----------------------------------
local entity = {}

entity.onMobDisengage = function(mob)
    DespawnMob(mob:getID(), 120)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        GetNPCByID(ID.npc.CERMET_HEADSTONE):setLocalVar("cooldown", os.time() + 900)
    end
end

return entity
