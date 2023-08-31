-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Aw'zdei
-----------------------------------
mixins = { require('scripts/mixins/families/zdei') }
-----------------------------------
local entity = {}

entity.onPath = function(mob)
    local spawnPos = mob:getSpawnPos()
    mob:pathThrough({ spawnPos.x, spawnPos.y, spawnPos.z })
    local pos = mob:getPos()
    if spawnPos.x == pos.x and spawnPos.z == pos.z then
        mob:setPos(spawnPos.x, spawnPos.y, spawnPos.z, mob:getRotPos() + 32)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
