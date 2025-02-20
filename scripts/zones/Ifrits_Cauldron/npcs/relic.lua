-----------------------------------
-- Area: Ifrit's Cauldron
--  NPC: <this space intentionally left blank>
-- !pos -18 40 20 205
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('RELIC_IN_PROGRESS') == xi.item.THYRUS and
        npcUtil.tradeHas(trade, { xi.item.RIMILALA_STRIPESHELL, xi.item.CELESTIAL_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.THYRUS }) -- currency, shard, necropsyche, stage 4
    then
        player:startEvent(32, xi.item.CLAUSTRUM)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 32 and
        npcUtil.giveItem(player, { xi.item.CLAUSTRUM, { xi.item.LUNGO_NANGO_JADESHELL, 30 } })
    then
        player:setCharVar('RELIC_IN_PROGRESS', 0)
        player:confirmTrade()
    end
end

return entity
