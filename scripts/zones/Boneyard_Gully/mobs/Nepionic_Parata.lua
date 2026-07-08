-----------------------------------
-- Area : Boneyard Gully
--  Mob : Nepionic Parata
--  ENM : Shell We Dance?
-- NOTE : These Uragnites do not go into their shell
-----------------------------------
---@type TMobEntity
local entity = {}

-----------------------------------
-- onMobSpawn
-----------------------------------
entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 200)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
end

return entity
