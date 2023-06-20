-----------------------------------
-- Area: Vunkerl Inlet [S]
--  NPC: Indescript Markings
-- Type: Quest
-- !pos -629.179 -49.002 -429.104 1 83
-----------------------------------
local ID = require("scripts/zones/Vunkerl_Inlet_[S]/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pantsQuestProgress = player:getCharVar("AF_SCH_PANTS")

    player:delStatusEffect(xi.effect.SNEAK)

    -- SCH AF Quest - Legs
    if
        pantsQuestProgress > 0 and
        pantsQuestProgress < 3 and
        not player:hasKeyItem(xi.ki.DJINN_EMBER)
    then
        player:addKeyItem(xi.ki.DJINN_EMBER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.DJINN_EMBER)
        player:setCharVar("AF_SCH_PANTS", pantsQuestProgress + 1)
        npc:hideNPC(60)

    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
