-----------------------------------
-- Area: South Gustaberg
--  NPC: qm1 (???)
-- Involved in Quest: The Cold Light of Day
-- !pos 744 0 -671 107
-----------------------------------
local ID = zones[xi.zone.SOUTH_GUSTABERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        (npcUtil.tradeHas(trade, xi.item.QUUS) or npcUtil.tradeHas(trade, xi.item.QUUS_F2)) and
        npcUtil.popFromQM(player, npc, ID.mob.BUBBLY_BERNIE, { hide = 0 })
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.MONSTER_TRACKS)
end

return entity
