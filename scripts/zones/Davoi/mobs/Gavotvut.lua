-----------------------------------
-- Area: Davoi
--  Mob: Gavotvut
-- Involved in Quest: The Doorman
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onMobDeath(mob, player, isKiller)

    if (player:getCharVar("theDoormanMyMob") == 1) then
        player:addCharVar("theDoormanKilledNM", 1)
    end

end
