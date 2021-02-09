-----------------------------------
-- Area: QuBia_Arena
--  Mob: Vangknok of Clan Death
-- Mission 9-2 SANDO
-----------------------------------
local global = require("scripts/zones/QuBia_Arena/Globals")
local ID = require("scripts/zones/QuBia_Arena/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    local battlefield = player:getBattlefield()
    if battlefield and global.phaseChangeReady(battlefield) then
        player:release() -- prevents event collision if player kills multiple remaining mobs with an AOE move/spell
        player:startEvent(32004, 0, 0, 4)
    end
end

return entity
