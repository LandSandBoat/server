-----------------------------------
-- Area: Metalworks
--  NPC: <this space intentionally left blank>
-- !pos -20 -11 33 237
-----------------------------------
local ID = zones[xi.zone.METALWORKS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('RELIC_IN_PROGRESS') == xi.item.FERDINAND and
        npcUtil.tradeHas(trade, { xi.item.TEN_THOUSAND_BYNE_BILL, xi.item.ETHEREAL_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.FERDINAND })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(843, xi.item.ANNIHILATOR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 843 and
        npcUtil.giveItem(player, { xi.item.ANNIHILATOR, { xi.item.ONE_HUNDRED_BYNE_BILL, 30 } })
    then
        player:confirmTrade()
        player:setCharVar('RELIC_IN_PROGRESS', 0)
    end
end

return entity
