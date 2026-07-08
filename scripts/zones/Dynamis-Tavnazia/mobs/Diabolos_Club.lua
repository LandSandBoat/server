-----------------------------------
-- Area: Dynamis-Tavnazia
--  Mob: Diabolos Club
-- Note: Mega Boss
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Diaboloss_Shard')
end

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.NIGHTMARE_AWAKENER)
        xi.dynamis.megaBossOnDeath(mob, player, optParams)
    end
end

return entity
