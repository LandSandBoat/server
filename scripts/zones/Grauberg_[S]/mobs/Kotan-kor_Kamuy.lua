-----------------------------------
-- Area: Grauberg [S]
--   NM: Kotan-kor Kamuy
-----------------------------------
local ID = zones[xi.zone.GRAUBERG_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.KOTAN_KOR_KAMUY - 4] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY - 3] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY - 2] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY + 1] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY + 2] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY + 3] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY + 4] = ID.mob.KOTAN_KOR_KAMUY,
    [ID.mob.KOTAN_KOR_KAMUY + 5] = ID.mob.KOTAN_KOR_KAMUY,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 504)
end

return entity
