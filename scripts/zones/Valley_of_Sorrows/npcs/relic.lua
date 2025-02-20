-----------------------------------
-- Area: Valley of Sorrows
--  NPC: <this space intentionally left blank>
-- !pos -14 -3 56 128
-----------------------------------
local ID = zones[xi.zone.VALLEY_OF_SORROWS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('RELIC_IN_PROGRESS') == xi.item.MILLENNIUM_HORN and
        npcUtil.tradeHas(trade, { xi.item.RIMILALA_STRIPESHELL, xi.item.MYSTERIAL_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.MILLENNIUM_HORN })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(15, xi.item.GJALLARHORN)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 15 and
        npcUtil.giveItem(player, { xi.item.GJALLARHORN, { xi.item.LUNGO_NANGO_JADESHELL, 30 } })
    then
        player:confirmTrade()
        player:setCharVar('RELIC_IN_PROGRESS', 0)
    end
end

return entity
