require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.flan = function(mob)
    mob:addListener("TAKE_DAMAGE", "FLAN_TAKE_DAMAGE", function(mob, damage, attacker, attackType, damageType)
        if attackType == xi.attackType.PHYSICAL or attackType == xi.attackType.RANGED then
            accumulated = mob:getLocalVar("physical")
            accumulated = accumulated + damage
            if accumulated > mob:getMaxHP() * 0.3 or damage > mob:getMaxHP() * 0.1 then
                mob:AnimationSub(2) -- Spike head
                mob:setMod(xi.mod.DMGPHYS, -50)
                mob:setMod(xi.mod.DMGRANGE, -50)
                mob:setMod(xi.mod.DMGMAGIC, 0)
                mob:setLocalVar("Damage", 0)
                accumulated = 0
            end
            mob:setLocalVar("physical", accumulated)
        else
            accumulated = mob:getLocalVar("magical")
            accumulated = accumulated + damage
            if accumulated > mob:getMaxHP() * 0.3 or damage > mob:getMaxHP() * 0.1 then
                mob:AnimationSub(1) -- Smooth head
                mob:setMod(xi.mod.DMGPHYS, 0)
                mob:setMod(xi.mod.DMGRANGE, 0)
                mob:setMod(xi.mod.DMGMAGIC, -50)
                mob:setLocalVar("Damage", 1)
                accumulated = 0
            end
            mob:setLocalVar("magical", accumulated)
        end
    end)

end

return g_mixins.families.flan
