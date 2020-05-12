-----------------------------------
-- Area: Apollyon NE
--  Mob: Sirin
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


    if (mobID ==16933072) then -- time T1
       GetNPCByID(16932864+125):setPos(mobX,mobY,mobZ);
    GetNPCByID(16932864+125):setStatus(tpz.status.NORMAL);
    elseif (mobID ==16933071) then -- time T2
    GetNPCByID(16932864+83):setPos(mobX,mobY,mobZ);
    GetNPCByID(16932864+83):setStatus(tpz.status.NORMAL);
    end
end;
