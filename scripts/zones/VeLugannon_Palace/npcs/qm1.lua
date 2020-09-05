-----------------------------------
-- Area: VeLugannon Palace
--  NPC: ??? (qm1)
-- !pos -370.039 16.014 -274.378 177
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:hasItem(16575) == false and player:getFreeSlotsCount() >= 1) then
        player:addItem(16575)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 16575) -- Curtana

        -- ??? dissapears for 2 hours and reappears on new position
        local hideTime = 7200
    else
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16575) -- Curtana

        -- ??? just change position
        local hideTime = 1
    end

    local randpos = math.random(1, 8)

    switch (randpos): caseof
    {
        [1] = function (x) npc:setPos(-370.039, 16.014, -274.378); end,
        [2] = function (x) npc:setPos(-389, 16, -274); end,
        [3] = function (x) npc:setPos(-434, 16, -229); end,
        [4] = function (x) npc:setPos(-434, 16, -210); end,
        [5] = function (x) npc:setPos(434, 13, -210); end,
        [6] = function (x) npc:setPos(434, 16, -230); end,
        [7] = function (x) npc:setPos(390, 16, -194); end,
        [8] = function (x) npc:setPos(370, 16, -194); end,
    }

    npc:hideNPC(hideTime)

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
