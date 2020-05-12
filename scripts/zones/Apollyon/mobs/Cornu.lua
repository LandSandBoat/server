-----------------------------------
-- Area: Apollyon NE
--  Mob: Cornu
-----------------------------------
require("scripts/globals/limbus");
-----------------------------------

function onMobDeath(mob, player, isKiller)
end;

function onMobDespawn(mob)
 local mobID = mob:getID();
 -- print(mobID);
      local mobX = mob:getXPos();
    local mobY = mob:getYPos();
    local mobZ = mob:getZPos();


    if (mobID ==16933066) then -- time T3
       GetNPCByID(16932864+84):setPos(mobX,mobY,mobZ);
    GetNPCByID(16932864+84):setStatus(tpz.status.NORMAL);
    elseif (mobID ==16933069) then -- recover
    GetNPCByID(16932864+127):setPos(mobX,mobY,mobZ);
    GetNPCByID(16932864+127):setStatus(tpz.status.NORMAL);
    end
end;
