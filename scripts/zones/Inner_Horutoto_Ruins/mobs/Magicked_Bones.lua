-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Magicked Bones
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}

entity.onMobRoam = function(mob)
    local totd = VanadielTOTD()
    if totd ~= xi.time.NIGHT and totd ~= xi.time.MIDNIGHT then
        DespawnMob(mob:getID())
    end
end

return entity
