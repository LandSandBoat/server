-----------------------------------
-- Area: Talacca Cove
--   NM: Imp Bandsman Add
-----------------------------------
mixins = { require('scripts/mixins/families/imp') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    -- One imp is always slightly bigger and another is always slightly smaller
    local mobIDModulized = mob:getID() % 4
    if mobIDModulized == 0 then
        mob:setMobFlags(1159)
    elseif mobIDModulized == 1 then
        mob:setMobFlags(1155)
    end
end

return entity
