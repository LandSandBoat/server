-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Stroper Chyme
-----------------------------------

if
    xi and
    xi.zones and
    xi.zones.Ordelles_Caves and
    xi.zones.Ordelles_Caves.mobs and
    xi.zones.Ordelles_Caves.mobs.Stroper_Chyme
then
    return xi.zones.Ordelles_Caves.mobs.Stroper_Chyme
else
    local entity = {}

    entity.onMobDeath = function(mob, player, optParams)
    end

    return entity
end
