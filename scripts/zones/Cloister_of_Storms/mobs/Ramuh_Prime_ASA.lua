-----------------------------------
-- Area: Cloister of Storms
--  Mob: Ramuh Prime
-- Involved in Mission: ASA-4 Sugar Coated Directive
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- ASA-4: Avatar is Unkillable Until Its Used Astral Flow At Least 5 times At Specified Intervals
    mob:setLocalVar("astralflows", 1)
    mob:setUnkillable(true)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobFight = function(mob, target)
    -- ASA-4: Astral Flow Behavior - Guaranteed to Use At Least 5 times before killable, at specified intervals.
    xi.asa.helpers.astralFlow(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
