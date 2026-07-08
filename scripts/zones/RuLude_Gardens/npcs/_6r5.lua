-----------------------------------
-- Area: Ru'Lude Gardens
-- Door: San d'Orian Emb.
-- San d'Oria Missions 3.3 "Appointment to Jeuno" and 4.1 "Magicite"
-----------------------------------
local ID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if
        pNation == xi.nation.SANDORIA and
        player:getRank(pNation) >= 4
    then
        player:messageSpecial(ID.text.RESTRICTED)
    else
        player:messageSpecial(ID.text.RESTRICTED + 1) -- you have no letter of introduction
    end
end

return entity
