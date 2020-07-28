-----------------------------------
-- Area: Temenos
--  Mob: Pee Qoho the Python
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobEngaged(mob, target)
  if   (IsMobDead(16929023)==true and IsMobDead(16929024)==true and IsMobDead(16929025)==true and
        IsMobDead(16929026)==true and IsMobDead(16929027)==true and IsMobDead(16929028)==true
    ) then
       mob:setMod(tpz.mod.SLASHRES, 1400)
       mob:setMod(tpz.mod.PIERCERES, 1400)
       mob:setMod(tpz.mod.IMPACTRES, 1400)
       mob:setMod(tpz.mod.HTHRES, 1400)
  else
      mob:setMod(tpz.mod.SLASHRES, 300)
      mob:setMod(tpz.mod.PIERCERES, 300)
      mob:setMod(tpz.mod.IMPACTRES, 300)
      mob:setMod(tpz.mod.HTHRES, 300)
  end
  GetMobByID(16929005):updateEnmity(target)
  GetMobByID(16929006):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller)
          if (IsMobDead(16929005)==true and IsMobDead(16929006)==true and IsMobDead(16929007)==true) then
            GetNPCByID(16928768+78):setPos(-280, -161, -440)
            GetNPCByID(16928768+78):setStatus(tpz.status.NORMAL)
            GetNPCByID(16928768+473):setStatus(tpz.status.NORMAL)
          end
end
