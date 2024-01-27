-----------------------------------
-- Area: Yhoator Jungle
--  NPC: ??? Used to spawn Edacious Opo-opo
-- !pos 545.7346 0.1819 -433.2258
-----------------------------------
local ID = zones[xi.zone.YHOATOR_JUNGLE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local spawnChance = 0
    if npcUtil.tradeHas(trade, xi.item.BUNCH_OF_PAMAMAS) then
        spawnChance = 5
    elseif npcUtil.tradeHas(trade, xi.item.BUNCH_OF_WILD_PAMAMAS) then
        spawnChance = 50
    end

    if spawnChance > 0 then
        player:confirmTrade()
        if
            math.random(1, 100) <= spawnChance and
            npcUtil.popFromQM(player, npc, ID.mob.EDACIOUS_OPO_OPO)
        then
            player:messageSpecial(ID.text.FAINT_CRY)
        else
            player:messageSpecial(ID.text.PAMAMAS)
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.WATER_HOLE)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
