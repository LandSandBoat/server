-----------------------------------
-- Area: South Gustaberg
--   NM: Leaping Lizzy
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local ID = require("scripts/zones/South_Gustaberg/IDs")
local entity = {}

entity.onMobSpawn = function(mob)
    -- Disallow two Leaping Lizzies from spawning at the same time
    if mob:getID() == ID.mob.LEAPING_LIZZY_N then
        DisallowRespawn(ID.mob.LEAPING_LIZZY_S, true)
    elseif mob:getID() == ID.mob.LEAPING_LIZZY_S then
        DisallowRespawn(ID.mob.LEAPING_LIZZY_N, true)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 200)

    if mob:getID() == ID.mob.LEAPING_LIZZY_N then
        DisallowRespawn(ID.mob.LEAPING_LIZZY_S, false)
    elseif mob:getID() == ID.mob.LEAPING_LIZZY_S then
        DisallowRespawn(ID.mob.LEAPING_LIZZY_N, false)
    end
end

return entity
