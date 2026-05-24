-----------------------------------
-- Area: VeLugannon Palace
--  NPC: ??? (qm1)
-- !pos -370.039 16.014 -274.378 177
-----------------------------------
local ID = zones[xi.zone.VELUGANNON_PALACE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local hideTime = 1

    if not player:hasItem(xi.item.CURTANA) and player:getFreeSlotsCount() >= 1 then
        player:addItem(xi.item.CURTANA)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.CURTANA) -- Curtana

        -- ??? disappears for 2 or 3 hours and reappears on new position
        hideTime = 60 * 60 * math.random(2, 3)
    else
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.CURTANA) -- Curtana

        return
    end

    npc:setPos(unpack(ID.positions.curtana[math.random(1, #ID.positions.curtana)]))
    npc:hideNPC(hideTime)
end

return entity
