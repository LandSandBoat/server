-----------------------------------
-- Area: Lower Delkfutt's Tower
--   NM: Disaster Idol
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    local DayOfTheWeek = VanadielDayOfTheWeek()

    mob:setSpellList(118 + DayOfTheWeek)
    mob:setLocalVar('DayOfTheWeek', DayOfTheWeek + 1)
end

entity.onMobFight = function(mob, target)
    -- TODO: Has level mimic of person who spawned it. Minimum level 65. HP should scale accordingly.

    local DayOfTheWeek = VanadielDayOfTheWeek()
    local mobday = mob:getLocalVar('DayOfTheWeek')

    if DayOfTheWeek + 1 ~= mobday then
        mob:setSpellList(118 + DayOfTheWeek)
        mob:setLocalVar('DayOfTheWeek', DayOfTheWeek + 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
