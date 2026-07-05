-----------------------------------
-- Area: Periqia
--  NPC: Excaliace
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('topRoomsOption', math.randomInt(2, 3))
    mob:setLocalVar('middleRoomsOption', math.randomInt(4, 5))
    mob:setLocalVar('bottomRoomsOption', math.randomInt(6, 7))
    mob:setLocalVar('lowerForkOption', math.randomInt(8, 9))
    mob:setLocalVar('pathProgressMask', 0)
    mob:setLocalVar('mobChatMessage', 0)
    mob:setLocalVar('chatMessage', 0)
    mob:setLocalVar('runMessage', 0)
    mob:setLocalVar('runTimeCheck', GetSystemTime())
    mob:setLocalVar('pathPoint', 1)
end

return entity
