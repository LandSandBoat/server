-----------------------------------
-- Area: Talacca Cove
--   NM: Imp Bandsman Add
-----------------------------------
mixins = { require('scripts/mixins/families/imp') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    -- One imp is always slightly bigger and another is always slightly smaller
    local mobIDModulized = mob:getID() % 4
    if mobIDModulized == 0 then
        mob:setMobFlags(1159)
    elseif mobIDModulized == 1 then
        mob:setMobFlags(1155)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
