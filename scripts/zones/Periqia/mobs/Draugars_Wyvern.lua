-----------------------------------
-- Area: Periqia
--  Mob: Draugar's Wyvern
-- Involved in Assault: Requiem
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.HPP, -10)
    mob:setMod(xi.mod.ATTP, 15)
    mob:setMod(xi.mod.DMGBREATH, -5000)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

return entity
