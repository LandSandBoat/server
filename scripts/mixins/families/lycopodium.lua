require("scripts/globals/mixins")
require("scripts/globals/status")
-----------------------------------

tpz = tpz or {}
tpz.mix = tpz.mix or {}
tpz.mix.lycopodium = tpz.mix.lycopodium or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.lycopodium = function(mob)
    mob:addListener("SPAWN", "LYCOPODIUM_SPAWN", function(mob)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1)
    end)

    mob:addListener("ROAM_TICK", "LYCOPODIUM_RTICK", function(mob)
        if mob:getHPP() == 100 then
            mob:setLocalVar("[lycopodium]damaged", 0)
        end
    end)

    mob:addListener("DISENGAGE", "LYCOPODIUM_DISENGAGE", function(mob, target)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
    end)

    mob:addListener("ENGAGE", "LYCOPODIUM_ENGAGE", function(mob, target)
        mob:setLocalVar("[lycopodium]disengageTime",  mob:getBattleTime() + 45)
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
        end
    end)
end

return g_mixins.families.lycopodium