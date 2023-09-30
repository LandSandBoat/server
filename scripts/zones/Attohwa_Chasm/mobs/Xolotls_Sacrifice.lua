-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl's Sacrifice
-- Note: Pet for Xolotl
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.LULLABYRESBUILD, 50)
end

entity.onMobRoam = function(mob)
    local hour = VanadielHour()

    if hour >= 4 and hour < 20 then -- Despawn if its daytime
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
