-----------------------------------
-- Area: Port Bastok
--  NPC: Patient Wheel
-- Type: Quest NPC
-- !pos -107.988 3.898 52.557 236
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatBastok, 1) == false) then
        player:startEvent(354)
    else
        player:startEvent(325)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 354) then
        player:setMaskBit(player:getCharVar("WildcatBastok"), "WildcatBastok", 1, true)
    end

end
