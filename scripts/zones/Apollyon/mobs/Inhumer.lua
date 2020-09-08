-----------------------------------
-- Area: Apollyon SE
--  Mob: Inhumer
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
 local mobID = mob:getID()
 if (mobID ==16933025) then -- time
    GetNPCByID(16932864+246):setPos(343, -1, -296)
    GetNPCByID(16932864+246):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16933028) then -- recover
    GetNPCByID(16932864+248):setPos(376, -1, -259)
    GetNPCByID(16932864+248):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16933022) then -- item
    GetNPCByID(16932864+247):setPos(307, -1, -309)
    GetNPCByID(16932864+247):setStatus(tpz.status.NORMAL)
 end

end
