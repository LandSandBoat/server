-----------------------------------
-- Area: Yhoator Jungle
--  NPC: Telepoint
-- !pos -280.942 0.597 -144.156 124
-----------------------------------
local ID = zones[xi.zone.YHOATOR_JUNGLE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade any normal crystal for a faded crystal
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
    if not player:hasKeyItem(xi.ki.YHOATOR_GATE_CRYSTAL) then
        player:startEvent(1)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1 then
        npcUtil.giveKeyItem(player, xi.ki.YHOATOR_GATE_CRYSTAL)
    end
end

return entity
