-----------------------------------
-- Area: The Eldieme Necropolis
-- NM: Skull of Lust
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
    mob:setMod(xi.mod.STORETP, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.SKULLCRUSHER)
        xi.hunts.checkHunt(mob, player, 187)
    end
end

return entity
