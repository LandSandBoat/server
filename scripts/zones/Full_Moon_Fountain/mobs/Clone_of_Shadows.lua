-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Clone of Shadows
-- BCNM: Battaru Royale (ASA-10)
-----------------------------------
require('scripts/missions/asa/helpers')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.asa.helpers.onCloneSpawn(mob)
end

entity.onMobFight = function(mob, target)
    xi.asa.helpers.onCloneFight(mob, target)
end

return entity
