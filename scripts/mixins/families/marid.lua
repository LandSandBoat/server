require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.marid = function(maridMob)
    -- 20% chance to break tusk on critical hit
    maridMob:addListener('CRITICAL_TAKE', 'MARID_CRITICAL_TAKE', function(mob)
        local brokenTusks = mob:getAnimationSub()

        if
            math.random(1, 100) <= 20 and
            brokenTusks < 2
        then
            mob:setAnimationSub(brokenTusks + 1)
        end
    end)

    -- Add Tusks to loot pool depending on number of broken tusks.
    maridMob:addListener('ITEM_DROPS', 'MARID_ITEM_DROPS', function(mob, loot)
        local brokenTusks = mob:getAnimationSub()

        for _ = 1, brokenTusks do
            loot:addItem(xi.item.MARID_TUSK, xi.drop_rate.GUARANTEED)
        end
    end)
end

return g_mixins.families.marid
