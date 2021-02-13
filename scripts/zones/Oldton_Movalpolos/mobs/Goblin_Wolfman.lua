-----------------------------------
-- Area: Oldton Movalpolos
--   NM: Goblin Wolfman
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 245)
end

return entity
