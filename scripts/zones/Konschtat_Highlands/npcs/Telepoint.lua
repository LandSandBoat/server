-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Telepoint
-- !pos 220.000 19.104 300.000 106
-----------------------------------
local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade any normal crystal for a faded crystal.
    local item = trade:getItemId()
    if
        trade:getItemCount() == 1 and
        item >= xi.item.FIRE_CRYSTAL and
        item <= xi.item.DARK_CRYSTAL and
        npcUtil.giveItem(player, xi.item.FADED_CRYSTAL)
    then
        player:tradeComplete()
    end
end

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.DEM_GATE_CRYSTAL) then
        player:startEvent(101)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 101 then
        npcUtil.giveKeyItem(player, xi.ki.DEM_GATE_CRYSTAL)
    end
end

return entity
