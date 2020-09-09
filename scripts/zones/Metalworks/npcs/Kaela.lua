-----------------------------------
-- Area: Metalworks
--  NPC: Kaela
-- Type: Adventurer's Assistant
-- !pos 40.167 -14.999 16.073 237
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatBastok, 8) == false) then
        player:startEvent(934)
    else
        player:startEvent(741)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 934) then
        player:setMaskBit(player:getCharVar("WildcatBastok"), "WildcatBastok", 8, true)
    end

end
