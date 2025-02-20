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

        -- ??? dissapears for 2 hours and reappears on new position
        hideTime = 7200
    else
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.CURTANA) -- Curtana
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

return entity
