-----------------------------------
-- Area: King Ranperre's Tomb
--   NM: Vrtra
-----------------------------------
mixins = 
{
    require("scripts/mixins/rage"),
    require("scripts/mixins/claim_shield")
}
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local offsets = { 1, 3, 5, 2, 4, 6 }

entity.onMobInitialize = function(mob)
    -- prevent cheesiness
    mob:setMod(xi.mod.SILENCERES, 50)
    mob:setMod(xi.mod.STUNRES, 50)
    mob:setMod(xi.mod.BINDRES, 50)
    mob:setMod(xi.mod.GRAVITYRES, 50)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.POISONRES, 100)
    mob:setMod(xi.mod.PARALYZERES, 100)
    mob:setMod(xi.mod.LULLABYRES, 10000)
end

entity.onMobSpawn = function(mob)
	mob:setLocalVar("[rage]timer", 1800) -- 30 minutes
end

entity.onMobEngaged = function(mob, target)
--    mob:resetLocalVars() -- This would prevent us from being able to rage Vrtra, so we unset the local vars individually instead.
    mob:setLocalVar("spawnTime", 0)
	mob:setLocalVar("twohourTime", 0)
end

entity.onMobFight = function(mob, target)
    local spawnTime = mob:getLocalVar("spawnTime")
    local twohourTime = mob:getLocalVar("twohourTime")
    local fifteenBlock = mob:getBattleTime() / 15

    if twohourTime == 0 then
        twohourTime = math.random(4, 6)
        mob:setLocalVar("twohourTime", twohourTime)
    end

    if spawnTime == 0 then
        spawnTime = math.random(3, 5)
        mob:setLocalVar("spawnTime", spawnTime)
    end

    if fifteenBlock > twohourTime then
        mob:useMobAbility(710)
        mob:setLocalVar("twohourTime", fifteenBlock + math.random(4, 6))
    elseif fifteenBlock > spawnTime then
        local mobId = mob:getID()

        for i, offset in ipairs(offsets) do
            local pet = GetMobByID(mobId + offset)

            if not pet:isSpawned() then
                pet:spawn(60)
                local pos = mob:getPos()
                pet:setPos(pos.x, pos.y, pos.z)
                pet:updateEnmity(target)
                break
            end
        end

        mob:setLocalVar("spawnTime", fifteenBlock + 4)
    end
end

entity.onMobDisengage = function(mob, weather)
    for i, offset in ipairs(offsets) do
        DespawnMob(mob:getID() + offset)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.VRTRA_VANQUISHER)
end

entity.onMobDespawn = function(mob)
    -- Set Vrtra's spawnpoint and respawn time (3-5 days)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(259200, 432000))
end

return entity
