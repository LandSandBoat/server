-----------------------------------
-- Antlion family mixin (For antlions that don't return underground)
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- Maximum time an antlion is allowed to stay buried after spawning, in seconds.
-- Surfacing is normally driven by Pit Ambush completing, but that only happens if
-- the mob engages. If it never does, the mob would remain untargetable, immobile
-- and unkillable for the rest of the zone's uptime.
local ambushTimeout = 30

local function surface(mob)
    if mob:getLocalVar('[Ambush]Done') ~= 0 then
        return
    end

    mob:hideName(false)
    mob:setUntargetable(false)
    mob:setAutoAttackEnabled(true)
    mob:setAnimationSub(1, false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setLocalVar('[Ambush]Done', 1)
end

g_mixins.families.antlion_ambush_no_rehide = function(antlion)
    antlion:addListener('PRESPAWN', 'ANTLION_AMBUSH_PRESPAWN', function(mob)
        mob:hideName(true)
        mob:setUntargetable(true)
        mob:setAutoAttackEnabled(false)
        mob:setAnimationSub(0)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        -- mob:setStatus(xi.status.INVISIBLE) -- TODO: Implement once packet 0x00E is rewritten.
    end)

    -- Failsafe for an ambush that never starts at all, which would otherwise leave the
    -- mob buried permanently and block anything waiting on it to despawn, such as a ???.
    antlion:addListener('SPAWN', 'ANTLION_AMBUSH_SPAWN', function(mob)
        mob:timer(ambushTimeout * 1000, function(mobArg)
            surface(mobArg)
        end)
    end)

    antlion:addListener('ENGAGE', 'ANTLION_AMBUSH_ENGAGE', function(mob, target)
        if mob:getLocalVar('[Ambush]Done') == 0 then
            -- mob:setStatus(xi.status.UPDATE)
            mob:useMobAbility(xi.mobSkill.PIT_AMBUSH_1)
        end
    end)

    -- Ensures an interupted pit ambush doesn't let the mob stay hidden underground
    antlion:addListener('WEAPONSKILL_STATE_EXIT', 'ANTLION_AMBUSH_FINISH', function(mob, skillId, wasExecuted)
        if skillId == xi.mobSkill.PIT_AMBUSH_1 then
            surface(mob)
        end
    end)
end

return g_mixins.families.antlion_ambush_no_rehide
