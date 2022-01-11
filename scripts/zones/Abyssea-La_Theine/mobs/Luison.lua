-----------------------------------
-- Area: Abyssea - La Theine
--  Mob: Luison
-----------------------------------
-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
require("scripts/globals/status")
require("scripts/globals/npc_util")
mixins = { require("scripts/mixins/families/gnole") }
-----------------------------------
local entity = {}
entity.onMobDeath = function(mob, player, isKiller)
end
return entity
