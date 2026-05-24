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

    local curtanaPos =
    {
        [1] =  { -434.320, 16.016, -230.060 },
        [2] =  {     -434,     16,     -210 }, -- Need better cap
        [3] =  { -389.990, 16.016, -274.531 },
        [4] =  { -370.050, 16.014, -194.259 },
        [5] =  { -370.039, 16.014, -274.378 },
        [6] =  { -389.050, 16.014, -274.259 }, -- Guessed based off of the southern duplicate. Needs cap.
        [7] =  { -325.667, 16.013, -209.940 },
        [8] =  { -325.611, 16.013, -229.970 },
        [9] =  {  325.670, 16.016, -209.973 }, 
        [16] = {  325.368, 16.013, -230.056 }, -- Guessed based off of western duplicate. Needs cap.
        [10] = {  370.070, 16.010, -274.472 },
        [11] = {  370.070, 15.998, -194.742 },
        [12] = {  390.016, 16.014, -274.371 },
        [13] = {      390,     16,     -194 }, -- need better cap
        [14] = { 434.269,  16.018, -209.917 },
        [16] = {  434.368, 16.013, -230.056 },
    }

    npc:setPos(unpack(curtanaPos[math.random(1, #curtanaPos)]))
    npc:hideNPC(hideTime)
end

return entity
