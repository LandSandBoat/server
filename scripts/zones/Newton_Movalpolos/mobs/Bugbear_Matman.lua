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
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onMobMobskillChoose = function(mob, target)
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
