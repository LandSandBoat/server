-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl's Sacrifice
-- Note: Pet for Xolotl
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob)
    local xolotl = GetMobByID(zones[xi.zone.ATTOHWA_CHASM].mob.XOLOTL)
    if xolotl then
        xolotl:setLocalVar('pet_spawn_time', GetSystemTime() + 60)
    end
end

return entity
