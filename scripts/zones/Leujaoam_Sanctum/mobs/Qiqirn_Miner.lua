-----------------------------------
-- Area: Leujaoam Sanctum (Orichalcum Survey)
--  Mob: Qiqirn Miner
-----------------------------------
---@type TMobEntity
local entity = {}

local function applyDormantState(mob)
    mob:hideHP(true)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 0)
    mob:setStatus(xi.status.NORMAL)
    -- TODO Find a way that the Qiqirn are not being hit by AoE as secondary target. So far I only found setUntargetable but it's not what we want.
end

local function applyAggressiveState(mob)
    mob:setStatus(xi.status.UPDATE)
    mob:setMaxHP(17000)
    mob:setHP(17000)
    mob:hideHP(false)
    mob:setAutoAttackEnabled(true)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 0)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

local function awakenMob(mob, sourcePlayer)
    if not mob:getInstance() then
        return
    end

    applyAggressiveState(mob)
end

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)

    applyDormantState(mob)

    mob:removeListener('ORICHALCUM_WAKE')
    mob:addListener('ORICHALCUM_WAKE', 'ORICHALCUM_WAKE', function(mobArg, sourcePlayer)
        awakenMob(mobArg, sourcePlayer)
    end)
end

entity.onMobDespawn = function(mob)
    mob:removeListener('ORICHALCUM_WAKE')
end

return entity
