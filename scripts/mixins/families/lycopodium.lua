require("scripts/globals/mixins")
require("scripts/globals/status")
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.lycopodium = function(mob)

    mob:addListener("ROAM_TICK", "LYCOPODIUM_RTICK", function(mob)
        if mob:getHPP() == 100 then
            mob:setLocalVar("[lycopodium]damaged", 0)
        end
    end)

    mob:addListener("MAGIC_TAKE", "LYCOPODIUM_MAGIC_TAKE", function(target, caster, spell)
        target:setLocalVar("[lycopodium]disengageTime",  target:getBattleTime() + 45)
    end)

    mob:addListener("COMBAT_TICK", "LYCOPODIUM_CTICK", function(mob)
        if mob:getLocalVar("[lycopodium]damaged") == 0 then
            local disengageTime = mob:getLocalVar("[lycopodium]disengageTime")

            if mob:getHP() < mob:getMaxHP() then
                mob:SetAutoAttackEnabled(true)
                mob:SetMobAbilityEnabled(true)
                mob:setLocalVar("[lycopodium]damaged", 1)
            elseif disengageTime > 0 and mob:getBattleTime() > disengageTime then
                mob:setLocalVar("[lycopodium]disengageTime",  0)
                mob:disengage()
            end
    end)
end

return g_mixins.families.lycopodium
