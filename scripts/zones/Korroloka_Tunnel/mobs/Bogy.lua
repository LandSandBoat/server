-----------------------------------
-- Area: Korroloka Tunnel (173)
--  Mob: Bogy
-- Note: PH for Dame Blanche
-----------------------------------
local ID = zones[xi.zone.KORROLOKA_TUNNEL]
-----------------------------------
local entity = {}

local damePHTable =
{
    [ID.mob.DAME_BLANCHE - 1] =  ID.mob.DAME_BLANCHE, -- -345.369 0.716 119.486
    [ID.mob.DAME_BLANCHE - 2] =  ID.mob.DAME_BLANCHE, -- -319.266 -0.244 130.650
    [ID.mob.DAME_BLANCHE - 3] =  ID.mob.DAME_BLANCHE, -- -319.225 -0.146 109.776
    [ID.mob.DAME_BLANCHE - 5] =  ID.mob.DAME_BLANCHE, -- -296.821 -3.207 131.239
    [ID.mob.DAME_BLANCHE - 4] =  ID.mob.DAME_BLANCHE, -- -292.487 -5.993 141.408
    [ID.mob.DAME_BLANCHE - 10] = ID.mob.DAME_BLANCHE, -- -277.338 -9.352 139.763
    [ID.mob.DAME_BLANCHE - 11] = ID.mob.DAME_BLANCHE, -- -276.713 -9.954 135.353
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 732, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, damePHTable, 5, 7200) -- 2 hour minimum
end

return entity
