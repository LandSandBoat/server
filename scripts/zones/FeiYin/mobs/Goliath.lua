-----------------------------------
-- Area: Fei'Yin
--   NM: Goliath
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -165.800, y = -0.112, z =  148.027 }
}

-- TODO:
-- Implement through the spawn slot system when chance is refactored to per-mob basis
entity.phList =
{
    [ID.mob.GOLIATH - 1] = ID.mob.GOLIATH,
    [ID.mob.GOLIATH + 1] = ID.mob.GOLIATH,
    [ID.mob.GOLIATH + 3] = ID.mob.GOLIATH,
    [ID.mob.GOLIATH + 4] = ID.mob.GOLIATH,
    [ID.mob.GOLIATH + 5] = ID.mob.GOLIATH,
    [ID.mob.GOLIATH + 7] = ID.mob.GOLIATH,
    [ID.mob.GOLIATH + 9] = ID.mob.GOLIATH,
}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.GOLIATH_KILLER)
    end
end

return entity
