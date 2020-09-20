----------------------------------
-- Area: Vunkerl Inlet [S]
--  NPC: Indescript Markings
-- Type: Quest
-- !pos -629.179 -49.002 -429.104 1 83
-----------------------------------
local ID = require("scripts/zones/Vunkerl_Inlet_[S]/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local pantsQuestProgress = player:getCharVar("AF_SCH_PANTS")

    player:delStatusEffect(tpz.effect.SNEAK)

    -- SCH AF Quest - Legs
    if (pantsQuestProgress > 0 and pantsQuestProgress < 3 and player:hasKeyItem(tpz.ki.DJINN_EMBER) == false) then
        player:addKeyItem(tpz.ki.DJINN_EMBER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DJINN_EMBER)
        player:setCharVar("AF_SCH_PANTS", pantsQuestProgress + 1)
        npc:hideNPC(60)

    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
