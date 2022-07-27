-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Anansi
-- BCNM: Come into my Parlor
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

local function spawnSpider(mob, attacker, uint)
    local spider = mob:getID() + uint

    if uint > 8 then
        return
    end

    GetMobByID(spider):setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
    SpawnMob(spider):updateEnmity(attacker)

    mob:timer(1000 * math.random(2, 6), function(mobArg)
        spawnSpider(mobArg, attacker, uint + 1)
    end)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.SLEEPRES, 100)

    mob:addListener("TAKE_DAMAGE", "ANANSI_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        if amount > mobArg:getHP() then
            local target = attacker
            if target:isPet() then
                target = target:getMaster()
            end

            -- Spawn first spider to prevent battlefield ending
            GetMobByID(mobArg:getID()+2):setSpawn(mobArg:getXPos(), mobArg:getYPos(), mobArg:getZPos(), mobArg:getRotPos())
            SpawnMob(mobArg:getID()+2):updateEnmity(attacker)

            -- Recursively spawn the rest of the spiders
            spawnSpider(mob, attacker, 3)
        end
    end)
end

entity.onMobDeath = function(mob)
end

return entity
