-----------------------------------
-- Area: Beadeaux [S] (92)
--   NM: Da'Dha Hundredmask
-- !pos -89.901 .225 -159.694 92
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 25)
    mob:addMod(tpz.mod.GRAVITYRES, 50)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
