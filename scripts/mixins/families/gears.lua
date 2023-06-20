require("scripts/globals/mixins")

g_mixins = g_mixins or {}

g_mixins.gears = function(gearsMob)
    gearsMob:addListener("COMBAT_TICK", "GEARS_CTICK", function(mob)
        local mobHPP = mob:getHPP()
        if mobHPP >= 26 and mobHPP <= 49 then
            if mob:getAnimationSub() ~= 1 then
                mob:setAnimationSub(1) -- double gear
                mob:setMobMod(xi.mobMod.SKILL_LIST, 151)
            end

            if mob:getLocalVar("Def1") == 0 then
                mob:delMod(xi.mod.MDEF, 10)
                mob:delMod(xi.mod.DEF, 20)
                mob:setLocalVar("Def1", 1)
            end
        elseif mobHPP <= 25 then
            if mob:getAnimationSub() ~= 2 then
                mob:setAnimationSub(2) -- single gear
                mob:setMobMod(xi.mobMod.SKILL_LIST, 152)
            end

            if mob:getLocalVar("Def2") == 0 then
                mob:delMod(xi.mod.MDEF, 10)
                mob:delMod(xi.mod.DEF, 20)
                mob:setLocalVar("Def2", 1)
            end
        elseif mobHPP > 50 then
            if mob:getAnimationSub() ~= 0 then
                mob:setAnimationSub(0) -- triple gear
                mob:setMobMod(xi.mobMod.SKILL_LIST, 150)
            end
        end
    end)
end

return g_mixins.gears
