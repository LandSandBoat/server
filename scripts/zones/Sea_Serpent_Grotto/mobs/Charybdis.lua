-----------------------------------
-- Area: Sea Serpent Grotto (176)
--   NM: Charybdis
-- !pos -152 48 -328 176
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.CHARYBDIS - 4] = ID.mob.CHARYBDIS, -- -138.181, 48.389, -338.001
    [ID.mob.CHARYBDIS - 2] = ID.mob.CHARYBDIS, -- -212.407, 38.538, -342.544
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MULTI_HIT, 5)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
