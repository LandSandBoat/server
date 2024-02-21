require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.aweuvhi = function(aweuvhiMob)
    aweuvhiMob:addListener('SPAWN', 'AWEUVHI_SPAWN', function(mob)
        -- Set a random animation when it spawns
        mob:setAnimationSub(math.random(0, 3))
        mob:setLocalVar('roamTime', os.time())
    end)

    aweuvhiMob:addListener('COMBAT_TICK', 'AWEUVHI_COMBAT', function(mob)
        -- Forms: 0 = Closed  1 = Closed  2 = Open 3 = Closed
        -- According to http://wiki.ffxiclopedia.org/wiki/Category:Euvhi
        -- ..when attacked will change states every minute or so..
        local randomTime = math.random(50, 75)
        local changeTime = mob:getLocalVar('changeTime')

        if mob:getBattleTime() - changeTime > randomTime then
            if mob:getAnimationSub() == 2 then
                mob:setAnimationSub(1)
            else
                mob:setAnimationSub(2)
            end

            mob:setLocalVar('changeTime', mob:getBattleTime())

            -- According to http://wiki.ffxiclopedia.org/wiki/Category:Euvhi
            -- When in an open state, damage taken by the Euvhi is doubled. Inflicting a large amount of damage to an Euvhi in an open state will cause it to close.
            -- Make everything do double
            if mob:getAnimationSub() == 2 then
                mob:setMod(xi.mod.HTH_SDT, 2000)
                mob:setMod(xi.mod.SLASH_SDT, 2000)
                mob:setMod(xi.mod.PIERCE_SDT, 2000)
                mob:setMod(xi.mod.IMPACT_SDT, 2000)
                for n = 1, #xi.magic.resistMod, 1 do
                    mob:setMod(xi.magic.resistMod[n], 2000)
                end

                for n = 1, #xi.magic.specificDmgTakenMod, 1 do
                    mob:setMod(xi.magic.specificDmgTakenMod[n], -10000)
                end
            else -- Reset all damage types
                mob:setMod(xi.mod.HTH_SDT, 1000)
                mob:setMod(xi.mod.SLASH_SDT, 1000)
                mob:setMod(xi.mod.PIERCE_SDT, 1000)
                mob:setMod(xi.mod.IMPACT_SDT, 1000)

                for n = 1, #xi.magic.resistMod, 1 do
                    mob:setMod(xi.magic.resistMod[n], 1000)
                end

                for n = 1, #xi.magic.specificDmgTakenMod, 1 do
                    mob:setMod(xi.magic.specificDmgTakenMod[n], 10000)
                end
            end
        end
    end)

    aweuvhiMob:addListener('ROAM_TICK', 'AWEUVHI_ROAM', function(mob)
        local roamTime = mob:getLocalVar('roamTime')

        if os.time() - roamTime > 60 then
            local randomSub = math.random(0, 2) * 5  -- AnimationSub: 0, 1, or 6 (3-5 don't do anything)
            mob:setAnimationSub(randomSub)
            mob:setLocalVar('roamTime', os.time())

            if
                mob:getZoneID() == xi.zone.THE_GARDEN_OF_RUHMET and
                randomSub == 0 or
                randomSub == 5
            then
                mob:setAggressive(false)
            else
                mob:setAggressive(true)
            end
        end
    end)

    aweuvhiMob:addListener('CRITICAL_TAKE', 'AWEUVHI_CRITICAL_TAKE', function(mob)
        -- According to http://wiki.ffxiclopedia.org/wiki/Category:Euvhi
        -- When in an open state, damage taken by the Euvhi is doubled. Inflicting a large amount of damage to an Euvhi in an open state will cause it to close.
        -- Crit is really the only thing we can do.
        if mob:getAnimationSub() == 2 then
            mob:setAnimationSub(0)
        end
    end)
end

return g_mixins.families.aweuvhi
