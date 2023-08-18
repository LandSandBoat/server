-----------------------------------
-- Area: Jugner_Forest
--   NM: Fradubio
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
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
        for i = ID.mob.FRADUBIO + 1, ID.mob.FRADUBIO + 5 do
            local pet = GetMobByID(i)
            if not pet:isSpawned() then
                pet:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos())
                pet:spawn()
                pet:updateEnmity(mob:getTarget())
                break
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    for i = ID.mob.FRADUBIO + 1, ID.mob.FRADUBIO + 5 do
        GetMobByID(i):setHP(0)
    end
end

return entity
