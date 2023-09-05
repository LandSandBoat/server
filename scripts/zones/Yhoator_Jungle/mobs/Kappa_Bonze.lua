-----------------------------------
-- Area: Yhoator Jungle
--   NM: Kappa Bonze
-- Involved in Quest: True will
-----------------------------------
local ID = require("scripts/zones/Yhoator_Jungle/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
