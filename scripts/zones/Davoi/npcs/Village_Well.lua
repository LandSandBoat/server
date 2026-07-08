-----------------------------------
-- Area: Davoi
--  NPC: Village Well
-- Involved in Quest: Under Oath
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('UnderOathCS') == 5 and
        npcUtil.tradeHas(trade, xi.item.WELL_WEIGHT)
    then
        player:startEvent(113)
    else
        player:messageSpecial(ID.text.A_WELL)
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getCharVar('UnderOathCS') == 5 and
        player:hasKeyItem(xi.ki.STRANGE_SHEET_OF_PAPER) and
        not player:hasItem(xi.item.WELL_WEIGHT) and
        not GetMobByID(ID.mob.ONE_EYED_GWAJBOJ):isSpawned() and
        not GetMobByID(ID.mob.THREE_EYED_PROZPUZ):isSpawned()
    then
        SpawnMob(ID.mob.ONE_EYED_GWAJBOJ):updateClaim(player)
        SpawnMob(ID.mob.THREE_EYED_PROZPUZ):updateClaim(player)
    elseif
        player:getCharVar('UnderOathCS') == 6 and
        player:hasKeyItem(xi.ki.KNIGHTS_CONFESSION)
    then
        player:startEvent(112) -- read contents of letter
    else
        player:messageSpecial(ID.text.A_WELL)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 113 then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, xi.ki.KNIGHTS_CONFESSION)
        player:setCharVar('UnderOathCS', 6)
        player:delKeyItem(xi.ki.STRANGE_SHEET_OF_PAPER)
    end
end

return entity
