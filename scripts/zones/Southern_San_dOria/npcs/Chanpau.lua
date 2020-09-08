-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chanpau
-- Optional Involvement in Quest: A Squire's Test II
-- !pos -152 -2 55 230
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    -- "Flyers for Regine" conditional script
    local FlyerForRegine = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE)

    if (FlyerForRegine == 1) then
        local count = trade:getItemCount()
        local MagicFlyer = trade:hasItemQty(532, 1)
        if (MagicFlyer == true and count == 1) then
            player:messageSpecial(ID.text.FLYER_REFUSED)
        end
    end

end

function onTrigger(player, npc)

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.A_SQUIRE_S_TEST_II) == QUEST_ACCEPTED) then
        player:startEvent(629)
    elseif (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM) == QUEST_COMPLETED) then
        Fired = player:getCharVar("Fired")
        if Fired == 1 then
            player:startEvent(567) -- i got fired in a day
            else
            player:startEvent(505) -- theres work ill go check it out
        end
    else
        player:startEvent(566)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 505) then
        player:setCharVar("Fired", 1)
    end
end

-------for future use
--    player:startEvent(32691) -- starlight celebration
