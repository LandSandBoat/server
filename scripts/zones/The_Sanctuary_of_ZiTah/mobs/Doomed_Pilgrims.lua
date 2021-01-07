-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--   NM: Doomed Pilgrims
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
-----------------------------------
local entity = {}

function onMobDisengage(mob)
    DespawnMob(mob:getID(), 120)
end

function onMobDeath(mob, player, isKiller)
    if isKiller then
        GetNPCByID(ID.npc.CERMET_HEADSTONE):setLocalVar("cooldown", os.time() + 900)
    end
end

return entity
