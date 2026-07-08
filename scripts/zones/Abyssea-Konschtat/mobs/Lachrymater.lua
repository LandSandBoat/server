-----------------------------------
-- Area: Abyssea-Konschtat
--   NM: Lachrymater
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local DayOfTheWeek = VanadielDayOfTheWeek()

    mob:setSpellList(188 + DayOfTheWeek)
end

return entity
