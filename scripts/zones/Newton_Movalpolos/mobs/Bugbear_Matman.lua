-----------------------------------
-- Area: Newton Movalpolos
--   NM: Bugbear Matman
-----------------------------------
local ID = zones[xi.zone.NEWTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.H2H_SINGLE_SWING, 1)
    mob:setMod(xi.mod.STORETP, 125)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLOW_RES_RANK, 8)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 10)
    mob:setMobMod(xi.mobMod.NO_H2H_PENALTY, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    -- Below 30% Bugbear Matman heavily prefers Heavy Whisk
    if mob:getHPP() <= 30 and math.random(1, 100) <= 60 then
        return 358
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 248)
end

entity.onMobDespawn = function(mob)
    local showman = GetNPCByID(ID.npc.MOBLIN_SHOWMAN)
    if showman then
        showman:setStatus(xi.status.NORMAL)
    end
end

return entity
