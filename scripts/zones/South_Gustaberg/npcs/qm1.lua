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
    -- tradeMatches does not confirm the quus. tradeHas would leave it reserved on a refused pop.
    if
        not npcUtil.tradeMatches(trade, { { xi.item.QUUS_1, 1 } }) and
        not npcUtil.tradeMatches(trade, { { xi.item.QUUS_2, 1 } })
    then
        return
    end

    -- The corpse blocks the pop for 15 seconds after he dies.
    if not npcUtil.popFromQM(player, npc, ID.mob.BUBBLY_BERNIE, { hide = 0 }) then
        return player:messageSpecial(ID.text.NOTHING_SEEMS_HAPPENING)
    end

    player:tradeComplete()

    return player:messageSpecial(ID.text.YOU_PUT_ITEM_DOWN, xi.item.QUUS_1)
end

entity.onTrigger = function(player, npc)
    if GetMobByID(ID.mob.BUBBLY_BERNIE):isSpawned() then
        player:messageSpecial(ID.text.MONSTER_TRACKS_FRESH)
    else
        player:messageSpecial(ID.text.MONSTER_TRACKS)
    end
end

return entity
