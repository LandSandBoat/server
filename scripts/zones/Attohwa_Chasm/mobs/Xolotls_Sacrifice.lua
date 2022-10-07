-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl's Sacrifice
-- Note: Pet for Xolotl
-----------------------------------
require("scripts/globals/world")
-----------------------------------
local entity = {}

entity.onMobRoam = function(mob)
    local hour = VanadielHour()

    if hour >= 4 and hour < 20 then -- Despawn Xolotl if its day
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
