-----------------------------------
-- Area: Davoi
--  Mob: Gavotvut
-- Involved in Quest: The Doorman
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if (player:getCharVar("theDoormanMyMob") == 1) then
        player:addCharVar("theDoormanKilledNM", 1)
    end
end

return entity
