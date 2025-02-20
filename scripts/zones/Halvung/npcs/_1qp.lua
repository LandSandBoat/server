-----------------------------------
-- Area: Halvung
--  NPC: Decorative Bronze Gate (_1qp)
-----------------------------------
local ID = zones[xi.zone.HALVUNG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade,
        {
            xi.item.HALVUNG_SHAKUDO_KEY,
            xi.item.HALVUNG_BRONZE_KEY,
            xi.item.HALVUNG_BRASS_KEY
        })
    then
        player:confirmTrade()
        npc:openDoor()
        player:messageSpecial(ID.text.KEY_BREAKS,
            xi.item.HALVUNG_SHAKUDO_KEY,
            xi.item.HALVUNG_BRONZE_KEY,
            xi.item.HALVUNG_BRASS_KEY
        )
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() <= 79.75 and npc:getAnimation() == xi.anim.CLOSE_DOOR then -- from inside the door
        npc:openDoor()
    else
        player:messageSpecial(ID.text.WIDE_TRENCH)
    end
end

return entity
