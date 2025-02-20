-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: <this space intentionally left blank>
-- !pos 0 8 -40 243
-----------------------------------
local ID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('RELIC_IN_PROGRESS') == xi.item.ABADDON_KILLER and
        npcUtil.tradeHas(trade, { xi.item.TEN_THOUSAND_BYNE_BILL, xi.item.SERAPHIC_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.ABADDON_KILLER })
    then -- currency, shard, necropsyche, stage 4
        player:startEvent(10035, xi.item.BRAVURA)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 10035 and
        npcUtil.giveItem(player, { xi.item.BRAVURA, { xi.item.ONE_HUNDRED_BYNE_BILL, 30 } })
    then
        player:confirmTrade()
        player:setCharVar('RELIC_IN_PROGRESS', 0)
    end
end

return entity
