require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.marid = function(maridMob)
    -- 20% chance to break tusk on critical hit
    maridMob:addListener('CRITICAL_TAKE', 'MARID_CRITICAL_TAKE', function(mob)
        if not utils.chance(20) then
            return
        end

        local broken = mob:getAnimationSub()
        if broken >= 2 then
            return
        end

        mob:setAnimationSub(broken + 1)
    end)

    maridMob:addListener('ITEM_DROPS', 'MARID_ITEM_DROPS', function(mob, loot)
        local broken = mob:getAnimationSub()
        for _ = 1, broken do
            loot:addItem(xi.item.MARID_TUSK, xi.drop_rate.GUARANTEED)
        end
    end)
end

return g_mixins.families.marid
