-----------------------------------
-- Helper NPCs that assist players in battlefields.
--
-- Waits for a timer or until target mobs are engaged, then attacks the first available target.
-- Defaults to no roaming unless allowRoaming = true.
--
-- Usage:
-- mixins = { require('scripts/mixins/helper_npc') }
--
-- local helperConfig = {
--     engageWaitTime = 90,                         -- seconds to wait (optional, default 0 = target engagement only)
--     allowRoaming = false,                        -- allow roaming (optional, default false)
--     isAggroable = true,                          -- can be targeted by enemies (optional, default true)
--     targetMobs = function(mob) return {...} end  -- function returning target mob IDs (required)
-- }
--
-- xi.mix.helperNpc.config(mob, helperConfig)
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.helperNpc = xi.mix.helperNpc or {}

g_mixins = g_mixins or {}

-- Configuration function
xi.mix.helperNpc.config = function(mob, params)
    if not params then
        return
    end

    local engageWaitTime = 0
    if
        params.engageWaitTime and
        params.engageWaitTime > 0
    then
        engageWaitTime = params.engageWaitTime
    end

    mob:setLocalVar('[helperNpc]engageWaitTime', engageWaitTime)

    if params.allowRoaming then
        mob:setLocalVar('[helperNpc]allowRoaming', 1)
    end

    local isAggroable = 1
    if params.isAggroable ~= nil and not params.isAggroable then
        isAggroable = 0
    end

    mob:setLocalVar('[helperNpc]isAggroable', isAggroable)

    if params.targetMobs and type(params.targetMobs) == 'function' then
        xi.mix.helperNpc.targetMobFunctions = xi.mix.helperNpc.targetMobFunctions or {}
        xi.mix.helperNpc.targetMobFunctions[mob:getID()] = params.targetMobs
    end
end

local function getMobList(mob)
    if
        xi.mix.helperNpc.targetMobFunctions and
        xi.mix.helperNpc.targetMobFunctions[mob:getID()]
    then
        return xi.mix.helperNpc.targetMobFunctions[mob:getID()](mob)
    end

    return {}
end

-- Helper function to find available target
local function findAvailableTarget(mob)
    local targetMobs = getMobList(mob)
    if not targetMobs or #targetMobs == 0 then
        return nil
    end

    for i = 1, #targetMobs do
        local targetMob = GetMobByID(targetMobs[i])
        if targetMob and targetMob:isSpawned() and not targetMob:isDead() then
            return targetMob
        end
    end

    return nil
end

g_mixins.helper_npc = function(helperMob)
    helperMob:addListener('SPAWN', 'HELPER_NPC_SPAWN', function(mob)
        local isAggroableVar = mob:getLocalVar('[helperNpc]isAggroable')
        local isAggroable = isAggroableVar ~= 0
        mob:setIsAggroable(isAggroable)

        -- Default to no roaming unless specified
        if mob:getLocalVar('[helperNpc]allowRoaming') ~= 1 then
            mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
        end

        local engageWaitTime = mob:getLocalVar('[helperNpc]engageWaitTime')
        if engageWaitTime > 0 then
            mob:setLocalVar('engageWait', GetSystemTime() + engageWaitTime)
        end
    end)

    helperMob:addListener('ROAM_TICK', 'HELPER_NPC_ROAM', function(mob)
        local engageWaitTime = mob:getLocalVar('[helperNpc]engageWaitTime')
        local engageWait     = mob:getLocalVar('engageWait')
        local targetMobs     = getMobList(mob)
        local shouldEngage   = false

        if engageWaitTime > 0 and GetSystemTime() > engageWait then
            shouldEngage = true
        end

        if not shouldEngage then
            for _, targetMobId in ipairs(targetMobs) do
                local targetMob = GetMobByID(targetMobId)
                if targetMob and targetMob:isSpawned() and targetMob:isEngaged() then
                    shouldEngage = true
                    break
                end
            end
        end

        if shouldEngage and not mob:getTarget() then
            local targetMob = findAvailableTarget(mob)
            if targetMob then
                mob:addEnmity(targetMob, 0, 1)
                mob:updateEnmity(targetMob)
            end
        end
    end)
end

return g_mixins.helper_npc
