-----------------------------------
-- Area: Korroloka Tunnel
--   NM: Falcatus Aranei
-----------------------------------
local ID = zones[xi.zone.KORROLOKA_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.FALCATUS_ARANEI + 2] = ID.mob.FALCATUS_ARANEI, -- -68.852 -5.029 141.069
    [ID.mob.FALCATUS_ARANEI + 1] = ID.mob.FALCATUS_ARANEI, -- -94.545 -6.095 136.480
    [ID.mob.FALCATUS_ARANEI + 3] = ID.mob.FALCATUS_ARANEI, -- -79.827 -6.046 133.982
    [ID.mob.FALCATUS_ARANEI - 4] = ID.mob.FALCATUS_ARANEI, -- -25.445 -6.073 142.192
    [ID.mob.FALCATUS_ARANEI - 3] = ID.mob.FALCATUS_ARANEI, -- -33.446 -6.038 141.987
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 1200)
    mob:setMobMod(xi.mobMod.GIL_MAX, 1903)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 227)
end

return entity
