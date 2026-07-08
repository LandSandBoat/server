-----------------------------------
-- Area: The Eldieme Necropolis
-- NM: Skull of Sloth
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
    mob:setMod(xi.mod.STORETP, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.SKULLCRUSHER)
        xi.hunts.checkHunt(mob, player, 186)
    end
end

return entity
