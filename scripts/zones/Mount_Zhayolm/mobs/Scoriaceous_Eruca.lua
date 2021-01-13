-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Scoriaceous Eruca
-----------------------------------
mixins = {require("scripts/mixins/families/eruca")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
end

return entity
