-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Wuur the Sandcomber
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1) -- "Will aggro any player, regardless of level"
    mob:setMod(tpz.mod.REGEN, 35) -- "Strong Auto Regen effect (around 30-40 HP)"
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 370)
end
