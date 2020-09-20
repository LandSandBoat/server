-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Carthi
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")

function onMobDisengage(mob)
    DespawnMob(mob:getID(), 120)
end

function onMobDeath(mob, player, isKiller)
    if (isKiller and GetMobByID(ID.mob.TIPHA):isDead()) then
        GetNPCByID(ID.npc.CERMET_HEADSTONE):setLocalVar("cooldown", os.time() + 900)
    end
end
