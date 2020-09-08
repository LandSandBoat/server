-----------------------------------
-- Area: Temenos W T
--  Mob: Enhanced Vulture
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobEngaged(mob, target)
        GetMobByID(16928959):updateEnmity(target)
        GetMobByID(16928960):updateEnmity(target)
        GetMobByID(16928961):updateEnmity(target)
        GetMobByID(16928962):updateEnmity(target)
        GetMobByID(16928963):updateEnmity(target)
        GetMobByID(16928964):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller)

    local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()
   if (IsMobDead(16928959)==true and IsMobDead(16928960)==true  and IsMobDead(16928961)==true
   and IsMobDead(16928962)==true  and IsMobDead(16928963)==true and IsMobDead(16928964)==true) then
       GetNPCByID(16928768+17):setPos(mobX, mobY, mobZ)
    GetNPCByID(16928768+17):setStatus(tpz.status.NORMAL)
    GetNPCByID(16928770+470):setStatus(tpz.status.NORMAL)
  end
end
