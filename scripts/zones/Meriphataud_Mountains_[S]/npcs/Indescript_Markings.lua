-----------------------------------
-- Area: Meriphataud_Mountains_[S]
--  NPC: Indescript Markings
-- Type: Quest
-- !pos -389 -9 92 97
-----------------------------------
local ID = require("scripts/zones/Meriphataud_Mountains_[S]/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local loafersQuestProgress = player:getCharVar("AF_SCH_BOOTS")

    player:delStatusEffect(tpz.effect.SNEAK)

    -- SCH AF Quest - Boots
    if loafersQuestProgress > 0 and loafersQuestProgress < 3 and not player:hasKeyItem(tpz.ki.DROGAROGAN_BONEMEAL) then
        player:addKeyItem(tpz.ki.DROGAROGAN_BONEMEAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DROGAROGAN_BONEMEAL)
        player:setCharVar("AF_SCH_BOOTS", loafersQuestProgress + 1)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
