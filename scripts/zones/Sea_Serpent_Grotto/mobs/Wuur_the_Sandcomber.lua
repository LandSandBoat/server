-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Wuur the Sandcomber
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1) -- "Will aggro any player, regardless of level"
    mob:setMod(tpz.mod.REGEN, 35) -- "Strong Auto Regen effect (around 30-40 HP)"
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 370)
end

return entity
