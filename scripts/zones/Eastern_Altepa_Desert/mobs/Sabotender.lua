-----------------------------------
-- Area: Eastern Altepa Desert
-- NM  : Sabotender
-- Notes: Set to linking in the mob_pool, to build a party with Cactro Rapido. Then linking disabled afterwards as they shouldn't link at all.
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
end

return entity
