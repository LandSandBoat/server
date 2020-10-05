-----------------------------------
-- Area: Metalworks
--  NPC: Invincible Shield
-- Type: Ballista
-- !pos -51.083 -11 2.126 237
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and utils.mask.getBit(WildcatBastok, 6) == false) then
        player:startEvent(932)
    else
        player:startEvent(810)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 932) then
        player:setCharVar("WildcatBastok", utils.mask.setBit(player:getCharVar("WildcatBastok"), 6, true))
    end

end
