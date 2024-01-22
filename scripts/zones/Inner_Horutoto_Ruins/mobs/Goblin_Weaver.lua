-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Weaver
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 648, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    -- This is a work around until "spawn slots" are a thing
    local params = {}
    params.nightOnly = true
    xi.mob.phOnDespawn(mob, { [ID.mob.MAGICKED_BONES - 1] = ID.mob.MAGICKED_BONES + 1 }, 50, 1, params) -- { [Goblin Weaver] = Dagger_Magicked_Bones }
end

return entity
