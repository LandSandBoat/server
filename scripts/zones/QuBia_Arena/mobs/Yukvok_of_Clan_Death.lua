-----------------------------------
-- Area: QuBia_Arena
--  Mob: Yukvok of Clan Death
-- Mission 9-2 SANDO
-----------------------------------
require("scripts/zones/QuBia_Arena/Globals")
local ID = require("scripts/zones/QuBia_Arena/IDs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    local battlefield = player:getBattlefield()
    if battlefield and phaseChangeReady(battlefield) then
        player:release() -- prevents event collision if player kills multiple remaining mobs with an AOE move/spell
        player:startEvent(32004, 0, 0, 4)
    end
end

return entity
