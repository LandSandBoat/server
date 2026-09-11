-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}
-----------------------------------

-- two rest bands, {19..37} 65% of the time and {34..67} otherwise
local roamBands =
{
    short = { cool = 37, rate = 20, chance = 65 },
    long  = { cool = 67, rate = 20 },
}

g_mixins.families.heartwing = function(heartwingMob)
    heartwingMob:addListener('ROAM_TICK', 'HEARTWING_ROAM_TICK', function(mob)
        if not mob:isFollowingPath() then
            return
        end

        local band = math.randomInt(1, 100) <= roamBands.short.chance and roamBands.short or roamBands.long
        mob:setMobMod(xi.mobMod.ROAM_COOL, band.cool)
        mob:setMobMod(xi.mobMod.ROAM_RATE, band.rate)
    end)
end

return g_mixins.families.heartwing
