-----------------------------------
-- Gorger NM Mixin
-- Automatically filters Fission from TP move list if all pets are spawned
--
-- Usage in mob files:
-- 1. Add mixin: mixins = { require('scripts/mixins/families/gorger_nm') }
--
-- For custom skill selection, you can also manually call:
--   if xi.mix.gorger.canUseFission(mob) then
--     table.insert(tpMoves, xi.mobSkill.FISSION)
--   end
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.gorger = xi.mix.gorger or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local fissionData =
{
    [xi.mobPool.HADAL_SATIATOR] = { count = 3, offset = 0 },
    [xi.mobPool.INGESTER      ] = { count = 4, offset = 0 },
    [xi.mobPool.INGURGITATOR  ] = { count = 2, offset = 1 },
    [xi.mobPool.PROCREATOR    ] = { count = 4, offset = 0 },
    [xi.mobPool.PROGENERATOR  ] = { count = 4, offset = 0 },
    [xi.mobPool.PROPAGATOR    ] = { count = 2, offset = 0 },
}

xi.mix.gorger.canUseFission = function(mob)
    -- Check if all offspring are already spawned
    local numAdds = mob:getLocalVar('fissionAdds')
    if numAdds == 0 then
        return false
    end

    local mobID  = mob:getID()
    local offset = mob:getLocalVar('fissionOffset')
    for i = 1, numAdds do
        local pet = GetMobByID(mobID + offset + i)
        if pet and not pet:isSpawned() then
            return true
        end
    end

    -- All adds are spawned, cannot use Fission
    return false
end

g_mixins.families.gorger_nm = function(gorgerMob)
    gorgerMob:addListener('SPAWN', 'GORGER_NM_SPAWN', function(mob)
        -- Store the number of adds and ID offset for this mob pool
        local data = fissionData[mob:getPool()]
        if data then
            mob:setLocalVar('fissionAdds', data.count)
            mob:setLocalVar('fissionOffset', data.offset)
        end
    end)
end

return g_mixins.families.gorger_nm
