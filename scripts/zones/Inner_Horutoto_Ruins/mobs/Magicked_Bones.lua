-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Magicked Bones
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.MAGICKED_BONES - 2] = ID.mob.MAGICKED_BONES,
    [ID.mob.MAGICKED_BONES - 1] = ID.mob.MAGICKED_BONES + 1, -- Dagger Magicked Bones
}

entity.onMobRoam = function(mob)
    local totd = VanadielTOTD()
    if totd ~= xi.time.NIGHT and totd ~= xi.time.MIDNIGHT then
        DespawnMob(mob:getID())
    end
end

return entity
