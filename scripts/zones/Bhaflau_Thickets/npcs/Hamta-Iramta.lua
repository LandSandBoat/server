-----------------------------------
-- Area: Bhaflau Thickets
--  NPC: Hamta-Iramta
-- Type: Alzadaal Undersea Ruins
-- !pos -459.942 -20.048 -4.999 52
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_THICKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

local function isOutsideAlzadaal(player)
    if player:getYPos() <= -16.01 then
        return true
    end

    return false
end

entity.onTrade = function(player, npc, trade)
    if
        isOutsideAlzadaal(player) and
        trade:getItemCount() == 1 and
        trade:hasItemQty(xi.item.IMPERIAL_SILVER_PIECE, 1)
    then
        player:tradeComplete()
        player:startEvent(135)
    end
end

entity.onTrigger = function(player, npc)
    if isOutsideAlzadaal(player) then
        if player:hasKeyItem(xi.ki.CAPTAIN_WILDCAT_BADGE) then
            player:messageSpecial(ID.text.YOU_HAVE_A_BADGE, xi.ki.CAPTAIN_WILDCAT_BADGE)
            player:startEvent(135)
        else
            player:startEvent(134)
        end
    else
        player:startEvent(136)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 135 then
        player:setPos(-115, -4, -620, 253, xi.zone.ALZADAAL_UNDERSEA_RUINS)
    end
end

return entity
