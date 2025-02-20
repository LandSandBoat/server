-----------------------------------
-- Area: Western Altepa Desert
--  NPC: <this space intentionally left blank>
-- !pos -152 -16 20 125
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('RELIC_IN_PROGRESS') == xi.item.OGRE_KILLER and
        npcUtil.tradeHas(trade, { xi.item.RIMILALA_STRIPESHELL, xi.item.RUNAEIC_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.OGRE_KILLER })
    then
        player:startEvent(205, xi.item.GUTTLER)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 205 and
        npcUtil.giveItem(player, { xi.item.GUTTLER, { xi.item.LUNGO_NANGO_JADESHELL, 30 } })
    then
        player:confirmTrade()
        player:setCharVar('RELIC_IN_PROGRESS', 0)
    end
end

return entity
