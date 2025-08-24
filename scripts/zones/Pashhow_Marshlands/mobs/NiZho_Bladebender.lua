-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Ni'Zho Bladebender
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.NI_ZHO_BLADEBENDER - 57] = ID.mob.NI_ZHO_BLADEBENDER, -- -429.953 24.5 -305.450 TODO: Audit PH
    [ID.mob.NI_ZHO_BLADEBENDER - 8]  = ID.mob.NI_ZHO_BLADEBENDER, -- 11.309 23.904 -337.923
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 60, 1, xi.regime.type.FIELDS)
    xi.hunts.checkHunt(mob, player, 214)
    xi.magian.onMobDeath(mob, player, optParams, set{ 893 })
end

return entity
