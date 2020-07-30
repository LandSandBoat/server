-----------------------------------
-- Area: Temenos N T
--  Mob: Praetorian Guard CCCXI
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobEngaged(mob, target)

end

function onMobDeath(mob, player, isKiller)
 if (IsMobDead(16928809)==true and IsMobDead(16928810)==true  and IsMobDead(16928811)==true and IsMobDead(16928812)==true ) then
       GetNPCByID(16928768+28):setPos(-311, 80, 419)
    GetNPCByID(16928768+28):setStatus(tpz.status.NORMAL)
    GetNPCByID(16928768+162):setPos(-311, 80, 417)
    GetNPCByID(16928768+162):setStatus(tpz.status.NORMAL)
    GetNPCByID(16928768+213):setPos(-311, 80, 421)
    GetNPCByID(16928768+213):setStatus(tpz.status.NORMAL)
    GetNPCByID(16928770+454):setStatus(tpz.status.NORMAL)
 end
end
