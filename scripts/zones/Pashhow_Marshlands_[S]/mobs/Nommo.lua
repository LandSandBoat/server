-----------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Nommo
-- https://www.bg-wiki.com/ffxi/Nommo
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.NOMMO - 5] = ID.mob.NOMMO, -- -168.292 24.499 396.933
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAMNESIA, { chance = 10, duration = 30 })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 509)
end

return entity
