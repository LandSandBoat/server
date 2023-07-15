-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Anansi
-- BCNM: Come into my Parlor
-----------------------------------
local entity = {}

local function spawnSpider(mob, attacker, uint)
    local spider = mob:getID() + uint

    if uint > 9 then
        mob:setBehaviour(0)
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
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_DESPAWN))

    mob:addListener("TAKE_DAMAGE", "ANANSI_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        if amount > mobArg:getHP() then
            if attacker:isPet() then
                attacker = attacker:getMaster()
            end

            -- Recursively spawn the rest of the spiders
            spawnSpider(mob, attacker, 2)
        end
    end)
end

entity.onMobDeath = function(mob)
end

return entity
