-----------------------------------
-- Area: Bibiki Bay
--  Mob: Shen
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
require("scripts/globals/mixins/families/uragnite")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
    entity.spawnFiltrate(mob, target)
end

entity.spawnFiltrate = function(mob, target)
    if mob:getAnimationSub() == 1 and mob:getHP() > 0 then
        for i = 1, 2 do
            if not GetMobByID(mob:getID()+i):isSpawned() then
                SpawnMob(mob:getID()+i):updateEnmity(target)
            end
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
