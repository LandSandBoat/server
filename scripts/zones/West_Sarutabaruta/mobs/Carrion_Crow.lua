-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Carrion Crow
-- Note: PH for Nunyenunc
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA]
-----------------------------------
---@type TMobEntity
local entity = {}

local nunyenuncPHTable =
{
    [ID.mob.NUNYENUNC - 3] = ID.mob.NUNYENUNC, -- 159.501 -20.117 485.528
    [ID.mob.NUNYENUNC - 2] = ID.mob.NUNYENUNC, -- -7.194 -17.288 431.604
    [ID.mob.NUNYENUNC - 1] = ID.mob.NUNYENUNC, -- 53.159 -24.540 554.652
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 28, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, nunyenuncPHTable, 10, 3600) -- 1 hour minimum
end

return entity
