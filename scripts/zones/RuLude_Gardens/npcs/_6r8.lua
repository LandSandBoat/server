-----------------------------------
-- Area: Ru'Lude Gardens
-- Door: Windurstian Ambassador
-- Windurst Missions 3.3 "A New Journey" and 4.1 "Magicite"
-- !pos 31 9 -22 243
-----------------------------------
local ID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getNation() == xi.nation.WINDURST and
        player:getRank(xi.nation.WINDURST) >= 4
    then
        player:messageSpecial(ID.text.RESTRICTED)
    else
        player:messageSpecial(ID.text.RESTRICTED + 1)
    end
end

return entity
