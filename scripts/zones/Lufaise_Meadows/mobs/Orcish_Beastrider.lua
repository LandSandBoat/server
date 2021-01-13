----------------------------------------
-- Area: Lufaise_Meadows
--  Mob: Orcish Beastrider
----------------------------------------
mixins = {require("scripts/mixins/fomor_hate")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setLocalVar("fomorHateAdj", -1)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
