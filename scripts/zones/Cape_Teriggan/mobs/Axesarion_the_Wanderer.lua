-----------------------------------
-- Area: Cape Teriggan
--   NM: Axesarion the Wanderer
-----------------------------------
local ID = require("scripts/zones/Cape_Teriggan/IDs")
-----------------------------------
local entity = {}

function onMobDisengage(mob)
    DespawnMob(mob:getID(), 120)
end

entity.onMobDeath = function(mob, player, isKiller)
    if (isKiller) then
        GetNPCByID(ID.npc.CERMET_HEADSTONE):setLocalVar("cooldown", os.time() + 900)
    end
end

return entity
