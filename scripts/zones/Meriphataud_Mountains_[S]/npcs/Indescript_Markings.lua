-----------------------------------
-- Area: Meriphataud_Mountains_[S]
--  NPC: Indescript Markings
-- Type: Quest
-- !pos -389 -9 92 97
-----------------------------------
local ID = require("scripts/zones/Meriphataud_Mountains_[S]/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local loafersQuestProgress = player:getCharVar("AF_SCH_BOOTS")

    player:delStatusEffect(xi.effect.SNEAK)

    -- SCH AF Quest - Boots
    if
        loafersQuestProgress > 0 and
        loafersQuestProgress < 3 and
        not player:hasKeyItem(xi.ki.DROGAROGAN_BONEMEAL)
    then
        player:addKeyItem(xi.ki.DROGAROGAN_BONEMEAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.DROGAROGAN_BONEMEAL)
        player:setCharVar("AF_SCH_BOOTS", loafersQuestProgress + 1)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
