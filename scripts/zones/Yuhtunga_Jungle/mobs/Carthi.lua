-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Carthi
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
-----------------------------------
local entity = {}

entity.onMobDisengage = function(mob)
    DespawnMob(mob:getID(), 120)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller and GetMobByID(ID.mob.TIPHA):isDead() then
        GetNPCByID(ID.npc.CERMET_HEADSTONE):setLocalVar("cooldown", os.time() + 900)
    end
end

return entity
