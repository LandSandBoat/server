-----------------------------------
-- Area: Alzadaal Undersea Ruins
-- Door: Gilded Gateway (Arrapago)
-- !pos -580 0 -159 72
-----------------------------------
local ID = zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
--    if not xi.instance.onTrigger(player, npc, xi.zone.ARRAPAGO_REMNANTS) then
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
--    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    for _, players in pairs(player:getAlliance()) do
        if players:checkImbuedItems() then
            if players:getID() == player:getID() then
                player:messageText(player, ID.text.IMBUED_ITEM, false)
            else
                player:messageText(player, ID.text.MEMBER_IMBUED_ITEM, false)
            end

            player:instanceEntry(npc, 1)
            return
        end
    end

    xi.instance.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.instance.onEventFinish(player, csid, option, npc)
end

return entity
