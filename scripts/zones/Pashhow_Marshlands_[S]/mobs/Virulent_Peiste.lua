-----------------------------------
-- Area: Pashhow Marshlands [S]
--  Mob: Virulent Peiste
-- Note: PH for Sugaar
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS_S]
-----------------------------------
mixins = { require('scripts/mixins/families/peiste') }
-----------------------------------
---@type TMobEntity
local entity = {}

local sugaarPHTable =
{
    [ID.mob.SUGAAR - 5] = ID.mob.SUGAAR, -- -412.599 24.437 -431.639
    [ID.mob.SUGAAR - 4] = ID.mob.SUGAAR, -- -455.311 24.499 -472.247
    [ID.mob.SUGAAR - 3] = ID.mob.SUGAAR, -- -446.738 24.499 -443.850
    [ID.mob.SUGAAR - 2] = ID.mob.SUGAAR, -- -417.691 23.840 -485.922
    [ID.mob.SUGAAR - 1] = ID.mob.SUGAAR, -- -444.380 24.499 -487.828
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, sugaarPHTable, 5, 3600) -- 1 hour
end

return entity
