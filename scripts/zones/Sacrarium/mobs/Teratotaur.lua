-----------------------------------
-- Area: Sacrarium
--  Mob: Teratotaur
-----------------------------------
mixins = {require("scripts/mixins/fomor_hate")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setLocalVar("fomorHateAdj", -4)
end

function onMobDeath(mob, player, isKiller)
end

return entity
