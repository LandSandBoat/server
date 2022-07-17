-----------------------------------
-- Area: Riverne - Site A01
--   NM: Shieldtrap
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

local spellLists = {17,13,15,12,14, 16, 19, 18}

entity.onMobSpawn = function(mob)
    mob:setlocalVar("currentDay", VanadielDayOfTheWeek())
end

entity.onMobFight = function(mob, target)
    -- Casts spells according to the current day of the week
    if VanadielDayOfTheWeek() ~= mob:getlocalVar("currentDay") then
        for k, v in pairs(xi.day) do
            if v == VanadielDayOfTheWeek() then
                mob:setSpellList(spellLists[k])
            end
        end
    end
end

entity.mobOnDeath = function(mob, player, isKiller)
end

return entity
