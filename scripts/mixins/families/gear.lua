require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}
g_mixins.families.gear = function(gearMob)
    gearMob:addListener('SPAWN', 'TRIPLE_GEAR_DROP', function(mob)
        -- Setup Triple Gears losing gears
        if mob:getFamily() == 120 then
            mob:setLocalVar('gearDrop1', math.random(45, 60))
            mob:setLocalVar('gearDrop2', math.random(35, 20))
        end
    end)

    gearMob:addListener('COMBAT_TICK', 'GEARS_CTICK', function(mob)
        -- Triple Gears only
        if mob:getFamily() == 120 then
            local mobHPP     = mob:getHPP()
            local tripleGear = 0
            local doubleGear = 1
            local singleGear = 2
            local skillList  = 150
            local dropFirst  = mob:getLocalVar('gearDrop1')
            local dropSecond = mob:getLocalVar('gearDrop2')

            if mobHPP >= dropSecond and mobHPP <= dropFirst then
                if mob:getAnimationSub() ~= doubleGear then
                    mob:setAnimationSub(doubleGear)
                    mob:setMobMod(xi.mobMod.SKILL_LIST, skillList + doubleGear)
                end

                if mob:getLocalVar('Def1') == 0 then
                    mob:delMod(xi.mod.MDEF, 10)
                    mob:delMod(xi.mod.DEF, 20)
                    mob:setLocalVar('Def1', 1)
                end
            elseif mobHPP <= dropSecond then
                if mob:getAnimationSub() ~= singleGear then
                    mob:setAnimationSub(singleGear)
                    mob:setMobMod(xi.mobMod.SKILL_LIST, skillList + singleGear)
                end

                if mob:getLocalVar('Def2') == 0 then
                    mob:delMod(xi.mod.MDEF, 10)
                    mob:delMod(xi.mod.DEF, 20)
                    mob:setLocalVar('Def2', 1)
                end
            elseif mobHPP > dropFirst then
                if mob:getAnimationSub() ~= 0 then
                    mob:setAnimationSub(tripleGear)
                    mob:setMobMod(xi.mobMod.SKILL_LIST, skillList)
                end
            end
        end
    end)
end

return g_mixins.families.gear
