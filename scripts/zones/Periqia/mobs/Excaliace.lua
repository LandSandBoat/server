-----------------------------------
-- Area: Periqia
--  NPC: Excaliace
-----------------------------------
local ID = require("scripts/zones/Periqia/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("topRoomsOption", math.random(2, 3))
    mob:setLocalVar("middleRoomsOption", math.random(4, 5))
    mob:setLocalVar("bottomRoomsOption", math.random(6, 7))
    mob:setLocalVar("lowerForkOption", math.random(8, 9))
    mob:setLocalVar("pathProgressMask", 0)
    mob:setLocalVar("mobChatMessage", 0)
    mob:setLocalVar("chatMessage", 0)
    mob:setLocalVar("runMessage", 0)
    mob:setLocalVar("runTimeCheck", os.time())
    mob:setLocalVar("pathPoint", 1)
end

return entity
