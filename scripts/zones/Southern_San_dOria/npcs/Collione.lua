-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Collione
--  General Info NPC
-- !pos 10 2 -66 230
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
    player:startEvent(859)
-- player:startEvent(854)  --chocobo dig game
-- player:startEvent(856)  -- play the chocobo game
-- player:startEvent(857)  -- rules for choc game
-- player:startEvent(858)  -- cant give more greens
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
