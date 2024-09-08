require('scripts/globals/mixins')
-----------------------------------
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.imp_aggro = xi.mix.imp_aggro or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function updateAggro(mob, hour)
    mob:setLocalVar('hour', hour)

    if hour >= 18 or hour < 6 then
        mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    elseif hour < 18 and hour >= 6 then
        mob:setMobMod(xi.mobMod.DETECTION, xi.detects.HEARING)
    end
end

g_mixins.families.imp_aggro = function(mob)
    mob:addListener('SPAWN', 'IMP_AGGRO_SPAWN', function(imp)
        updateAggro(imp, VanadielHour())
    end)

    mob:addListener('ROAM_TICK', 'IMP_AGGRO_ROAM_TICK', function(imp)
        local hour = VanadielHour()
        if hour ~= imp:getLocalVar('hour') then
            updateAggro(imp, hour)
        end
    end)
end

return g_mixins.families.imp_aggro
