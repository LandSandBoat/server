require("scripts/globals/mixins")
require("scripts/globals/status")


g_mixins = g_mixins or {}

g_mixins.gears = function(mob)

    mob:addListener("COMBAT_TICK", "GEARS_CTICK", function(mob)
        local mobHPP = mob:getHPP()
        if (mobHPP >= 26 and mobHPP <= 49) then
            if mob:AnimationSub() ~= 1 then
                mob:AnimationSub(1) -- double gear
                mob:setMobMod(tpz.mobMod.SKILL_LIST, 151)
            end
        if mob:getLocalVar("Def1") == 0 then
            mob:delMod(tpz.mod.MDEF, 10)
            mob:delMod(tpz.mod.DEF, 20)
            mob:setLocalVar("Def1", 1)
        end
        elseif mobHPP <= 25 then
            if mob:AnimationSub() ~= 2 then
                mob:AnimationSub(2) -- single gear
                mob:setMobMod(tpz.mobMod.SKILL_LIST, 152)
            end
            if mob:getLocalVar("Def2") == 0 then
                mob:delMod(tpz.mod.MDEF, 10)
                mob:delMod(tpz.mod.DEF, 20)
                mob:setLocalVar("Def2", 1)
            end
        elseif mobHPP > 50 then
            if mob:AnimationSub() ~= 0 then
                mob:AnimationSub(0) -- tripple gear
                mob:setMobMod(tpz.mobMod.SKILL_LIST, 150)
            end
        end

    end)

end

return g_mixins.gears
