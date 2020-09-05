-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Lich C Magnus
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.LICH_BANISHER)
    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.BLUE_RIBBON_BLUES) == QUEST_ACCEPTED) then
        player:setCharVar("Lich_C_Magnus_Died", 1)
    end
end
