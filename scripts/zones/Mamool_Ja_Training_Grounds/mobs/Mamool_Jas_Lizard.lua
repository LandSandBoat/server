-----------------------------------
-- Area: Mamool Ja Training Grounds
--  Mob: Mamool Ja's Lizard
-- Involved in Assault: Imperial Agent Rescue
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

return entity
