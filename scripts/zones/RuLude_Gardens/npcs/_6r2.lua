-----------------------------------
-- Area: Ru'Lude Gardens
-- Door: Bastokan Emb.
-- Bastok Missions 3.3 "Jeuno" and 4.1 "Magicite"
-----------------------------------
local ID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if
        pNation == xi.nation.BASTOK and
        player:getRank(pNation) >= 4
    then
        player:messageSpecial(ID.text.RESTRICTED)
    else
        player:messageSpecial(ID.text.RESTRICTED + 1) -- you have no letter of introduction
    end
end

return entity
