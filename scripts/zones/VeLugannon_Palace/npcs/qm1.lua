-----------------------------------
-- Area: VeLugannon Palace
--  NPC: ??? (qm1)
-- !pos -370.039 16.014 -274.378 177
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local hideTime = 0

    if not player:hasItem(xi.items.CURTANA) and player:getFreeSlotsCount() >= 1 then
        player:addItem(xi.items.CURTANA)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.CURTANA) -- Curtana

        -- ??? dissapears for 2 hours and reappears on new position
        hideTime = 7200
    else
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.CURTANA) -- Curtana

        -- ??? just change position
        hideTime = 1
    end

    local curtanaPos =
    {
        [1] = { -370.039, 16.014, -274.378 },
        [2] = {     -389,     16,     -274 },
        [3] = {     -434,     16,     -229 },
        [4] = {     -434,     16,     -210 },
        [5] = {      434,     13,     -210 },
        [6] = {      434,     16,     -230 },
        [7] = {      390,     16,     -194 },
        [8] = {      370,     16,     -194 },
    }

    npc:setPos(unpack(curtanaPos[math.random(1, 8)]))
    npc:hideNPC(hideTime)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
