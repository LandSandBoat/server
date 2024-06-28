-----------------------------------
-- Area: Korroloka Tunnel (173)
--  Mob: Huge Spider
-- Note: PH for Falcatus Aranei
-----------------------------------
local ID = zones[xi.zone.KORROLOKA_TUNNEL]
-----------------------------------
local entity = {}

local falcatusPHTable =
{
    [ID.mob.FALCATUS_ARANEI + 2] = ID.mob.FALCATUS_ARANEI, -- -68.852 -5.029 141.069
    [ID.mob.FALCATUS_ARANEI + 1] = ID.mob.FALCATUS_ARANEI, -- -94.545 -6.095 136.480
    [ID.mob.FALCATUS_ARANEI + 3] = ID.mob.FALCATUS_ARANEI, -- -79.827 -6.046 133.982
    [ID.mob.FALCATUS_ARANEI - 4] = ID.mob.FALCATUS_ARANEI, -- -25.445 -6.073 142.192
    [ID.mob.FALCATUS_ARANEI - 3] = ID.mob.FALCATUS_ARANEI, -- -33.446 -6.038 141.987
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 729, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, falcatusPHTable, 5, 7200) -- 2 hour minimum
end

return entity
