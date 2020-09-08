-----------------------------------
-- Area: Cloister of Gales
--  Mob: Garuda Prime
-- Involved in Mission: ASA-4 Sugar Coated Directive
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    -- ASA-4: Avatar is Unkillable Until Its Used Astral Flow At Least 5 times At Specified Intervals
    mob:setLocalVar("astralflows", 0)
    mob:setUnkillable(true)
end

function onMobFight(mob, target)
    -- ASA-4: Astral Flow Behavior - Guaranteed to Use At Least 5 times before killable, at specified intervals.
    if mob:getCurrentAction() == tpz.act.ATTACK then
        local astralFlows = mob:getLocalVar("astralflows")
        if (astralFlows == 0 and mob:getHPP() <= 80)
        or (astralFlows == 1 and mob:getHPP() <= 60)
        or (astralFlows == 2 and mob:getHPP() <= 40)
        or (astralFlows == 3 and mob:getHPP() <= 20)
        or (astralFlows == 4 and mob:getHPP() <= 1) then
            mob:setLocalVar("astralflows", astralFlows + 1)
            mob:useMobAbility(875)
            if astralFlows >= 5 then
                mob:setUnkillable(false)
            end
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
