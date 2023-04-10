-----------------------------------
-- Area: The Celestial Nexus
--  Mob: Eald'narche (Phase 2)
-- Zilart Mission 16 BCNM Fight
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- 60% fast cast, -75% physical damage taken, 10tp/tick regain, no standback
    mob:addMod(xi.mod.UFASTCAST, 60)
    mob:addMod(xi.mod.UDMGPHYS, -7500)
    mob:addMod(xi.mod.REGAIN, 100)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, -1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 25)
    if
        GetMobByID(mob:getID() - 1):isDead() and
        GetMobByID(mob:getID() - 2):isDead()
    then
        mob:getBattlefield():setLocalVar("phaseChange", 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
