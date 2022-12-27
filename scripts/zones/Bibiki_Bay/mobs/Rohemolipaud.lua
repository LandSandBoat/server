-----------------------------------
-- Area: Bibiki Bay
--  Mob: Rohemolipaud
-- Note: NM for quest: "The Search for Goldmane"
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
