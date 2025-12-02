-----------------------------------
-- Area: Lufaise Meadows
--  Mob: Tavnazian Ram
-----------------------------------
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local amaltheia = GetMobByID(ID.mob.AMALTHEIA)

    if amaltheia and amaltheia:isSpawned() then
        xi.follow.follow(mob, amaltheia)
    end
end

entity.onMobDisengage = function(mob)
    local amaltheia = GetMobByID(ID.mob.AMALTHEIA)

    if amaltheia and amaltheia:isSpawned() then
        xi.follow.follow(mob, amaltheia)
    end
end

return entity
