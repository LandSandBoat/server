-----------------------------------
-- Area: Jugner_Forest
--   NM: Fradubio
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")
-----------------------------------
local entity = {}

local updateRegen = function(mob)
    local hour = VanadielHour()
    if hour >= 4 and hour < 20 then
        mob:setMod(xi.mod.REGEN, 25)
    else
        mob:setMod(xi.mod.REGEN, 0)
    end
end

entity.onMobSpawn = function(mob)
    updateRegen(mob)
end

entity.onMobFight = function(mob)
    updateRegen(mob)
end

entity.onMobRoam = function(mob)
    updateRegen(mob)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 329 then
        for i = ID.mob.DUESSA_START, ID.mob.DUESSA_END do
            local pet = GetMobByID(i)
            if not pet:isSpawned() then
                local petId = pet:getID()
                switch (petId): caseof {
                    [17203449] = function()
                        pet:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:updateEnmity(mob:getTarget())
                    end,
                    [17203450] = function()
                        pet:setSpawn(mob:getXPos() + 2, mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:updateEnmity(mob:getTarget())
                    end,
                    [17203451] = function()
                        pet:setSpawn(mob:getXPos() + 3, mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:updateEnmity(mob:getTarget())
                    end,
                    [17203452] = function()
                        pet:setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:updateEnmity(mob:getTarget())
                    end,
                    [17203453] = function()
                        pet:setSpawn(mob:getXPos() + 5, mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:updateEnmity(mob:getTarget())
                    end,
                }
                break
            end
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    for i = ID.mob.DUESSA_START, ID.mob.DUESSA_START do
        GetMobByID(i):setHP(0)
    end
end

return entity
