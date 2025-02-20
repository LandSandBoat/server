-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: <this space intentionally left blank>
-- !pos -356 14 -102 176
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('RELIC_IN_PROGRESS') == xi.item.YOSHIMITSU and
        npcUtil.tradeHas(trade, { xi.item.TEN_THOUSAND_BYNE_BILL, xi.item.DEMONIAC_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.YOSHIMITSU })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(11, xi.item.KIKOKU)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 11 and
        npcUtil.giveItem(player, { xi.item.KIKOKU, { xi.item.ONE_HUNDRED_BYNE_BILL, 30 } })
    then
        player:confirmTrade()
        player:setCharVar('RELIC_IN_PROGRESS', 0)
    end
end

return entity
