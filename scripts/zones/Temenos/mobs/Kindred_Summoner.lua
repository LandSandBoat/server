-----------------------------------
-- Area: Temenos N T
--  Mob: Kindred Summoner
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobEngaged(mob, target)
GetMobByID(16928800):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller)
 if (IsMobDead(16928797)==true and IsMobDead(16928798)==true  and IsMobDead(16928799)==true ) then
       GetNPCByID(16928768+27):setPos(-120, -80, 429)
    GetNPCByID(16928768+27):setStatus(tpz.status.NORMAL)
    GetNPCByID(16928768+161):setPos(-123, -80, 429)
    GetNPCByID(16928768+161):setStatus(tpz.status.NORMAL)
    GetNPCByID(16928768+212):setPos(-117, -80, 429)
    GetNPCByID(16928768+212):setStatus(tpz.status.NORMAL)
 end
end
