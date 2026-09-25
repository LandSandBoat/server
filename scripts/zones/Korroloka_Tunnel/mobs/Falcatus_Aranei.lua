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
    [ID.mob.FALCATUS_ARANEI - 1] = ID.mob.FALCATUS_ARANEI, -- Confirmed on retail
    [ID.mob.FALCATUS_ARANEI + 4] = ID.mob.FALCATUS_ARANEI, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 1200)
    mob:setMobMod(xi.mobMod.GIL_MAX, 1200)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 227)
end

return entity
