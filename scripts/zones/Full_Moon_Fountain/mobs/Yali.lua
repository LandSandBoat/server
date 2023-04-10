-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Yali
-- Windurst Mission 9-2
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Full_Moon_Fountain/IDs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setSpellList(135)
end

entity.onMobSpawn = function(mob)
    local battlefield = mob:getBattlefield()
    local inst = battlefield:getArea()
    local instOffset = ID.mob.MOON_READING_OFFSET + (6 * (inst - 1))
    if
        GetMobByID(instOffset):isDead() and
        GetMobByID(instOffset + 1):isDead() and
        GetMobByID(instOffset + 2):isDead() and
        GetMobByID(instOffset + 3):isDead()
    then
        battlefield:setLocalVar("phaseChange", 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
