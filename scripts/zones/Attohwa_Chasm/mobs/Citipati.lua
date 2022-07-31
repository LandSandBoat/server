-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Citipati
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
end

entity.onMobRoam = function(mob)
    if VanadielHour() >= 4 and VanadielHour() < 20 then -- Despawn if its day
        DespawnMob(mob:getID())
    end
end

entity.onMobDisengage = function(mob)
    if VanadielHour() >= 4 and VanadielHour() < 20 then -- Despawn if its day
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 278)
end

return entity
