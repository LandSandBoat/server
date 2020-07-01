-----------------------------------
-- Area: Lower Delkfutt's Tower
--   NM: Disaster Idol
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onMobEngaged(mob, target)
    local dayofWeek = VanadielDayOfWeek()

    mob:setSpellList(118 + dayofWeek)
    mob:setLocalVar("dayofweek", dayofWeek + 1)
end

function onMobFight(mob, target)
    -- TODO: Has level mimic of person who spawned it. Minimum level 65. HP should scale accordingly.

    local dayofWeek = VanadielDayOfWeek()
    local mobday = mob:getLocalVar("dayofweek")

    if dayofWeek + 1 ~= mobday then
        mob:setSpellList(118 + dayofWeek)
        mob:setLocalVar("dayofweek", dayofWeek + 1)
    end
end

function onMobDeath(mob, player, isKiller)
    if player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Tenzen_s_Path") == 6 then
        player:setCharVar("COP_Tenzen_s_Path", 7)
    end
end
