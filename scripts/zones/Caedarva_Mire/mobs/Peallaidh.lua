-----------------------------------
-- Area: Caedarva Mire
--  Mob: Peallaidh
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SLEEP)
    mob:setMod(xi.mod.STORETP, 50) -- Value an approximation. Precise values needed
end

-- ********Chigoe behavior ommited until https://github.com/LandSandBoat/server/pull/4381 is merged*********
-- entity.onMobWeaponSkill = function(target, mob, skill)
    -- local spawn = mob:getPos()
    -- local counter = 0

    -- for i = 0, 4 do
    --     local chigoe = GetMobByID(ID.mob.PEALLAIDH_CHIGOES + i)

    --     -- Spawns 2 at a time for a maximum of 5
    --     if counter >= 2 then
    --         return
    --     end

    --     if not chigoe:isAlive() then
    --         chigoe:setSpawn(spawn.x, spawn.y, spawn.z)
    --         SpawnMob(chigoe:getID()):updateEnmity(target)
    --         chigoe:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    --         counter = counter + 1

    --         -- Targets master if target is pet
    --         if target:isPet() then
    --             chigoe:updateEnmity(target:getMaster())
    --         end
    --     end
    -- end
-- end

-- Chigoe do not despawn on death
entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 468)
end

return entity
