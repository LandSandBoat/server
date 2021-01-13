-----------------------------------
-- Area: North Gustaberg
--  Mob: Gambilox Wanderling
-- Quest NM - "As Thick as Thieves"
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, isKiller)
    if player:getCharVar("thickAsThievesGamblingCS") == 5 then
        player:setCharVar("thickAsThievesGamblingCS", 6)
    end
end

return entity
