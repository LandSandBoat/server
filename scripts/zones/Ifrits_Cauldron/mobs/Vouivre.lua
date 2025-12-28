-----------------------------------
-- Area: Ifrits Cauldron
--   NM: Vouivre
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -38.587, y =  3.815, z =  259.578 }
}

entity.phList =
{
    [ID.mob.VOUIVRE - 13] = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 12] = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 9]  = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 8]  = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 5]  = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 1]  = ID.mob.VOUIVRE,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 402)
end

return entity
