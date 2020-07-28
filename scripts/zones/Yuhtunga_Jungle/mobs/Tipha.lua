-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Tipha
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")

function onMobDisengage(mob)
    DespawnMob(mob:getID(), 120)
end

function onMobDeath(mob, player, isKiller)
    if (isKiller and GetMobByID(ID.mob.CARTHI):isDead()) then
        GetNPCByID(ID.npc.CERMET_HEADSTONE):setLocalVar("cooldown", os.time() + 900)
    end
end
