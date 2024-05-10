-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Goblin Alchemist
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
local entity = {}

local foreseerPHTable =
{
    [ID.mob.FORESEER_ORAMIX - 7] = ID.mob.FORESEER_ORAMIX,
    [ID.mob.FORESEER_ORAMIX + 4] = ID.mob.FORESEER_ORAMIX,
    [ID.mob.FORESEER_ORAMIX + 7] = ID.mob.FORESEER_ORAMIX,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 757, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, foreseerPHTable, 5, 3600) -- 1 hour
end

return entity
