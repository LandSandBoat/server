require("scripts/globals/mixins")
require("scripts/globals/status")

g_mixins = g_mixins or {}

g_mixins.atori_tutori_qm = function(atoriMob)
    atoriMob:addListener("SPAWN", "JOB_SPECIAL_SPAWN", function(mob)
        mob:setLocalVar("specialThreshold", 35)
    end)

    atoriMob:addListener("ENGAGE", "ATORI_ENGAGE", function(mob, target)
        if mob:getLocalVar("engaged") == 0 then
            local ID = zones[mob:getZoneID()]
            mob:messageText(mob, ID.text.PROMISE_ME_YOU_WONT_GO_DOWN)
            mob:setLocalVar("engaged", target:getID())
        end
    end)

    atoriMob:addListener("COMBAT_TICK", "ATORI_CTICK", function(mob)
        if mob:getHPP() < mob:getLocalVar("specialThreshold") then
            local ID = zones[mob:getZoneID()]
            mob:messageText(mob, ID.text.YOU_PACKED_MORE_OF_A_PUNCH)
            xi.mobskills.mobBuffMove(mob, xi.effect.HUNDRED_FISTS, 1, 0, 30)
            mob:setLocalVar("specialThreshold", 0)
        end
    end)

    atoriMob:addListener("DEATH", "ATORI_DEATH", function(mob, killer)
        local ID = zones[mob:getZoneID()]
        mob:messageText(mob, ID.text.WHATS_THIS_STRANGE_FEELING)
    end)

    atoriMob:addListener("EFFECT_GAIN", "TERRORIZED", function(mob, effect)
        local ID = zones[mob:getZoneID()]
        if effect:getType() == xi.effect.TERROR then
            mob:showText(mob, ID.text.YIKEY_WIKEYS)
        end
    end)

    atoriMob:addListener("EFFECT_LOSE", "TERRORIZED", function(mob, effect)
        local ID = zones[mob:getZoneID()]
        if effect:getType() == xi.effect.TERROR then
            mob:showText(mob, ID.text.WHATS_THE_MATTARU)
        end
    end)
end

return g_mixins.atori_tutori_qm
