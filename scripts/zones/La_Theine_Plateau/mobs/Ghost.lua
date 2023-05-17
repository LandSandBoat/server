-----------------------------------
-- Area: La Theine Plateau
--  Mob: Ghosts
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    if mob:getID() == 17195190 or mob:getID() == 17195190 then
        mob:addMod(xi.mod.DMGMAGIC, 1500)
        mob:addMod(xi.mod.MEVA, -5)
    end
end

return entity
