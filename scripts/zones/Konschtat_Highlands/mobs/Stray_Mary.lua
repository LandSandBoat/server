-----------------------------------
-- Area: Konschtat Highlands
--   NM: Stray Mary
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
require("scripts/quests/tutorial")
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
-----------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    -- Disallow two Stray Marys from spawning
    if mob:getID() == ID.Konschtat_Highlands.STRAY_MARY_N then
        DisallowRespawn(ID.Konschtat_Highlands.STRAY_MARY_S, true)
    elseif mob:getID() == ID.Konschtat_Highlands.STRAY_MARY_S then
        DisallowRespawn(ID.Konschtat_Highlands.STRAY_MARY_N, true)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 203)
    player:addTitle(xi.title.MARYS_GUIDE)
    xi.tutorial.onMobDeath(player)

    if mob:getID() == ID.Konschtat_Highlands.STRAY_MARY_N then
        DisallowRespawn(ID.Konschtat_Highlands.STRAY_MARY_S, false)
    elseif mob:getID() == ID.Konschtat_Highlands.STRAY_MARY_S then
        DisallowRespawn(ID.Konschtat_Highlands.STRAY_MARY_N, false)
    end
end

return entity
