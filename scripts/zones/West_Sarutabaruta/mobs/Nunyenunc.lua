-----------------------------------
-- Area: West Sarutabaruta (115)
--   NM: Nunyenunc
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.NUNYENUNC - 3] = ID.mob.NUNYENUNC, -- 159.501 -20.117 485.528
    [ID.mob.NUNYENUNC - 2] = ID.mob.NUNYENUNC, -- -7.194 -17.288 431.604
    [ID.mob.NUNYENUNC - 1] = ID.mob.NUNYENUNC, -- 53.159 -24.540 554.652
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.LIGHT_MEVA, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 251)
end

return entity
