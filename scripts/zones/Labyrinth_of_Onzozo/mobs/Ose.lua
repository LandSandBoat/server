-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Ose
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.OSE - 9] = ID.mob.OSE, -- -1.758 4.982 153.412
    [ID.mob.OSE - 8] = ID.mob.OSE, -- 8.113 5.055 159.197
    [ID.mob.OSE - 7] = ID.mob.OSE, -- 39.858 4.364 164.961
    [ID.mob.OSE - 6] = ID.mob.OSE, -- 48.440 5.070 174.352
    [ID.mob.OSE - 3] = ID.mob.OSE, -- -7.000 4.467 184.000
    [ID.mob.OSE - 2] = ID.mob.OSE, -- -7.233 4.976 204.202
    [ID.mob.OSE + 1] = ID.mob.OSE, -- 26.971 4.440 216.229
    [ID.mob.OSE + 2] = ID.mob.OSE, -- 9.000 4.000 176.000
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
