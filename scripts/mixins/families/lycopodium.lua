require("scripts/globals/mixins")
-----------------------------------
-- TODO: Lycopodiums should use a regen move on players with the title "Babban's Traveling Companion"

xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.lycopodium = xi.mix.lycopodium or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.lycopodium = function(mob)
    mob:addListener("SPAWN", "LYCOPODIUM_SPAWN", function(lycopodium)
        lycopodium:setAutoAttackEnabled(false)
        lycopodium:setMobAbilityEnabled(false)
        lycopodium:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    end)

    mob:addListener("ROAM_TICK", "LYCOPODIUM_RTICK", function(lycopodium)
        -- Goes back to a passive state if roaming and reset completely.
        if lycopodium:getHPP() == 100 then
            if not lycopodium:isAlly() then
                lycopodium:setLocalVar("[lycopodium]damaged", 0)
            end

            lycopodium:setAutoAttackEnabled(false)
            lycopodium:setMobAbilityEnabled(false)
        end
    end)

    mob:addListener("DISENGAGE", "LYCOPODIUM_DISENGAGE", function(lycopodium)
        -- Ensure it goes back into passive state on deaggro
        if not lycopodium:isAlly() then
            lycopodium:setAutoAttackEnabled(false)
            lycopodium:setMobAbilityEnabled(false)
        end
    end)

    mob:addListener("ENGAGE", "LYCOPODIUM_ENGAGE", function(lycopodium)
        lycopodium:setLocalVar("[lycopodium]disengageTime",  lycopodium:getBattleTime() + 45)
        if lycopodium:isAlly() then
            lycopodium:setAutoAttackEnabled(true)
            lycopodium:setMobAbilityEnabled(true)
        end
    end)

    mob:addListener("COMBAT_TICK", "LYCOPODIUM_CTICK", function(lycopodium)
        if lycopodium:isAlly() then
            lycopodium:setAutoAttackEnabled(true)
            lycopodium:setMobAbilityEnabled(true)
        else
            local disengageTime = lycopodium:getLocalVar("[lycopodium]disengageTime")
            local damaged = lycopodium:getLocalVar("[lycopodium]damaged")

            if lycopodium:getHP() < lycopodium:getMaxHP() then
                lycopodium:setAutoAttackEnabled(true)
                lycopodium:setMobAbilityEnabled(true)
            elseif
                disengageTime > 0 and
                lycopodium:getBattleTime() > disengageTime and
                damaged == 0
            then
                lycopodium:setLocalVar("[lycopodium]disengageTime",  0)
                lycopodium:disengage()
            end
        end
    end)

    mob:addListener("TAKE_DAMAGE", "LYCOPODIUM_DAMAGE", function(lycopodium)
        lycopodium:setAutoAttackEnabled(true)
        lycopodium:setMobAbilityEnabled(true)

        if not lycopodium:isAlly() then
            lycopodium:setLocalVar("[lycopodium]damaged", 1)
        end
    end)
end

return g_mixins.families.lycopodium
