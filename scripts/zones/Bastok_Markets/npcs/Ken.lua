-----------------------------------
-- Area: Bastok Markets
--  NPC: Ken
-- Type: Quest NPC
-- !pos -340.857 -11.003 -149.008 235
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatBastok, 13)) then
        player:startEvent(432)
    else
        player:startEvent(361)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 432) then
        player:setCharVar("WildcatBastok", utils.mask.setBit(player:getCharVar("WildcatBastok"), 13, true))
    end

end
