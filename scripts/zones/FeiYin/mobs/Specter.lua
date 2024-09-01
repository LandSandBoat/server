-----------------------------------
-- Area: Fei'Yin
--  Mob: Specter
-- Note: PH for N/E/S/W Shadow NMs
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

local northernShadowPHTable =
{
    [ID.mob.NORTHERN_SHADOW - 4] = ID.mob.NORTHERN_SHADOW, -- -159.000 -16.000 146.000
}

local easternShadowPHTable =
{
    [ID.mob.EASTERN_SHADOW - 2] = ID.mob.EASTERN_SHADOW, -- -159.000 -16.000 146.000
}

local westernShadowPHTable =
{
    [ID.mob.WESTERN_SHADOW - 1] = ID.mob.WESTERN_SHADOW, -- -159.000 -16.000 146.000
}

local southernShadowPHTable =
{
    [ID.mob.SOUTHERN_SHADOW - 3] = ID.mob.SOUTHERN_SHADOW, -- -159.000 -16.000 146.000
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 712, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, northernShadowPHTable, 5, 57600) -- 16 hours
    xi.mob.phOnDespawn(mob, easternShadowPHTable, 5, 36000) -- 10 hours
    xi.mob.phOnDespawn(mob, westernShadowPHTable, 5, 36000) -- 10 hours
    xi.mob.phOnDespawn(mob, southernShadowPHTable, 5, 57600) -- 16 hours
end

return entity
